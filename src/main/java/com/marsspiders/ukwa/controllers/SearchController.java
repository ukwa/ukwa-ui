package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.LocaleConfiguration;
import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.HomeController.PROJECT_NAME;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/search")
public class SearchController {

    private static final String TYPE_COLLECTION = "collection";
    private static final String TYPE_TARGET = "target";
    private static final String SEARCH_LOCATION_FULL_TEXT = "full_text";
    private static final String SEARCH_LOCATION_TITLE = "title";

    @Autowired
    SolrSearchService searchService;

    @RequestMapping(value = "", method = GET)
    public ModelAndView searchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
                                   @RequestParam(value = "text", required = false) String text,
                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        List<SearchResultDTO> searchResultDTOs = new ArrayList<>();

        if (SEARCH_LOCATION_FULL_TEXT.equalsIgnoreCase(searchLocation)) {
            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContentByFullText(text);
            List<ContentInfo> contentInfoList = archivedSites.getResponseBody().getDocuments();

            String rootPathWithLang = getRootPathWithLang(request);
            searchResultDTOs = toSearchResults(contentInfoList, rootPathWithLang, searchLocation);
        } else if (SEARCH_LOCATION_TITLE.equalsIgnoreCase(searchLocation)) {
            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContentByTitle(text);
            List<ContentInfo> collectionInfoList = archivedSites.getResponseBody().getDocuments();

            String rootPathWithLang = getRootPathWithLang(request);
            searchResultDTOs = toSearchResults(collectionInfoList, rootPathWithLang, searchLocation);
        }

        ModelAndView mav = new ModelAndView("search");
        mav.addObject("searchResults", searchResultDTOs);
        mav.addObject("totalSearchResultsSize", searchResultDTOs != null ? searchResultDTOs.size() : 0);
        mav.addObject("originalSearchRequest", text);
        mav.addObject("originalSearchLocation", searchLocation);

        return mav;
    }

    private List<SearchResultDTO> toSearchResults(List<ContentInfo> contentInfoList, String rootPathWithLang, String searchLocation) {
        return contentInfoList
                .stream()
                .map(d -> {

                    String url = d.getUrl() != null ? d.getUrl().get(0) : "";
                    String wayBackUrl = rootPathWithLang + "wayback/" + d.getWayback_date() + "/" + url;
                    String text = SEARCH_LOCATION_TITLE.equalsIgnoreCase(searchLocation) || d.getContent() == null
                            ? ""
                            : d.getContent().get(0);

                    SearchResultDTO searchResult = new SearchResultDTO();
                    searchResult.setId(d.getId());
                    searchResult.setTitle(d.getTitle());
                    searchResult.setDate(d.getCrawl_date());
                    searchResult.setText(text);
                    searchResult.setDisplayUrl(url);
                    searchResult.setUrl(wayBackUrl);
                    searchResult.setDomain(d.getDomain());

                    return searchResult;
                })
                .collect(Collectors.toList());
    }

    private List<SearchResultDTO> toTitleSearchResults(List<ContentInfo> contentInfoList, String rootPathWithLang) {
        return contentInfoList
                .stream()
                .map(d -> {
                    String url = d.getUrl() != null ? d.getUrl().get(0) : "";
                    String wayBackUrl = rootPathWithLang + "wayback/" + d.getWayback_date() + "/" + url;

                    SearchResultDTO searchResult = new SearchResultDTO();
                    searchResult.setId(d.getId());
                    searchResult.setTitle(d.getTitle());
                    searchResult.setDate(d.getCrawl_date());
                    searchResult.setText("");
                    searchResult.setDisplayUrl(url);
                    searchResult.setUrl(wayBackUrl);
                    searchResult.setDomain(d.getDomain());

                    return searchResult;
                })
                .collect(Collectors.toList());
    }

    public static String getRootPathWithLang(HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        URL url = new URL(request.getRequestURL().toString());
        String host = url.getHost();
        String userInfo = url.getUserInfo();
        String scheme = url.getProtocol();
        int port = url.getPort();
        String path = (String) request.getAttribute("javax.servlet.forward.request_uri");

        String langPart = "";
        for (String possibleLocale : LocaleConfiguration.AVAILABLE_LOCALES) {
            if (path.startsWith("/" + possibleLocale)) {
                langPart = "/" + possibleLocale;
                break;
            }
        }

        String newPath = langPart + "/" + PROJECT_NAME + "/";
        URI uri = new URI(scheme, userInfo, host, port, newPath, null, null);
        return uri.toString();
    }

}
