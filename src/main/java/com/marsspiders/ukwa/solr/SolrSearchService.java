package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.ResponseBody;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static java.lang.String.format;

@Service
public class SolrSearchService {

    @Value("${solr.collection.search.path}")
    private String solrCollectionPath;

    @Value("${solr.full.text.search.path}")
    private String solrFullTextPath;

    @Value("${solr.auth.username}")
    private String username;

    @Value("${solr.auth.password}")
    private String password;

    @Value("${solr.read.timeout}")
    private Integer readTimeout;

    @Value("${solr.connection.timeout}")
    private Integer connectionTimeout;

    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        String queryString = "-parentId:[*%20TO%20*]";
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        String queryString = "id:" + targetId;
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(List<String> parentCollectionIds) {
        String parentIdsQueryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));

        URLCodec codec = new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(parentIdsQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return populateSearchUrlAndSendRequest(solrCollectionPath, encodedQueryString, CollectionInfo.class);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollectionsByTitle(String parentCollectionId, String titleTextSearch) {
        String textToSearchInTitleQueryString = "title:*" + titleTextSearch + "*";
        String parentIdsQueryString = "parentId:" + parentCollectionId;

        URLCodec codec = new URLCodec();
        String encodedParentIdsQueryString = null;
        String encodedTitleSearchString = null;
        try {
            encodedParentIdsQueryString = codec.encode(parentIdsQueryString);
            encodedTitleSearchString = codec.encode(textToSearchInTitleQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        String queryString = encodedParentIdsQueryString + "&fq=" + encodedTitleSearchString;
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class);
    }

    public SolrSearchResult<ContentInfo> searchContentByTitle(String titleTextSearch) {
        String textToSearchInTitleQueryString = "title:*" + titleTextSearch + "*";

        URLCodec codec = new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(textToSearchInTitleQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return populateSearchUrlAndSendRequest(solrFullTextPath, encodedQueryString, ContentInfo.class);
    }

    public SolrSearchResult<ContentInfo> searchContentByFullText(String fullTextSearch) {
        String searchQuery = "text:*" + fullTextSearch + "*";

        URLCodec codec = new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(searchQuery);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return populateSearchUrlAndSendRequest(solrFullTextPath, encodedQueryString, ContentInfo.class);
    }

    private  <T extends BodyDocsType> SolrSearchResult<T>  populateSearchUrlAndSendRequest(String solrPath,
                                                                                           String queryString,
                                                                                           Class<T> bodyDocsType) {
        int rowsLimit = 1000;
        int startFrom = 0;

        String solrSearchUrl = format("%sindent=%s&q=%s&rows=%d&start=%d&wt=%s",
                solrPath, INDENT_FLAG, queryString, rowsLimit, startFrom, RESULT_FORMAT);

        return sendRequest(solrSearchUrl, username, password, bodyDocsType);
    }


    private <T extends BodyDocsType> SolrSearchResult<T> sendRequest(String solrSearchUrl,
                                                                     String userName,
                                                                     String password,
                                                                     Class<T> bodyDocsType) {
        try {
            CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
            credentialsProvider.setCredentials(
                    new AuthScope(AuthScope.ANY_HOST, AuthScope.ANY_PORT),
                    new UsernamePasswordCredentials(userName, password));

            RequestConfig requestConfig = RequestConfig.custom()
                    .setConnectTimeout(connectionTimeout)
                    .setConnectionRequestTimeout(connectionTimeout)
                    .setSocketTimeout(readTimeout)
                    .build();

            HttpClient client = HttpClientBuilder
                    .create()
                    .setDefaultCredentialsProvider(credentialsProvider)
                    .setDefaultRequestConfig(requestConfig)
                    .build();

            HttpGet request = new HttpGet(solrSearchUrl);

            HttpResponse response = client.execute(request);
            System.out.println("ResponseBody Code: " + response.getStatusLine().getStatusCode());

            String solrSearchResultString = IOUtils.toString(response.getEntity().getContent());
            System.out.println("ResponseBody body: " + solrSearchResultString);

            //Need to deserialize json according to generic type passed
            ObjectMapper mapper = new ObjectMapper();
            JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);

            return mapper.readValue(solrSearchResultString, javaType);
        } catch (IOException e) {
            e.printStackTrace();

            ResponseBody<T> responseBody = new ResponseBody<T>();
            responseBody.setDocuments(Collections.emptyList());

            SolrSearchResult<T> solrSearchResult = new SolrSearchResult<>();
            solrSearchResult.setResponseBody(responseBody);

            return solrSearchResult;
        }
    }
}
