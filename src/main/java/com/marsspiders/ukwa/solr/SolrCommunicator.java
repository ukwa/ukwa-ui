package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.*;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.NoOpResponseParser;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.Group;
import org.apache.solr.client.solrj.response.GroupCommand;
import org.apache.solr.client.solrj.response.GroupResponse;
import org.apache.solr.client.solrj.response.QueryResponse;
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


    public String returnTextGroupCategories() {

        SolrQuery query = new SolrQuery();

        query.set("group.field", "collectionAreaId");
        query.set("group.limit", "-1");
        query.set("group", true);
        query.set("indent", "on");


        query.setParam("q", "type: \"collection\" AND collectionAreaId:[* TO *]");
        query.set("rows", "1000");

        //query.set("wt", "json");

        String solrServerUrl = solrCollectionPath;
        String solrRequestHandler = solrCollectionRequestHandler;

        //http://localhost:8984/solr/collections/select
        HttpSolrClient solrClient = new HttpSolrClient.Builder(solrServerUrl).build();
        solrClient.setConnectionTimeout(connectionTimeout);
        solrClient.setSoTimeout(readTimeout);


        /*
        QueryResponse gRes = null;
        try {
            gRes = solrClient.query( query);
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        /*
        GroupResponse grpR = gRes.getGroupResponse();
        List<GroupCommand> groupCommands = gRes.getGroupResponse().getValues();
        log.info("------ categories, groupCommands List size :  " + groupCommands.size());

        List<Group> grs = new ArrayList<>();

            for(GroupCommand gc : groupCommands){
                List<Group> groups = gc.getValues();
                for(Group group : groups){
                    log.info("........ group data : " + group.getResult().getNumFound());
                    //Group gr = new Group();

                    //gr..setGroupText(group.getGroupValue());
                    //gr.setCount(group.getResult().getNumFound());
                    //grs.add(gr);
                }
            }

            */

        QueryRequest req = new QueryRequest(query);
        req.setResponseParser(new NoOpResponseParser("json"));
        req.setPath(solrRequestHandler);

        //------ ?
        NamedList<Object> response_nl = null;



        //QueryResponse response = null;// = solr.query(query);
        //SolrDocumentList results = response.getResults();
        //-------
        QueryResponse response = null;
        try {
            //response = solrClient.query(query);
            response_nl = solrClient.request(req);
            //response=new QueryResponse(response_nl, solrClient);
            //response = solrClient.query(query);
            log.info("--------- response solrClient = OK");

        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


        String categoriesGroupSearchResultString = (String)response_nl.get("response");

        SolrDocumentList solrDocumentList;
        solrDocumentList = (SolrDocumentList) response_nl.get("response");
        //printResults(solrDocumentList);

        String primaryKey = "groupValue";
        String highlightField = "";
        List<SolrDocument> docs = new ArrayList<SolrDocument>();
        //SolrDocumentList sdl = response.getResults();
        System.out.println("-----solrDocumentList.size()----: " + solrDocumentList.size());

        for (SolrDocument doc : solrDocumentList) {
            String pkey = (String) doc.getFieldValue(primaryKey);
            System.out.println("-----b----: " + pkey);
            if (response.getHighlighting() != null && highlightField != null) {
                List<String> hls = response.getHighlighting().get(pkey).get(highlightField);
                if (hls != null) {
                    doc.addField("highlight", hls.get(0));
                }
            }
            //doc.removeFields("anno_val");
            //doc.removeFields("anno_key");
            //docs.add(doc);
        }

        //QueryResponse queryResponse = solrClient.query(params);
        //solrDocumentList = queryResponse.getResults();

        /*
        QueryResponse queryResponse = null;

        try {
            queryResponse = req.process(solrClient);
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        */


        /*
        //QueryResponse response2 = solrClient.query(query);
        GroupResponse groups = queryResponse.getGroupResponse();
        for (Group group : groups.getValues().get(0).getValues()) {
            //StrainBean strain = new StrainBean();
            String colonyId = group.getGroupValue();
            System.out.println("------- zzz ------- : " + colonyId);
//            if (colonyId != null && !colonyId.equalsIgnoreCase("null")) {
//                strain.setColonyId(colonyId);
//                SolrDocument doc = group.getResult().get(0);
//                strain.setAllele((String) doc.get(ObservationDTO.ALLELE_SYMBOL));
//                strain.setGeneSymbol((String) doc.get(ObservationDTO.GENE_SYMBOL));
//                strain.setMgiAccession((String) doc.get(ObservationDTO.GENE_ACCESSION_ID));
//                strains.add(strain);
//            }
        }

        */
        /*
        //Create parser and get the root object
        JsonParser parser = new JsonParser();
        JsonObject rootObj = parser.parse(json).getAsJsonObject();

//Get the solr_date array
        JsonArray solrDateArray = rootObj
                .getAsJsonObject("facet_counts")
                .getAsJsonObject("facet_fields")
                .getAsJsonArray("solr_date");
        */
        /*
        SolrDocumentList results = response.getResults();
        log.info("--------- results size = " + results.size());
        //iterate the results
        for (int i = 0; i < results.size(); ++i) {
            System.out.println(results.get(i));
        }
        */




        /*
        SolrDocumentList docList = response.getResults();
        //assertEquals(docList.getNumFound(), 1);

        for (SolrDocument doc : docList) {
            //assertEquals((String) doc.getFieldValue("id"), "123456");
            //assertEquals((Double) doc.getFieldValue("price"), (Double) 599.99);
        }
        */
        //------

        /*

        NamedList<Object> response = null;
        //List<Group> response = null;

        try {

            response = solrClient.request(req);
        } catch (SolrServerException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //String categoriesGroupSearchResultString = (String)response.get("response");

        */

        /*

        GroupResponse grpR = response.getGroupResponse();
        List<GroupCommand> groupCommands = gRes.getGroupResponse().getValues();
        log.info("------ categories, groupCommands List size :  " + groupCommands.size());


        NamedList categoriesGroupSearchResultString = (NamedList)response;//.get("groups");
        */
        //String categoriesGroupSearchResultString = (String)response.get("response");

        //Map<String, SolrJSONFacet> jsonFacetMap = new HashMap<>();
        /*
        if (categoriesGroupSearchResultString != null) {
            log.info("------------ categoriesGroupSearchResultString != NULL " );
*/
            /*
            Iterator<String> facetIterator = categoriesGroupSearchResultString.iterator();
            while (facetIterator.hasNext()) {
                String entry = facetIterator.next();
                //if (NamedList.class.isAssignableFrom(entry.getValue().getClass())) {
                    log.info("------------  entry.getKey() = " + entry.toString());
                    //jsonFacetMap.put(entry.getKey(), resolveJSONFacet((NamedList) entry.getValue()));
                }
            */
            /*
        }
        else{
            log.info("------------ categoriesGroupSearchResultString = NULL " );

        }
        */


        //Need to deserialize json according to generic type passed
        //ObjectMapper mapper = new ObjectMapper();
        //JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);


        return categoriesGroupSearchResultString;
    }

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
}
