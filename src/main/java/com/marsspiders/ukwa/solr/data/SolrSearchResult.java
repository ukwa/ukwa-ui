package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.Map;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SolrSearchResult <T extends BodyDocsType>{
    @JsonProperty("facet_counts")
    private FacetCounts facetCounts;

    @JsonProperty("responseHeader")
    private ResponseHeader responseHeader;

    @JsonProperty("response")
    private ResponseBody<T> responseBody;

    @JsonProperty("highlighting")
    private Map<String, HighlightingContent> highlighting;

    public FacetCounts getFacetCounts() {
        return facetCounts;
    }

    public void setFacetCounts(FacetCounts facetCounts) {
        this.facetCounts = facetCounts;
    }

    public ResponseHeader getResponseHeader() {
        return responseHeader;
    }

    public void setResponseHeader(ResponseHeader responseHeader) {
        this.responseHeader = responseHeader;
    }

    public ResponseBody<T> getResponseBody() {
        return responseBody;
    }

    public void setResponseBody(ResponseBody<T> responseBody) {
        this.responseBody = responseBody;
    }

    public Map<String, HighlightingContent> getHighlighting() {
        return highlighting;
    }

    public void setHighlighting(Map<String, HighlightingContent> highlighting) {
        this.highlighting = highlighting;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
