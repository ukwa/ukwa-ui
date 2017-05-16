package com.marsspiders.ukwa.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    private static final Logger log = LoggerFactory.getLogger(ArchiveController.class);

    @Value("${archive.web.location}")
    private String archiveWebLocation;

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @RequestMapping(value = "{timestamp}/**", method = GET)
    public String fetchArchivedPageByTimestamp(@PathVariable("timestamp") String timestamp, HttpServletRequest request) {
        String siteUrl = evaluateUrlFromRequest(request);
        String prettySiteUrl = siteUrl.replaceAll(":/([a-zA-Z0-9])", "://$1");

        log.info("Requesting archived page '" + prettySiteUrl + "' for the following period: " + timestamp);

        String redirectUrl = archiveWebLocation + timestamp + "/" + prettySiteUrl;
        return "redirect:" + redirectUrl;
    }

    private static String evaluateUrlFromRequest(HttpServletRequest request) {
        String wholePath = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        String bestMatchPattern = (String ) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);

        AntPathMatcher apm = new AntPathMatcher();
        return apm.extractPathWithinPattern(bestMatchPattern, wholePath);
    }
}
