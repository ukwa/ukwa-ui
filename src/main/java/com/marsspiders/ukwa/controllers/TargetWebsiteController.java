package com.marsspiders.ukwa.controllers;


import com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO;
import com.marsspiders.ukwa.solr.SolrSearchService;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = "ukwa/target")
public class TargetWebsiteController {

    @Autowired
    SolrSearchService searchService;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "/{targetId}", method = GET)
    public ModelAndView targetWebsiteOverviewPage(@PathVariable("targetId") String targetId) {
        SolrSearchResult<CollectionInfo> searchResult = searchService.fetchCollectionById(targetId);
        CollectionInfo websiteInformation = searchResult.getResponseBody().getDocuments().get(0);

        TargetWebsiteDTO targetWebsite = new TargetWebsiteDTO();
        targetWebsite.setName(websiteInformation.getTitle());
        targetWebsite.setDescription(websiteInformation.getDescription());
        targetWebsite.setArchiveUrl(toArchiveUrl(websiteInformation));
        targetWebsite.setUrl(websiteInformation.getUrl());
        targetWebsite.setStartDate(websiteInformation.getStartDate());
        targetWebsite.setEndDate(websiteInformation.getEndDate());
        targetWebsite.setLanguage(websiteInformation.getLanguage());
        targetWebsite.setAdditionalUrls(websiteInformation.getAdditionalUrl());

        ModelAndView mav = new ModelAndView("website_overview");
        mav.addObject("targetWebsite", targetWebsite);
        mav.addObject("setProtocolToHttps", setProtocolToHttps);

        return mav;
    }

    private String toArchiveUrl(CollectionInfo websiteInformation) {
        String originalUrl = websiteInformation.getUrl();
        return HomeController.PROJECT_NAME + "/wayback/*/" + originalUrl;
    }
}