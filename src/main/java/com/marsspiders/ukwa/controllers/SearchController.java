package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
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
import java.text.NumberFormat;
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
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isNumeric;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/search")
public class SearchController {
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
    public ModelAndView searchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
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
                                   //Modal Dialog - hidden modal_domains_vals FOR MAIN FILTER FORM
                                   @RequestParam(value = "modal_filter_domains_vals", required = false) String[] checked_domains_FromModal,
                                   @RequestParam(value = "modal_filter_suffix_vals", required = false) String[] checked_suffix_FromModal,
                                   @RequestParam(value = "modal_filter_documenttypes_vals", required = false) String[] checked_contenttypes_FromModal,
                                   @RequestParam(value = "modal_filter_collections_vals", required = false) String[] checked_collections_FromModal,
                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException, ParseException {

        List<SearchResultDTO> searchResultDTOs = new ArrayList<>();
        List<String> accessTermsPairs = new LinkedList<>();
        List<String> contentTypesPairs = new LinkedList<>();
        List<String> publicSuffixesPairs = new LinkedList<>();
        List<String> domainsPairs = new LinkedList<>();
        List<String> collectionPairs = new LinkedList<>();

        List<String> originalDomains = ((checked_domains_FromModal != null && checked_domains_FromModal.length!=0) ? asList(checked_domains_FromModal) : (checkedDomains != null ? asList(checkedDomains) : emptyList()));
        List<String> originalContentTypes = (checked_contenttypes_FromModal != null && checked_contenttypes_FromModal.length!=0) ? asList(checked_contenttypes_FromModal) : checkedContentTypes != null ? asList(checkedContentTypes) : emptyList();
        List<String> originalPublicSuffixes = (checked_suffix_FromModal != null && checked_suffix_FromModal.length!=0) ? asList(checked_suffix_FromModal) : checkedPublicSuffixes != null ? asList(checkedPublicSuffixes) : emptyList();
        List<String> originalRangeDates = checkedRangeDates != null ? asList(checkedRangeDates) : emptyList();
        List<String> originalCollections = (checked_collections_FromModal != null && checked_collections_FromModal.length!=0) ? asList(checked_collections_FromModal) : checkedCollections != null ? asList(checkedCollections) : emptyList();

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
            Date fromDate = isBlank(fromDateText) ? null : sdf.parse(fromDateText);
            Date toDate = isBlank(toDateText) ? null : sdf.parse(toDateText);

            if (isValidUrl(text)) {
                SolrSearchResult<ContentInfo> archivedSitesByOriginalUrl = searchService.searchUrlInContent(text);
                List<ContentInfo> urlSearchResults = archivedSitesByOriginalUrl.getResponseBody().getDocuments();

                if (urlSearchResults.size() > 0) {
                    String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
                    ContentInfo contentInfo = urlSearchResults.get(0);

                    SearchResultDTO originalUrlSearchResultDTO = toSearchResultDto(archivedSitesByOriginalUrl, searchBy,
                            rootPathWithLang, contentInfo, userIpFromBl);
                    searchResultDTOs.add(originalUrlSearchResultDTO);
                }
            }

            int startRowToSend = startFromRow <= solrSearchResultsLimit ? startFromRow : 1;
            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContent(searchBy, text, rowsPerPage,
                    sortBy, accessTo, startRowToSend, originalContentTypes, originalPublicSuffixes, originalDomains,
                    fromDate, toDate, originalRangeDates, originalCollections);


            searchResultDTOs.addAll(toSearchResults(archivedSites, request, searchBy, userIpFromBl));
            totalSearchResultsSize = archivedSites.getResponseBody().getNumFound();

            FacetCounts facetCounts = archivedSites.getFacetCounts();
            if (facetCounts != null && facetCounts.getFields() != null) {
                accessTermsPairs = facetCounts.getFields().getAccessTerms();
                contentTypesPairs = facetCounts.getFields().getTypes();
                publicSuffixesPairs = facetCounts.getFields().getPublicSuffixes();
                domainsPairs = facetCounts.getFields().getDomains();
                collectionPairs = facetCounts.getFields().getCollections();
            }
        }

        String originalAccessView = accessTo == null ? "" : accessTo.getWebRequestAccessRestriction();
        String originalSortValue = sortBy == null ? "" : sortBy.getWebRequestOrderValue();

        log.debug("originalAccessView = " + originalAccessView);
        log.debug("originalSortValue = " + originalSortValue);


        ModelAndView mav = new ModelAndView("search");
        mav.addObject("totalSearchResultsSize", totalSearchResultsSize);
        mav.addObject("totalSearchResultsSizeFormatted", NumberFormat.getInstance().format(totalSearchResultsSize));
        mav.addObject("accessTerms", accessTermsPairs);
        mav.addObject("contentTypes", contentTypesPairs);
        mav.addObject("publicSuffixes", publicSuffixesPairs);
        mav.addObject("domains", domainsPairs);
        mav.addObject("collections", collectionPairs);
        mav.addObject("originalSearchRequest", text == null ? "" : text.replaceAll("\"", "&quot;"));
        mav.addObject("originalSearchLocation", searchLocation);
        mav.addObject("originalContentTypes", originalContentTypes);
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
        mav.addObject("totalPages", (int) (Math.ceil(totalSearchResultsSize / (double) rowsPerPage)));

        if (startFromRow < solrSearchResultsLimit) {
            mav.addObject("searchResults", searchResultDTOs);
        } else {
            mav.addObject("deepPaging", true);
            mav.addObject("searchResults", new ArrayList<>());
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

    private List<SearchResultDTO> toSearchResults(SolrSearchResult<ContentInfo> archivedSites,
                                                  HttpServletRequest request,
                                                  SearchByEnum searchLocation,
                                                  boolean userIpFromBl)
            throws MalformedURLException, URISyntaxException {
        String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
        List<ContentInfo> contentInfoList = archivedSites.getResponseBody().getDocuments();

        return contentInfoList
                .stream()
                .map(archivedSiteInfo -> toSearchResultDto(archivedSites, searchLocation, rootPathWithLang, archivedSiteInfo, userIpFromBl))
                .collect(toList());
    }

    private static SearchResultDTO toSearchResultDto(SolrSearchResult<ContentInfo> archivedSites,
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

        SearchResultDTO searchResult = new SearchResultDTO();
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
