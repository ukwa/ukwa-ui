package com.marsspiders.ukwa.ip;

import com.marsspiders.ukwa.WaybackIpConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.util.IpUtil.fetchClientIps;
import static com.marsspiders.ukwa.util.IpUtil.ipWithinRange;
import static org.apache.commons.lang3.StringUtils.isBlank;

@Service
public class WaybackIpResolver {
    private static final Log log = LogFactory.getLog(WaybackIpResolver.class);

    @Autowired
    WaybackIpConfiguration waybackIpConfiguration;

    public boolean isUserIpFromBl(HttpServletRequest request) {
        List<String> clientIps = fetchClientIps(request);
        log.debug("User's client ips: " + clientIps);

        List<String> locationsIpRanges = waybackIpConfiguration.getIpAddressListAtLocation();
        List<String> allBlIpAddressRanges = new ArrayList<>();
        for (String locationIpRanges : locationsIpRanges) {
            String[] locationIpRangesArray = locationIpRanges.split(",");
            List<String> locationIpRangeList = Arrays.asList(locationIpRangesArray);

            List<String> notEmptyRanges = locationIpRangeList
                    .stream()
                    .filter(range -> !isBlank(range))
                    .collect(Collectors.toList());

            allBlIpAddressRanges.addAll(notEmptyRanges);
        }

        for (String blIpAddressRange : allBlIpAddressRanges) {
            for (String clientIp : clientIps) {
                if (ipWithinRange(clientIp, blIpAddressRange.trim())) {
                    return true;
                }
            }

        }

        return false;
    }
}
