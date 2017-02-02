package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.DocumentInformation;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = "ukwa/collection")
public class CollectionController {

    private static final String TYPE_COLLECTION = "collection";
    private static final String TYPE_TARGET = "target";

    @Autowired
    SolrSearchService searchService;

    @RequestMapping(value = "", method = GET)
    public ModelAndView collectionsPage() {
        SolrSearchResult searchResult = searchService.fetchRootCollections();
        List<String> rootCollectionIds = searchResult.getResponseBody().getDocuments()
                .stream()
                .map(DocumentInformation::getId)
                .collect(Collectors.toList());

        SolrSearchResult subCollectionsResult = searchService.fetchSubCollections(rootCollectionIds);

        List<CollectionDTO> collections = searchResult.getResponseBody().getDocuments()
                .stream()
                .map(d -> {
                    String id = d.getId();
                    String name = d.getName();
                    long sectionsNum = countChildItems(subCollectionsResult, id, TYPE_COLLECTION);
                    long websitesNum = countChildItems(subCollectionsResult, id, TYPE_TARGET);
                    long websitesOpenAccessNum = 0;

                    return new CollectionDTO(id, name, sectionsNum, websitesNum, websitesOpenAccessNum);
                })
                .collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("collections");
        mav.addObject("collections", collections);

        return mav;
    }

    private long countChildItems(SolrSearchResult subCollectionsResult, String parentId, String itemType) {
        return subCollectionsResult.getResponseBody().getDocuments()
                .stream()
                .filter(sc -> itemType.equalsIgnoreCase(sc.getType()) && sc.getParentId().equals(parentId))
                .count();
    }

    @RequestMapping(value = "/{collectionId}", method = GET)
    public ModelAndView collectionOverviewPage(@PathVariable("collectionId") String collectionId) {
        SolrSearchResult searchResult = searchService.fetchSubCollections(Collections.singletonList(collectionId));

        List<String> subCollectionsIds = searchResult.getResponseBody().getDocuments()
                .stream()
                .filter(d -> TYPE_COLLECTION.equalsIgnoreCase(d.getType()))
                .map(DocumentInformation::getId)
                .collect(Collectors.toList());

        SolrSearchResult subCollectionsResult = searchService.fetchSubCollections(subCollectionsIds);

        List<CollectionDTO> subCollections = searchResult.getResponseBody().getDocuments()
                .stream()
                .filter(d -> TYPE_COLLECTION.equalsIgnoreCase(d.getType()))
                .map(d -> {
                    String id = d.getId();
                    String name = d.getName();
                    long sectionsNum = countChildItems(subCollectionsResult, id, TYPE_COLLECTION);
                    long websitesNum = countChildItems(subCollectionsResult, id, TYPE_TARGET);
                    long websitesOpenAccessNum = 0;

                    return new CollectionDTO(id, name, sectionsNum, websitesNum, websitesOpenAccessNum);
                })
                .collect(Collectors.toList());

        List<TargetWebsiteDTO> targetWebsites= searchResult.getResponseBody().getDocuments()
                .stream()
                .filter(d -> TYPE_TARGET.equalsIgnoreCase(d.getType()))
                .map(d -> {
                    String id = d.getId();
                    String name = d.getTitle();
                    String screenshot = "dummy";

                    TargetWebsiteDTO targetWebsite = new TargetWebsiteDTO();
                    targetWebsite.setId(id);
                    targetWebsite.setName(name);
                    targetWebsite.setScreenshot(screenshot);

                    return targetWebsite;
                })
                .collect(Collectors.toList());

        ModelAndView mav = new ModelAndView("collection_overview");
        mav.addObject("targetWebsites", targetWebsites);
        mav.addObject("subCollections", subCollections);

        return mav;
    }
}
