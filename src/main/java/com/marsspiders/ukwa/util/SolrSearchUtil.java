package com.marsspiders.ukwa.util;

import com.marsspiders.ukwa.solr.AccessToEnum;
import com.marsspiders.ukwa.solr.SolrSearchService;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import static com.marsspiders.ukwa.solr.AccessToEnum.VIEWABLE_ANYWHERE;
import static com.marsspiders.ukwa.solr.SolrSearchService.AND_JOINER;
import static com.marsspiders.ukwa.solr.SolrSearchService.EXCLUDE_MARKER_SECOND_LAYER_TAG;
import static com.marsspiders.ukwa.solr.SolrSearchService.EXCLUDE_MARKER_FIRST_LAYER_TAG;
import static com.marsspiders.ukwa.solr.SolrSearchService.FIELD_ACCESS_TERMS;
import static com.marsspiders.ukwa.solr.SolrSearchService.OR_JOINER;

public class SolrSearchUtil {
    private static final Logger log = LoggerFactory.getLogger(SolrSearchUtil.class);
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    public static final String DATE_PART_AFTER_YEAR = "-01-01T00:00:00Z";

    public static String generateDateQuery(Date fromDatePicked, Date toDatePicked, List<String> rangeDates) {
        String fromDateText = fromDatePicked != null ? sdf.format(fromDatePicked) : "*";
        String toDateText = toDatePicked != null ? sdf.format(toDatePicked) : "*";
        if(fromDatePicked != null || toDatePicked != null){
            return SolrSearchService.FIELD_CRAWL_DATE + ":[" + fromDateText + " TO " + toDateText + "]";
        }

        String dateQuery = "";
        for (String originalRangeDate : rangeDates) {
            dateQuery += dateQuery.length() > 0 ? OR_JOINER : EXCLUDE_MARKER_SECOND_LAYER_TAG;

            int yearWhenArchived = Integer.parseInt(originalRangeDate);
            String fromDate = yearWhenArchived + DATE_PART_AFTER_YEAR;
            String toDate = (yearWhenArchived + 1) + DATE_PART_AFTER_YEAR;

            dateQuery += SolrSearchService.FIELD_CRAWL_DATE + ":[" + fromDate + " TO " + toDate + "]";
        }

        return dateQuery;
    }

    public static String generateAccessToQuery(AccessToEnum accessTo) {
        if(accessTo == null){
            accessTo = VIEWABLE_ANYWHERE;
        }

        String[] accessToFilters = accessTo.getSolrRequestAccessRestriction().split(",");

        String notEmptyFacetQuery = FIELD_ACCESS_TERMS + ":['' TO *]";
        String multipleConditionQuery = toMultipleConditionsQueryWithPreCondition(Arrays.asList(accessToFilters), FIELD_ACCESS_TERMS);

        return EXCLUDE_MARKER_FIRST_LAYER_TAG + notEmptyFacetQuery + multipleConditionQuery;
    }

    public static String generateMultipleConditionsQuery(List<String> conditions, String fieldName) {
        String multipleConditionQueryWithExclude = "";

        if(conditions.size() > 0){
            String multipleConditionsQuery = toMultipleConditionsQuery(conditions, fieldName);
            multipleConditionQueryWithExclude = EXCLUDE_MARKER_SECOND_LAYER_TAG + multipleConditionsQuery;
        }

        return multipleConditionQueryWithExclude;
    }

    public static String generateMultipleAndConditionsQuery(List<String> conditions, String fieldName) {
        String multipleConditionQueryWithExclude = "";

        if(conditions.size() > 0){
            String multipleConditionsQuery = toMultipleAndConditionsQuery(conditions, fieldName);
            multipleConditionQueryWithExclude = EXCLUDE_MARKER_SECOND_LAYER_TAG + multipleConditionsQuery;
        }

        return multipleConditionQueryWithExclude;
    }

    public static String generateMultipleConditionsQueryWithPreCondition(List<String> publicSuffixes, String fieldName) {
        String notEmptyFacetQuery = fieldName + ":['' TO *]";
        String multipleConditionQuery = toMultipleConditionsQueryWithPreCondition(publicSuffixes, fieldName);

        return EXCLUDE_MARKER_SECOND_LAYER_TAG + notEmptyFacetQuery + multipleConditionQuery;
    }

    private static String toMultipleConditionsQuery(List<String> values, String fieldName) {
        StringBuilder sb = new StringBuilder();

        for (String valueToInclude : values) {
            if(sb.length() == 0){
                sb.append("(");
            } else {
                sb.append(OR_JOINER);
            }
            sb.append(fieldName).append(":").append("\"").append(valueToInclude).append("\"");
        }

        if(sb.length() != 0){
            sb.append(")");
        }

        return sb.toString();
    }

    private static String toMultipleAndConditionsQuery(List<String> values, String fieldName) {
        StringBuilder sb = new StringBuilder();

        for (String valueToInclude : values) {
            if(sb.length() == 0){
                sb.append("(");
            } else {
                sb.append(AND_JOINER);
            }
            sb.append(fieldName).append(":").append("\"").append(valueToInclude).append("\"");
        }

        if(sb.length() != 0){
            sb.append(")");
        }

        return sb.toString();
    }

    private static String toMultipleConditionsQueryWithPreCondition(List<String> values, String fieldName) {
        StringBuilder sb = new StringBuilder();

        for (String valueToInclude : values) {
            if(sb.length() == 0){
                sb.append("(");
            } else {
                sb.append(OR_JOINER);
            }
            sb.append(fieldName).append(":").append(valueToInclude);
        }

        if(sb.length() != 0){
            sb.append(")");
            sb.insert(0, AND_JOINER);
        }

        return sb.toString();
    }

    /**
     * This function generates primary Advanced Search Query.
     * Results of this query will be used for filtering (fq) and faceting.
     **/
    public static String toPrimaryAdvancedSearchQuery(String FIELD_TEXT, String searchText, String proximityPhrase1, String proximityPhrase2, String proximityDistance, String excludedWords) {
        StringBuilder sb = new StringBuilder();
        //Search Text
        if (searchText!=null && !searchText.isEmpty())
        {
            sb.append("{!q.op=" + AND_JOINER + " df=" + FIELD_TEXT + "}").append(QueryParser.escape(searchText));
        }
        //Add Proximity
        if (    proximityPhrase1 != null && !proximityPhrase1.isEmpty() &&      // CHECK IF PROXIMITY PHRASE 1 EXISTS
                proximityPhrase2 != null && !proximityPhrase2.isEmpty() &&     // CHECK IF PROXIMITY PHRASE 2 EXISTS
                proximityDistance != null && !proximityDistance.isEmpty() )   // CHECK IF PROXIMITY DISTANCE EXISTS
        {
            sb.append("\"" + proximityPhrase1 + " " + proximityPhrase2 + "\"" + "~" + proximityDistance);
        }
        //Add Words to Exclude
        if (excludedWords!=null && !excludedWords.isEmpty())
        {
            List<String> excludedWordsList = Arrays.asList(excludedWords.split("[,\\s]+"));
            for (String valueToInclude : excludedWordsList) {
                sb.append(" ").append("-").append(valueToInclude);
            }
        }

        log.debug("sb advancedQueryString.toString() = " + sb.toString());

        return sb.toString();
    }


}
