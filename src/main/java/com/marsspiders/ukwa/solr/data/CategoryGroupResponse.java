package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class CategoryGroupResponse implements BodyDocsType {
    //@JsonProperty("groupValue")
    //private String groupValue;


    @JsonProperty("grouped")
    private String[] grouped;

    //@JsonProperty("doclist")
    //private Object[] collectionInCategorylist;
}
