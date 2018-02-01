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

import java.util.*;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_TARGET;
import static com.marsspiders.ukwa.util.SolrSearchUtil.*;
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

    //-------------------- advanced SEARCH -----------------------------------
    private static final String FIELD_AUTHOR = "author";
    private static final String FIELD_POSTCODE_DISTRICT = "postcode_district";
    private static final String FIELD_CONTENT_LANGUAGE = "content_language";
    private static final String FIELD_LINKS_DOMAINS = "links_domains";
    //------------------------------------------------------------------------

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

    /**
     * Content advanced search
     *
     * @param searchLocation
     * @param searchText
     * @param rows
     * @param sortBy
     * @param accessTo
     * @param start
     * @param contentTypes
     * @param publicSuffixes
     * @param originalDomains
     * @param fromDatePicked
     * @param toDatePicked
     * @param rangeDates
     * @param collections
     * @return
     */
    public SolrSearchResult<ContentInfo> advancedSearchContent(SearchByEnum searchLocation,
                                                               String searchText,
                                                               //--------------------------------
                                                               String proximityPhrase1,
                                                               String proximityPhrase2,
                                                               String proximityDistance,
                                                               String excludedWords,

                                                               String hostDomainPublicSuffixes,
                                                               String fileFormats,
                                                               String websiteTitles,
                                                               String pageTitles,
                                                               String authorNames,

                                                               List<String> postcodeDistricts,
                                                               List<String> contentLanguages,
                                                               List<String> linksDomains,
                                                               List<String> crawlDates,
                                                               //--------------------------------
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
        log.info("------------------------------------------------------------");
        log.info("Advanced Searching content for '" + searchText + "' by " + searchLocation);

        SortClause sort = sortBy == null
                ? null
                : new SortClause(FIELD_CRAWL_DATE, sortBy.getSolrOrderValue());


        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);
        log.debug("dateQuery = " + dateQuery);

        String accessToQuery = generateAccessToQuery(accessTo);
        log.debug("accessToQuery = " + accessToQuery);

        String contentTypeQuery = generateMultipleConditionsQuery(contentTypes, FIELD_TYPE);
        log.debug("contentTypeQuery = " + contentTypeQuery);

        String collectionsQuery = generateMultipleConditionsQuery(collections, FIELD_COLLECTION);
        log.debug("collectionsQuery = " + collectionsQuery);

        String publicSuffixesQuery = generateMultipleConditionsQuery(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        log.debug("publicSuffixesQuery = " + publicSuffixesQuery);

        String domainsQuery = generateMultipleConditionsQuery(originalDomains, FIELD_DOMAIN);
        log.debug("domainsQuery = " + domainsQuery);

        String crawlDatesQuery = generateMultipleConditionsQuery(crawlDates, FIELD_CRAWL_DATE);
        log.debug("crawlDatesQuery = " + crawlDatesQuery);


        //---------- GAP test --------------------------------------------
        //String dateQueryWithGap = generateDateQueryGap(fromDatePicked, toDatePicked, rangeDates);
        //log.debug("dateQueryWithGap = " + dateQueryWithGap);
        //----------------------------------------------------------------
        String phraseQuery = generateMultipleConditionsQuery(contentTypes, FIELD_TYPE);
        log.debug("dateQuery = " + phraseQuery);

        String postcodedistrictQuery = generateMultipleConditionsQuery(postcodeDistricts, FIELD_POSTCODE_DISTRICT);
        log.debug("postcodedistrictQuery = " + postcodedistrictQuery);

        String contentLanguagesQuery = generateMultipleConditionsQuery(contentLanguages, FIELD_CONTENT_LANGUAGE);
        log.debug("contentLanguagesQuery = " + contentLanguagesQuery);

        String linksDomainsQuery = generateMultipleConditionsQuery(linksDomains, FIELD_LINKS_DOMAINS);
        log.debug("linksDomains = " + linksDomainsQuery);


        //filter list
        List<String> filters = new ArrayList<>();


        //--------------------------------------------------------------
        //
        //  ALL SEARCH FIELDS HAVE AND JOIN
        //  all search fields could be list, separated by space or comma
        //  uses generateMultipleAndConditionsQuery method
        //
        //--------------------------------------------------------------

        //---------- hostDomainPublicSuffix -------------
        if (hostDomainPublicSuffixes!=null && !hostDomainPublicSuffixes.isEmpty()){
            //List<String> hostDomainPublicSuffixList = Arrays.asList(hostDomainPublicSuffixes.split("[,\\s]+"));
            //log.debug("hostDomainPublicSuffix List = " + hostDomainPublicSuffixQuery);
            filters.add("{!tag=host}host:"+ hostDomainPublicSuffixes +
                    " OR " +"{!tag=domain}domain:"+ hostDomainPublicSuffixes +
                    " OR " +"{!tag=public_suffix}public_suffix:"+ hostDomainPublicSuffixes );
        }

        //---------- hostDomainPublicSuffix -------------
        if (fileFormats!=null && !fileFormats.isEmpty() ){
            log.debug("fileFormat List = " + fileFormats);
            filters.add("content_type_norm:" + fileFormats);
        }

        //---------- websiteTitle -------------
        if (websiteTitles!=null && !websiteTitles.isEmpty()){
        //    List<String> websiteTitleList = Arrays.asList(hostDomainPublicSuffix.split("[,\\s]+"));
        //    String websiteTitleQuery = generateMultipleAndConditionsQuery(websiteTitleList, FIELD_TITLE);
        //    log.debug("websiteTitle List = " + websiteTitleQuery);
        //    filters.add(websiteTitleQuery);
            filters.add("title:" + websiteTitles);
            filters.add("url_type:SLASHPAGE");
        }

        //---------- pageTitle -------------
        if (pageTitles!=null && !pageTitles.isEmpty()){
            filters.add("title:" + pageTitles);
        }

        //---------- AUTHORs LIST -------------
        if (authorNames!=null && !authorNames.isEmpty()){
            List<String> authorsList = Arrays.asList(authorNames.split("[,\\s]+"));
            //TODO: change to RAW SOLR query
            String authorsQuery = generateMultipleAndConditionsQuery(authorsList, FIELD_AUTHOR);
            log.debug("authors names = " + authorsQuery);
            filters.add(authorsQuery);
        }

        log.info("------------------------------------------------------------");

        filters.add(dateQuery);
        filters.add(accessToQuery);
        filters.add(contentTypeQuery);
        filters.add(publicSuffixesQuery);
        filters.add(domainsQuery);
        filters.add(collectionsQuery);
        //-------------- NEW -----------------------
        //filters.add(dateQueryWithGap);
        filters.add(phraseQuery);
        filters.add(postcodedistrictQuery);
        filters.add(contentLanguagesQuery);
        filters.add(linksDomainsQuery);


        filters.add(crawlDatesQuery);
        //-------------------------------------------

        String[] facets = {
                FIELD_PUBLIC_SUFFIX,
                FIELD_TYPE,
                FIELD_HOST,
                FIELD_DOMAIN,
                FIELD_COLLECTION,
                FIELD_CONTENT_TYPE_NORM,
                FIELD_ACCESS_TERMS,
                //TODO:
                //postcode district
                //crawl years - GAP 1 YEAR
                //Language
                //Links domains
                //ADVANCED SEARCH
                FIELD_POSTCODE_DISTRICT,
                FIELD_CONTENT_LANGUAGE,
                FIELD_LINKS_DOMAINS,
                FIELD_CRAWL_DATE
        };

        return sendRequest(toPrimaryAdvancedSearchQuery(FIELD_TEXT, searchText, proximityPhrase1, proximityPhrase2, proximityDistance, excludedWords),
                sort,
                filters,
                FIELD_CONTENT,
                ContentInfo.class,
                start, rows,
                facets);
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
