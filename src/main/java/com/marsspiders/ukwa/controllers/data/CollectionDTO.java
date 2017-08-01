package com.marsspiders.ukwa.controllers.data;

import java.util.List;

public class CollectionDTO {
    private String id;
    private String parentId;
    private String name;
    private String description;
    private String imageAltMessage;
    private String fullDescription;
    private long subCollectionsNum;
    private long websitesNum;
    private long websitesOpenAccessNum;
    private List<CollectionDTO> subCollections;
    private List<TargetWebsiteDTO> websites;

    public CollectionDTO() {
    }

    public CollectionDTO(String id, String parentId, String name, String description, String fullDescription,
                         String imageAltMessage, long subCollectionsNum, long websitesNum, long websitesOpenAccessNum) {
        this.id = id;
        this.parentId = parentId;
        this.name = name;
        this.description = description;
        this.fullDescription = fullDescription;
        this.subCollectionsNum = subCollectionsNum;
        this.websitesNum = websitesNum;
        this.websitesOpenAccessNum = websitesOpenAccessNum;
        this.imageAltMessage = imageAltMessage;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
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

    public String getFullDescription() {
        return fullDescription;
    }

    public void setFullDescription(String fullDescription) {
        this.fullDescription = fullDescription;
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

    public String getImageAltMessage() {
        return imageAltMessage;
    }

    public void setImageAltMessage(String imageAltMessage) {
        this.imageAltMessage = imageAltMessage;
    }
}
