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
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

    @Value("${solr.show.stub.data.when.service.not.available}")
    private boolean showStubData;

    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        String queryString = "-parentId:[*%20TO%20*]";
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, 100, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        String queryString = "id:" + targetId;
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, 100, 0);
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

        return populateSearchUrlAndSendRequest(solrCollectionPath, encodedQueryString, CollectionInfo.class, 100, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollectionsByTitle(String parentCollectionId, String titleTextSearch) {
        String textToSearchInTitleQueryString = "title:*" + escapeQueryChars(titleTextSearch) + "*";
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
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, 100, 0);
    }

    public SolrSearchResult<ContentInfo> searchContentByTitle(String titleTextSearch) {
        String textToSearchInTitleQueryString = "title:*" + escapeQueryChars(titleTextSearch) + "*";

        URLCodec codec = new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(textToSearchInTitleQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return populateSearchUrlAndSendRequest(solrFullTextPath, encodedQueryString, ContentInfo.class, 10, 0);
    }

    public SolrSearchResult<ContentInfo> searchContentByFullText(String fullTextSearch) {
        String searchQuery = "text:*" + escapeQueryChars(fullTextSearch) + "*";

        URLCodec codec = new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(searchQuery);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return populateSearchUrlAndSendRequest(solrFullTextPath, encodedQueryString, ContentInfo.class, 10, 0);
    }

    /**
     * Copy logic from {@link org.apache.solr.client.solrj.util.ClientUtils#escapeQueryChars(String) escapeQueryChars}
     * But replacing of whitespace was removed
     */
    private static String escapeQueryChars(String stringToEscape) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < stringToEscape.length(); i++) {
            char c = stringToEscape.charAt(i);
            // These characters are part of the query syntax and must be escaped
            if (c == '\\' || c == '+' || c == '-' || c == '!'  || c == '(' || c == ')' || c == ':'
                    || c == '^' || c == '[' || c == ']' || c == '\"' || c == '{' || c == '}' || c == '~'
                    || c == '*' || c == '?' || c == '|' || c == '&'  || c == ';' || c == '/') {
                sb.append('\\');
            }
            sb.append(c);
        }
        return sb.toString();
    }

    private <T extends BodyDocsType> SolrSearchResult<T> populateSearchUrlAndSendRequest(String solrPath,
                                                                                         String queryString,
                                                                                         Class<T> bodyDocsType,
                                                                                         int rowsLimit,
                                                                                         int startFrom) {
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
            return toBackupSolrSearchResult(bodyDocsType);
        }
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
            e.printStackTrace();
            return null;
        }

        ObjectMapper mapper = new ObjectMapper();
        JavaType javaType = mapper.getTypeFactory().constructParametricType(SolrSearchResult.class, bodyDocsType);

        try {
            return mapper.readValue(solrSearchResultStubString, javaType);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
