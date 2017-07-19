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

    @JsonProperty("type")
    private LinkedList<String> types;

    @JsonProperty("content_type_norm")
    private LinkedList<String> contentTypes;

    @JsonProperty("host")
    private LinkedList<String> hosts;

    @JsonProperty("domain")
    private LinkedList<String> domains;

    @JsonProperty("collection")
    private LinkedList<String> collections;

    @JsonProperty("access_terms")
    private LinkedList<String> accessTerms;

    public LinkedList<String> getPublicSuffixes() {
        return publicSuffixes;
    }

    public void setPublicSuffixes(LinkedList<String> publicSuffixes) {
        this.publicSuffixes = publicSuffixes;
    }

    public LinkedList<String> getTypes() {
        return types;
    }

    public LinkedList<String> getContentTypes() {
        return contentTypes;
    }

    public void setContentTypes(LinkedList<String> contentTypes) {
        this.contentTypes = contentTypes;
    }

    public void setTypes(LinkedList<String> types) {
        this.types = types;
    }

    public LinkedList<String> getHosts() {
        return hosts;
    }

    public void setHosts(LinkedList<String> hosts) {
        this.hosts = hosts;
    }

    public LinkedList<String> getDomains() {
        return domains;
    }

    public void setDomains(LinkedList<String> domains) {
        this.domains = domains;
    }

    public LinkedList<String> getCollections() {
        return collections;
    }

    public void setCollections(LinkedList<String> collections) {
        this.collections = collections;
    }

    public LinkedList<String> getAccessTerms() {
        return accessTerms;
    }

    public void setAccessTerms(LinkedList<String> accessTerms) {
        this.accessTerms = accessTerms;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
