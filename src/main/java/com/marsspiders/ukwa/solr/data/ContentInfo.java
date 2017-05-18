package com.marsspiders.ukwa.solr.data;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ContentInfo implements BodyDocsType {
    @JsonProperty("id")
    private String id;
    @JsonProperty("source_file")
    private String source_file;
    @JsonProperty("source_file_offset")
    private String source_file_offset;
    @JsonProperty("url")
    private String url;
    @JsonProperty("url_type")
    private List<String> url_type;
    @JsonProperty("record_type")
    private String record_type;
    @JsonProperty("host")
    private String host;
    @JsonProperty("domain")
    private String domain;
    @JsonProperty("public_suffix")
    private String public_suffix;
    @JsonProperty("server")
    private List<String> server;
    @JsonProperty("content_type_served")
    private String content_type_served;
    @JsonProperty("content_length")
    private String content_length;
    @JsonProperty("hash")
    private List<String> hash;
    @JsonProperty("crawl_date")
    private String crawl_date;
    @JsonProperty("crawl_year")
    private String crawl_year;
    @JsonProperty("wayback_date")
    private String wayback_date;
    @JsonProperty("content")
    private List<String> content;
    @JsonProperty("content_text_length")
    private String content_text_length;
    @JsonProperty("content_type")
    private List<String> content_type;
    @JsonProperty("title")
    private String title;
    @JsonProperty("content_encoding")
    private String content_encoding;
    @JsonProperty("content_ffb")
    private String content_ffb;
    @JsonProperty("content_type_droid")
    private String content_type_droid;
    @JsonProperty("links_domains")
    private List<String> links_domains;
    @JsonProperty("links_public_suffixes")
    private List<String> links_public_suffixes;
    @JsonProperty("elements_used")
    private List<String> elements_used;
    @JsonProperty("content_type_tika")
    private String content_type_tika;
    @JsonProperty("content_type_version")
    private String content_type_version;
    @JsonProperty("content_type_full")
    private String content_type_full;
    @JsonProperty("content_type_norm")
    private String content_type_norm;
    @JsonProperty("content_language")
    private String content_language;
    @JsonProperty("ssdeep_hash_bs_96")
    private String ssdeep_hash_bs_96;
    @JsonProperty("ssdeep_hash_bs_192")
    private String ssdeep_hash_bs_192;
    @JsonProperty("ssdeep_hash_ngram_bs_96")
    private String ssdeep_hash_ngram_bs_96;
    @JsonProperty("ssdeep_hash_ngram_bs_192")
    private String ssdeep_hash_ngram_bs_192;
    @JsonProperty("_version_")
    private String _version_;
    @JsonProperty("access_terms")
    private List<String> access_terms;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSource_file() {
        return source_file;
    }

    public void setSource_file(String source_file) {
        this.source_file = source_file;
    }

    public String getSource_file_offset() {
        return source_file_offset;
    }

    public void setSource_file_offset(String source_file_offset) {
        this.source_file_offset = source_file_offset;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<String> getUrl_type() {
        return url_type;
    }

    public void setUrl_type(List<String> url_type) {
        this.url_type = url_type;
    }

    public String getRecord_type() {
        return record_type;
    }

    public void setRecord_type(String record_type) {
        this.record_type = record_type;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getDomain() {
        return domain;
    }

    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getPublic_suffix() {
        return public_suffix;
    }

    public void setPublic_suffix(String public_suffix) {
        this.public_suffix = public_suffix;
    }

    public List<String> getServer() {
        return server;
    }

    public void setServer(List<String> server) {
        this.server = server;
    }

    public String getContent_type_served() {
        return content_type_served;
    }

    public void setContent_type_served(String content_type_served) {
        this.content_type_served = content_type_served;
    }

    public String getContent_length() {
        return content_length;
    }

    public void setContent_length(String content_length) {
        this.content_length = content_length;
    }

    public List<String> getHash() {
        return hash;
    }

    public void setHash(List<String> hash) {
        this.hash = hash;
    }

    public String getCrawl_date() {
        return crawl_date;
    }

    public void setCrawl_date(String crawl_date) {
        this.crawl_date = crawl_date;
    }

    public String getCrawl_year() {
        return crawl_year;
    }

    public void setCrawl_year(String crawl_year) {
        this.crawl_year = crawl_year;
    }

    public String getWayback_date() {
        return wayback_date;
    }

    public void setWayback_date(String wayback_date) {
        this.wayback_date = wayback_date;
    }

    public List<String> getContent() {
        return content;
    }

    public void setContent(List<String> content) {
        this.content = content;
    }

    public String getContent_text_length() {
        return content_text_length;
    }

    public void setContent_text_length(String content_text_length) {
        this.content_text_length = content_text_length;
    }

    public List<String> getContent_type() {
        return content_type;
    }

    public void setContent_type(List<String> content_type) {
        this.content_type = content_type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent_encoding() {
        return content_encoding;
    }

    public void setContent_encoding(String content_encoding) {
        this.content_encoding = content_encoding;
    }

    public String getContent_ffb() {
        return content_ffb;
    }

    public void setContent_ffb(String content_ffb) {
        this.content_ffb = content_ffb;
    }

    public String getContent_type_droid() {
        return content_type_droid;
    }

    public void setContent_type_droid(String content_type_droid) {
        this.content_type_droid = content_type_droid;
    }

    public List<String> getLinks_domains() {
        return links_domains;
    }

    public void setLinks_domains(List<String> links_domains) {
        this.links_domains = links_domains;
    }

    public List<String> getLinks_public_suffixes() {
        return links_public_suffixes;
    }

    public void setLinks_public_suffixes(List<String> links_public_suffixes) {
        this.links_public_suffixes = links_public_suffixes;
    }

    public List<String> getElements_used() {
        return elements_used;
    }

    public void setElements_used(List<String> elements_used) {
        this.elements_used = elements_used;
    }

    public String getContent_type_tika() {
        return content_type_tika;
    }

    public void setContent_type_tika(String content_type_tika) {
        this.content_type_tika = content_type_tika;
    }

    public String getContent_type_version() {
        return content_type_version;
    }

    public void setContent_type_version(String content_type_version) {
        this.content_type_version = content_type_version;
    }

    public String getContent_type_full() {
        return content_type_full;
    }

    public void setContent_type_full(String content_type_full) {
        this.content_type_full = content_type_full;
    }

    public String getContent_type_norm() {
        return content_type_norm;
    }

    public void setContent_type_norm(String content_type_norm) {
        this.content_type_norm = content_type_norm;
    }

    public String getContent_language() {
        return content_language;
    }

    public void setContent_language(String content_language) {
        this.content_language = content_language;
    }

    public String getSsdeep_hash_bs_96() {
        return ssdeep_hash_bs_96;
    }

    public void setSsdeep_hash_bs_96(String ssdeep_hash_bs_96) {
        this.ssdeep_hash_bs_96 = ssdeep_hash_bs_96;
    }

    public String getSsdeep_hash_bs_192() {
        return ssdeep_hash_bs_192;
    }

    public void setSsdeep_hash_bs_192(String ssdeep_hash_bs_192) {
        this.ssdeep_hash_bs_192 = ssdeep_hash_bs_192;
    }

    public String getSsdeep_hash_ngram_bs_96() {
        return ssdeep_hash_ngram_bs_96;
    }

    public void setSsdeep_hash_ngram_bs_96(String ssdeep_hash_ngram_bs_96) {
        this.ssdeep_hash_ngram_bs_96 = ssdeep_hash_ngram_bs_96;
    }

    public String getSsdeep_hash_ngram_bs_192() {
        return ssdeep_hash_ngram_bs_192;
    }

    public void setSsdeep_hash_ngram_bs_192(String ssdeep_hash_ngram_bs_192) {
        this.ssdeep_hash_ngram_bs_192 = ssdeep_hash_ngram_bs_192;
    }

    public String get_version_() {
        return _version_;
    }

    public void set_version_(String _version_) {
        this._version_ = _version_;
    }

    public List<String> getAccess_terms() {
        return access_terms;
    }

    public void setAccess_terms(List<String> access_terms) {
        this.access_terms = access_terms;
    }

    @Override

    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
    }
}