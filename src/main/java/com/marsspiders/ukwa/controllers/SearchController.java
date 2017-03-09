package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
import com.marsspiders.ukwa.solr.DocumentTypeEnum;
import com.marsspiders.ukwa.solr.SearchByEnum;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.ContentInfo;
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
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.CollectionController.ROWS_PER_PAGE;
import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static com.marsspiders.ukwa.solr.SearchByEnum.TITLE;
import static com.marsspiders.ukwa.util.UrlUtil.getRootPathWithLang;
import static java.util.Arrays.asList;
import static java.util.Collections.emptyList;
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isNumeric;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/search")
public class SearchController {

    private static final String SEARCH_LOCATION_FULL_TEXT = "full_text";
    private static final String SEARCH_LOCATION_TITLE = "title";
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    @Autowired
    SolrSearchService searchService;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "", method = GET)
    public ModelAndView searchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
                                   @RequestParam(value = "text", required = false) String text,
                                   @RequestParam(value = "page", required = false) String pageNum,
                                   @RequestParam(value = "from_date", required = false) String fromDateText,
                                   @RequestParam(value = "to_date", required = false) String toDateText,
                                   @RequestParam(value = "doc_type", required = false) String[] documentTypes,
                                   @RequestParam(value = "public_suffix", required = false) String[] checkedPublicSuffixes,
                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException, ParseException {
        List<SearchResultDTO> searchResultDTOs = new ArrayList<>();
        List<String> originalPublicSuffixes = checkedPublicSuffixes != null ? asList(checkedPublicSuffixes) : emptyList();
        long targetPageNumber = isNumeric(pageNum) ? Long.valueOf(pageNum) : 1;
        long totalSearchResultsSize = 0;

        SearchByEnum searchBy = SearchByEnum.fromString(searchLocation);
        LinkedList<String> publicSuffixes = new LinkedList<>();
        if (!isBlank(text) && searchBy != null) {
            long startFromRow = (targetPageNumber - 1) * ROWS_PER_PAGE;
            Date fromDate = isBlank(fromDateText) ? null : sdf.parse(fromDateText);
            Date toDate = isBlank(toDateText) ? null : sdf.parse(toDateText);
            List<DocumentTypeEnum> documentTypesList = toDocumentTypes(documentTypes);

            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContentByFullText(
                    searchBy, text, ROWS_PER_PAGE, startFromRow, fromDate, toDate, documentTypesList, originalPublicSuffixes);

            if (archivedSites.getFacetCounts() != null && archivedSites.getFacetCounts().getFacetFields() != null) {
                publicSuffixes = archivedSites.getFacetCounts().getFacetFields().getPublicSuffixes();
            }
            totalSearchResultsSize = archivedSites.getResponseBody().getNumFound();
            searchResultDTOs = toSearchResults(archivedSites, request, searchBy, text);
        }

        ModelAndView mav = new ModelAndView("search");
        mav.addObject("searchResults", searchResultDTOs);
        mav.addObject("totalSearchResultsSize", totalSearchResultsSize);
        mav.addObject("publicSuffixes", publicSuffixes);
        mav.addObject("originalSearchRequest", text);
        mav.addObject("originalSearchLocation", searchLocation);
        mav.addObject("originalToDateText", toDateText);
        mav.addObject("originalFromDateText", fromDateText);
        mav.addObject("originalDocumentTypes", documentTypes != null ? asList(documentTypes) : emptyList());
        mav.addObject("originalPublicSuffixes", originalPublicSuffixes);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);
        mav.addObject("targetPageNumber", targetPageNumber);
        mav.addObject("rowsPerPageLimit", ROWS_PER_PAGE);
        mav.addObject("totalPages", (int) (Math.ceil(totalSearchResultsSize / (double) ROWS_PER_PAGE)));

        return mav;
    }

    private List<DocumentTypeEnum> toDocumentTypes(String[] docType) {
        List<DocumentTypeEnum> documentTypes = new ArrayList<>();
        if (docType == null) {
            return documentTypes;
        }

        for (String type : docType) {
            DocumentTypeEnum documentType = DocumentTypeEnum.fromString(type);
            if (documentType != null) {
                documentTypes.add(documentType);
            }
        }

        return documentTypes;
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
                    String content = searchLocation == TITLE || d.getContent() == null
                            ? ""
                            : d.getContent().get(0);

                    String escapedContent = content != null
                            ? content.replaceAll("<[^>]*>", "")
                            : "";

                    String textToSearchByWord[] = textToSearch.trim().replaceAll("\\s+", " ").split(" ", 2);
                    int startOfFirstWord = escapedContent.indexOf(textToSearchByWord[0]);
                    int startOfContentToShow = startOfFirstWord < 25 ? 0 : startOfFirstWord - 25;
                    String shortContent = abbreviate(escapedContent, startOfContentToShow, 300);

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
                .collect(Collectors.toList());
    }

}
