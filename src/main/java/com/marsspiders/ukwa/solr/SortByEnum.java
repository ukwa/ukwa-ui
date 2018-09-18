package com.marsspiders.ukwa.solr;

public enum SortByEnum {
    MOSTRELEVANT_TO_LEASTRELEVANT("nto", "desc"),
    LEASTRELEVANT_TO_MOSTRELEVANT("otn", "asc");

    private String webRequestOrderValue;
    private String solrOrderValue;

    SortByEnum(String webRequestOrderValue, String solrOrderValue) {
        this.webRequestOrderValue = webRequestOrderValue;
        this.solrOrderValue = solrOrderValue;
    }

    public String getWebRequestOrderValue() {
        return webRequestOrderValue;
    }

    public String getSolrOrderValue() {
        return solrOrderValue;
    }

    public static SortByEnum fromString(String text) {
        for (SortByEnum sortBy : SortByEnum.values()) {
            if (sortBy.webRequestOrderValue.equalsIgnoreCase(text)) {
                return sortBy;
            }
        }

        return null;
    }
}
