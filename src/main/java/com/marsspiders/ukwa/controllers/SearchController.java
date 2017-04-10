package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
import com.marsspiders.ukwa.solr.SearchByEnum;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.FacetCounts;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
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
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static com.marsspiders.ukwa.controllers.CollectionController.ROWS_PER_PAGE;
import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.solr.SearchByEnum.TITLE;
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

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    SolrSearchService searchService;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "", method = GET)
    public ModelAndView searchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
                                   @RequestParam(value = "text", required = false) String text,
                                   @RequestParam(value = "page", required = false) String pageNum,
                                   @RequestParam(value = "content_type", required = false) String[] checkedDocumentTypes,
                                   @RequestParam(value = "public_suffix", required = false) String[] checkedPublicSuffixes,
                                   @RequestParam(value = "from_date", required = false) String fromDateText,
                                   @RequestParam(value = "to_date", required = false) String toDateText,
                                   @RequestParam(value = "range_date", required = false) String[] checkedRangeDates,
                                   @RequestParam(value = "collection", required = false) String[] checkedCollectionIds,
                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException, ParseException {

        List<String> originalDocumentTypes = checkedDocumentTypes != null ? asList(checkedDocumentTypes) : emptyList();
        List<String> originalPublicSuffixes = checkedPublicSuffixes != null ? asList(checkedPublicSuffixes) : emptyList();
        List<String> originalRangeDates = checkedRangeDates != null ? asList(checkedRangeDates) : emptyList();
        List<String> originalCollectionIds = checkedCollectionIds != null ? asList(checkedCollectionIds) : emptyList();
        long targetPageNumber = isNumeric(pageNum) ? Long.valueOf(pageNum) : 1;
        long totalSearchResultsSize = 0;

        SearchByEnum searchBy = SearchByEnum.fromString(searchLocation);
        List<SearchResultDTO> searchResultDTOs = new ArrayList<>();
        List<String> contentTypesPairs = new LinkedList<>();
        List<String> publicSuffixesPairs = new LinkedList<>();
        List<String> rangeDatesPairs = new LinkedList<>();
        Map<String, String> collectionsNamesToId = new HashMap<>();

        if (!isBlank(text) && searchBy != null) {
            long startFromRow = (targetPageNumber - 1) * ROWS_PER_PAGE;
            Date fromDate = isBlank(fromDateText) ? null : sdf.parse(fromDateText);
            Date toDate = isBlank(toDateText) ? null : sdf.parse(toDateText);

            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContent(searchBy, text,
                    ROWS_PER_PAGE, startFromRow, originalDocumentTypes, originalPublicSuffixes,
                    fromDate, toDate, originalRangeDates, originalCollectionIds);

            searchResultDTOs = toSearchResults(archivedSites, request, searchBy, text);
            totalSearchResultsSize = archivedSites.getResponseBody().getNumFound();

            FacetCounts facetCounts = archivedSites.getFacetCounts();
            if (facetCounts != null && facetCounts.getFields() != null) {
                LinkedList<String> datesCount = facetCounts.getRanges().getCrawlDateRange().getCount();

                contentTypesPairs = facetCounts.getFields().getContentTypes();
                publicSuffixesPairs = facetCounts.getFields().getPublicSuffixes();
                rangeDatesPairs = toRangeDates(datesCount);
                collectionsNamesToId = searchService.getParentCollections(facetCounts.getFields().getHosts());
            }
        }

        ModelAndView mav = new ModelAndView("search");
        mav.addObject("searchResults", searchResultDTOs);
        mav.addObject("totalSearchResultsSize", totalSearchResultsSize);
        mav.addObject("contentTypes", contentTypesPairs);
        mav.addObject("publicSuffixes", publicSuffixesPairs);
        mav.addObject("rangeDates", rangeDatesPairs);
        mav.addObject("collectionsNamesToId", collectionsNamesToId);
        mav.addObject("originalSearchRequest", text);
        mav.addObject("originalSearchLocation", searchLocation);
        mav.addObject("originalContentTypes", originalDocumentTypes);
        mav.addObject("originalPublicSuffixes", originalPublicSuffixes);
        mav.addObject("originalFromDateText", fromDateText);
        mav.addObject("originalToDateText", toDateText);
        mav.addObject("originalRangeDates", originalRangeDates);
        mav.addObject("originalCollectionIds", originalCollectionIds);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("targetPageNumber", targetPageNumber);
        mav.addObject("rowsPerPageLimit", ROWS_PER_PAGE);
        mav.addObject("totalPages", (int) (Math.ceil(totalSearchResultsSize / (double) ROWS_PER_PAGE)));

        return mav;
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
                                                  String textToSearch) throws MalformedURLException, URISyntaxException {
        String rootPathWithLang = getRootPathWithLang(request, setProtocolToHttps);
        List<ContentInfo> contentInfoList = archivedSites.getResponseBody().getDocuments();

        return contentInfoList
                .stream()
                .map(d -> {

                    String url = d.getUrl() != null ? d.getUrl().get(0) : "";
                    String wayBackUrl = rootPathWithLang + "wayback/" + d.getWayback_date() + "/" + url;
                    String shortContent = toShortContent(searchLocation, textToSearch, d);

                    SearchResultDTO searchResult = new SearchResultDTO();
                    searchResult.setId(d.getId());
                    searchResult.setTitle(abbreviate(d.getTitle(), 70));
                    searchResult.setDate(d.getCrawl_date().substring(0, 10));
                    searchResult.setText(shortContent);
                    searchResult.setDisplayUrl(url);
                    searchResult.setUrl(wayBackUrl);
                    searchResult.setDomain(d.getDomain());

                    return searchResult;
                })
                .collect(toList());
    }

    private String toShortContent(SearchByEnum searchLocation, String textToSearch, ContentInfo d) {
        String escapedContent = toEscapedContent(searchLocation, d);

        String textToSearchByWord[] = textToSearch.trim().replaceAll("\\s+", " ").split(" ", 2);
        int startOfFirstWord = escapedContent.indexOf(textToSearchByWord[0]);
        int startOfContentToShow = startOfFirstWord < 25 ? 0 : startOfFirstWord - 25;
        return abbreviate(escapedContent, startOfContentToShow, 300);
    }

    private String toEscapedContent(SearchByEnum searchLocation, ContentInfo contentInfo) {
        String content = searchLocation == TITLE || contentInfo.getContent() == null
                ? ""
                : contentInfo.getContent().get(0);

        return content != null
                ? content.replaceAll("<[^>]*>", "")
                : "";
    }

}
