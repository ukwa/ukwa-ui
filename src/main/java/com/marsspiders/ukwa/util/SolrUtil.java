package com.marsspiders.ukwa.util;

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
}
