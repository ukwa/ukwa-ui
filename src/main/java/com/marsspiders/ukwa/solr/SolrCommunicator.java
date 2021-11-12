package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.*;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.NoOpResponseParser;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.*;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.SolrParams;
import org.apache.solr.common.util.NamedList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@Service
public class SolrCommunicator {
    private static final Logger log = LoggerFactory.getLogger(SolrCommunicator.class);

    @Value("${solr.collection.search.path}")
    private String solrCollectionPath;

    @Value("${solr.collection.search.request.handler}")
    private String solrCollectionRequestHandler;

    //TODO: Query Handler
//    @Value("${solr.collection.search.request.query.handler}")
//    private String solrCollectionQueryRequestHandler;

    @Value("${solr.full.text.search.path}")
    private String solrFullTextPath;

    @Value("${solr.full.text.search.request.handler}")
    private String solrFullTextRequestHandler;

    @Value("${solr.auth.username}")
    private String username;

    @Value("${solr.auth.password}")
    private String password;

    @Value("${solr.read.timeout}")
    private Integer readTimeout;

    @Value("${solr.connection.timeout}")
    private Integer connectionTimeout;

    @Value("${solr.show.stub.data.when.service.not.available}")
    private boolean showStubData;


    <T extends BodyDocsType> SolrSearchResult<T> sendRequest(Class<T> bodyDocsType, SolrQuery query) {
        try {

            String solrServerUrl;
            String solrRequestHandler;
            if (bodyDocsType.isAssignableFrom(ContentInfo.class)) {
                solrServerUrl = solrFullTextPath;
                solrRequestHandler = solrFullTextRequestHandler;
            } else if (bodyDocsType.isAssignableFrom(CollectionInfo.class)) {
                solrServerUrl = solrCollectionPath;
                solrRequestHandler = solrCollectionRequestHandler;
            } else {
                throw new IllegalStateException("Unknown bodyDocsType: " + bodyDocsType);
            }

            QueryRequest req = new QueryRequest(query);
            req.setResponseParser(new NoOpResponseParser("json"));
            req.setBasicAuthCredentials(username, password);
            req.setPath(solrRequestHandler);

            log.info("......query : " + query);
            log.info("......solrServerUrl : " + solrServerUrl);
            HttpSolrClient solrClient = new HttpSolrClient.Builder(solrServerUrl).build();
            solrClient.setConnectionTimeout(connectionTimeout);
            solrClient.setSoTimeout(readTimeout);

            log.info("......req : " + req);

            NamedList<Object> response = solrClient.request(req);
            String solrSearchResultString = (String)response.get("response");


            //Need to deserialize json according to generic type passed
            ObjectMapper mapper = new ObjectMapper();
            JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);

            return mapper.readValue(solrSearchResultString, javaType);
        } catch (Exception e) {
            String errorMsg = "Failed to get data from Solr";
            log.error(errorMsg, e);

            if (showStubData) {
                return toStubSolrSearchResult(bodyDocsType);
            } else {
                throw new RuntimeException(errorMsg, e);
            }
        }
    }

    private <T extends BodyDocsType> SolrSearchResult<T> toStubSolrSearchResult(Class<T> bodyDocsType) {
        String solrSearchResultStubFileName;
        if (bodyDocsType.isAssignableFrom(ContentInfo.class)) {
            solrSearchResultStubFileName = "contentSearchStub.json";
        } else if (bodyDocsType.isAssignableFrom(CollectionInfo.class)) {
            solrSearchResultStubFileName = "collectionSearchStub.json";
        } else {
            return null;
        }

        String solrSearchResultStubString;
        try {

            Resource resource = new ClassPathResource(solrSearchResultStubFileName);
            InputStream resourceInputStream = resource.getInputStream();
            BufferedReader buffer = new BufferedReader(new InputStreamReader(resourceInputStream));
            solrSearchResultStubString = buffer.lines().collect(Collectors.joining("\n"));
        } catch (IOException e) {
            log.error("Failed to read stub response from file", e);
            return null;
        }

        ObjectMapper mapper = new ObjectMapper();
        JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);

        try {
            return mapper.readValue(solrSearchResultStubString, javaType);
        } catch (IOException e) {
            log.error("Failed to map stub response to java class", e);
            return null;
        }
    }

    /**
     * Pivot Categories Request (due to multivalued field in SOLR)
     * @return
     * @throws Exception
     */
    public NamedList<List<PivotField>> pivotCategoriesRequest() throws Exception{

        // Set query criteria
        /*
         * http://localhost:38983/solr/collections/select?
         *
         * fl=collectionAreaId&
         * fq=collectionAreaId:[*%20TO%20*]-collectionAreaId:(2945)&
         * indent=on&
         *
         * facet=true&
         * facet.limit=-1&
         * facet.pivot.mincount=1&
         * facet.pivot=collectionAreaId,id&
         *
         * q=*:*&
         * wt=json
         *
         * */
        log.info("------ pivots categories  " );

        SolrQuery query = new SolrQuery();
        query.setFacet(true);
        query.addFacetPivotField(new String[]{"collectionAreaId,id,description,name"});
        query.addFilterQuery("collectionAreaId:[* TO *]-collectionAreaId:(2945)"); //exception for collection : working
        query.set("q", "*");
        query.set("facet.limit", "-1");
        query.set("facet.pivot.mincount", "1");
        query.set("wt", "json");
        query.set("fl",new String[]{"name,description"});

        HttpSolrClient solrClient = new HttpSolrClient.Builder(solrCollectionPath + "/solr/collections").build();
        solrClient.setConnectionTimeout(connectionTimeout);
        NamedList<List<PivotField>> pivotEntryList = null;
        try {
            QueryResponse result = solrClient.query(query);
            pivotEntryList = result.getFacetPivot();
            if (pivotEntryList == null)
                return null;
        } catch (SolrServerException | IOException e) {
            e.printStackTrace();
        }
        return pivotEntryList;
    }
}
