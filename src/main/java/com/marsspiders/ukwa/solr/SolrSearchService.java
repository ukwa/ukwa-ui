package com.marsspiders.ukwa.solr;

import com.marsspiders.ukwa.solr.data.BodyDocsType;
import com.marsspiders.ukwa.solr.data.CollectionInfo;
import com.marsspiders.ukwa.solr.data.ContentInfo;
import com.marsspiders.ukwa.solr.data.SolrSearchResult;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import static com.marsspiders.ukwa.controllers.CollectionController.TYPE_COLLECTION;
import static com.marsspiders.ukwa.solr.AccessToEnum.VIEWABLE_ANYWHERE;
import static com.marsspiders.ukwa.util.SolrUtil.escapeQueryChars;
import static com.marsspiders.ukwa.util.SolrUtil.toEncoded;
import static com.marsspiders.ukwa.util.SolrUtil.toMultipleConditionsQuery;
import static com.marsspiders.ukwa.util.SolrUtil.toMultipleConditionsQueryWithPreCondition;
import static java.lang.String.format;

@Service
public class SolrSearchService {
    private static final Logger log = LoggerFactory.getLogger(SolrSearchService.class);

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    public static final String AND_JOINER = " AND ";
    public static final String OR_JOINER = " OR ";

    private static final int ROOT_COLLECTIONS_ROWS_LIMIT = 1000;
    private static final String INDENT_FLAG = "on";
    private static final String RESULT_FORMAT = "json";

    private static final String FIELD_CONTENT_TYPE_NORM = "content_type_norm";
    private static final String FIELD_PUBLIC_SUFFIX = "public_suffix";
    private static final String FIELD_HOST = "host";
    private static final String FIELD_DOMAIN = "domain";
    private static final String FIELD_CRAWL_DATE = "crawl_date";
    private static final String FIELD_ACCESS_TERMS = "access_terms";
    private static final String FIELD_ID = "id";
    private static final String FIELD_TITLE = "title";
    private static final String FIELD_URL = "url";
    private static final String FIELD_WAYBACK_DATE = "wayback_date";
    private static final String FIELD_COLLECTION = "collection";

    private static final String EXCLUDE_FACET_TAG_NAME = "filter";
    private static final String EXCLUDE_MARKER_TAG = "{!tag=" + EXCLUDE_FACET_TAG_NAME + "}";
    private static final String EXCLUDE_POINT_TAG = "{!ex=" + EXCLUDE_FACET_TAG_NAME + "}";
    private static final String DATE_PART_AFTER_YEAR = "-01-01T00:00:00Z";
    private static final int FACET_RANGE_START_YEAR = 1980;
    private static final int FACET_RANGE_END_YEAR = 2040;

    @Autowired
    SolrCommunicator communicator;

    private SolrSearchResult<CollectionInfo> fetchAllCollections() {
        log.info("Fetching all collections");

        String queryString = "type:" + TYPE_COLLECTION;

        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchRootCollections() {
        log.info("Fetching root collections");

        String queryString = "-parentId:[*%20TO%20*]";
        return sendRequest(queryString, CollectionInfo.class, ROOT_COLLECTIONS_ROWS_LIMIT, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchCollectionById(String targetId) {
        log.info("Fetching collections by id: " + targetId);

        String queryString = FIELD_ID + ":" + targetId;
        //As result should be only one row, but for debug purposes we pass limit 100 to see what actual result are returned
        int rowsLimit = 100;
        return sendRequest(queryString, CollectionInfo.class, rowsLimit, 0);
    }

    public SolrSearchResult<CollectionInfo> fetchChildCollections(Collection<String> parentCollectionIds,
                                                                  String documentType,
                                                                  long rowsLimit,
                                                                  long startFrom) {
        log.info("Fetching child collections by parent ids: " + parentCollectionIds + ", documentType: " + documentType);

        String typeSearchQueryString = "type:" + documentType;
        String parentIdsQueryString = parentCollectionIds.stream()
                .map(id -> "parentId:" + id)
                .collect(Collectors.joining(" OR "));

        URLCodec codec = new URLCodec();
        String encodedParentIdQueryString = null;
        try {
            encodedParentIdQueryString = codec.encode(parentIdsQueryString);
        } catch (EncoderException e) {
            log.error("Failed to encode parentIds query", e);
        }

        String queryString = encodedParentIdQueryString + "&fq=" + typeSearchQueryString;
        return sendRequest(queryString, CollectionInfo.class, rowsLimit, startFrom);
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

        String accessToValue = accessTo == null
                ? VIEWABLE_ANYWHERE.getSolrRequestAccessRestriction()
                : accessTo.getSolrRequestAccessRestriction();
        String accessToQuery = FIELD_ACCESS_TERMS + ":" + accessToValue;
        String searchQuery = searchLocation.getSolrSearchLocation() + ":\"" + escapeQueryChars(textToSearch) + "\"";
        String sortByQuery = sortBy == null ? "" : FIELD_CRAWL_DATE + " " + sortBy.getSolrOrderValue();
        String dateQuery = generateDateQuery(fromDatePicked, toDatePicked, rangeDates);

        String contentTypeNotEmpty = FIELD_CONTENT_TYPE_NORM + ":['' TO *]";
        String contentTypesConditionQuery = toMultipleConditionsQueryWithPreCondition(contentTypes, FIELD_CONTENT_TYPE_NORM);
        String contentTypeQuery = EXCLUDE_MARKER_TAG + contentTypeNotEmpty + contentTypesConditionQuery;

        String publicSuffixesNotEmpty = FIELD_PUBLIC_SUFFIX + ":['' TO *]";
        String publicSuffixesConditionQuery = toMultipleConditionsQueryWithPreCondition(publicSuffixes, FIELD_PUBLIC_SUFFIX);
        String publicSuffixesQuery = EXCLUDE_MARKER_TAG + publicSuffixesNotEmpty + publicSuffixesConditionQuery;

        String domainsNotEmpty = FIELD_DOMAIN + ":['' TO *]";
        String domainsConditionQuery = toMultipleConditionsQueryWithPreCondition(originalDomains, FIELD_DOMAIN);
        String domainsQuery = EXCLUDE_MARKER_TAG + domainsNotEmpty + domainsConditionQuery;

        String collectionsQuery = "";
        if(collections.size() > 0){
            String collectionsConditionQuery = toMultipleConditionsQuery(collections, FIELD_COLLECTION);
            collectionsQuery = EXCLUDE_MARKER_TAG + collectionsConditionQuery;
        }

        String queryString = toEncoded(searchQuery) +
                "&sort=" + toEncoded(sortByQuery) +
                "&fq=" + toEncoded(accessToQuery) +
                "&fq=" + toEncoded(dateQuery) +
                "&fq=" + toEncoded(contentTypeQuery) +
                "&fq=" + toEncoded(publicSuffixesQuery) +
                "&fq=" + toEncoded(domainsQuery) +
                "&fq=" + toEncoded(collectionsQuery) +
                "&facet.range.gap=%2B1YEAR" +
                "&facet.range=" + toEncoded(EXCLUDE_POINT_TAG) + FIELD_CRAWL_DATE +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.start=" + FACET_RANGE_START_YEAR + DATE_PART_AFTER_YEAR +
                "&f." + FIELD_CRAWL_DATE + ".facet.range.end=" + FACET_RANGE_END_YEAR + DATE_PART_AFTER_YEAR +
                "&hl=true" + //from: http://stackoverflow.com/questions/3452665/how-do-i-return-only-a-truncated-portion-of-a-field-in-solr
                "&hl.fl=content" +
                "&f.content.hl.alternateField=content" +
                "&hl.maxAlternateFieldLength=300" +
                "&fl=" + FIELD_ID + "," + FIELD_TITLE + "," + FIELD_CRAWL_DATE + "," + FIELD_URL + ","
                + FIELD_WAYBACK_DATE + "," + FIELD_DOMAIN + "," + FIELD_ACCESS_TERMS;

        String[] facets = {FIELD_PUBLIC_SUFFIX, FIELD_CONTENT_TYPE_NORM, FIELD_HOST, FIELD_DOMAIN, FIELD_COLLECTION};
        return sendRequest(queryString, ContentInfo.class, rowsLimit, startFrom, facets);
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
