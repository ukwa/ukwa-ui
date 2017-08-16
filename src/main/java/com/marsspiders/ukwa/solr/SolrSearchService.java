package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.lang3.StringUtils;
import org.apache.solr.client.solrj.util.ClientUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.CollectionDocumentType.TYPE_TARGET;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateAccessToQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateDateQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateMultipleConditionsQuery;
import static com.marsspiders.ukwa.util.SolrSearchUtil.generateMultipleConditionsQueryWithPreCondition;
import static com.marsspiders.ukwa.util.SolrStringUtil.toEncoded;
import static java.lang.String.format;

@Service
public class SolrSearchService {
    private static final Logger log = LoggerFactory.getLogger(SolrSearchService.class);


    public static final String AND_JOINER = " AND ";
    public static final String OR_JOINER = " OR ";

    private static final int ROOT_COLLECTIONS_ROWS_LIMIT = 1000;
    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    private static final String FIELD_NAME = "name";
    private static final String FIELD_TYPE = "type";
    private static final String FIELD_PUBLIC_SUFFIX = "public_suffix";
    private static final String FIELD_HOST = "host";
    private static final String FIELD_DOMAIN = "domain";
    public static final String FIELD_CRAWL_DATE = "crawl_date";
    public static final String FIELD_ACCESS_TERMS = "access_terms";
    private static final String FIELD_ID = "id";
    private static final String FIELD_TITLE = "title";
    private static final String FIELD_URL = "url";
    private static final String FIELD_WAYBACK_DATE = "wayback_date";
    private static final String FIELD_COLLECTION = "collection";

    private static final String EXCLUDE_FACET_FIRST_LAYER_TAG_NAME = "filterFirstLayer";
    private static final String EXCLUDE_FACET_SECOND_LAYER_TAG_NAME = "filterSecondLayer";
    public static final String EXCLUDE_MARKER_FIRST_LAYER_TAG = "{!tag=" + EXCLUDE_FACET_FIRST_LAYER_TAG_NAME + "}";
    public static final String EXCLUDE_MARKER_SECOND_LAYER_TAG = "{!tag=" + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_FIRST_LAYER_TAG = "{!ex="
            + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + ","
            + EXCLUDE_FACET_FIRST_LAYER_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_SECOND_LAYER_TAG = "{!ex=" + EXCLUDE_FACET_SECOND_LAYER_TAG_NAME + "}";
    public static final String DATE_PART_AFTER_YEAR = "-01-01T00:00:00Z";
    private static final int FACET_RANGE_START_YEAR = 1980;
    private static final int FACET_RANGE_END_YEAR = 2040;

    @Autowired
    SolrCommunicator communicator;

    private SolrSearchResult<CollectionInfo> fetchAllCollections() {
        log.info("Fetching all collections");

        String queryString = "type:" + TYPE_COLLECTION.getSolrDocumentType();

        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        log.info("Fetching root collections");

        String noParentQuery = "-parentId:[* TO *]";
        String sortQuery = FIELD_NAME + " asc";

        String queryString = toEncoded(noParentQuery)
                + "&sort=" + toEncoded(sortQuery);

        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        log.info("Fetching collections by id: " + targetId);

        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        int rowsLimit = 100;

        String collectionIdQuery = FIELD_ID + ":" + targetId;
        String sortQuery = FIELD_NAME + " asc";     //TODO: think about sorting for only one result, do we need it?

        String queryString = toEncoded(collectionIdQuery)
                + "&sort=" + toEncoded(sortQuery);

        return sendRequest(queryString, CollectionInfo.class, rowsLimit, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(Collection<String> parentCollectionIds,
                                                                  CollectionDocumentType documentType,
                                                                  long rowsLimit,
                                                                  long startFrom) {
        log.info("Fetching child collections by parent ids: " + parentCollectionIds + ", documentType: " + documentType);

        String fieldToSort = documentType == TYPE_TARGET
                ? FIELD_TITLE
                : FIELD_NAME;

        String sortQuery = fieldToSort + " asc";
        String typeSearchQueryString = "type:" + documentType.getSolrDocumentType();
        String parentIdsQueryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));


        String queryString = toEncoded(parentIdsQueryString)
                + "&fq=" + toEncoded(typeSearchQueryString)
                + "&sort=" + toEncoded(sortQuery);

        return sendRequest(queryString, CollectionInfo.class, rowsLimit, startFrom);
    }

    public SolrSearchResult<ContentInfo> searchUrlInContent(String urlToSearch) {
        log.info("Searching site for url '" + urlToSearch);

        String protocolPart = "(https?\\:\\/\\/)?";
        String wwwPart = "(www\\.)?";
        String urlWithReplacedSlashes = urlToSearch.replace("/", "\\/");
        String endSlashPart = "\\/?";

        String urlToSearchRegex = protocolPart + wwwPart + urlWithReplacedSlashes + endSlashPart;
        String urlToSearchQuery = FIELD_URL + ":/" + urlToSearchRegex + "/";

        String queryString = toEncoded(urlToSearchQuery) +
                        "&fl=" + FIELD_ID + "," + FIELD_TITLE + "," + FIELD_CRAWL_DATE + "," + FIELD_URL + ","
                        + FIELD_WAYBACK_DATE + "," + FIELD_DOMAIN + "," + FIELD_ACCESS_TERMS;

        String[] facets = {};
        return sendRequest(queryString, ContentInfo.class, 10, 0, facets);
    }

    public SolrSearchResult<ContentInfo> searchContent(SearchByEnum searchLocation,
                                                       String textToSearch,
                                                       long rowsLimit,
                                                       SortByEnum sortBy,
                                                       AccessToEnum accessTo,
                                                       long startFrom,
                                                       List<String> contentTypes,
                                                       List<String> publicSuffixes,
                                                       List<String> originalDomains,
                                                       Date fromDatePicked,
                                                       Date toDatePicked,
                                                       List<String> rangeDates,
                                                       List<String> collections) {
        log.info("Searching content for '" + textToSearch + "' by " + searchLocation);

        int quotesCount = StringUtils.countMatches(textToSearch, "\"");
        if(quotesCount % 2 != 0){
            //Since Solr can't recognize request with only one quote, we should add another one to close it
            textToSearch += "\"";
        }

        String searchQuery = ClientUtils.escapeQueryChars(textToSearch);
        String sortByQuery = sortBy == null ? "" : FIELD_CRAWL_DATE + " " + sortBy.getSolrOrderValue();
        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);
        String accessToQuery = generateAccessToQuery(accessTo);
        String contentTypeQuery = generateMultipleConditionsQuery(contentTypes, FIELD_TYPE);
        String collectionsQuery = generateMultipleConditionsQuery(collections, FIELD_COLLECTION);
        String publicSuffixesQuery = generateMultipleConditionsQueryWithPreCondition(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        String domainsQuery = generateMultipleConditionsQueryWithPreCondition(originalDomains, FIELD_DOMAIN);

        //After escaping and encoding quotes with double slash SOLR doesn't recognize request to find exact match,
        //so we should remove \\" (encoded double slash) and leave just quote "
        String encodedSearchQueryWithQuotes = toEncoded(searchQuery.replaceAll("\\\\\"", "\""));
        String queryString = "q=" + encodedSearchQueryWithQuotes +
                "&sort=" + toEncoded(sortByQuery) +
                "&fq=" + toEncoded(accessToQuery) +
                "&fq=" + toEncoded(dateQuery) +
                "&fq=" + toEncoded(contentTypeQuery) +
                "&fq=" + toEncoded(publicSuffixesQuery) +
                "&fq=" + toEncoded(domainsQuery) +
                "&fq=" + toEncoded(collectionsQuery) +
                "&df=text" +
                "&facet.range.gap=%2B1YEAR" +
                "&facet.range=" + toEncoded(EXCLUDE_POINT_SECOND_LAYER_TAG) + FIELD_CRAWL_DATE +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.start=" + FACET_RANGE_START_YEAR + DATE_PART_AFTER_YEAR +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.end=" + FACET_RANGE_END_YEAR + DATE_PART_AFTER_YEAR +
                "&hl=true" + //from: http://stackoverflow.com/questions/3452665/how-do-i-return-only-a-truncated-portion-of-a-field-in-solr
                "&hl.fl=content" +
                "&f.content.hl.alternateField=content" +
                "&hl.maxAlternateFieldLength=300" +
                "&fl=" + FIELD_ID + "," + FIELD_TITLE + "," + FIELD_CRAWL_DATE + "," + FIELD_URL + ","
                + FIELD_WAYBACK_DATE + "," + FIELD_DOMAIN + "," + FIELD_ACCESS_TERMS;

        String[] facets = {FIELD_PUBLIC_SUFFIX, FIELD_TYPE, FIELD_HOST, FIELD_DOMAIN, FIELD_COLLECTION, "content_type_norm", FIELD_ACCESS_TERMS};
        return sendRequest(queryString, ContentInfo.class, rowsLimit, startFrom, facets);
    }

    private <T extends BodyDocsType> SolrSearchResult<T> sendRequest(String queryString,
                                                                     Class<T> bodyDocsType,
                                                                     long rowsLimit,
                                                                     long startFrom,
                                                                     String... facetFields) {
        String fieldsFacetQuery = "&facet=on";
        for (String facetField : facetFields) {
            if(facetField.equals(FIELD_ACCESS_TERMS)){
                fieldsFacetQuery += "&facet.field=" + toEncoded(EXCLUDE_POINT_FIRST_LAYER_TAG) + facetField;
            } else {
                fieldsFacetQuery += "&facet.field=" + toEncoded(EXCLUDE_POINT_SECOND_LAYER_TAG) + facetField;
            }
        }


        String solrSearchUrl = format("indent=%s&%s&rows=%d&start=%d&wt=%s%s",
                INDENT_FLAG, queryString, rowsLimit, startFrom, RESULT_FORMAT, fieldsFacetQuery);

        return communicator.sendRequest(solrSearchUrl, bodyDocsType);
    }
}
