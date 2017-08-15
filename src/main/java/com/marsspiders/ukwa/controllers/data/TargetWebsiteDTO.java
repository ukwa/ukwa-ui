package com.marsspiders.ukwa.controllers.data;

import java.util.List;

public class TargetWebsiteDTO {
    private String id;
    private String name;
    private String screenshot;
    private String description;
    private String archiveUrl;
    private String url;
    private String startDate;
    private String endDate;
    private String language;
    private List<String> additionalUrls;
    private String access;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getScreenshot() {
        return screenshot;
    }

    public void setScreenshot(String screenshot) {
        this.screenshot = screenshot;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setArchiveUrl(String archiveUrl) {
        this.archiveUrl = archiveUrl;
    }

    public String getArchiveUrl() {
        return archiveUrl;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getLanguage() {
        return language;
    }

    public List<String> getAdditionalUrls() {
        return additionalUrls;
    }

    public void setAdditionalUrls(List<String> additionalUrls) {
        this.additionalUrls = additionalUrls;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }
}
