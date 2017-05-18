package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.ResponseBody;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
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
import java.util.Collections;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.util.SolrUtil.toDecoded;

@Service
public class SolrCommunicator {
    private static final Logger log = LoggerFactory.getLogger(SolrCommunicator.class);

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

    @Value("${solr.show.stub.data.when.service.not.available}")
    private boolean showStubData;

    <T extends BodyDocsType> SolrSearchResult<T> sendRequest(String solrSearchUrl, Class<T> bodyDocsType) {
        try {

            String solrServerUrl;
            if (bodyDocsType.isAssignableFrom(ContentInfo.class)) {
                solrServerUrl = solrFullTextPath;
            } else if (bodyDocsType.isAssignableFrom(CollectionInfo.class)) {
                solrServerUrl = solrCollectionPath;
            } else {
                throw new IllegalStateException("Unknown bodyDocsType: " + bodyDocsType);
            }

            HttpGet request = new HttpGet(solrServerUrl + solrSearchUrl);
            log.debug("Sending request to SOLR: " + toDecoded(request.getURI().toString()));

            HttpResponse response = getHttpClient().execute(request);
            String solrSearchResultString = IOUtils.toString(response.getEntity().getContent());

            int subStringLength = solrSearchResultString.length() >= 1000 ? 1000 : solrSearchResultString.length();
            //String cutResponseBody = toDecoded(solrSearchResultString.substring(0, subStringLength)) + ".........";
            String fullResponseLine = solrSearchResultString.replaceAll("\n", "");
            log.debug("SOLR Response length: " + solrSearchResultString.length() + ", body: " + fullResponseLine);

            if(response.getStatusLine().getStatusCode() != 200){
                throw new IllegalStateException("Unexpected response status code: " + response.getStatusLine().getStatusCode());
            }

            //Need to deserialize json according to generic type passed
            ObjectMapper mapper = new ObjectMapper();
            JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);

            return mapper.readValue(solrSearchResultString, javaType);
        } catch (IOException e) {
            log.error("Failed to send request to Solr", e);
            return toBackupSolrSearchResult(bodyDocsType);
        }
    }

    private HttpClient getHttpClient() {
        CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
        credentialsProvider.setCredentials(
                new AuthScope(AuthScope.ANY_HOST, AuthScope.ANY_PORT),
                new UsernamePasswordCredentials(username, password));

        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(connectionTimeout)
                .setConnectionRequestTimeout(connectionTimeout)
                .setSocketTimeout(readTimeout)
                .build();

        return HttpClientBuilder
                .create()
                .setDefaultCredentialsProvider(credentialsProvider)
                .setDefaultRequestConfig(requestConfig)
                .build();
    }

    private <T extends BodyDocsType> SolrSearchResult<T> toBackupSolrSearchResult(Class<T> bodyDocsType) {
        SolrSearchResult<T> solrSearchResult = null;

        if (showStubData) {
            solrSearchResult = toStubSolrSearchResult(bodyDocsType);
        }

        if (solrSearchResult == null) {
            solrSearchResult = toEmptySolrSearchResult();
        }

        return solrSearchResult;
    }

    private <T extends BodyDocsType> SolrSearchResult<T> toEmptySolrSearchResult() {
        SolrSearchResult<T> solrSearchResult;
        ResponseBody<T> responseBody = new ResponseBody<T>();
        responseBody.setDocuments(Collections.emptyList());

        solrSearchResult = new SolrSearchResult<>();
        solrSearchResult.setResponseBody(responseBody);

        return solrSearchResult;
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
