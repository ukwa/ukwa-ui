package com.marsspiders.ukwa.controllers;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = HomeController.PROJECT_NAME + "/wayback")
public class ArchiveController {

    @Value("${archive.web.location}")
    private String archiveWebLocation;

    @RequestMapping(value = "{timestamp}/**", method = GET)
    public String fetchArchivedPageByTimestamp(@PathVariable("timestamp") String timestamp, HttpServletRequest request) {
        String siteUrl = evaluateUrlFromRequest(request);
        System.out.println("Requesting archived page '" + siteUrl + "' for the following period: " + timestamp);

        String redirectUrl = archiveWebLocation + timestamp + "/" + siteUrl;
        return "redirect:" + redirectUrl;
    }

    private static String evaluateUrlFromRequest(HttpServletRequest request) {
        String wholePath = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        String bestMatchPattern = (String ) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);

        AntPathMatcher apm = new AntPathMatcher();
        return apm.extractPathWithinPattern(bestMatchPattern, wholePath);
    }
}
