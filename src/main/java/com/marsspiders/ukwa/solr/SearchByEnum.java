package com.marsspiders.ukwa.solr;

public enum SearchByEnum {
    TITLE("title", "title"),
    FULL_TEXT("full_text", "text");

    private String webRequestSearchLocation;
    private String solrSearchLocation;

    SearchByEnum(String webRequestSearchLocation, String solrSearchLocation) {
        this.webRequestSearchLocation = webRequestSearchLocation;
        this.solrSearchLocation = solrSearchLocation;
    }

    public String getWebRequestSearchLocation() {
        return webRequestSearchLocation;
    }

    public String getSolrSearchLocation() {
        return solrSearchLocation;
    }

    public static SearchByEnum fromString(String text) {
        for (SearchByEnum location : SearchByEnum.values()) {
            if (location.webRequestSearchLocation.equalsIgnoreCase(text)) {
                return location;
            }
        }

        return null;
    }
}
