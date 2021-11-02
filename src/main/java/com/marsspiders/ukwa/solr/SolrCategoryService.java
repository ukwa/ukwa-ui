package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.solr.client.solrj.SolrQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SolrCategoryService {
    private static final Logger log = LoggerFactory.getLogger(SolrCategoryService.class);


    @Autowired
    SolrCommunicator communicator;



    //public SolrSearchResult<CollectionInfo> fetchCategoryById(String categoryId) {
    //    log.info("Fetching categories by id: " + categoryId);
    public String fetchCategories(){ //String categoryId) {
        log.info(".....Fetching categories and subcategories + decode....");

        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        //int rowsLimit = 100;
        //String collectionIdQuery = FIELD_ID + ":" + targetId;
        //SolrQuery.SortClause sortClause = new SolrQuery.SortClause(FIELD_NAME, asc);

        //return sendRequest(collectionIdQuery, sortClause, null, null, CollectionInfo.class, 0, rowsLimit);
        //return communicator.sendRequest(bodyDocsType, query);

        return communicator.returnTextGroupCategories();
    }
}
