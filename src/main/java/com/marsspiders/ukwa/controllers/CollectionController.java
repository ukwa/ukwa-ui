package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.SearchController.getRootPathWithLang;
import static java.util.Collections.singletonList;
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
@RequestMapping(value = HomeController.PROJECT_NAME + "/collection")
public class CollectionController {

    private static final String TYPE_COLLECTION = "collection";
    private static final String TYPE_TARGET = "target";

    @Autowired
    SolrSearchService searchService;


    @RequestMapping(value = "/old", method = GET)
    public ModelAndView collectionsPageTemporaryOld() {
        SolrSearchResult<CollectionInfo> rootCollectionsSearchResult = searchService.fetchRootCollections();
        List<CollectionInfo> rootCollectionsDocuments = rootCollectionsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> collections = generateCollectionsDTOs(rootCollectionsDocuments);

        ModelAndView mav = new ModelAndView("collections");
        mav.addObject("collections", collections);

        return mav;
    }

    @RequestMapping(value = "", method = GET)
    public ModelAndView collectionsPage() {
        SolrSearchResult<CollectionInfo> rootCollectionsSearchResult = searchService.fetchRootCollections();
        List<CollectionInfo> rootCollectionsDocuments = rootCollectionsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> collections = generateCollectionsDTOs(rootCollectionsDocuments);

        ModelAndView mav = new ModelAndView("speccoll");
        mav.addObject("collections", collections);

        return mav;
    }

    @RequestMapping(value = "/{collectionId}/old", method = GET)
    public ModelAndView collectionOverviewPageTemporaryOld(@PathVariable("collectionId") String collectionId,
                                                  HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        SolrSearchResult<CollectionInfo> childItemsSearchResult = searchService.fetchChildCollections(singletonList(collectionId));

        List<CollectionInfo> childItemsDocuments = childItemsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> subCollections = generateCollectionsDTOs(childItemsDocuments);
        CollectionDTO currentCollection = generatePlainCollectionDTO(collectionId);

        SolrSearchResult<CollectionInfo> rootCollectionsSearchResult = searchService.fetchRootCollections();
        List<CollectionInfo> rootCollectionsDocuments = rootCollectionsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> rootCollections = generateCollectionsDTOs(rootCollectionsDocuments);

        ModelAndView mav = new ModelAndView("collection_overview");
        mav.addObject("targetWebsites", targetWebsites);
        mav.addObject("subCollections", subCollections);
        mav.addObject("currentCollection", currentCollection);
        mav.addObject("rootCollections", rootCollections);

        return mav;
    }

    @RequestMapping(value = "/{collectionId}", method = GET)
    public ModelAndView collectionOverviewPage(@PathVariable("collectionId") String collectionId,
                                               HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        SolrSearchResult<CollectionInfo> childItemsSearchResult = searchService.fetchChildCollections(singletonList(collectionId));

        return collectionOverviewPageInternal(collectionId, childItemsSearchResult, request);
    }

    @RequestMapping(value = "/{collectionId}/search", method = POST)
    public ModelAndView collectionOverviewPageSearch(@PathVariable("collectionId") String collectionId,
                                                     @RequestParam("filter") String titleFilter,
                                                     HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        SolrSearchResult<CollectionInfo> childItemsSearchResult = searchService.fetchChildCollectionsByTitle(collectionId, titleFilter);

        return collectionOverviewPageInternal(collectionId, childItemsSearchResult, request);
    }

    private ModelAndView collectionOverviewPageInternal(String collectionId,
                                                        SolrSearchResult<CollectionInfo> childItemsSearchResult,
                                                        HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        List<CollectionInfo> childItemsDocuments = childItemsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> subCollections = generateCollectionsDTOs(childItemsDocuments);
        CollectionDTO currentCollection = generatePlainCollectionDTO(collectionId);

        SolrSearchResult<CollectionInfo> rootCollectionsSearchResult = searchService.fetchRootCollections();
        List<CollectionInfo> rootCollectionsDocuments = rootCollectionsSearchResult.getResponseBody().getDocuments();

        List<CollectionDTO> rootCollections = generateCollectionsDTOs(rootCollectionsDocuments);

        ModelAndView mav = new ModelAndView("coll");
        mav.addObject("targetWebsites", targetWebsites);
        mav.addObject("subCollections", subCollections);
        mav.addObject("currentCollection", currentCollection);
        mav.addObject("rootCollections", rootCollections);

        return mav;
    }

    private List<TargetWebsiteDTO> generateTargetWebsitesDTOs(List<CollectionInfo> childItemsDocuments, String rootPathWithLang) {
        return childItemsDocuments
                .stream()
                .filter(d -> TYPE_TARGET.equalsIgnoreCase(d.getType()))
                .map(d -> {
                    String id = d.getId();
                    String name = d.getTitle();
                    String screenshotName = "thumbnail-default-" + ((int) (16 * Math.random()) + 1) + ".png";
                    String description = d.getDescription() != null
                            ? d.getDescription().replaceAll("<[^>]*>", "")
                            : null;
                    String shortDescription = abbreviate(description, 60);
                    String wayBackUrl = rootPathWithLang + "wayback/*/" + d.getUrl();

                    TargetWebsiteDTO targetWebsite = new TargetWebsiteDTO();
                    targetWebsite.setId(id);
                    targetWebsite.setName(name);
                    targetWebsite.setScreenshot(screenshotName);
                    targetWebsite.setDescription(shortDescription);
                    targetWebsite.setArchiveUrl(wayBackUrl);
                    targetWebsite.setUrl(d.getUrl());
                    targetWebsite.setStartDate(d.getStartDate() != null ? d.getStartDate().substring(0, 10) : "");
                    targetWebsite.setEndDate(d.getEndDate() != null ? d.getEndDate().substring(0, 10) : "");
                    targetWebsite.setLanguage(d.getLanguage());
                    targetWebsite.setAdditionalUrls(d.getAdditionalUrl());

                    return targetWebsite;
                })
                .collect(Collectors.toList());
    }

    private List<CollectionDTO> generateCollectionsDTOs(List<CollectionInfo> itemsDocuments) {
        List<String> collectionsIds = itemsDocuments
                .stream()
                .filter(d -> TYPE_COLLECTION.equalsIgnoreCase(d.getType()))
                .map(CollectionInfo::getId)
                .collect(Collectors.toList());

        SolrSearchResult<CollectionInfo> subCollectionsSearchResult = searchService.fetchChildCollections(collectionsIds);
        List<CollectionInfo> subCollections = subCollectionsSearchResult.getResponseBody().getDocuments();

        return itemsDocuments
                .stream()
                .filter(d -> TYPE_COLLECTION.equalsIgnoreCase(d.getType()))
                .map(d -> toCollectionDTO(d, subCollections, true))
                .collect(Collectors.toList());
    }

    private CollectionDTO generatePlainCollectionDTO(String collectionId) {
        SolrSearchResult<CollectionInfo> collectionSearchResult = searchService.fetchCollectionById(collectionId);
        CollectionInfo currentCollectionInformation = collectionSearchResult.getResponseBody().getDocuments().get(0);

        return toCollectionDTO(currentCollectionInformation, Collections.emptyList(), false);
    }

    private CollectionDTO toCollectionDTO(CollectionInfo currentCollection, List<CollectionInfo> subCollections, boolean abbreviate) {
        String id = currentCollection.getId();
        String name = currentCollection.getName();
        String description = currentCollection.getDescription() != null
                ? currentCollection.getDescription().replaceAll("<[^>]*>", "")
                : null;

        String shortDescription = abbreviate ? abbreviate(description, 60) : description;
        long sectionsNum = countChildItems(id, TYPE_COLLECTION, subCollections);
        long websitesNum = countChildItems(id, TYPE_TARGET, subCollections);
        long websitesOpenAccessNum = 0;

        return new CollectionDTO(id, name, shortDescription, sectionsNum, websitesNum, websitesOpenAccessNum);
    }

    private long countChildItems(String parentId, String itemType, List<CollectionInfo> subCollections) {
        return subCollections
                .stream()
                .filter(collection -> {
                    String type = collection.getType();
                    String subCollectionParentId = collection.getParentId();
                    return (itemType.equalsIgnoreCase(type) && parentId.equals(subCollectionParentId));
                })
                .count();
    }
}
