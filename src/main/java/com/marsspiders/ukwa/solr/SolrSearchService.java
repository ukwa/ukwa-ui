package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.ResponseBody;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import com.marsspiders.ukwa.util.SolrUtil;
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
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static java.lang.String.format;
import static org.apache.commons.lang3.StringUtils.isBlank;

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
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        String queryString = "-parentId:[*%20TO%20*]";
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, 1000, 0, null);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        String queryString = "id:" + targetId;
        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        int rowsLimit = 100;
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, rowsLimit, 0, null);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(List<String> parentCollectionIds,
                                                                  String documentType,
                                                                  long rowsLimit,
                                                                  long startFrom) {
        String typeSearchQueryString = "type:" + documentType;
        String parentIdsQueryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));

        URLCodec codec = new URLCodec();
        String encodedParentIdQueryString = null;
        try {
            encodedParentIdQueryString = codec.encode(parentIdsQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        String queryString = encodedParentIdQueryString + "&fq=" + typeSearchQueryString;
        return populateSearchUrlAndSendRequest(solrCollectionPath, queryString, CollectionInfo.class, rowsLimit, startFrom, null);
    }

    public SolrSearchResult<ContentInfo> searchContentByFullText(SearchByEnum searchLocation, String textToSearch,
                                                                 long rowsLimit,
                                                                 long startFrom,
                                                                 Date fromDate,
                                                                 Date toDate,
                                                                 List<DocumentTypeEnum> documentTypes,
                                                                 List<String> checkedPublicSuffixes) {
        String fromDateText = fromDate != null ? sdf.format(fromDate) : "*";
        String toDateText = toDate != null ? sdf.format(toDate) : "*";

        String dateQuery = "crawl_date:[" + fromDateText + " TO " + toDateText + "]";
        String searchQuery = searchLocation.getSolrSearchLocation() + ":\"" + SolrUtil.escapeQueryChars(textToSearch) + "\"";
        String contentTypeNotEmpty = "content_type:['' TO *]";
        String andJoiner = " AND ";
        String orJoiner = " OR ";

        StringBuilder sb = new StringBuilder();
        for (String contentType : DocumentTypeEnum.toContentTypes(documentTypes)) {
           if(sb.length() == 0){
               sb.append("(");
           } else {
               sb.append(orJoiner);
           }
            sb.append("content_type:").append(contentType);
        }

        if(sb.length() != 0){
            sb.append(")");
            sb.insert(0, andJoiner);
        }

        String contentTypeQueryString = contentTypeNotEmpty + sb.toString();


        sb = new StringBuilder();
        for (String publicSuffix : checkedPublicSuffixes) {
            if(sb.length() == 0){
                sb.append("(");
            } else {
                sb.append(orJoiner);
            }
            sb.append("public_suffix:").append(publicSuffix);
        }

        if(sb.length() != 0){
            sb.append(")");
            sb.insert(0, andJoiner);
        }

        String publicSuffixQueryString = sb.toString();

        URLCodec codec = new URLCodec();
        String encodedSearchQueryString = null;
        String encodedDateQueryString = null;
        String encodedAndJoiner = null;
        String encodedContentTypeQueryString = null;
        String encodedPublicSuffixQueryString = null;
        try {
            encodedSearchQueryString = codec.encode(searchQuery);
            encodedDateQueryString = codec.encode(dateQuery);
            encodedAndJoiner = codec.encode(andJoiner);
            encodedContentTypeQueryString = codec.encode(contentTypeQueryString);
            encodedPublicSuffixQueryString = codec.encode(publicSuffixQueryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        String facetField = "public_suffix";
        String queryString = encodedSearchQueryString + "&fq=" + encodedDateQueryString + encodedAndJoiner + encodedContentTypeQueryString + encodedPublicSuffixQueryString;
        return populateSearchUrlAndSendRequest(solrFullTextPath, queryString, ContentInfo.class, rowsLimit, startFrom, facetField);
    }

    private <T extends BodyDocsType> SolrSearchResult<T> populateSearchUrlAndSendRequest(String solrPath,
                                                                                         String queryString,
                                                                                         Class<T> bodyDocsType,
                                                                                         long rowsLimit,
                                                                                         long startFrom, String facetField) {
        String facetQuery = isBlank(facetField) ? "" : "&facet=on&facet.field=" + facetField;
        String solrSearchUrl = format("%sindent=%s&q=%s&rows=%d&start=%d&wt=%s%s",
                solrPath, INDENT_FLAG, queryString, rowsLimit, startFrom, RESULT_FORMAT, facetQuery);

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
            System.out.println("Sending request to SOLR: " + solrSearchUrl);

            HttpResponse response = client.execute(request);
            System.out.println("SOLR ResponseBody Code: " + response.getStatusLine().getStatusCode());

            String solrSearchResultString = IOUtils.toString(response.getEntity().getContent());
            System.out.println("SOLR ResponseBody body: " + solrSearchResultString.replaceAll("\n", ""));

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
