package com.marsspiders.ukwa.controllers.data;

import java.util.List;

public class CollectionDTO {
    private String id;
    private String name;
    private String description;
    private long subCollectionsNum;
    private long websitesNum;
    private long websitesOpenAccessNum;
    private List<CollectionDTO> subCollections;
    private List<TargetWebsiteDTO> websites;

    public CollectionDTO() {
    }

    public CollectionDTO(String id, String name, String description, long subCollectionsNum, long websitesNum, long websitesOpenAccessNum) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.subCollectionsNum = subCollectionsNum;
        this.websitesNum = websitesNum;
        this.websitesOpenAccessNum = websitesOpenAccessNum;
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getSubCollectionsNum() {
        return subCollectionsNum;
    }

    public void setSubCollectionsNum(long subCollectionsNum) {
        this.subCollectionsNum = subCollectionsNum;
    }

    public long getWebsitesNum() {
        return websitesNum;
    }

    public void setWebsitesNum(long websitesNum) {
        this.websitesNum = websitesNum;
    }

    public long getWebsitesOpenAccessNum() {
        return websitesOpenAccessNum;
    }

    public void setWebsitesOpenAccessNum(long websitesOpenAccessNum) {
        this.websitesOpenAccessNum = websitesOpenAccessNum;
    }

    public List<CollectionDTO> getSubCollections() {
        return subCollections;
    }

    public void setSubCollections(List<CollectionDTO> subCollections) {
        this.subCollections = subCollections;
    }

    public List<TargetWebsiteDTO> getWebsites() {
        return websites;
    }

    public void setWebsites(List<TargetWebsiteDTO> websites) {
        this.websites = websites;
    }
}
