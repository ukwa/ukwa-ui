package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.SortClause;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_TARGET;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateAccessToQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateDateQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateMultipleConditionsQuery;
import static org.apache.commons.lang3.StringUtils.isNotBlank;
import static org.apache.solr.client.solrj.SolrQuery.ORDER.asc;

import org.apache.lucene.queryparser.classic.QueryParser;

@Service
public class SolrSearchService {
    private static final Logger log = LoggerFactory.getLogger(SolrSearchService.class);

    public static final String AND_JOINER = " AND ";
    public static final String OR_JOINER = " OR ";

    private static final int ROOT_COLLECTIONS_ROWS_LIMIT = 1000;

    public static final String FIELD_CRAWL_DATE = "crawl_date";
    public static final String FIELD_ACCESS_TERMS = "access_terms";
    private static final String FIELD_NAME = "name";
    private static final String FIELD_TYPE = "type";
    private static final String FIELD_PUBLIC_SUFFIX = "public_suffix";
    private static final String FIELD_HOST = "host";
    private static final String FIELD_DOMAIN = "domain";
    private static final String FIELD_ID = "id";
    private static final String FIELD_TITLE = "title";
    private static final String FIELD_URL = "url";
    private static final String FIELD_COLLECTION = "collection";
    private static final String FIELD_CONTENT_TYPE_NORM = "content_type_norm";
    private static final String FIELD_CONTENT = "content";
    private static final String FIELD_TEXT = "text";

    private static final String EXCLUDE_FACET_FIRST_LAYER_TAG_NAME = "filterFirstLayer";
    private static final String EXCLUDE_FACET_SECOND_LAYER_TAG_NAME = "filterSecondLayer";
    public static final String EXCLUDE_MARKER_FIRST_LAYER_TAG = "{!tag=" + EXCLUDE_FACET_FIRST_LAYER_TAG_NAME + "}";
    public static final String EXCLUDE_MARKER_SECOND_LAYER_TAG = "{!tag=" + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_FIRST_LAYER_TAG = "{!ex="
            + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + ","
            + EXCLUDE_FACET_FIRST_LAYER_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_SECOND_LAYER_TAG = "{!ex=" + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + "}";

    @Autowired
    SolrCommunicator communicator;

    private SolrSearchResult<CollectionInfo> fetchAllCollections() {
        log.info("Fetching all collections");

        String queryString = "type:" + TYPE_COLLECTION.getSolrDocumentType();
        int rowsLimit = ROOT_COLLECTIONS_ROWS_LIMIT;

        return sendRequest(queryString, null, null, null, CollectionInfo.class, 0, rowsLimit);
    }

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        log.info("Fetching root collections");

        String noParentQuery = "-parentId:[* TO *]";
        SortClause sortClause = new SortClause(FIELD_NAME, asc);
        int rowsLimit = ROOT_COLLECTIONS_ROWS_LIMIT;

        return sendRequest(noParentQuery, sortClause, null, null, CollectionInfo.class, 0, rowsLimit);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        log.info("Fetching collections by id: " + targetId);

        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        int rowsLimit = 100;
        String collectionIdQuery = FIELD_ID + ":" + targetId;
        SortClause sortClause = new SortClause(FIELD_NAME, asc);

        return sendRequest(collectionIdQuery, sortClause, null, null, CollectionInfo.class, 0, rowsLimit);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(Collection<String> parentCollectionIds,
                                                                  CollectionDocumentType documentType,
                                                                  int rowsLimit,
                                                                  int startFrom) {
        log.info("Fetching child collections by parent ids: " + parentCollectionIds + ", documentType: " + documentType);

        String fieldToSort = documentType == TYPE_TARGET
                ? FIELD_TITLE
                : FIELD_NAME;

        SortClause sortClause = new SortClause(fieldToSort, asc);
        String typeSearchQueryString = "type:" + documentType.getSolrDocumentType();
        String queryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));

        List<String> filterQueries = new ArrayList<>();
        filterQueries.add(typeSearchQueryString);

        return sendRequest(queryString, sortClause, filterQueries, null, CollectionInfo.class, startFrom, rowsLimit);
    }

    public SolrSearchResult<ContentInfo> searchUrlInContent(String urlToSearch) {
        log.info("Searching site for url '" + urlToSearch);

        String protocolPart = "(https?\\:\\/\\/)?";
        String wwwPart = "(www\\.)?";
        String urlWithReplacedSlashes = urlToSearch.replace("/", "\\/");
        String endSlashPart = "\\/?";

        String urlToSearchRegex = protocolPart + wwwPart + urlWithReplacedSlashes + endSlashPart;
        String urlToSearchQuery = FIELD_URL + ":/" + urlToSearchRegex + "/";

        return sendRequest(urlToSearchQuery, null, null, null, ContentInfo.class, 0, 10);
    }

    public SolrSearchResult<ContentInfo> searchContent(SearchByEnum searchLocation,
                                                       String searchText,
                                                       int rows,
                                                       SortByEnum sortBy,
                                                       AccessToEnum accessTo,
                                                       int start,
                                                       List<String> contentTypes,
                                                       List<String> publicSuffixes,
                                                       List<String> originalDomains,
                                                       Date fromDatePicked,
                                                       Date toDatePicked,
                                                       List<String> rangeDates,
                                                       List<String> collections) {
        log.info("Searching content for '" + searchText + "' by " + searchLocation);

        SortClause sort = sortBy == null
                ? null
                : new SortClause(FIELD_CRAWL_DATE, sortBy.getSolrOrderValue());
        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);
        String accessToQuery = generateAccessToQuery(accessTo);
        String contentTypeQuery = generateMultipleConditionsQuery(contentTypes, FIELD_TYPE);
        String collectionsQuery = generateMultipleConditionsQuery(collections, FIELD_COLLECTION);
        String publicSuffixesQuery = generateMultipleConditionsQuery(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        String domainsQuery = generateMultipleConditionsQuery(originalDomains, FIELD_DOMAIN);

        List<String> filters = new ArrayList<>();
        filters.add(dateQuery);
        filters.add(accessToQuery);
        filters.add(contentTypeQuery);
        filters.add(publicSuffixesQuery);
        filters.add(domainsQuery);
        filters.add(collectionsQuery);

        String[] facets = {FIELD_PUBLIC_SUFFIX, FIELD_TYPE, FIELD_HOST, FIELD_DOMAIN,
                FIELD_COLLECTION, FIELD_CONTENT_TYPE_NORM, FIELD_ACCESS_TERMS};

        String queryString = "{!q.op=" + AND_JOINER + " df=" + FIELD_TEXT + "}" + QueryParser.escape(searchText);
        return sendRequest(queryString, sort, filters, FIELD_CONTENT, ContentInfo.class, start, rows, facets);
    }

    private <T extends BodyDocsType> SolrSearchResult<T> sendRequest(String queryString,
                                                                     SortClause sortClause,
                                                                     List<String> filterQueries,
                                                                     String highlightField,
                                                                     Class<T> bodyDocsType,
                                                                     int startFrom,
                                                                     int rowsLimit,
                                                                     String... facetFields) {
        SolrQuery query = new SolrQuery();
        query.setQuery(queryString);
        query.set("defType", "edismax");
        query.setStart(startFrom);
        query.setRows(rowsLimit);

        if(sortClause != null){
            query.addSort(sortClause);
        }

        if(filterQueries != null && filterQueries.size() > 0){
            query.addFilterQuery(filterQueries.toArray(new String[filterQueries.size()]));
        }

        if(isNotBlank(highlightField)){
            query.setHighlight(true);
            query.addHighlightField(highlightField);
        }

        if(facetFields.length > 0){
            query.setFacet(true);

            for (String facetField : facetFields) {
                if (facetField.equals(FIELD_ACCESS_TERMS)) {
                    query.addFacetField(EXCLUDE_POINT_FIRST_LAYER_TAG + facetField);
                } else {
                    query.addFacetField(EXCLUDE_POINT_SECOND_LAYER_TAG + facetField);
                }
            }
        }

        return communicator.sendRequest(bodyDocsType, query);
    }
}
