package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

@JsonIgnoreProperties(ignoreUnknown = true)
public class FacetCounts {
    @JsonProperty("facet_fields")
    private FacetFields facetFields;

    public FacetFields getFacetFields() {
        return facetFields;
    }

    public void setFacetFields(FacetFields facetFields) {
        this.facetFields = facetFields;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
