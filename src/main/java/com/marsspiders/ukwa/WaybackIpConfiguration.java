package com.marsspiders.ukwa;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@ConfigurationProperties("bl.wayback")
public class WaybackIpConfiguration {
    private String offSiteUrl;
    private List<String> url;
    private List<String> ipAddressListAtLocation;
    private List<String> indexToLocation;

    public String getOffSiteUrl() {
        return offSiteUrl;
    }

    public void setOffSiteUrl(String offSiteUrl) {
        this.offSiteUrl = offSiteUrl;
    }

    public List<String> getUrl() {
        return url;
    }

    public void setUrl(List<String> url) {
        this.url = url;
    }

    public List<String> getIpAddressListAtLocation() {
        return ipAddressListAtLocation;
    }

    public void setIpAddressListAtLocation(List<String> ipAddressListAtLocation) {
        this.ipAddressListAtLocation = ipAddressListAtLocation;
    }

    public List<String> getIndexToLocation() {
        return indexToLocation;
    }

    public void setIndexToLocation(List<String> indexToLocation) {
        this.indexToLocation = indexToLocation;
    }
}
