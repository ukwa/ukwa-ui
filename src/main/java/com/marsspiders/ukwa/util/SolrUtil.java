package com.marsspiders.ukwa.util;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.EncoderException;
import org.apache.commons.codec.net.URLCodec;

import java.util.List;

import static com.marsspiders.ukwa.solr.SolrSearchService.AND_JOINER;
import static com.marsspiders.ukwa.solr.SolrSearchService.OR_JOINER;

public class SolrUtil {
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

    public static String toMultipleConditionsQuery(List<String> values, String fieldName) {
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

    public static String toEncoded(String searchQuery) {
        URLCodec codec = new URLCodec();
        try {
            searchQuery = codec.encode(searchQuery);
        } catch (EncoderException e) {
            e.printStackTrace();
        }

        return searchQuery;
    }

    public static String toDecoded(String searchQuery) {
        URLCodec codec = new URLCodec();
        try {
            searchQuery = codec.decode(searchQuery);
        } catch (DecoderException e) {
            e.printStackTrace();
        }

        return searchQuery;
    }

}
