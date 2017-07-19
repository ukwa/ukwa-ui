package com.marsspiders.ukwa.solr;

public enum AccessToEnum {
    VIEWABLE_ANYWHERE("va", "OA"),
    VIEWABLE_ONLY_ON_LIBRARY("vool", "OA,RRO");

    private String webRequestAccessRestriction;
    private String solrRequestAccessRestriction;

    AccessToEnum(String webRequestAccessRestriction, String solrRequestAccessRestriction) {
        this.webRequestAccessRestriction = webRequestAccessRestriction;
        this.solrRequestAccessRestriction = solrRequestAccessRestriction;
    }

    public String getWebRequestAccessRestriction() {
        return webRequestAccessRestriction;
    }

    public String getSolrRequestAccessRestriction() {
        return solrRequestAccessRestriction;
    }


    public static AccessToEnum fromString(String text) {
        for (AccessToEnum accessTo : AccessToEnum.values()) {
            if (accessTo.webRequestAccessRestriction.equalsIgnoreCase(text)) {
                return accessTo;
            }
        }

        return null;
    }
}
