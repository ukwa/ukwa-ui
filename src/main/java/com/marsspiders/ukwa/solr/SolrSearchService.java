package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.CollectionController.TYPE_COLLECTION;
import static com.marsspiders.ukwa.controllers.CollectionController.TYPE_TARGET;
import static com.marsspiders.ukwa.util.SolrUtil.escapeQueryChars;
import static com.marsspiders.ukwa.util.SolrUtil.toEncoded;
import static com.marsspiders.ukwa.util.SolrUtil.toMultipleConditionsQuery;
import static java.lang.String.format;
import static java.util.stream.Collectors.toList;

@Service
public class SolrSearchService {
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    public static final String AND_JOINER = " AND ";
    public static final String OR_JOINER = " OR ";

    private static final int ROOT_COLLECTIONS_ROWS_LIMIT = 1000;
    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    private static final String FIELD_CONTENT_TYPE_NORM = "content_type_norm";
    private static final String FIELD_PUBLIC_SUFFIX = "public_suffix";
    private static final String FIELD_HOST = "host";
    private static final String FIELD_CRAWL_DATE = "crawl_date";

    private static final String EXCLUDE_FACET_TAG_NAME = "filter";
    private static final String EXCLUDE_MARKER_TAG = "{!tag=" + EXCLUDE_FACET_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_TAG = "{!ex=" + EXCLUDE_FACET_TAG_NAME + "}";
    private static final String DATE_PART_AFTER_YEAR = "-01-01T00:00:00Z";
    private static final int FACET_RANGE_START_YEAR = 1980;
    private static final int FACET_RANGE_END_YEAR = 2040;

    private final Map<String, List<String>> collectionIdsToHosts = new HashMap<>();
    private final Map<String, String> urlsToCollectionId = new HashMap<>();
    private final Map<String, String> idsToNames = new HashMap<>();

    @Autowired
    SolrCommunicator communicator;

    private SolrSearchResult<CollectionInfo> fetchAllCollections() {
        System.out.println("Fetching all collections");

        String queryString = "type:" + TYPE_COLLECTION;

        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        System.out.println("Fetching root collections");

        String queryString = "-parentId:[*%20TO%20*]";
        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        System.out.println("Fetching collections by id: " + targetId);

        String queryString = "id:" + targetId;
        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        int rowsLimit = 100;
        return sendRequest(queryString, CollectionInfo.class, rowsLimit, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(Collection<String> parentCollectionIds,
                                                                  String documentType,
                                                                  long rowsLimit,
                                                                  long startFrom) {
        System.out.println("Fetching child collections by parent ids: " + parentCollectionIds + ", documentType: " + documentType);

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
        return sendRequest(queryString, CollectionInfo.class, rowsLimit, startFrom);
    }

    public Map<String, String> getParentCollections(List<String> hostsPairs) {
        Map<String, String> collectionIdsToName = new HashMap<>();

        if (hostsPairs == null || hostsPairs.size() == 0) {
            return collectionIdsToName;
        }

        List<String> actualHosts = toActualHosts(hostsPairs);
        determineUrlsByCollections();

        System.out.println("Getting parent collections by hosts: " + actualHosts);

        for (String url : urlsToCollectionId.keySet()) {
            String domainName = toDomainName(url);

            String collectionId = urlsToCollectionId.get(url);
            if (actualHosts.contains(domainName) && collectionIdsToName.get(collectionId) == null) {
                collectionIdsToName.put(collectionId, idsToNames.get(collectionId));
            }
        }

        System.out.println("Parent collections by hosts are: " + collectionIdsToName);


        return collectionIdsToName;
    }

    private void determineUrlsByCollections() {
        if (urlsToCollectionId.size() > 0) {
            return;
        }

        System.out.println("Determining urls of all collections");

        SolrSearchResult<CollectionInfo> allCollections = fetchAllCollections();
        allCollections.getResponseBody().getDocuments()
                .stream()
                .forEach(d -> idsToNames.put(d.getId(), d.getName()));

        SolrSearchResult<CollectionInfo> childCollections = fetchChildCollections(idsToNames.keySet(), TYPE_TARGET, 100000, 0);
        childCollections.getResponseBody().getDocuments()
                .stream()
                .forEach(d -> {
                    String url = d.getUrl();
                    String collectionId = d.getParentId();
                    urlsToCollectionId.put(url, collectionId);

                    List<String> hosts = collectionIdsToHosts.get(collectionId);
                    if (hosts == null) {
                        hosts = new ArrayList<>();
                    }

                    hosts.add(toDomainName(url));
                    collectionIdsToHosts.put(collectionId, hosts);
                });
    }

    private static String toDomainName(String url) {
        try {
            URI uri = new URI(url);
            String domain = uri.getHost();
            return domain.startsWith("www.") ? domain.substring(4) : domain;
        } catch (URISyntaxException e) {
            e.printStackTrace();
            return null;
        }
    }

    public SolrSearchResult<ContentInfo> searchContent(SearchByEnum searchLocation,
                                                       String textToSearch,
                                                       long rowsLimit,
                                                       long startFrom,
                                                       List<String> contentTypes,
                                                       List<String> publicSuffixes,
                                                       Date fromDatePicked,
                                                       Date toDatePicked,
                                                       List<String> rangeDates,
                                                       List<String> collectionIds) {
        System.out.println("Searching content for '" + textToSearch + "' by " + searchLocation);

        String searchQuery = searchLocation.getSolrSearchLocation() + ":\"" + escapeQueryChars(textToSearch) + "\"";
        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);

        String contentTypeNotEmpty = FIELD_CONTENT_TYPE_NORM + ":['' TO *]";
        String contentTypesConditionQuery = toMultipleConditionsQuery(contentTypes, FIELD_CONTENT_TYPE_NORM);
        String contentTypeQuery = EXCLUDE_MARKER_TAG + contentTypeNotEmpty + contentTypesConditionQuery;

        String publicSuffixesNotEmpty = FIELD_PUBLIC_SUFFIX + ":['' TO *]";
        String publicSuffixesConditionQuery = toMultipleConditionsQuery(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        String publicSuffixesQuery = EXCLUDE_MARKER_TAG + publicSuffixesNotEmpty + publicSuffixesConditionQuery;

        List<String> hostsToSearch = getActualHostsFromCollections(collectionIds, searchLocation, textToSearch);
        String originalCollectionsNotEmpty = FIELD_HOST + ":['' TO *]";
        String originalCollectionsConditionQuery = toMultipleConditionsQuery(hostsToSearch, FIELD_HOST);
        String originalCollectionsQuery = EXCLUDE_MARKER_TAG + originalCollectionsNotEmpty + originalCollectionsConditionQuery;

        String queryString = toEncoded(searchQuery) +
                "&fq=" + toEncoded(dateQuery) +
                "&fq=" + toEncoded(contentTypeQuery) +
                "&fq=" + toEncoded(publicSuffixesQuery) +
                "&fq=" + toEncoded(originalCollectionsQuery) +
                "&facet.range.gap=%2B1YEAR" +
                "&facet.range=" + toEncoded(EXCLUDE_POINT_TAG) + FIELD_CRAWL_DATE +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.start=" + FACET_RANGE_START_YEAR + DATE_PART_AFTER_YEAR +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.end=" + FACET_RANGE_END_YEAR + DATE_PART_AFTER_YEAR;

        return sendRequest(queryString, ContentInfo.class, rowsLimit, startFrom,
                FIELD_PUBLIC_SUFFIX, FIELD_CONTENT_TYPE_NORM, FIELD_HOST);
    }

    private String generateDateQuery(Date fromDatePicked, Date toDatePicked, List<String> rangeDates) {
        String fromDateText = fromDatePicked != null ? sdf.format(fromDatePicked) : "*";
        String toDateText = toDatePicked != null ? sdf.format(toDatePicked) : "*";
        if(fromDatePicked != null || toDatePicked != null){
            return FIELD_CRAWL_DATE + ":[" + fromDateText + " TO " + toDateText + "]";
        }

        String dateQuery = "";
        for (String originalRangeDate : rangeDates) {
            dateQuery += dateQuery.length() > 0 ? OR_JOINER : EXCLUDE_MARKER_TAG;

            int yearWhenArchived = Integer.parseInt(originalRangeDate);
            String fromDate = yearWhenArchived + DATE_PART_AFTER_YEAR;
            String toDate = (yearWhenArchived + 1) + DATE_PART_AFTER_YEAR;

            dateQuery += FIELD_CRAWL_DATE + ":[" + fromDate + " TO " + toDate + "]";
        }

        return dateQuery;
    }

    private List<String> getActualHostsFromCollections(List<String> collectionIds, SearchByEnum searchLocation, String textToSearch) {
        System.out.println("Getting list of actual hosts that are contains in collections: " + collectionIds);

        String searchQuery = searchLocation.getSolrSearchLocation() + ":\"" + escapeQueryChars(textToSearch) + "\"";
        String queryString = toEncoded(searchQuery);

        SolrSearchResult<ContentInfo> result = sendRequest(queryString, ContentInfo.class, 0, 0, FIELD_HOST);
        List<String> actualHosts = toActualHosts(result.getFacetCounts().getFields().getHosts());

        List<String> hostsToSearch = new ArrayList<>();

        collectionIds
                .stream()
                .forEach(id -> {
                    List<String> hostsFromCollection = collectionIdsToHosts.get(id);
                    if (hostsFromCollection == null) {
                        return;
                    }

                    List<String> actualHostsFromCollection = hostsFromCollection
                            .stream()
                            .filter(actualHosts::contains)
                            .collect(toList());

                    hostsToSearch.addAll(actualHostsFromCollection);
                });

        return hostsToSearch;
    }

    private List<String> toActualHosts(List<String> hostsPairs) {
        List<String> actualHosts = new ArrayList<>();
        for (int i = 0; i < hostsPairs.size(); i += 2) {
            if ("0".equals(hostsPairs.get(i + 1))) {
                continue;
            }

            actualHosts.add(hostsPairs.get(i));
        }
        return actualHosts;
    }


    private <T extends BodyDocsType> SolrSearchResult<T> sendRequest(String queryString,
                                                                     Class<T> bodyDocsType,
                                                                     long rowsLimit,
                                                                     long startFrom,
                                                                     String... facetFields) {
        String fieldsFacetQuery = "&facet=on";
        for (String facetField : facetFields) {
            fieldsFacetQuery += "&facet.field=" + toEncoded(EXCLUDE_POINT_TAG) + facetField;
        }


        String solrSearchUrl = format("indent=%s&q=%s&rows=%d&start=%d&wt=%s%s",
                INDENT_FLAG, queryString, rowsLimit, startFrom, RESULT_FORMAT, fieldsFacetQuery);

        return communicator.sendRequest(solrSearchUrl, bodyDocsType);
    }
}
