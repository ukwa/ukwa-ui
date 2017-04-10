package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@JsonIgnoreProperties(ignoreUnknown = true)
public class FacetRanges {
    @JsonProperty("crawl_date")
    private FacetRange crawlDateRange;

    public FacetRange getCrawlDateRange() {
        return crawlDateRange;
    }

    public void setCrawlDateRange(FacetRange crawlDateRange) {
        this.crawlDateRange = crawlDateRange;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
