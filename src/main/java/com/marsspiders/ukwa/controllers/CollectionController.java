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
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.util.UrlUtil.getRootPathWithLang;
import static java.util.Collections.singletonList;
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.apache.commons.lang3.StringUtils.isNumeric;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = HomeController.PROJECT_NAME + "/collection")
public class CollectionController {

    public static final String TYPE_COLLECTION = "collection";
    public static final String TYPE_TARGET = "target";
    static final int ROWS_PER_PAGE = 10;

    @Autowired
    private SolrSearchService searchService;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "", method = GET)
    public ModelAndView rootCollectionsPage() {
        List<CollectionDTO> collections = generateRootCollectionDTOs();

        ModelAndView mav = new ModelAndView("speccoll");
        mav.addObject("collections", collections);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }

    @RequestMapping(value = "/{collectionId}", method = GET)
    public ModelAndView collectionOverviewPage(@PathVariable("collectionId") String collectionId,
                                               @RequestParam(value = "page", required = false) String pageNum,
                                               HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        long targetPageNumber = isNumeric(pageNum) ? Long.valueOf(pageNum) : 1;
        long startFromRow = (targetPageNumber - 1) * ROWS_PER_PAGE;

        SolrSearchResult<CollectionInfo> targetWebsitesSearchResult = searchService
                .fetchChildCollections(singletonList(collectionId), TYPE_TARGET, ROWS_PER_PAGE, startFromRow);
        List<CollectionInfo> targetWebsitesDocuments = targetWebsitesSearchResult.getResponseBody().getDocuments();

        String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);

        List<TargetWebsiteDTO> targetWebsites = generateTargetWebsitesDTOs(targetWebsitesDocuments, rootPathWithLang);
        List<CollectionDTO> subCollections = generateSubCollectionDTOs(collectionId);
        List<CollectionDTO> rootCollections = generateRootCollectionDTOs();
        CollectionDTO currentCollection = generatePlainCollectionDTO(collectionId);
        currentCollection.setWebsitesNum(targetWebsitesSearchResult.getResponseBody().getNumFound());

        ModelAndView mav = new ModelAndView("coll");
        mav.addObject("targetWebsites", targetWebsites);
        mav.addObject("subCollections", subCollections);
        mav.addObject("currentCollection", currentCollection);
        mav.addObject("rootCollections", rootCollections);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("targetPageNumber", targetPageNumber);
        mav.addObject("rowsPerPageLimit", ROWS_PER_PAGE);

        return mav;
    }

    private List<CollectionDTO> generateSubCollectionDTOs(String collectionId) {
        return searchService
                .fetchChildCollections(singletonList(collectionId), TYPE_COLLECTION, 1000, 0)
                .getResponseBody().getDocuments()
                .stream()
                .map(d -> toCollectionDTO(d, true))
                .collect(Collectors.toList());
    }

    private List<CollectionDTO> generateRootCollectionDTOs() {
        return searchService
                .fetchRootCollections()
                .getResponseBody().getDocuments()
                .stream()
                .map(d -> toCollectionDTO(d, true))
                .collect(Collectors.toList());
    }

    private CollectionDTO generatePlainCollectionDTO(String collectionId) {
        CollectionInfo currentCollectionInformation = searchService
                .fetchCollectionById(collectionId)
                .getResponseBody().getDocuments()
                .get(0);

        return toCollectionDTO(currentCollectionInformation, false);
    }

    private List<TargetWebsiteDTO> generateTargetWebsitesDTOs(List<CollectionInfo> websites, String rootPathWithLang) {
        return websites
                .stream()
                .map(d -> toTargetWebsiteDTO(rootPathWithLang, d))
                .collect(Collectors.toList());
    }

    private static TargetWebsiteDTO toTargetWebsiteDTO(String rootPathWithLang, CollectionInfo websiteInfo) {
        String id = websiteInfo.getId();
        String name = websiteInfo.getTitle();
        String screenshotName = "thumbnail-default-" + ((int) (16 * Math.random()) + 1) + ".png";
        String description = websiteInfo.getDescription() != null
                ? websiteInfo.getDescription().replaceAll("<[^>]*>", "")
                : null;
        String shortDescription = abbreviate(description, 60);
        String wayBackUrl = rootPathWithLang + "wayback/*/" + websiteInfo.getUrl();

        TargetWebsiteDTO targetWebsite = new TargetWebsiteDTO();
        targetWebsite.setId(id);
        targetWebsite.setName(name);
        targetWebsite.setScreenshot(screenshotName);
        targetWebsite.setDescription(shortDescription);
        targetWebsite.setArchiveUrl(wayBackUrl);
        targetWebsite.setUrl(websiteInfo.getUrl());
        targetWebsite.setStartDate(websiteInfo.getStartDate() != null ? websiteInfo.getStartDate().substring(0, 10) : "");
        targetWebsite.setEndDate(websiteInfo.getEndDate() != null ? websiteInfo.getEndDate().substring(0, 10) : "");
        targetWebsite.setLanguage(websiteInfo.getLanguage());
        targetWebsite.setAdditionalUrls(websiteInfo.getAdditionalUrl());

        return targetWebsite;
    }

    private static CollectionDTO toCollectionDTO(CollectionInfo collectionInfo, boolean abbreviate) {
        String id = collectionInfo.getId();
        String name = collectionInfo.getName();
        String description = collectionInfo.getDescription() != null
                ? collectionInfo.getDescription().replaceAll("<[^>]*>", "")
                : null;

        String shortDescription = abbreviate ? abbreviate(description, 60) : description;

        return new CollectionDTO(id, name, shortDescription, 0, 0, 0);
    }

}
