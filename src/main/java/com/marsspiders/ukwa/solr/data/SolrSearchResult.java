package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@JsonIgnoreProperties(ignoreUnknown = true)
public class SolrSearchResult <T extends BodyDocsType>{
    @JsonProperty("responseHeader")
    private ResponseHeader responseHeader;

    @JsonProperty("response")
    private ResponseBody<T> responseBody;


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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
