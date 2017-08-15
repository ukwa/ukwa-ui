package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.CollectionDTO;
import com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO;
import com.marsspiders.ukwa.ip.WaybackIpResolver;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_TARGET;
import static com.marsspiders.ukwa.util.UrlUtil.getLocale;
import static com.marsspiders.ukwa.util.UrlUtil.getRootPathWithLang;
import static java.util.Collections.singletonList;
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.apache.commons.lang3.StringUtils.isNumeric;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = HomeController.PROJECT_NAME + "/collection")
public class CollectionController {

    static final int ROWS_PER_PAGE_DEFAULT = 50;
    private static final String COLLECTION_ALT_MESSAGE_DEFAULT = "coll.alt.default";
    private static final String COLLECTION_ALT_MESSAGE_ID = "coll.alt.";

    @Autowired
    private SolrSearchService searchService;

    @Autowired
    private MessageSource messageSource;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Autowired
    WaybackIpResolver waybackIpResolver;

    @RequestMapping(value = "", method = GET)
    public ModelAndView rootCollectionsPage(HttpServletRequest request) {
        Locale locale = getLocale(request);

        List<CollectionDTO> collections = generateRootCollectionDTOs(locale);

        ModelAndView mav = new ModelAndView("speccoll");
        mav.addObject("collections", collections);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }

    @RequestMapping(value = "/{collectionId}", method = GET)
    public ModelAndView collectionOverviewPage(@PathVariable("collectionId") String collectionId,
                                               @RequestParam(value = "page", required = false) String pageNum,
                                               HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        boolean userIpFromBl = waybackIpResolver.isUserIpFromBl(request);
        long totalSearchResultsSize = 0;
        long targetPageNumber = isNumeric(pageNum) ? Long.valueOf(pageNum) : 1;
        long startFromRow = (targetPageNumber - 1) * ROWS_PER_PAGE_DEFAULT;

        SolrSearchResult<CollectionInfo> targetWebsitesSearchResult = searchService
                .fetchChildCollections(singletonList(collectionId), TYPE_TARGET, ROWS_PER_PAGE_DEFAULT, startFromRow);
        List<CollectionInfo> targetWebsitesDocuments = targetWebsitesSearchResult.getResponseBody().getDocuments();
        totalSearchResultsSize = targetWebsitesSearchResult.getResponseBody().getNumFound();

        String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
        Locale locale = getLocale(request);

        List<TargetWebsiteDTO> targetWebsites = generateTargetWebsitesDTOs(targetWebsitesDocuments, rootPathWithLang, userIpFromBl);
        List<CollectionDTO> subCollections = generateSubCollectionDTOs(collectionId, locale);
        CollectionDTO currentCollection = generatePlainCollectionDTO(collectionId, locale, targetWebsitesSearchResult);
        Map<String, String> breadcrumbPath = buildCollectionBreadcrumbPath(currentCollection);


        ModelAndView mav = new ModelAndView("coll");
        mav.addObject("userIpFromBl", userIpFromBl);
        mav.addObject("breadcrumbPath", breadcrumbPath);
        mav.addObject("targetWebsites", targetWebsites);
        mav.addObject("subCollections", subCollections);
        mav.addObject("currentCollection", currentCollection);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("targetPageNumber", targetPageNumber);
        mav.addObject("rowsPerPageLimit", ROWS_PER_PAGE_DEFAULT);
        mav.addObject("totalSearchResultsSize", totalSearchResultsSize);
        mav.addObject("totalPages", (int) (Math.ceil(totalSearchResultsSize / (double) ROWS_PER_PAGE_DEFAULT)));

        return mav;
    }

    private Map<String, String> buildCollectionBreadcrumbPath(CollectionDTO currentCollectionDto) {
        Map<String, String> path = new LinkedHashMap<>();
        path.put(currentCollectionDto.getId(), currentCollectionDto.getName());

        String parentCollectionId = currentCollectionDto.getParentId();
        while (parentCollectionId != null) {
            CollectionInfo parentCollection = searchService
                    .fetchCollectionById(parentCollectionId)
                    .getResponseBody().getDocuments()
                    .get(0);

            //Create a new map to get reversed map in result
            Map<String, String> oldPath = new LinkedHashMap<>(path);
            path.clear();
            path.put(parentCollection.getId(), parentCollection.getName());
            path.putAll(oldPath);

            parentCollectionId = parentCollection.getParentId();
        }

        return path;
    }

    private List<CollectionDTO> generateSubCollectionDTOs(String collectionId, Locale locale) {
        return searchService
                .fetchChildCollections(singletonList(collectionId), TYPE_COLLECTION, 1000, 0)
                .getResponseBody().getDocuments()
                .stream()
                .map(d -> toCollectionDTO(d, true, locale))
                .collect(Collectors.toList());
    }

    private List<CollectionDTO> generateRootCollectionDTOs(Locale locale) {
        Map<String, CollectionDTO> rootCollections = searchService
                .fetchRootCollections()
                .getResponseBody().getDocuments()
                .stream()
                .collect(Collectors
                        .toMap(CollectionInfo::getId, collection -> toCollectionDTO(collection, true, locale)));

        Set<String> parentCollectionIds = rootCollections.keySet();

        searchService
                .fetchChildCollections(parentCollectionIds, TYPE_COLLECTION, 1000, 0)
                .getResponseBody().getDocuments()
                .stream()
                .forEach(subCollection -> {
                    String parentId = subCollection.getParentId();

                    CollectionDTO parentCollectionDto = rootCollections.get(parentId);
                    if (parentCollectionDto.getSubCollections() == null) {
                        parentCollectionDto.setSubCollections(new ArrayList<>());
                    }

                    CollectionDTO subCollectionDTO = toCollectionDTO(subCollection, true, locale);
                    parentCollectionDto.getSubCollections().add(subCollectionDTO);

                });

        ArrayList<CollectionDTO> sortedCollectionDTOs = new ArrayList<>(rootCollections.values());
        Collections.sort(sortedCollectionDTOs, (c1, c2) -> c1.getName().compareTo(c2.getName()));

        return sortedCollectionDTOs;
    }

    private CollectionDTO generatePlainCollectionDTO(String collectionId,
                                                     Locale locale,
                                                     SolrSearchResult<CollectionInfo> targetWebsitesSearchResult) {
        CollectionInfo currentCollectionInformation = searchService
                .fetchCollectionById(collectionId)
                .getResponseBody().getDocuments()
                .get(0);

        CollectionDTO collectionDTO = toCollectionDTO(currentCollectionInformation, false, locale);
        collectionDTO.setWebsitesNum(targetWebsitesSearchResult.getResponseBody().getNumFound());

        return collectionDTO;
    }

    private List<TargetWebsiteDTO> generateTargetWebsitesDTOs(List<CollectionInfo> websites,
                                                              String rootPathWithLang,
                                                              boolean userIpFromBl) {
        return websites
                .stream()
                .map(websiteInfo -> toTargetWebsiteDTO(rootPathWithLang, websiteInfo, userIpFromBl))
                .collect(Collectors.toList());
    }

    private static TargetWebsiteDTO toTargetWebsiteDTO(String rootPathWithLang,
                                                       CollectionInfo websiteInfo,
                                                       boolean userIpFromBl) {
        boolean readRoomOnlyAccess = readRoomOnlyAccess(websiteInfo);

        String id = websiteInfo.getId();
        String name = websiteInfo.getTitle();
        String screenshotName = "thumbnail-default-" + ((int) (16 * Math.random()) + 1) + ".png";
        String description = websiteInfo.getDescription() != null
                ? websiteInfo.getDescription().replaceAll("<[^>]*>", "")
                : null;
        String shortDescription = abbreviate(description, 60);
        String wayBackUrl;
        if (!userIpFromBl && readRoomOnlyAccess) {
            //Redirect to page with information about Reading Room Only restriction
            wayBackUrl = "noresults";
        } else {
            wayBackUrl = rootPathWithLang + "wayback/*/" + websiteInfo.getUrl();
        }

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
        targetWebsite.setAccess(readRoomOnlyAccess ? "RRO" : "OA");

        return targetWebsite;
    }

    private CollectionDTO toCollectionDTO(CollectionInfo collectionInfo, boolean abbreviate, Locale locale) {
        String id = collectionInfo.getId();
        String parentId = collectionInfo.getParentId();
        String name = collectionInfo.getName();
        String fullDescription = collectionInfo.getDescription() != null
                ? collectionInfo.getDescription().replaceAll("<[^>]*>", "")
                : null;

        String shortDescription = abbreviate
                ? abbreviate(fullDescription, 60)
                : fullDescription;

        String defaultImageAltMessage = messageSource.getMessage(COLLECTION_ALT_MESSAGE_DEFAULT, null, locale);
        String imageAltMessage = messageSource.getMessage(COLLECTION_ALT_MESSAGE_ID + id, null, defaultImageAltMessage, locale);

        return new CollectionDTO(id, parentId, name, shortDescription, fullDescription, imageAltMessage, 0, 0, 0);
    }

    private static boolean readRoomOnlyAccess(CollectionInfo websiteInfo) {
        return websiteInfo.getLicenses() == null || websiteInfo.getLicenses().size() == 0;
    }

}
