package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.response.PivotField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.util.NamedList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class SolrCategoryService {
    private static final Logger log = LoggerFactory.getLogger(SolrCategoryService.class);

    @Autowired
    SolrCommunicator communicator;


    public NamedList<List<PivotField>> pivotQueryCategories() throws Exception{
        //int rowsLimit = ROOT_COLLECTIONS_ROWS_LIMIT;
        return communicator.pivotCategoriesRequest();
    }
}
