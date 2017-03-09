package com.marsspiders.ukwa.solr;

import java.util.ArrayList;
import java.util.List;

public enum DocumentTypeEnum {
    HTML,
    PDF,
    WORD,
    EXCEL,
    POWER_POINT,
    TEXT;

    public static DocumentTypeEnum fromString(String text) {
        for (DocumentTypeEnum type : DocumentTypeEnum.values()) {
            if (type.name().equalsIgnoreCase(text)) {
                return type;
            }
        }

        return null;
    }

// Possible content_type values:
//    <lst name="content_type">
//    <int name="application/atom+xml">0</int>
//    <int name="application/dif+xml">0</int>
//    <int name="application/epub+zip">0</int>
//    <int name="application/fits">0</int>
//    <int name="application/font-woff">0</int>
//    <int name="application/gzip">0</int>
//    <int name="application/illustrator">0</int>
//    <int name="application/java-vm">0</int>
//    <int name="application/mp4">0</int>
//    <int name="application/msword">0</int>
//    <int name="application/octet-stream">0</int>
//    <int name="application/onenote">0</int>
//    <int name="application/pdf">0</int>
//    <int name="application/pgp-signature">0</int>
//    <int name="application/pkcs7-signature">0</int>
//    <int name="application/pls+xml">0</int>
//    <int name="application/postscript">0</int>
//    <int name="application/rdf+xml">0</int>
//    <int name="application/rss+xml">0</int>
//    <int name="application/rtf">0</int>
//    <int name="application/smil+xml">0</int>
//    <int name="application/vnd.adobe.indesign-idml-package">0</int>
//    <int name="application/vnd.adobe.xfl">0</int>
//    <int name="application/vnd.apple.numbers">0</int>
//    <int name="application/vnd.apple.pages">0</int>
//    <int name="application/vnd.google-earth.kml+xml">0</int>
//    <int name="application/vnd.iccprofile">0</int>
//    <int name="application/vnd.immervision-ivp">0</int>
//    <int name="application/vnd.ms-cab-compressed">0</int>
//    <int name="application/vnd.ms-excel">0</int>
//    <int name="application/vnd.ms-excel.sheet.macroenabled.12">0</int>
//    <int name="application/vnd.ms-fontobject">0</int>
//    <int name="application/vnd.ms-htmlhelp">0</int>
//    <int name="application/vnd.ms-outlook">0</int>
//    <int name="application/vnd.ms-powerpoint">0</int>
//    <int name="application/vnd.ms-powerpoint.presentation.macroenabled.12">0</int>
//    <int name="application/vnd.ms-tnef">0</int>
//    <int name="application/vnd.ms-word.document.macroenabled.12">0</int>
//    <int name="application/vnd.ms-xpsdocument">0</int>
//    <int name="application/vnd.oasis.opendocument.graphics">0</int>
//    <int name="application/vnd.oasis.opendocument.presentation">0</int>
//    <int name="application/vnd.oasis.opendocument.spreadsheet">0</int>
//    <int name="application/vnd.oasis.opendocument.text">0</int>
//    <int name="application/vnd.openxmlformats-officedocument">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.presentationml.presentation">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.presentationml.slideshow">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.presentationml.template">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.spreadsheetml.template">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.wordprocessingml.document">0</int>
//    <int name="application/vnd.openxmlformats-officedocument.wordprocessingml.template">0</int>
//    <int name="application/vnd.rn-realmedia">0</int>
//    <int name="application/vnd.symbian.install">0</int>
//    <int name="application/vnd.visio">0</int>
//    <int name="application/x-123">0</int>
//    <int name="application/x-7z-compressed">0</int>
//    <int name="application/x-acorn_draw">0</int>
//    <int name="application/x-adobe-indesign">0</int>
//    <int name="application/x-archive">0</int>
//    <int name="application/x-bittorrent">0</int>
//    <int name="application/x-bplist">0</int>
//    <int name="application/x-bzip2">0</int>
//    <int name="application/x-cdf">0</int>
//    <int name="application/x-compress">0</int>
//    <int name="application/x-director">0</int>
//    <int name="application/x-dosexec">0</int>
//    <int name="application/x-elc">0</int>
//    <int name="application/x-empty">0</int>
//    <int name="application/x-executable">0</int>
//    <int name="application/x-filemaker">0</int>
//    <int name="application/x-font-otf">0</int>
//    <int name="application/x-font-ttf">0</int>
//    <int name="application/x-font-type1">0</int>
//    <int name="application/x-java-pack200">0</int>
//    <int name="application/x-lha">0</int>
//    <int name="application/x-lharc">0</int>
//    <int name="application/x-matlab-data">0</int>
//    <int name="application/x-matroska">0</int>
//    <int name="application/x-mobipocket-mobibook">0</int>
//    <int name="application/x-ms-installer">0</int>
//    <int name="application/x-ms-reader">0</int>
//    <int name="application/x-msdownload">0</int>
//    <int name="application/x-msmetafile">0</int>
//    <int name="application/x-mspublisher">0</int>
//    <int name="application/x-mysql-misam-index">0</int>
//    <int name="application/x-netcdf">0</int>
//    <int name="application/x-object">0</int>
//    <int name="application/x-puid-fmt-217">0</int>
//    <int name="application/x-puid-fmt-325">0</int>
//    <int name="application/x-puid-fmt-336">0</int>
//    <int name="application/x-puid-fmt-386">0</int>
//    <int name="application/x-puid-fmt-394">0</int>
//    <int name="application/x-puid-fmt-503">0</int>
//    <int name="application/x-puid-fmt-600">0</int>
//    <int name="application/x-puid-fmt-666">0</int>
//    <int name="application/x-puid-fmt-670">0</int>
//    <int name="application/x-puid-fmt-696">0</int>
//    <int name="application/x-puid-x-fmt-376">0</int>
//    <int name="application/x-puid-x-fmt-428">0</int>
//    <int name="application/x-rar-compressed">0</int>
//    </lst>

    static List<String> toContentTypes(List<DocumentTypeEnum> documentTypes) {
        List<String> contentTypesToSearch = new ArrayList<>();
        for (DocumentTypeEnum documentType : documentTypes) {

            switch (documentType) {
                case HTML:
                    contentTypesToSearch.add("application/xhtml+xml");
                    contentTypesToSearch.add("text/html");
                case WORD:
                    contentTypesToSearch.add("application/rtf");
                    contentTypesToSearch.add("application/msword");
                    contentTypesToSearch.add("application/vnd.ms-word.document.macroenabled.12");
                    contentTypesToSearch.add("pplication/vnd.oasis.opendocument.text");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.wordprocessingml.template");
                case TEXT:
                    contentTypesToSearch.add("text/plain");
                    contentTypesToSearch.add("application/vnd.oasis.opendocument.text");
                case PDF:
                    contentTypesToSearch.add("application/pdf");
                case EXCEL:
                    contentTypesToSearch.add("application/vnd.ms-excel");
                    contentTypesToSearch.add("application/vnd.ms-excel.sheet.macroenabled.12");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.spreadsheetml.template");
                    contentTypesToSearch.add("application/vnd.oasis.opendocument.spreadsheet");
                case POWER_POINT:
                    contentTypesToSearch.add("application/vnd.ms-powerpoint");
                    contentTypesToSearch.add("application/vnd.ms-powerpoint.presentation.macroenabled.12");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.presentationml.presentation");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.presentationml.slideshow");
                    contentTypesToSearch.add("application/vnd.openxmlformats-officedocument.presentationml.template");
                    contentTypesToSearch.add("application/vnd.oasis.opendocument.presentation");
                default:
                    //contentType = "UNDEFINED";
            }
        }
        return contentTypesToSearch;
    }
}
