package com.marsspiders.ukwa.solr.data;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.LinkedList;

@JsonIgnoreProperties(ignoreUnknown = true)
public class FacetRange {
    @JsonProperty("counts")
    private LinkedList<String> count;

    @JsonProperty("gap")
    private String gap;

    @JsonProperty("start")
    private String start;

    @JsonProperty("end")
    private String end;

    public LinkedList<String> getCount() {
        return count;
    }

    public void setCount(LinkedList<String> count) {
        this.count = count;
    }

    public String getGap() {
        return gap;
    }

    public void setGap(String gap) {
        this.gap = gap;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}
