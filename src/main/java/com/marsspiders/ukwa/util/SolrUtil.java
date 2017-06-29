package com.marsspiders.ukwa.util;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

import static com.marsspiders.ukwa.solr.SolrSearchService.AND_JOINER;
import static com.marsspiders.ukwa.solr.SolrSearchService.OR_JOINER;
import static java.lang.String.format;

public class SolrUtil {
    private static final Logger log = LoggerFactory.getLogger(SolrUtil.class);

    /**
     * Copy logic from {@link org.apache.solr.client.solrj.util.ClientUtils#escapeQueryChars(String) escapeQueryChars}
     * But replacing of whitespace was removed
     */
    public static String escapeQueryChars(String stringToEscape) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < stringToEscape.length(); i++) {
            char c = stringToEscape.charAt(i);
            // These characters are part of the query syntax and must be escaped
            if (c == '\\' || c == '+' || c == '-' || c == '!'  || c == '(' || c == ')' || c == ':'
                    || c == '^' || c == '[' || c == ']' || c == '\"' || c == '{' || c == '}' || c == '~'
                    || c == '*' || c == '?' || c == '|' || c == '&'  || c == ';' || c == '/') {
                sb.append('\\');
            }
            sb.append(c);
        }
        return sb.toString();
    }

    public static String toMultipleConditionsQueryWithPreCondition(List<String> values, String fieldName) {
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


    public static String toMultipleConditionsQuery(List<String> values, String fieldName) {
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

    public static String toEncoded(String searchQuery) {
        URLCodec codec = new URLCodec();
        try {
            searchQuery = codec.encode(searchQuery);
        } catch (EncoderException e) {
            log.error(format("Failed to encode search query string '%s'", searchQuery), e);
        }

        return searchQuery;
    }

    public static String toDecoded(String searchQuery) {
        URLCodec codec = new URLCodec();
        try {
            searchQuery = codec.decode(searchQuery);
        } catch (DecoderException e) {
            log.error(format("Failed to decode search query string '%s'", searchQuery), e);
        }

        return searchQuery;
    }

}
