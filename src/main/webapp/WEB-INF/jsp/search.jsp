<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="uri" value="${req.requestURI}"/>
<c:set var="url">
    ${req.requestURL}
</c:set>
<c:if test="${setProtocolToHttps}">
    <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<c:set var="locale">
    ${pageContext.response.locale}
</c:set>
<jsp:useBean id="searchResults" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.SearchResultDTO>"/>
<jsp:useBean id="contentTypes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="accessTerms" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="publicSuffixes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="domains" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="collections" scope="request" type="java.util.List<java.lang.String>"/>
<spring:message code="pagination.goto" var="goToPage"/>
<spring:message code="pagination.current" var="currentPage"/>
<html lang="${locale}">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title><spring:message code="search.title" /></title>
    <%@include file="head.jsp" %>
</head>

<body>

<c:set var = "searchPage" value = "true"/>

<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>

    <!-- Modal Search Filter CheckBox Dialog -->
    <div class="modal fade" id="SearchFilterDialog" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header float-right">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="max-height: calc(100vh - 143px);overflow-y: auto;">

                        <div class="d-flex flex-row mt-2">

                            <!-- nav-tabs--vertical: display: flex;	flex-flow: column nowrap;-->
                            <!-- nav-tabs--left (BAD!) flex: 1 0 auto; -->
                            <ul class="nav nav-tabs nav-tabs--vertical nav-tabs--left" role="navigation">
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#domain" role="tab">Domain</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#documenttype" role="tab">Document Type</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#suffix" role="tab">Suffix</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#topicsandthemes" role="tab">Topics and Themes</a>
                                </li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <!-- Domain -->
                                <div class="tab-pane" id="domain" role="tabpanel">
                                    <div class="container-inline-flex column wrap fixed-width-750">

                                        <c:if test="${domains.size() > 1}">
                                            <c:forEach begin="0" end="${domains.size() - 1}" step="2" var="i">

                                                <c:if test="${(domains.get(i + 1) != 0 ) || (originalDomains.contains(domains.get(i))?true:false)}">
                                                    <div class="form-check-cont box2 relative" style="width: 310px;padding: 10px;word-wrap:break-word;text-overflow: ellipsis" title="<c:out value="${domains.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox-modal-domains" name="domain_filter_modal" id="domain_filter_modal_<c:out value="${i}"/>"
                                                               value="${domains.get(i)}"
                                                            ${originalDomains.contains(domains.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue" style="width: 100px; word-wrap:break-word;" for="domain_filter_modal_<c:out value="${i}"/>" title="<c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)">
                                                            <c:out value="${domains.get(i)}"/>
                                                            <span class="label-counts black" style="text-overflow: ellipsis">(<span class="results-count"><c:out value="${domains.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                    </div>
                                </div>

                                <!-- Document Type -->
                                <div class="tab-pane" id="documenttype" role="tabpanel">

                                    <div class="container-inline-flex column wrap fixed-height-500 fixed-width-750">

                                        <c:if test="${contentTypes.size() > 1}">
                                            <c:forEach begin="0" end="${contentTypes.size() - 1}" step="2" var="i">

                                                <c:if test="${(contentTypes.get(i + 1) != 0) || (originalContentTypes.contains(contentTypes.get(i))?true:false)}">

                                                    <div class="form-check-cont box2 relative" style="width: 310px;padding: 10px" title="<c:out value="${contentTypes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox-modal-documenttypes" name="content_type_filter_modal" id="content_type_filter_modal_<c:out value="${i}"/>"
                                                               value="${contentTypes.get(i)}"
                                                            ${originalContentTypes.contains(contentTypes.get(i))? 'checked' : ''}/>
                                                        <label class="main-search-check-label" style="color: #0c49b0" for="content_type_filter_modal_<c:out value="${i}"/>">
                                                            <c:out value="${contentTypes.get(i)}"/>
                                                            <span class="label-counts black no-italics" >(<span class="results-count"><c:out value="${contentTypes.get(i + 1)}"/></span>)</span></label>
                                                    </div>

                                                </c:if>

                                            </c:forEach>
                                        </c:if>

                                    </div>

                                </div>

                                <!-- Suffix -->
                                <div class="tab-pane" id="suffix" role="tabpanel">

                                    <div class="container-inline-flex column wrap fixed-height-500 fixed-width-750">

                                        <c:if test="${publicSuffixes.size() > 1}">

                                            <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
                                                <c:if test="${(publicSuffixes.get(i + 1) != 0) || (originalPublicSuffixes.contains(publicSuffixes.get(i))?true:false)}">

                                                    <div class="form-check-cont box2 relative" style="width: 310px;padding: 10px" title="<c:out value="${publicSuffixes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox-modal-suffixes" name="public_suffix_filter_modal" id="public_suffix_filter_modal_<c:out value="${i}"/>"
                                                               value="${publicSuffixes.get(i)}"
                                                            ${originalPublicSuffixes.contains(publicSuffixes.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue no-italics" for="public_suffix_filter_modal_<c:out value="${i}"/>">
                                                            <c:out value="${publicSuffixes.get(i)}"/>
                                                            <span class="label-counts black no-italics">(<span class="results-count"><c:out value="${publicSuffixes.get(i + 1)}"/></span>)</span></label>
                                                    </div>

                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                    </div>

                                </div>



                                <!-- Topics and Themes -->
                                <div class="tab-pane" id="topicsandthemes" role="tabpanel">
                                    <div class="container-inline-flex column wrap fixed-height-500 fixed-width-750">

                                        <c:if test="${collections.size() > 1}">

                                            <c:forEach begin="0" end="${collections.size() - 1}" step="2" var="i">
                                                <c:if test="${(collections.get(i + 1) != 0) || (originalCollections.contains(collections.get(i))?true:false)}">
                                                    <div class="form-check-cont box2 relative" style="width: 310px;padding: 10px" title="<c:out value="${collections.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox-modal-collections" name="collection_filter_modal" id="collection_filter_modal_<c:out value="${i}"/>"
                                                               value="${collections.get(i)}"
                                                            ${originalCollections.contains(collections.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue no-italics box2" style="overflow: hidden" for="collection_filter_modal_<c:out value="${i}"/>"
                                                               title="<c:out value="${collections.get(i)}"/> (<c:out value="${collections.get(i + 1)}"/>)">
                                                            <c:out value="${collections.get(i)}"/>
                                                            <span class="label-counts black no-italics">(<span class="results-count"><c:out value="${collections.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </c:if>

                                            </c:forEach>
                                        </c:if>

                                    </div>
                                </div>

                            </div>
                        </div>

                </div>
                <div class="modal-footer center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" id="apply-modal-filter">Apply</button>
                </div>
            </div>
        </div>
    </div>



    <section id="content">


        <div class="row margin-0 padding-0">

            <div class="col-lg-3 col-md-4 col-sm-12  padding-0 side-bar-right">
                <aside id="sidebar">
                    <div class="row padding-top-10">
                        <div class="col-md-12 col-sm-12 sidebar-clear-filter-layout" style="padding-left: 50px; padding-right: 50px">

                            <c:set var = "hasFilters" value = "false"/>
                            <c:if test="${searchPage == 'true'}">
                                <p class="searchFilter sidebar-clear-filter-2 clearable x onX" ><spring:message code="search.filters.access" />&nbsp;

                                    <c:if test="${originalAccessView.contains('va') || empty originalAccessView}">
                                        <spring:message code="search.filters.access.open" />
                                    </c:if>

                                    <c:if test="${originalAccessView.contains('vool')}">
                                        <spring:message code="search.filters.access.all" />
                                    </c:if>

                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${fn:length(originalDomains) > 0}">
                                <p class="searchFilter sidebar-clear-filter-3 clearable x onX"><spring:message code="search.filters.domain" />&nbsp;
                                    <c:forEach items="${originalDomains}" var="domain">
                                        &quot;<c:out value="${domain}"/>&quot;&nbsp;
                                    </c:forEach>
                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${fn:length(originalContentTypes) > 0}">
                                <p class="searchFilter sidebar-clear-filter-4 clearable x onX"><spring:message code="search.filters.doctype" />&nbsp;
                                    <c:forEach items="${originalContentTypes}" var="doctype">
                                        &quot;<c:out value="${doctype}"/>&quot;&nbsp;
                                    </c:forEach>
                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${fn:length(originalPublicSuffixes) > 0}">
                                <p class="searchFilter sidebar-clear-filter-5 clearable x onX"><spring:message code="search.filters.suffix" />&nbsp;
                                    <c:forEach items="${originalPublicSuffixes}" var="suffix">
                                        &quot;<c:out value="${suffix}"/>&quot;&nbsp;
                                    </c:forEach>
                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${fn:length(originalFromDateText) > 0 || fn:length(originalToDateText) > 0}">
                                <p class="searchFilter sidebar-clear-filter-6 clearable x onX"><spring:message code="search.filters.date" />&nbsp;

                                    <c:choose>
                                        <c:when test="${fn:length(originalFromDateText) > 0}">
                                            <c:out value="${originalFromDateText}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code="search.filters.date.any" />
                                        </c:otherwise>
                                    </c:choose>

                                    &nbsp;-&nbsp;

                                    <c:choose>
                                        <c:when test="${fn:length(originalToDateText) > 0}">
                                            <c:out value="${originalToDateText}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <spring:message code="search.filters.date.any" />
                                        </c:otherwise>
                                    </c:choose>

                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${fn:length(originalCollections) > 0}">
                                <p class="searchFilter sidebar-clear-filter-7 clearable x onX"><spring:message code="search.filters.collection" />&nbsp;
                                    <c:forEach items="${originalCollections}" var="collection">
                                        &quot;<c:out value="${collection}"/>&quot;&nbsp;
                                    </c:forEach>
                                </p>
                                <c:set var = "hasFilters" value = "true"/>
                            </c:if>

                            <c:if test="${hasFilters == 'true'}">
                                <p class="margin-0 sidebar-clear-filter-button">
                                    <button type="button" id="btn_reset_filters" title="<spring:message code="search.filters.reset" />" class="button-radius-5 searchResetRedesigned margin-top-10 padding-side-70 margin-bottom-20"><spring:message code="search.filters.reset" /></button>
                                </p>
                            </c:if>

                        </div>
                        <hr class="search-sidebar-hr"/>
                    </div>
                    <div class="height-0"><spring:message code="search.filter.notice" /></div>
                    <form action="search" method="get" enctype="multipart/form-data" name="filter_form" id="filter_form">
                        <div class="sidebar-item toggle open vl" id="toggle-sidebar"></div>
                        <div class="sidebar-collapse" role="region">
                            <%--   View facets   --%>
                            <%--   Accessing Content collapse filter   --%>
                            <div class="sidebar-filter-header no-collapse" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.view.title" />" tabindex="0" role="tab">
                                <div class="sidebar-filter-header-title-redesign" id="t_access"><spring:message code="search.side.view.title"/></div>
                                <div class="infotooltip" title="<spring:message code="search.side.view.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.view.tip" />" tabindex="0"></div>
                            </div>
                            <div class="sidebar-filter expanded no-collapse" aria-labelledby="t_access">
                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">

                                    <c:if test="${accessTerms.size() > 1}">
                                        <c:forEach begin="0" end="${accessTerms.size() - 1}" step="2" var="i">
                                            <c:if test="${accessTerms.get(i) == 'OA'}">
                                                <c:set var="vaCount" value="${accessTerms.get(i + 1)}"/>
                                                <c:set var="voolCount" value="${voolCount + accessTerms.get(i + 1)}"/>
                                            </c:if>
                                            <c:if test="${accessTerms.get(i) == 'RRO'}">
                                                <c:set var="voolCount" value="${voolCount + accessTerms.get(i + 1)}"/>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <div class="form-check-cont padding-0" title="<spring:message code="search.side.view.1" />" tabindex="0">
                                        <input tabindex="-1" type="radio" class="blue access_filter" name="view_filter" id="view_filter_1" value="va"
                                        ${originalAccessView.contains('va') || empty originalAccessView ? 'checked' : ''}/>
                                        <label class="main-search-check-label blue block-two-text-lines" for="view_filter_1" title="<spring:message code="search.side.view.1" />">
                                            <spring:message code="search.side.view.1" />
                                            <span class="label-counts black">(<span class="results-count"><c:out value="${vaCount}"/></span>)</span>
                                        </label>
                                    </div>
                                </div>


                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                    <div class="form-check-cont padding-0" title="<spring:message code="search.side.view.2" />" tabindex="0">
                                        <input type="radio" class="blue access_filter" name="view_filter" id="view_filter_2" value="vool"
                                        ${originalAccessView.contains('vool') ? 'checked' : ''}/>
                                        <label class="main-search-check-label blue block-two-text-lines" for="view_filter_2" title="<spring:message code="search.side.view.2" />"> <spring:message code="search.side.view.2" /> <span class="label-counts black">(<span class="results-count"><c:out value="${voolCount}"/></span>)</span></label>
                                    </div>
                                </div>
                            </div>
                            <hr class="search-sidebar-hr"/>
                            <div role="tablist">

                                <%--   Domains collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.domain.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title-redesign" id="t_domain"><spring:message code="search.side.domain.title" /></div>
                                    <div class="infotooltip" title="<spring:message code="search.side.domain.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.domain.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_domain">
                                    <c:if test="${domains.size() > 1}">
                                        <c:forEach begin="0" end="${domains.size() - 1}" step="2" var="i">

                                            <c:if test="${(domains.get(i + 1) != 0 && (i < 5)) || (originalDomains.contains(domains.get(i))?true:false)}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12 " >
                                                    <div class="form-check-cont padding-0" title="<c:out value="${domains.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox" name="domain_filter" id="domain_filter_<c:out value="${i}"/>"
                                                               value="${domains.get(i)}"
                                                            ${originalDomains.contains(domains.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue block-two-text-lines" for="domain_filter_<c:out value="${i}"/>" title="<c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)">
                                                            <c:out value="${domains.get(i)}"/>
                                                            <span class="label-counts black">(<span class="results-count"><c:out value="${domains.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>

                                        </c:forEach>
                                        <div class="openPlusSign" style="margin-left: 10px"><a href="#domain" data-toggle="modal" data-target="#SearchFilterDialog" style="text-decoration:none">Show more</a></div>
                                    </c:if>
                                </div>

                                <hr class="search-sidebar-hr"/>
                                <%--   Document type collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title-redesign" id="t_doctype"><spring:message code="search.side.doctype.title" /></div>
                                    <div class="infotooltip" title="<spring:message code="search.side.doctype.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_doctype">
                                    <c:if test="${contentTypes.size() > 1}">
                                        <c:forEach begin="0" end="${contentTypes.size() - 1}" step="2" var="i">

                                            <c:if test="${(contentTypes.get(i + 1) != 0 && (i < 5)) || (originalContentTypes.contains(contentTypes.get(i))?true:false)}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                    <div class="form-check-cont padding-0" title="<c:out value="${contentTypes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox" name="content_type" id="content_type_<c:out value="${i}"/>"
                                                               value="${contentTypes.get(i)}"
                                                            ${originalContentTypes.contains(contentTypes.get(i))? 'checked' : ''}/>
                                                        <label class="main-search-check-label" style="color: #0c49b0" for="content_type_<c:out value="${i}"/>">
                                                            <c:out value="${contentTypes.get(i)}"/>
                                                            <span class="label-counts black" >(<span class="results-count"><c:out value="${contentTypes.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>

                                        </c:forEach>
                                        <div class="openPlusSign" style="margin-left: 10px"><a href="#documenttype" data-toggle="modal" data-target="#SearchFilterDialog" style="text-decoration:none">Show more</a></div>
                                    </c:if>
                                </div>

                                    <hr class="search-sidebar-hr"/>

                                <%--   Public suffix collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.suffix.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title-redesign" id="t_suffix"><spring:message code="search.side.suffix.title" /></div>
                                    <div class="infotooltip" title="<spring:message code="search.side.suffix.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.suffix.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_suffix">
                                    <c:if test="${publicSuffixes.size() > 1}">

                                        <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
                                            <c:if test="${(publicSuffixes.get(i + 1) != 0 && (i < 5)) || (originalPublicSuffixes.contains(publicSuffixes.get(i))?true:false)}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                    <div class="form-check-cont padding-0" title="<c:out value="${publicSuffixes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox" name="public_suffix" id="public_suffix_<c:out value="${i}"/>"
                                                               value="${publicSuffixes.get(i)}"
                                                            ${originalPublicSuffixes.contains(publicSuffixes.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue block-two-text-lines" for="public_suffix_<c:out value="${i}"/>">
                                                            <c:out value="${publicSuffixes.get(i)}"/>
                                                            <span class="label-counts black">(<span class="results-count"><c:out value="${publicSuffixes.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                        <div class="openPlusSign" style="margin-left: 10px"><a href="#suffix" data-toggle="modal" data-target="#SearchFilterDialog" style="text-decoration:none">Show more</a></div>
                                    </c:if>

                                </div>

                                <hr class="search-sidebar-hr"/>
                                <%--   Archived year collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open archived-date" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.date.title" />" tabindex="0" id="dates_header" role="tab">
                                    <div class="sidebar-filter-header-title-redesign" id="t_date"><spring:message code="search.side.date.title" /></div>
                                    <div class="infotooltip" title="<spring:message code="search.side.date.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.date.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter expanded no-collapse" id="dates_container" role="tabpanel" aria-hidden="true"
                                     aria-labelledby="t_date" style="padding-left: 40px">
                                    <div class="row padding-top-10">
                                        <div class="col-auto">
                                            <label for="from_date" class="blue date-range-label"><spring:message
                                                    code="search.side.date.from"/></label>
                                        </div>
                                    </div>
                                    <div class="row padding-bottom-10">
                                        <div class="col-auto">
                                            <input type="text" class="form-control form-white-placeholder" name="from_date"
                                                   id="from_date" title="<spring:message code="search.side.date.from" />"
                                                   placeholder="YYYY-MM-DD"
                                                   value="${originalFromDateText != null ? originalFromDateText : ''}"/>
                                        </div>
                                    </div>
                                    <div class="row padding-top-10">
                                        <div class="col-auto">
                                            <label for="to_date" class="blue date-range-label"><spring:message
                                                    code="search.side.date.to"/></label>
                                        </div>
                                    </div>
                                    <div class="row padding-bottom-10 ">
                                        <div class="col-auto">
                                            <input type="text" class="form-control form-white-placeholder" name="to_date" id="to_date"
                                                   title="<spring:message code="search.side.date.to" />" placeholder="YYYY-MM-DD"
                                                   value="${originalToDateText != null ? originalToDateText : ''}"/>
                                        </div>
                                    </div>
                                    <div class="row padding-top-20">
                                        <div class="col-sm-12">
                                            <button type="submit" title="<spring:message code="search.side.date.submit" />" class="button button-blue width-auto-inline"><spring:message code="search.side.date.submit" /></button>
                                            <button type="button" title="<spring:message code="search.side.date.reset" />" class="button button-blue width-auto-inline margin-top-10 text-small" id="btn_reset_dates">X</button>
                                        </div>
                                    </div>
                                </div>
                                <hr class="search-sidebar-hr"/>
                                <%--   Collection collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.coll.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title-redesign" id="t_coll"><spring:message code="search.side.coll.title" /></div>
                                    <div class="infotooltip" title="<spring:message code="search.side.coll.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.coll.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_coll">
                                    <c:if test="${collections.size() > 1}">

                                        <c:forEach begin="0" end="${collections.size() - 1}" step="2" var="i">
                                            <c:if test="${(collections.get(i + 1) != 0 && (i < 5)) || (originalCollections.contains(collections.get(i))?true:false)}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                    <div class="form-check-cont padding-0" title="<c:out value="${collections.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="blue sidebar-filter-input-checkbox" name="collection" id="collection_<c:out value="${i}"/>"
                                                               value="${collections.get(i)}"
                                                            ${originalCollections.contains(collections.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label blue block-two-text-lines" for="collection_<c:out value="${i}"/>"
                                                               title="<c:out value="${collections.get(i)}"/> (<c:out value="${collections.get(i + 1)}"/>)">
                                                            <c:out value="${collections.get(i)}"/>
                                                            <span class="label-counts black">(<span class="results-count"><c:out value="${collections.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>

                                        </c:forEach>
                                        <div class="openPlusSign" style="margin-left: 10px"><a href="#topicsandthemes" data-toggle="modal" data-target="#SearchFilterDialog" style="text-decoration:none">Show more</a></div>
                                    </c:if>

                                </div>

                                <hr class="search-sidebar-hr"/>

                                    <input type="hidden" name="modal_filter_domains_vals" id="input_hidden_field_checked_modal_domains_array" value="">
                                    <input type="hidden" name="modal_filter_suffix_vals" id="input_hidden_field_checked_modal_suffix_array">
                                    <input type="hidden" name="modal_filter_documenttypes_vals" id="input_hidden_field_checked_modal_documenttypes_array">
                                    <input type="hidden" name="modal_filter_collections_vals" id="input_hidden_field_checked_modal_collections_array">
                                <input type="hidden" name="search_location" id="search_location" value="${originalSearchLocation}">
                                <input type="hidden" name="text" id="text_hidden" value="${originalSearchRequest}">
                                <input type="hidden" name="view_sort" id="view_sort" value="${empty originalSortValue ? 'nto' : originalSortValue}">
                                <input type="hidden" name="view_count" id="view_count" value="${empty rowsPerPageLimit ? '50' : rowsPerPageLimit}">
                            </div>

                            <div class="border-top-white">&nbsp;</div>

                        </div>
                    </form>
                </aside>
            </div>

            <div class="col-lg-9 col-md-8 col-sm-12 padding-0 padding-left-20">
                <div class="results-header border-bottom-gray">
                    <div class="row margin-0 padding-0">
                        <%@include file="searchpage_searchForm.jsp" %>
                    </div>
                    <div class="row">
                        <div class="col-sm-12" style="padding-left:30px;">
                            <span class="search-results-main-heading bold">Search results: </span><span class="search-results-main-heading"><c:out value="${totalSearchResultsSizeFormatted}"/></span>
                            <span class="search-results-main-heading ">&nbsp;<spring:message code="search.results.num"/>&nbsp;</span><span class="search-results-main-heading">&quot;<c:out value="${originalSearchRequest}" escapeXml="false"/>&quot;</span></div>
                    </div>

                    <c:choose>
                        <c:when test="${deepPaging}">
                            <div class="row margin-top-30">
                                <div class="col-sm-12 padding-top-5">
                                    <span class="bold gray"><spring:message code="search.deep.paging" /></span>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>

                </div>
                <div class="row border-bottom-gray margin-0 left">
                    <div class="col-md-12 padding-20 padding-mobile-side-0">
                        <div class="search-results-top-filters width-200 margin-top-10">
                            <div class="form-check-cont form-margin-check" title="Newest to Oldest" tabindex="0">
                                <input type="radio" name="sort" id="sort_1" value="nto" class="sort"
                                ${originalSortValue.contains('nto') || empty originalSortValue ? 'checked' : ''}/>
                                <label class="main-search-check-label text-small" for="sort_1" title="<spring:message code="search.results.sort.newest" />"><spring:message code="search.results.sort.newest" /></label>
                            </div>
                        </div>
                        <div class="search-results-top-filters width-200 margin-top-10">
                            <div class="form-check-cont form-margin-check" title="Oldest to Newest" tabindex="0">
                                <input type="radio" name="sort" id="sort_2" value="otn" class="sort"
                                ${originalSortValue.contains('otn') ? 'checked' : ''}/>
                                <label class="main-search-check-label text-small" for="sort_2" title="<spring:message code="search.results.sort.oldest" />"><spring:message code="search.results.sort.oldest" /></label>
                            </div>
                        </div>
                        <div class="search-results-top-filters-2 results-items-per-page">
                            <label for="count" title="<spring:message code="search.results.items" />" class="margin-top-10 text-small"><spring:message code="search.results.items" /></label>
                            <select class="form-control search-results-display-count" name="count" id="count" tabindex="0">
                                <option value="50" ${rowsPerPageLimit == 50 ? 'selected' : ''}>50</option>
                                <option value="100" ${rowsPerPageLimit == 100 ? 'selected' : ''}>100</option>
                                <option value="200" ${rowsPerPageLimit == 200 ? 'selected' : ''}>200</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row padding-0 margin-0">
                    <div class="col-md-12 pagination-cont">
                        <%--preserve all current parameters in URL and change only page parameter--%>
                        <c:url var="nextUrl" value="">
                            <c:forEach items="${param}" var="entry">
                                <c:if test="${entry.key != 'page'}">
                                    <c:param name="${entry.key}" value="${entry.value}" />
                                </c:if>
                            </c:forEach>
                            <%--set page value as a placeholder as it is going to be changed for each link--%>
                            <c:param name="page" value="PAGE_NUM_PLACEHOLDER" />
                        </c:url>
                        <c:if test="${targetPageNumber > 1}"> <a style="text-decoration: none" href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-number-redesign arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div>Previous</a></c:if>
                        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                            <c:if test="${i <= totalPages && !deepPaging}">
                                <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>">
                                    <div class="pagination-number-redesign ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                        <c:out value="${i}"/>
                                    </div></a>
                            </c:if>
                        </c:forEach>
                        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit && !deepPaging}"> <a style="text-decoration: none" href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />">Next<div class="pagination-number-redesign arrow right-arrow"></div></a> </c:if>
                    </div>
                </div>

                <div class="results-container">
                    <c:forEach items="${searchResults}" var="searchResult">
                        <!--RESULT ROW-->
                        <div class="row margin-0 padding-0 border-bottom-gray">
                            <div class="col-md-12 results-result">
                                <h2 class="margin-0">
                                    <c:out value="${searchResult.title}"/>
                                </h2><br/>
                                <c:choose>
                                    <c:when test="${searchResult.access == 'RRO' && userIpFromBl}">
              <span class="results-title-text results-lib-premises text-smaller black">
                <spring:message code="search.results.library.premises" />
              </span>
                                    </c:when>
                                    <c:when test="${searchResult.access == 'RRO' && !userIpFromBl}">
              <span class="results-title-text results-lib-premises text-smaller">
                <spring:message code="search.results.library.premises" />
              </span>
                                    </c:when>
                                </c:choose>

                                <span class="results-title-text clearfix padding-vert-10"> <a title="<c:out value="${searchResult.displayUrl}"/>" class="break-all" href="<c:out value="${searchResult.url}"/>">           <span class="results-for-highlight"><c:out value="${searchResult.displayUrl}"/></span>
          </a> </span> <span class="results-title-text clearfix break-all">
           <span class="results-for-highlight"><c:out value="${searchResult.text}"/></span>
          </span>
                                <span class="results-title-text results-title-date padding-0 padding-top-20 bold"><spring:message code="search.results.archived.date"/></span>
                                <span class="results-title-text results-title-date padding-0 padding-top-20"><c:out value="${searchResult.date}"/></span>

                                </span>
                            </div>
                        </div>

                        <!--/RESULT ROW-->
                    </c:forEach>


                    <!--NO RESULTS-->
                    <c:choose>
                        <c:when test="${totalPages == 0}">
                            <div class="row margin-0 padding-0 border-bottom-gray">
                                <div class="col-md-12 results-result">
                                    <h2 class="margin-0 padding-top-20 gray">
                                        <spring:message code="search.noresults" />
                                    </h2>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                    <!--/NO RESULTS-->

                </div>

                <div class="row padding-0 margin-0">
                    <div class="col-md-12 pagination-cont">
                        <%--preserve all current parameters in URL and change only page parameter--%>
                        <c:url var="nextUrl" value="">
                            <c:forEach items="${param}" var="entry">
                                <c:if test="${entry.key != 'page'}">
                                    <c:param name="${entry.key}" value="${entry.value}" />
                                </c:if>
                            </c:forEach>
                            <%--set page value as a placeholder as it is going to be changed for each link--%>
                            <c:param name="page" value="PAGE_NUM_PLACEHOLDER" />
                        </c:url>
                        <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-number-redesign arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div>Previous</a> </c:if>
                        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                            <c:if test="${i <= totalPages && !deepPaging}">
                                <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>">
                                    <div class="pagination-number-redesign ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                        <c:out value="${i}"/>
                                    </div></a>
                            </c:if>
                        </c:forEach>
                        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit && !deepPaging}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />">Next<div class="pagination-number-redesign arrow right-arrow"></div></a> </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="up-button" title="<spring:message code="top.of.page" />" aria-label="<spring:message code="top.of.page" />"  tabindex="0"></div>

    <footer>
        <%@include file="footer.jsp" %>
    </footer>
</div>
<script>




    function showDateReset() {
        if ($(".archived-date").length>0) {
            if ($("#from_date").val().trim()!=="" || $("#to_date").val().trim()!=="") {
                $("#btn_reset_dates").show();
            } else {
                $("#btn_reset_dates").hide();
            }
        }
    }

    function toggle(el) {

        if (el.hasClass("open")) {
            el.next(".sidebar-filter:not(.no-collapse)").children().show();
            el.next(".sidebar-filter").addClass("expanded").attr("aria-hidden","false");
            el.removeClass("open").addClass("closee").attr("aria-expanded","true");
            checkboxSize();
        } else {
            el.next(".sidebar-filter:not(.no-collapse)").children().hide();
            el.next(".sidebar-filter").removeClass("expanded").attr("aria-hidden","false");
            el.removeClass("closee").addClass("open").attr("aria-expanded","false");
        }

    }

    // Removal of Filter Criteria
    function tog(v){return v?'addClass':'removeClass';}

    $(document).ready(function(e) {

        // Removal of Filter Criteria
        $(document).on('p', '.clearable', function(){
            //$(this)[tog(this.value)]('x');
        }).on('mousemove', '.x', function( e ){
            $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
        }).on('touchstart click', '.onX', function( ev ){
            alert('Sorry, this feature is still in progress.');
            ev.preventDefault();
            //-----------------------------------
            // filter id submit form
            //-----------------------------------
            //$(this).removeClass('x onX').val('').change();
        });


        $("#SearchFilterDialog").on('shown.bs.modal', function(e) {
            var tab = e.relatedTarget.hash;
            $('.nav-tabs a[href="'+tab+'"]').tab('show')
        });

        $('#SearchFilterDialog').on('hidden.bs.modal', function (e) {
            //alert("hide modal");


            //var value = $('#myPopupInput').val();
            //$('#myMainPageInput').val(value);
        });

        $("#from_date, #to_date").datepicker({
            dateFormat: "yy-mm-dd",
            changeMonth: true,
            changeYear: true,
            yearRange: "-50:+0",
            maxDate : 'now'
        });

        //filters toggle and count
        $(".sidebar-filter-header:not(.no-collapse)").each(function(index, element) {

            //keyboard nav and toggle
            $(this).on("click keydown", function(e) {

                switch (e.which) {

                    case 13:
                    case 1:
                    case 32: {
                        //expand on enter, click or space
                        e.preventDefault();
                        toggle($(this));
                        break;
                    }

                    //down arrow, pgdown
                    case 40: {
                        e.preventDefault();
                        if ($(this).nextAll(".sidebar-filter-header:not(.no-collapse)").first().attr("class")!==undefined) {
                            $(this).nextAll(".sidebar-filter-header:not(.no-collapse)").first().focus();
                        } else {
                            $(".sidebar-filter-header:not(.no-collapse)").first().focus();
                        }
                        break;
                    }

                    //up arrow, pgup
                    case 38: {
                        e.preventDefault();
                        if ($(this).prevAll(".sidebar-filter-header:not(.no-collapse)").first().attr("class")!==undefined) {
                            $(this).prevAll(".sidebar-filter-header:not(.no-collapse)").first().focus();
                        } else {
                            $(".sidebar-filter-header:not(.no-collapse)").last().focus();
                        }
                        break;
                    }

                    //end
                    case 35: {
                        e.preventDefault();
                        $(".sidebar-filter-header:not(.no-collapse)").last().focus();
                        break;
                    }

                    //home
                    case 36: {
                        e.preventDefault();
                        $(".sidebar-filter-header:not(.no-collapse)").first().focus();
                        break;
                    }

                }

            });

            $(this).focus(function(e) {
                $(this).attr("aria-selected", "true");
            }).blur(function(e) {
                $(this).attr("aria-selected", "false");
            });;

            //expand selected
            if ($(this).next(".sidebar-filter").children(".sidebar-filter-checkbox").children(".form-check-cont").children("input:checked").length!=0) {
                toggle($(this));
            } else {
                $(this).next(".sidebar-filter:not(.no-collapse)").children().hide();
            }


        });

        //hide facets where there is no result
        var sidebar_noresults = '<spring:message code="search.side.noresults" />';
        $(".sidebar-filter-header:not(.archived-date)").each(function(index, element) {
            if ($(this).next(".sidebar-filter").children(".sidebar-filter-checkbox").children(".form-check-cont").children("input").length==0) $(this).next('.sidebar-filter').html('<span class="sidebar-noresults">'+sidebar_noresults+'</span>');
        });

        //expand if dates inputed
        if ($("#from_date").val()!=="" || $("#to_date").val()!=="") {
            $("#dates_header").removeClass("open").addClass("closee");
            $("#dates_container").addClass("expanded").children().show();
        }

        //change filters
        //$("input[type='checkbox'], .access_filter").click(function(e) { $("#filter_form").submit(); });
        $(".sidebar-filter-input-checkbox, .access_filter").click(function(e) { $("#filter_form").submit(); });


        $.fn.getDataFromModalFilter = function () {
            var checkedModalDomains  = $('.sidebar-filter-input-checkbox-modal-domains:checkbox:checked').map(function() {
                return this.value;
            }).get();
            var checkedModalPublicSuffixArray  = $('.sidebar-filter-input-checkbox-modal-suffixes:checkbox:checked').map(function() {
                return this.value;
            }).get();
            var checkedModalDocumentTypes  = $('.sidebar-filter-input-checkbox-modal-documenttypes:checkbox:checked').map(function() {
                return this.value;
            }).get();
            var checkedModalCollections  = $('.sidebar-filter-input-checkbox-modal-collections:checkbox:checked').map(function() {
                return this.value;
            }).get();

            //store in hidden field
            $('#input_hidden_field_checked_modal_domains_array').val(checkedModalDomains);//JSON.stringify(checkedModalDomainsArray));
            $('#input_hidden_field_checked_modal_suffix_array').val(checkedModalPublicSuffixArray);
            $('#input_hidden_field_checked_modal_documenttypes_array').val(checkedModalDocumentTypes);
            $('#input_hidden_field_checked_modal_collections_array').val(checkedModalCollections);

        };

        $("#apply-modal-filter").click(function () {


            $.fn.getDataFromModalFilter();
            // submit old form
            $("#filter_form").submit();
        });

        //form validation
        $("#filter_form_modal").submit(function(e) {

            showPleaseWait();

            var isValid = true;
            return true;
        });

            //submit on resort
        $(".sort").each(function(index, element) {
            $(this).click(function(e) {
                $("#view_sort").val($(this).val());
                $("#filter_form").submit();
            });
        });

        //form count
        $("#count").change(function(e) {
            $("#view_count").val($(this).val());
            $("#filter_form").submit();
        });

        //form validation
        $("#filter_form").submit(function(e) {

            showPleaseWait();

            var isValid = true;
            var from = Date.parse($("#from_date").val());
            var to = Date.parse($("#to_date").val());
            var now = new Date();

            if ($("#from_date").val().trim()!=="" && !from) isValid=false;
            if ($("#to_date").val().trim()!=="" && !to) isValid=false;
            if (isValid && (from>now || to>now)) isValid=false;
            if (isValid && to<from) isValid=false;

            if (isValid) {
                return true;
            } else {
                alert('<spring:message code="notice.date.range" />');
                return false;
            }

        });

        //checks should filters be retained and submits
        $("#search_form").submit(function(e) {

            showPleaseWait();

            if ($("#reset_filters").val() === "true") {
                return true;
            } else {
                $("#text_hidden").val($("#text").val());
                $("#filter_form").submit();
                return false;
            }
        });

        //resets filters
        $("#btn_reset_filters").click(function(e) {
            $("#reset_filters").val("true");
            $('checkbox[value="Web page"]').val("");
            $("#search_form").submit();
        });

        //date reset
        $("#btn_reset_dates").click(function(e) {
            $("#from_date, #to_date").val("");
            showDateReset();
        });

        //show/hide date reset button
        $("#from_date, #to_date").on("change keyup", function(e) {
            showDateReset();
        });

        showDateReset();
        checkboxSize(); //expand checkbox size to fit label content


    });

</script>
</body>
</html>