package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.AdvancedSearchResultDTO;
import com.marsspiders.ukwa.ip.WaybackIpResolver;
import com.marsspiders.ukwa.solr.AccessToEnum;
import com.marsspiders.ukwa.solr.SearchByEnum;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.SortByEnum;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.FacetCounts;
import com.marsspiders.ukwa.solr.data.HighlightingContent;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import com.marsspiders.ukwa.util.UrlUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import static com.marsspiders.ukwa.controllers.CollectionController.ROWS_PER_PAGE_DEFAULT;
import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.solr.AccessToEnum.VIEWABLE_ANYWHERE;
import static com.marsspiders.ukwa.solr.SearchByEnum.FULL_TEXT;
import static com.marsspiders.ukwa.util.UrlUtil.getRootPathWithLang;
import static java.util.Arrays.asList;
import static java.util.Collections.emptyList;
import static java.util.stream.Collectors.toList;
import static org.apache.commons.lang3.StringUtils.*;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

//import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
//----------------
//---------------

//import com.marsspiders.ukwa.controllers.data.SearchResultDTO;

/**
 * Created by mvidmantas on 13/10/2017.
 */
@Controller
@RequestMapping(value = PROJECT_NAME + "/advancedsearch")
public class AdvancedSearchController {
    private static final Logger log = LoggerFactory.getLogger(SolrSearchService.class);

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    private static final String URL_PATTERN = "(?i)^(?:(?:https?|ftp)://)?(?:\\S+(?::\\S*)?@)?(?:(?!(?:10|127)(?:\\.\\d{1,3}){3})(?!(?:169\\.254|192\\.168)(?:\\.\\d{1,3}){2})(?!172\\.(?:1[6-9]|2\\d|3[0-1])(?:\\.\\d{1,3}){2})(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]-*)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,}))\\.?)(?::\\d{2,5})?(?:[/?#]\\S*)?$";
    //Best URL regex validator from: https://mathiasbynens.be/demo/url-regex
    //checker: https://regex101.com

    @Autowired
    SolrSearchService searchService;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Value("${solr.search.results.limit}")
    private int solrSearchResultsLimit;

    @Autowired
    WaybackIpResolver waybackIpResolver;

    @RequestMapping(value = "", method = GET)
    public ModelAndView advancedSearchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
                                   @RequestParam(value = "text", required = false) String text,
                                   @RequestParam(value = "page", required = false) String pageNum,
                                   @RequestParam(value = "content_type", required = false) String[] checkedContentTypes,
                                   @RequestParam(value = "public_suffix", required = false) String[] checkedPublicSuffixes,
                                   @RequestParam(value = "domain_filter", required = false) String[] checkedDomains,
                                   @RequestParam(value = "from_date", required = false) String fromDateText,
                                   @RequestParam(value = "to_date", required = false) String toDateText,
                                   @RequestParam(value = "range_date", required = false) String[] checkedRangeDates,
                                   @RequestParam(value = "collection", required = false) String[] checkedCollections,
                                   @RequestParam(value = "view_sort", required = false) String sortValue,
                                   @RequestParam(value = "view_count", required = false) String viewCount,
                                   @RequestParam(value = "view_filter", required = false) String accessViewFilter,

                                   //---------------- NEW
                                           @RequestParam(value = "checkedPhrases", required = false) String[] checkedPhrases,
                                           @RequestParam(value = "postcode_district", required = false) String[] checkedPostcodeDistricts,
                                           @RequestParam(value = "content_language", required = false) String[] checkedContentLanguages,
                                           @RequestParam(value = "links_domains", required = false) String[] checkedLinksDomains,
                                           @RequestParam(value = "crawlDates", required = false) String[] checkedCrawlDates,


                                           // advanced search form fields
                                   @RequestParam(value = "proximityPhrase1", required = false) String proximityPhrase1,
                                   @RequestParam(value = "proximityPhrase2", required = false) String proximityPhrase2,
                                           @RequestParam(value = "proximityDistance", required = false) String proximityDistance,
                                           @RequestParam(value = "excludedWords", required = false) String excludedWords,
                                   @RequestParam(value = "dateStart", required = false) String dateStartText,
                                   @RequestParam(value = "dateStop", required = false) String dateStopText,
                                   @RequestParam(value = "hostDomainPublicText", required = false) String hostDomainPublicText,
                                   @RequestParam(value = "fileFormatText", required = false) String fileFormatText,
                                   @RequestParam(value = "websiteTitleText", required = false) String websiteTitleText,
                                   @RequestParam(value = "pageTitleText", required = false) String pageTitleText,
                                   @RequestParam(value = "authorText", required = false) String authorText,


                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException, ParseException {

        log.debug("====================================================================================");
        log.debug("ADVANCED CONTROLLER - searchPage " + request.getParameter("searchButtons"));
        log.debug("====================================================================================");
        if (request.getParameter("searchButtons") != null){
            String searchButtonAction = request.getParameter("searchButtons");
            if(searchButtonAction.equals("basicsearch") )
            {
                log.info("ADVANCED advancedSearchPage - basicsearch = " + request.getParameter("searchButtons"));
                log.debug("ADVANCED advancedSearchPage - basicsearch = " + request.getParameter("searchButtons"));
            }
            else if(searchButtonAction.equals("advancedsearch"))
            {
                log.info("ADVANCED advancedSearchPage - advancedsearch");
                log.debug("ADVANCED advancedSearchPage - advancedsearch ");
            }
        }


        log.info("------------------------------------------------------------");
        log.info("advancedSearchPage searchLocation=" + searchLocation
                + ", proximityPhrase1 = " + proximityPhrase1
                + ", proximityPhrase2 = " + proximityPhrase2
                + ", proximityDistance = " + proximityDistance);
        log.info("dateStartText = " + dateStartText + ", dateStopText = " + dateStopText);

        List<AdvancedSearchResultDTO> searchResultDTOs = new ArrayList<>();
        List<String> accessTermsPairs = new LinkedList<>();
        List<String> contentTypesPairs = new LinkedList<>();
        List<String> publicSuffixesPairs = new LinkedList<>();
        List<String> domainsPairs = new LinkedList<>();
        List<String> collectionPairs = new LinkedList<>();
        //----------------new FACETS----------------------------------------------
        List<String> phrasePairs = new LinkedList<>();
        List<String> dateWithGapPairs = new LinkedList<>();

        List<String> linksDomainsPairs = new LinkedList<>();
        List<String> postcodeDistrictsPairs = new LinkedList<>();
        List<String> contentLanguagesPairs = new LinkedList<>();
        List<String> crawlDatesPairs = new LinkedList<>();

        //------------------------------------------------------------------------

        List<String> originalContentTypes = checkedContentTypes != null ? asList(checkedContentTypes) : emptyList();
        List<String> originalPublicSuffixes = checkedPublicSuffixes != null ? asList(checkedPublicSuffixes) : emptyList();
        List<String> originalDomains = checkedDomains != null ? asList(checkedDomains) : emptyList();
        List<String> originalRangeDates = checkedRangeDates != null ? asList(checkedRangeDates) : emptyList();
        List<String> originalCollections = checkedCollections != null ? asList(checkedCollections) : emptyList();

        // ------------- NEW -------------------
        List<String> originalPhrasePairs = checkedPhrases != null ? asList(checkedPhrases) : emptyList();

        List<String> originalLinksDomains = checkedLinksDomains != null ? asList(checkedLinksDomains) : emptyList();
        List<String> originalPostcodeDistricts = checkedPostcodeDistricts != null ? asList(checkedPostcodeDistricts) : emptyList();
        List<String> originalContentLanguages = checkedContentLanguages != null ? asList(checkedContentLanguages) : emptyList();
        List<String> originalCrawlDates = checkedCrawlDates != null ? asList(checkedCrawlDates) : emptyList();
        // ------------- NEW -------------------

        int rowsPerPage = isNumeric(viewCount) ? Integer.valueOf(viewCount) : ROWS_PER_PAGE_DEFAULT;
        int targetPageNumber = isNumeric(pageNum) ? Integer.valueOf(pageNum) : 1;
        int startFromRow = (targetPageNumber - 1) * rowsPerPage;
        long totalSearchResultsSize = 0;
        boolean userIpFromBl = waybackIpResolver.isUserIpFromBl(request);

        SearchByEnum searchBy = SearchByEnum.fromString(searchLocation);
        SortByEnum sortBy = SortByEnum.fromString(sortValue);
        if (sortBy == null) {
            sortBy = SortByEnum.NEWEST_TO_OLDEST;
        }

        AccessToEnum accessTo = AccessToEnum.fromString(accessViewFilter);
        if (accessTo == null && userIpFromBl) {
            accessTo = AccessToEnum.VIEWABLE_ONLY_ON_LIBRARY;
        }

        if (!isBlank(text) && searchBy != null) {
            //Date fromDate = isBlank(fromDateText) ? null : sdf.parse(fromDateText);
            //Date toDate = isBlank(toDateText) ? null : sdf.parse(toDateText);

            Date fromDate = isBlank(dateStartText) ? null : sdf.parse(dateStartText);
            Date toDate = isBlank(dateStopText) ? null : sdf.parse(dateStopText);

            if (isValidUrl(text)) {
                SolrSearchResult<ContentInfo> archivedSitesByOriginalUrl = searchService.searchUrlInContent(text);
                List<ContentInfo> urlSearchResults = archivedSitesByOriginalUrl.getResponseBody().getDocuments();

                if (urlSearchResults.size() > 0) {
                    String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
                    ContentInfo contentInfo = urlSearchResults.get(0);

                    AdvancedSearchResultDTO originalUrlSearchResultDTO = toAdvancedSearchResultDto(archivedSitesByOriginalUrl, searchBy,
                            rootPathWithLang, contentInfo, userIpFromBl);
                    searchResultDTOs.add(originalUrlSearchResultDTO);
                }
            }

            int startRowToSend = startFromRow <= solrSearchResultsLimit ? startFromRow : 1;

            //-------------------------------------------------------
            //USE searchService.advancedSearchContent
            //-------------------------------------------------------
            SolrSearchResult<ContentInfo> archivedSites = searchService.advancedSearchContent(
                    searchBy,
                    text,
                    //-----------------
                    proximityPhrase1,
                    proximityPhrase2,
                    proximityDistance,
                    excludedWords,
                    //originalAuthors,
                    originalPostcodeDistricts,
                    originalContentLanguages,
                    originalLinksDomains,
                    originalCrawlDates,
                    //-----------------
                    rowsPerPage,
                    sortBy,
                    accessTo,
                    startRowToSend,
                    originalContentTypes,
                    originalPublicSuffixes,
                    originalDomains,
                    fromDate, toDate,
                    originalRangeDates,
                    originalCollections);


            searchResultDTOs.addAll(toAdvancedSearchResults(archivedSites, request, searchBy, userIpFromBl));
            totalSearchResultsSize = archivedSites.getResponseBody().getNumFound();

            FacetCounts facetCounts = archivedSites.getFacetCounts();

            if (facetCounts != null && facetCounts.getFields() != null) {

                log.debug("facetCounts.getFields() = " + facetCounts.getFields());
                log.debug("facetCounts.getRanges() = " + facetCounts.getRanges());

                accessTermsPairs = facetCounts.getFields().getAccessTerms();
                contentTypesPairs = facetCounts.getFields().getTypes();
                publicSuffixesPairs = facetCounts.getFields().getPublicSuffixes();
                domainsPairs = facetCounts.getFields().getDomains();
                collectionPairs = facetCounts.getFields().getCollections();
                //------------- NEW ---------------------
                phrasePairs = facetCounts.getFields().getTypes();
                linksDomainsPairs = facetCounts.getFields().getLinksDomains();
                contentLanguagesPairs = facetCounts.getFields().getContentLanguages();
                postcodeDistrictsPairs = facetCounts.getFields().getPostcodeDistricts();
                crawlDatesPairs = facetCounts.getFields().getCrawlDates();




            }
        }

        //------------------------------------------------------
        //Proximity: could be 3 words and proximity distance
        //3 words: search term + phrase 1 + phrase 2
        //------------------------------------------------------

        String originalAccessView = accessTo == null ? "" : accessTo.getWebRequestAccessRestriction();
        String originalSortValue = sortBy == null ? "" : sortBy.getWebRequestOrderValue();

        ModelAndView mav = new ModelAndView("advancedSearch");
        mav.addObject("totalSearchResultsSize", totalSearchResultsSize);
        mav.addObject("accessTerms", accessTermsPairs);
        mav.addObject("contentTypes", contentTypesPairs);

        //-------- NEW -------------
        mav.addObject("phrasePairs", phrasePairs);
        mav.addObject("linksDomains", linksDomainsPairs);
        mav.addObject("contentLanguages", contentLanguagesPairs);
        mav.addObject("postcodeDistricts", postcodeDistrictsPairs);
        mav.addObject("crawlDates", crawlDatesPairs);
        //---------------------

        mav.addObject("publicSuffixes", publicSuffixesPairs);
        mav.addObject("domains", domainsPairs);
        mav.addObject("collections", collectionPairs);


        mav.addObject("originalSearchLocation", searchLocation);
        mav.addObject("originalContentTypes", originalContentTypes);

        //-------- NEW -------------
        mav.addObject("originalPhrasePairs", originalPhrasePairs);
        mav.addObject("originalLinksDomains", originalLinksDomains);
        mav.addObject("originalContentLanguages", originalContentLanguages);
        mav.addObject("originalPostcodeDistricts", originalPostcodeDistricts);
        mav.addObject("originalCrawlDates", originalCrawlDates);

        //------------------- if phrase1
        //if (text != null && proximityPhrase1!=null && proximityPhrase2!=null && proximityDistance!=null){
            //mav.addObject("originalSearchRequest", ("\"" + text + "\", \"" + proximityPhrase1 + "\", \"" + proximityPhrase2 + "\", <i>proximity Distance</i>  " + proximityDistance).replaceAll("\"", "&quot;"));
        //}
        //else

        mav.addObject("originalSearchRequest", text == null ? "" : text.replaceAll("\"", "&quot;"));
        //---------------------

        mav.addObject("originalPublicSuffixes", originalPublicSuffixes);
        mav.addObject("originalDomains", originalDomains);
        mav.addObject("originalFromDateText", fromDateText);
        mav.addObject("originalToDateText", toDateText);
        mav.addObject("originalRangeDates", originalRangeDates);
        mav.addObject("originalCollections", originalCollections);
        mav.addObject("originalAccessView", originalAccessView);
        mav.addObject("originalSortValue", originalSortValue);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("targetPageNumber", targetPageNumber);
        mav.addObject("rowsPerPageLimit", rowsPerPage);
        mav.addObject("userIpFromBl", userIpFromBl);

        //------------advanced
        mav.addObject("originalproximityPhrase1", proximityPhrase1);
        mav.addObject("originalproximityPhrase2", proximityPhrase2);
        mav.addObject("originalproximityDistance", proximityDistance);
        mav.addObject("originalExcludedWords", excludedWords);

        mav.addObject("originaldateStart", dateStartText);
        mav.addObject("originaldateStop", dateStopText);

        mav.addObject("originalhostDomainPublicText", hostDomainPublicText);
        mav.addObject("originalfileFormatText", fileFormatText);
        mav.addObject("originalwebsiteTitleText", websiteTitleText);
        mav.addObject("originalpageTitleText", pageTitleText);
        mav.addObject("originalauthorText", authorText);
        //------------advanced

        mav.addObject("totalPages", (int) (Math.ceil(totalSearchResultsSize / (double) rowsPerPage)));

        if (startFromRow < solrSearchResultsLimit) {
            mav.addObject("advancedSearchResults", searchResultDTOs);
        } else {
            mav.addObject("deepPaging", true);
            mav.addObject("advancedSearchResults", new ArrayList<>());
        }

        return mav;
    }


    private static boolean isValidUrl(String text) {
        return text.matches(URL_PATTERN);
    }

    private List<String> toRangeDates(LinkedList<String> crawlDatesCount) {
        return crawlDatesCount
                .stream()
                .map(date -> (date.length() > 10)
                        ? date.substring(0, 4)
                        : date)
                .collect(toList());
    }

    private List<AdvancedSearchResultDTO> toAdvancedSearchResults(SolrSearchResult<ContentInfo> archivedSites,
                                                                  HttpServletRequest request,
                                                                  SearchByEnum searchLocation,
                                                                  boolean userIpFromBl)
            throws MalformedURLException, URISyntaxException {
        String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
        List<ContentInfo> contentInfoList = archivedSites.getResponseBody().getDocuments();

        return contentInfoList
                .stream()
                .map(archivedSiteInfo -> toAdvancedSearchResultDto(archivedSites, searchLocation, rootPathWithLang, archivedSiteInfo, userIpFromBl))
                .collect(toList());
    }


    private static AdvancedSearchResultDTO toAdvancedSearchResultDto(SolrSearchResult<ContentInfo> archivedSites,
                                                                     SearchByEnum searchLocation,
                                                                     String rootPathWithLang,
                                                                     ContentInfo archivedSiteInfo,
                                                                     boolean userIpFromBl) {
        String url = archivedSiteInfo.getUrl() != null ? archivedSiteInfo.getUrl() : "";
        String wayBackUrl = toWayBackUrl(userIpFromBl, rootPathWithLang, archivedSiteInfo, url);
        HighlightingContent highlightingContent = archivedSites.getHighlighting() == null
                ? null
                : archivedSites.getHighlighting().get(archivedSiteInfo.getId());
        String escapedContent = toEscapedContent(searchLocation, highlightingContent);
        String originalDomain = toOriginalDomain(url);
        String abbreviatedTitle = abbreviate(archivedSiteInfo.getTitle(), 70);
        String displayCrawlDate = archivedSiteInfo.getCrawl_date().substring(0, 10);

        AdvancedSearchResultDTO searchResult = new AdvancedSearchResultDTO();
        searchResult.setId(archivedSiteInfo.getId());
        searchResult.setTitle(abbreviatedTitle);
        searchResult.setDate(displayCrawlDate);
        searchResult.setText(escapedContent);
        searchResult.setDisplayUrl(url);
        searchResult.setUrl(wayBackUrl);
        searchResult.setDisplayDomain(archivedSiteInfo.getDomain());
        searchResult.setDomain(originalDomain);
        searchResult.setAccess(readRoomOnlyAccess(archivedSiteInfo) ? "RRO" : "OA");

        return searchResult;
    }

    private static String toEscapedContent(SearchByEnum searchLocation, HighlightingContent highlightingContent) {
        String escapedContent = "";
        if (searchLocation == FULL_TEXT && highlightingContent != null && highlightingContent.getContent() != null) {
            String shortContent = highlightingContent.getContent().get(0);
            escapedContent = shortContent != null ? shortContent.replaceAll("<[^>]*>", "") : "";
        }

        return escapedContent;
    }

    private static String toWayBackUrl(boolean userIpFromBl, String rootPathWithLang, ContentInfo archivedSiteInfo, String url) {
        if (!userIpFromBl && readRoomOnlyAccess(archivedSiteInfo)) {
            //Redirect to page with information about Reading Room Only restriction
            return "noresults";
        }

        //If site available for Open Access, we should set accessFlag to 'OA' to use default off-site wayback url in ArchiveController
        String accessFlag = readRoomOnlyAccess(archivedSiteInfo) ? "RRO" : VIEWABLE_ANYWHERE.getSolrRequestAccessRestriction();
        //Need to replace "jsp", "JSP" to avoid treating .jsp file in wayback url as its own url by Spring
        String urlWithUppercaseJsp = url.replace(".jsp", ".JSP");
        return rootPathWithLang + "wayback/" + accessFlag + "/" + archivedSiteInfo.getWayback_date() + "/" + urlWithUppercaseJsp;
    }

    private static boolean readRoomOnlyAccess(ContentInfo archivedSiteInfo) {
        return archivedSiteInfo.getAccess_terms() != null
                && archivedSiteInfo.getAccess_terms().size() == 1
                && archivedSiteInfo.getAccess_terms().get(0).equals("RRO");
    }

    private static String toOriginalDomain(String url) {
        String domain = "";
        try {
            domain = UrlUtil.getOnlyDomainWithProtocol(url);
        } catch (MalformedURLException | URISyntaxException e) {
            log.error("Failed to calculate original domain url", e);
        }

        return domain;
    }

}
