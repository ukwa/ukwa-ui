package com.marsspiders.ukwa.solr;

public enum OrderByEnum {
    NEWEST_TO_OLDEST("nto", "desc"),
    OLDEST_TO_NEWEST("otn", "asc");

    private String webRequestOrderValue;
    private String solrOrderValue;

    OrderByEnum(String webRequestOrderValue, String solrOrderValue) {
        this.webRequestOrderValue = webRequestOrderValue;
        this.solrOrderValue = solrOrderValue;
    }

    public String getWebRequestOrderValue() {
        return webRequestOrderValue;
    }

    public String getSolrOrderValue() {
        return solrOrderValue;
    }

    public static OrderByEnum fromString(String text) {
        for (OrderByEnum orderBy : OrderByEnum.values()) {
            if (orderBy.webRequestOrderValue.equalsIgnoreCase(text)) {
                return orderBy;
            }
        }

        return null;
    }
}
