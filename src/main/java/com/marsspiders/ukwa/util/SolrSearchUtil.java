package com.marsspiders.ukwa.util;

import com.marsspiders.ukwa.solr.AccessToEnum;
import com.marsspiders.ukwa.solr.SolrSearchService;

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
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

    public static final String DATE_PART_AFTER_YEAR = "-01-01T00:00:00Z";

    public static String generateDateQuery(Date fromDatePicked, Date toDatePicked, List<String> rangeDates) {
        String fromDateText = fromDatePicked != null ? sdf.format(fromDatePicked) : "*";
        String toDateText = toDatePicked != null ? sdf.format(toDatePicked) : "*";

        System.out.println("......generateDateQuery - before fromDatePicked != null" );
        if(fromDatePicked != null || toDatePicked != null){
            System.out.println("......generateDateQuery - return : " + SolrSearchService.FIELD_CRAWL_DATE + ":[" + fromDateText + " TO " + toDateText + "]" );
            return SolrSearchService.FIELD_CRAWL_DATE + ":[" + fromDateText + " TO " + toDateText + "]";
        }

        System.out.println("......generateDateQuery - before dateQuery" );

        String dateQuery = "";
        if (rangeDates != null)
            for (String originalRangeDate : rangeDates) {
                System.out.println("......generateDateQuery - originalRangeDate = " + originalRangeDate );

                dateQuery += dateQuery.length() > 0 ? OR_JOINER : EXCLUDE_MARKER_SECOND_LAYER_TAG;

                int yearWhenArchived = Integer.parseInt(originalRangeDate);
                String fromDate = yearWhenArchived + DATE_PART_AFTER_YEAR;
                String toDate = (yearWhenArchived + 1) + DATE_PART_AFTER_YEAR;

                dateQuery += SolrSearchService.FIELD_CRAWL_DATE + ":[" + fromDate + " TO " + toDate + "]";
            }
        System.out.println("......generateDateQuery - dateQuery = " + dateQuery );


        return dateQuery;
    }

    public static String generateAccessToQuery(AccessToEnum accessTo) {
        if(accessTo == null){
            accessTo = VIEWABLE_ANYWHERE;
        }

        String[] accessToFilters = accessTo.getSolrRequestAccessRestriction().split(",");

        // If we're not filtering by one value, given there's only two possible
        // values, do no filtering at all:
        if (accessToFilters.length > 1) {
            return "";
        }

        String multipleConditionQuery = toMultipleConditionsQuery(
                Arrays.asList(accessToFilters), FIELD_ACCESS_TERMS);

        return EXCLUDE_MARKER_FIRST_LAYER_TAG + multipleConditionQuery;
    }

    public static String generateMultipleConditionsQuery(List<String> conditions, String fieldName) {
        String multipleConditionQueryWithExclude = "";

        if(conditions != null && conditions.size() > 0){
            String multipleConditionsQuery = toMultipleConditionsQuery(conditions, fieldName);
            multipleConditionQueryWithExclude = multipleConditionsQuery;
        }


        System.out.println("-----rrr222---- generateMultipleConditionsQuery = " + multipleConditionQueryWithExclude);

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
}
