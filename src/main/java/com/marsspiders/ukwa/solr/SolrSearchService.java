package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrQuery.SortClause;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrClient;
import org.apache.solr.client.solrj.impl.NoOpResponseParser;
import org.apache.solr.client.solrj.request.QueryRequest;
import org.apache.solr.client.solrj.response.*;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.params.GroupParams;
import org.apache.solr.common.util.NamedList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

//import org.springframework.data.solr.core.query.result.GroupResult;

import java.io.IOException;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_TARGET;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateAccessToQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateDateQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateMultipleConditionsQuery;
import static org.apache.commons.lang3.StringUtils.isNotBlank;
import static org.apache.solr.client.solrj.SolrQuery.ORDER.asc;

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
    // private static final String FIELD_HOST = "host";
    private static final String FIELD_DOMAIN = "domain";
    private static final String FIELD_ID = "id";
    private static final String FIELD_TITLE = "title";
    private static final String FIELD_URL = "url";
    private static final String FIELD_COLLECTION = "collection";
    // private static final String FIELD_CONTENT_TYPE_NORM =
    // "content_type_norm";
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


    //------------------ categories start -----------------

    private SolrSearchResult<CollectionInfo> fetchAllCollectionsCategories() {
        log.info("Fetching all collections - categories");

        String queryString = "type:" + TYPE_COLLECTION.getSolrDocumentType();
        int rowsLimit = ROOT_COLLECTIONS_ROWS_LIMIT;

        return sendRequest(queryString, null, null, null, CollectionInfo.class, 0, rowsLimit);
    }

    public SolrSearchResult<CollectionInfo> fetchRootCollectionsCategories() {
        log.info("Fetching root collections - Categories");

        //------- add query  CATEGORIES !!!!!

        //String noParentQuery = "-parentId:[* TO *]";
        //SortClause sortClause = new SortClause(FIELD_NAME, asc);
        //int rowsLimit = ROOT_COLLECTIONS_ROWS_LIMIT;

        return sendCategoryRequest("", CollectionInfo.class);
    }

    //------------------ categories end -----------------

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
                                                       String queryString,
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
                                                       List<String> collections,
                                                       boolean preProcessQueryString) {
        log.debug("Searching content for '" + queryString + "' by " + searchLocation);

        SortClause sort = sortBy == null ? null : (sortBy.getWebRequestOrderValue()=="relevant" ? new SortClause("score", sortBy.getSolrOrderValue()) : new SortClause(FIELD_CRAWL_DATE, sortBy.getSolrOrderValue()));
        log.debug("Searching content after  sort sortBy" );

        log.debug("Searching content fromDatePicked = " + fromDatePicked + ", toDatePicked = " + toDatePicked + ", rangeDates = " + rangeDates );
        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);
        log.debug("Searching content after  generateDateQuery" );

        String accessToQuery = generateAccessToQuery(accessTo);
        log.debug("Searching content after  generateAccessToQuery" );

        String contentTypeQuery = generateMultipleConditionsQuery(contentTypes, FIELD_TYPE);
        String collectionsQuery = generateMultipleConditionsQuery(collections, FIELD_COLLECTION);
        String publicSuffixesQuery = generateMultipleConditionsQuery(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        String domainsQuery = generateMultipleConditionsQuery(originalDomains, FIELD_DOMAIN);

        log.debug("Searching content after  domainsQuery" );


        List<String> filters = new ArrayList<>();
        filters.add(dateQuery);
        filters.add(accessToQuery);
        filters.add(contentTypeQuery);
        filters.add(publicSuffixesQuery);
        filters.add(domainsQuery);
        filters.add(collectionsQuery);

        String[] facets = { FIELD_PUBLIC_SUFFIX, FIELD_TYPE, FIELD_DOMAIN,
                FIELD_COLLECTION, FIELD_ACCESS_TERMS };


        if (preProcessQueryString){
            //Remove:
            // - URL prefixes
            // - symbols:    + - & | ! ( ) { } [ ] ^ " ~ * ? : \ /
            Pattern p = Pattern.compile("(http[s]?://www\\.|http[s]?://|www\\.|[&|*()?:!,~{}^/]+)");
            return sendRequest(p.matcher(queryString).replaceAll(""), sort, filters, FIELD_CONTENT, ContentInfo.class, start, rows, facets);
        }
        else
            //return sendRequestEmpty(queryString, sort, filters, FIELD_CONTENT, ContentInfo.class, start, rows, facets);
            return sendRequestCheckCollection(ContentInfo.class, "");
    }

    /**
     * Check if there is anything in full-text-index for specific collection
     * @param bodyDocsType
     * @param <T>
     * @return
     */
    private <T extends BodyDocsType> SolrSearchResult<T> sendRequestCheckCollection(Class<T> bodyDocsType, String collectionName) {
        SolrQuery query = new SolrQuery();
        query.setQuery("*:*"); //main query
        query.setParam("q", "collection: " + collectionName);
        return communicator.sendRequest(bodyDocsType, query);
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

        //
        //Edismax can:
        // -- run queries against all query fields,
        // -- (and also) run a query in the form of a phrase against the phrase fields
        //

        query.set("qf", FIELD_TEXT);
        query.set("pf", FIELD_TEXT);
        //query.set("sow", "false");
        //query.set("mm", "2");

        // Limit fields coming back to those we actually need (see
        // SearchResultDTO):
        // BUT this breaks because the same code is used for both Solr back ends
        // query.setFields("id", "access_terms", "url", "crawl_date", "title",
        // "domain");

        if(filterQueries != null && filterQueries.size() > 0){
            query.addFilterQuery(filterQueries.toArray(new String[filterQueries.size()]));
        }

        //hl
        if(isNotBlank(highlightField)){
            query.setHighlight(true);
            query.addHighlightField(highlightField);
        }

        //facet=true
        //facet.field=...
        if(facetFields.length > 0){
            query.setFacet(true);

            // Use threads for faceting, try eight for now:
            query.set("facet.threads", 8);

            // Setup each facet:
            for (String facetField : facetFields) {
                if (facetField.equals(FIELD_ACCESS_TERMS)) {
                    query.addFacetField(EXCLUDE_POINT_FIRST_LAYER_TAG + facetField);
                } else {
                    query.addFacetField(facetField);
                }
            }
        }

        return communicator.sendRequest(bodyDocsType, query);
    }



    public <T extends BodyDocsType> SolrSearchResult<T> sendCategoryRequest(String queryString,
                                                                     Class<T> bodyDocsType
                                                                     ) {

        SolrQuery query = new SolrQuery();
        query.setFacet(true);
        query.addFacetPivotField(new String[]{"collectionAreaId,parentId,id"});
        //SolrSearchResult
        // http://localhost:38983/solr/collections/select?
        // fl=collectionAreaId,id,parentId
        // &fq=collectionAreaId:[*%20TO%20*]-collectionAreaId:(2945)
        // &indent=on&facet=true
        // &facet.limit=-1
        // &facet.pivot.mincount=1
        // &facet.pivot=collectionAreaId,parentId,id
        // &q=*:*&wt=json


        query.set("facet.limit", "-1");
//        query.set("group", true);
        //query.set("fq", "collectionAreaId:[*%20TO%20*]-collectionAreaId:(2945)");
        query.set("indent", "on");

        query.setParam("q", "*:*");
        //query.set("rows", "1000");
        query.set("wt", "json");

        log.info("------- pries sendRequest categories query = " + query.toString());


        return communicator.sendRequest(bodyDocsType, query);
    }


    public static void queryFacet(HttpSolrClient solrClient, String collecionName) throws Exception{
        SolrQuery query = new SolrQuery();
        query.setQuery("*");
        // Do not query data, only query facet results
        query.setFacet(true);
        // facet field
        query.addFacetField("price");
        // Total facet results
        query.setFacetLimit(8);
        // Start query
        QueryResponse queryResponse = solrClient.query(collecionName, query);
        List<FacetField> facetFields = queryResponse.getFacetFields();
        for (FacetField facetField : facetFields) {
            String facetName=facetField.getName();
            List<FacetField.Count> values = facetField.getValues();
            for (FacetField.Count count : values) {
                String name = count.getName();
                long num=count.getCount();
                System.out.println("facetName: "+facetName+"; name: "+name+"; num: "+num);
            }
        }
    }

}
