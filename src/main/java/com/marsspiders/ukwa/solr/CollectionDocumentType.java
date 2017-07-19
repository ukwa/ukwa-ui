package com.marsspiders.ukwa.solr;

public enum CollectionDocumentType {
    TYPE_COLLECTION("collection"),
    TYPE_TARGET("target");

    private String solrDocumentType;

    CollectionDocumentType(String solrDocumentType) {
        this.solrDocumentType = solrDocumentType;
    }

    public String getSolrDocumentType() {
        return solrDocumentType;
    }
}
