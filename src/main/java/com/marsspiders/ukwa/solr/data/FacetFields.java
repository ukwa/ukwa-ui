package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.LinkedList;

@JsonIgnoreProperties(ignoreUnknown = true)
public class FacetFields {
    @JsonProperty("public_suffix")
    private LinkedList<String> publicSuffixes;

    public LinkedList<String> getPublicSuffixes() {
        return publicSuffixes;
    }

    public void setPublicSuffixes(LinkedList<String> publicSuffixes) {
        this.publicSuffixes = publicSuffixes;
    }


    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
