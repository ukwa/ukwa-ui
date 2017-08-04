package com.marsspiders.ukwa.controllers;

import com.marsspiders.ukwa.WaybackIpConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.List;

import static com.marsspiders.ukwa.util.IpUtil.fetchClientIps;
import static com.marsspiders.ukwa.util.IpUtil.ipWithinRange;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

@Controller
@RequestMapping(value = HomeController.PROJECT_NAME + "/wayback")
public class ArchiveController {
    private static final Logger log = LoggerFactory.getLogger(ArchiveController.class);

    @Value("${set.protocol.to.https}")
    private Boolean setProtocolToHttps;

    @Autowired
    WaybackIpConfiguration waybackIpConfiguration;

    @RequestMapping(value = "{timestamp}/**", method = GET)
    public String fetchArchivedPageByTimestamp(@PathVariable("timestamp") String timestamp, HttpServletRequest request) {
        List<String> clientIps = fetchClientIps(request);
        String waybackUrl = fetchWaybackUrlByIp(clientIps);

        String siteUrl = evaluateUrlFromRequest(request);
        String prettySiteUrl = siteUrl.replaceAll(":/([a-zA-Z0-9])", "://$1");

        log.info("Requesting archived page '" + prettySiteUrl + "' for the following period: " + timestamp);

        String redirectUrl = waybackUrl + timestamp + "/" + prettySiteUrl;
        return "redirect:" + redirectUrl;
    }

    private static String evaluateUrlFromRequest(HttpServletRequest request) {
        String wholePath = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
        String bestMatchPattern = (String ) request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);

        AntPathMatcher apm = new AntPathMatcher();
        return apm.extractPathWithinPattern(bestMatchPattern, wholePath);
    }

    private String fetchWaybackUrlByIp(List<String> clientIps) {
        log.debug("User's client ips: " + clientIps);

        List<String> locationsIpRanges = waybackIpConfiguration.getIpAddressListAtLocation();

        for (String currentLocationIpRanges : locationsIpRanges) {
            String[] currentLocationIpRangesArray = currentLocationIpRanges.split(",");
            List<String> currentLocationIpRangeList = Arrays.asList(currentLocationIpRangesArray);

            String waybackUrl = tryFetchWaybackUrlForCurrentLocation(clientIps, currentLocationIpRanges, currentLocationIpRangeList);
            if (waybackUrl != null) {
                return waybackUrl;
            }
        }

        return waybackIpConfiguration.getOffSiteUrl();
    }

    private String tryFetchWaybackUrlForCurrentLocation(List<String> clientIps, String locationIpRanges, List<String> locationIpRangeList) {
        for (String locationIpRange : locationIpRangeList) {
            for (String clientIp : clientIps) {
                if (ipWithinRange(clientIp, locationIpRange.trim())) {
                    List<String> locationsIpRanges = waybackIpConfiguration.getIpAddressListAtLocation();
                    List<String> waybackLocations = waybackIpConfiguration.getIndexToLocation();
                    List<String> waybackUrls = waybackIpConfiguration.getUrl();

                    int locationId = locationsIpRanges.indexOf(locationIpRanges);
                    log.debug("Ip belongs to: " + waybackLocations.get(locationId) + " location");

                    return waybackUrls.get(locationId);
                }
            }

        }

        return null;
    }

}
