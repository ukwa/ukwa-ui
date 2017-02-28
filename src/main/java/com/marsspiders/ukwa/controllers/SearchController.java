package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.LocaleConfiguration;
import com.marsspiders.ukwa.controllers.data.SearchResultDTO;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import static org.apache.commons.lang3.StringUtils.abbreviate;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = PROJECT_NAME + "/search")
public class SearchController {

    private static final String SEARCH_LOCATION_FULL_TEXT = "full_text";
    private static final String SEARCH_LOCATION_TITLE = "title";

    @Autowired
    SolrSearchService searchService;


    @RequestMapping(value = "", method = GET)
    public ModelAndView searchPage(@RequestParam(value = "search_location", required = false) String searchLocation,
                                   @RequestParam(value = "text", required = false) String text,
                                   HttpServletRequest request) throws MalformedURLException, URISyntaxException {
        List<SearchResultDTO> searchResultDTOs = new ArrayList<>();
        boolean blankSearchParams = StringUtils.isBlank(searchLocation) || StringUtils.isBlank(text);

        if (!blankSearchParams && SEARCH_LOCATION_FULL_TEXT.equalsIgnoreCase(searchLocation)) {
            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContentByFullText(text);
            List<ContentInfo> contentInfoList = archivedSites.getResponseBody().getDocuments();

            searchResultDTOs = toSearchResults(contentInfoList, rootPathWithLang, searchLocation, text);
        } else if (!blankSearchParams && SEARCH_LOCATION_TITLE.equalsIgnoreCase(searchLocation)) {
            SolrSearchResult<ContentInfo> archivedSites = searchService.searchContentByTitle(text);
            List<ContentInfo> collectionInfoList = archivedSites.getResponseBody().getDocuments();

            searchResultDTOs = toSearchResults(collectionInfoList, rootPathWithLang, searchLocation, text);
        }

        ModelAndView mav = new ModelAndView("search");
        mav.addObject("searchResults", searchResultDTOs);
        mav.addObject("totalSearchResultsSize", searchResultDTOs != null ? searchResultDTOs.size() : 0);
        mav.addObject("originalSearchRequest", text);
        mav.addObject("originalSearchLocation", searchLocation);

        return mav;
    }

    private List<SearchResultDTO> toSearchResults(List<ContentInfo> contentInfoList,
                                                  String rootPathWithLang,
                                                  String searchLocation,
                                                  String textToSearch) {
        return contentInfoList
                .stream()
                .map(d -> {

                    String url = d.getUrl() != null ? d.getUrl().get(0) : "";
                    String wayBackUrl = rootPathWithLang + "wayback/" + d.getWayback_date() + "/" + url;
                    String content = SEARCH_LOCATION_TITLE.equalsIgnoreCase(searchLocation) || d.getContent() == null
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

        URL url = new URL(request.getRequestURL().toString());
        String host = url.getHost();
        String userInfo = url.getUserInfo();
        String scheme = url.getProtocol();
            scheme = scheme.replace("http", "https");
        }

        int port = url.getPort();
        String path = (String) request.getAttribute("javax.servlet.forward.request_uri");

        String langPart = "";
        for (String possibleLocale : LocaleConfiguration.AVAILABLE_LOCALES) {
            if (path != null && path.startsWith("/" + possibleLocale)) {
                langPart = "/" + possibleLocale;
                break;
            }
        }

        String newPath = langPart + "/" + PROJECT_NAME + "/";
        URI uri = new URI(scheme, userInfo, host, port, newPath, null, null);
        return uri.toString();
    }

}
