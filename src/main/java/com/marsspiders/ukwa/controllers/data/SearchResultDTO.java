package com.marsspiders.ukwa.controllers.data;

public class SearchResultDTO {
    private String id;
    private String title;
    //TODO: check what exact date should be used
    private String date;
    private String url;
    private String displayUrl;
    private String domain;
    private String displayDomain;
    private String text;
    private String access;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDisplayUrl() {
        return displayUrl;
    }

    public void setDisplayUrl(String displayUrl) {
        this.displayUrl = displayUrl;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getDisplayDomain() {
        return displayDomain;
    }

    public void setDisplayDomain(String displayDomain) {
        this.displayDomain = displayDomain;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public String getAccess() {
        return access;
    }
}
