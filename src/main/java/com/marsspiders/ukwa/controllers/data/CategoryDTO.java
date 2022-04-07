package com.marsspiders.ukwa.controllers.data;

import java.util.List;

public class CategoryDTO {

    private String collectionAreaId;
    private String parentId;
    private String name;
    private String description;
    private String imageAltMessage;
    private String fullDescription;
    private long subCollectionsAreaNum;
    //private long websitesNum;
    //private long websitesOpenAccessNum;
    private List<CollectionDTO> subCollections;
    //private List<TargetWebsiteDTO> websites;

}
