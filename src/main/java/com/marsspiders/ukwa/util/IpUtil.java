package com.marsspiders.ukwa.util;

import org.apache.commons.net.util.SubnetUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class IpUtil {


    public static boolean ipWithinRange(String clientIp, String blIpAddressRange) {
        try {
            if (blIpAddressRange.equals(clientIp)) {
                return true;
            }

            SubnetUtils utils = new SubnetUtils(blIpAddressRange);

            return utils.getInfo().isInRange(clientIp);
        } catch (Exception e) {
            return false;
        }
    }

    public static List<String> fetchClientIps(HttpServletRequest request) {
        List<String> ips = new ArrayList<>();

        Enumeration<String> realIps = request.getHeaders("X-Real-IP");
        while (realIps.hasMoreElements()) {
            ips.add(realIps.nextElement());
        }

        Enumeration<String> remoteIp = request.getHeaders("X-FORWARDED-FOR");
        while (remoteIp.hasMoreElements()) {
            ips.add(remoteIp.nextElement());
        }

        if (ips.size() == 0) {
            ips.add(request.getRemoteAddr());
        }

        return ips;
    }
}
