package com.marsspiders.ukwa.solr;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import static java.lang.String.format;

@Service
public class SolrSearchService {

    @Value("${solr.search.path}")
    private String solrPath;

    @Value("${solr.auth.username}")
    private String username;

    @Value("${solr.auth.password}")
    private String password;

    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    public SolrSearchResult fetchRootCollections() {
        String queryString = "-parentId:[*%20TO%20*]";
        return fetchCollectionsInternal(queryString);
    }

    public SolrSearchResult fetchSubCollections(List<String> parentCollectionIds) {
        String queryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));

        URLCodec codec =  new URLCodec();
        String encodedQueryString = null;
        try {
            encodedQueryString = codec.encode(queryString);
        } catch (EncoderException e) {
            e.printStackTrace();
        }
        return fetchCollectionsInternal(encodedQueryString);
    }

    private SolrSearchResult fetchCollectionsInternal(String queryString) {
        int rowsLimit = 10000;
        int startFrom = 0;

        String solrSearchUrl = format("%sindent=%s&q=%s&rows=%d&start=%d&wt=%s",
                solrPath, INDENT_FLAG, queryString, rowsLimit, startFrom, RESULT_FORMAT);

        return sendRequest(solrSearchUrl, username, password);
    }


    private SolrSearchResult sendRequest(String solrSearchUrl, String userName, String password) {
        try {
            CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
            credentialsProvider.setCredentials(
                    new AuthScope(AuthScope.ANY_HOST, AuthScope.ANY_PORT),
                    new UsernamePasswordCredentials(userName, password));
            HttpClient client = HttpClientBuilder.create().setDefaultCredentialsProvider(credentialsProvider).build();
            HttpGet request = new HttpGet(solrSearchUrl);

            HttpResponse response = client.execute(request);
            System.out.println("ResponseBody Code: " + response.getStatusLine().getStatusCode());

            String solrSearchResultString = IOUtils.toString(response.getEntity().getContent());
            System.out.println("ResponseBody body: " + solrSearchResultString);

            return new ObjectMapper().readValue(solrSearchResultString, SolrSearchResult.class);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
