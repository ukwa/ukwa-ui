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
<jsp:useBean id="advancedSearchResults" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.AdvancedSearchResultDTO>"/>
<jsp:useBean id="contentTypes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="accessTerms" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="publicSuffixes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="domains" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="collections" scope="request" type="java.util.List<java.lang.String>"/>
<spring:message code="pagination.goto" var="goToPage"/>
<spring:message code="pagination.current" var="currentPage"/>

<jsp:useBean id="phrasePairs" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="linksDomains" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="postcodeDistricts" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="contentLanguages" scope="request" type="java.util.List<java.lang.String>"/>


<html lang="${locale}">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title><spring:message code="search.title" /></title>
    <%@include file="head.jsp" %>
</head>

<body>

<c:set var = "advancedSearchPage" value = "true"/>

<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>
    <section id="content">
        <div class="row margin-0 padding-0">

            <div class="col-lg-3 col-md-4 col-sm-12 sidebar padding-0">
                <aside id="sidebar">
                    <div class="height-0"><spring:message code="search.filter.notice" /></div>
                    <form action="advancedsearch" method="get" enctype="multipart/form-data" name="advanced_filter_form" id="advanced_filter_form">
                        <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
                        <div class="sidebar-collapse" role="region">
                            <%--   View facet   --%>
                            <div class="sidebar-filter-header no-collapse" id="t_access" title="<spring:message code="search.side.view.title" />"> <spring:message code="search.side.view.title" />
                                <div class="help-button small white" title="<spring:message code="search.side.view.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.view.tip" />" tabindex="0"></div>
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
                                        <input tabindex="-1" type="radio" class="white access_filter" name="view_filter" id="view_filter_1" value="va"
                                        ${originalAccessView.contains('va') || empty originalAccessView ? 'checked' : ''}/>
                                        <label class="main-search-check-label white" for="view_filter_1" title="<spring:message code="search.side.view.1" />"><spring:message code="search.side.view.1" /> <span class="label-counts">(<span class="results-count"><c:out value="${vaCount}"/></span>)</span></label>
                                    </div>
                                </div>
                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                    <div class="form-check-cont padding-0" title="<spring:message code="search.side.view.2" />" tabindex="0">
                                        <input type="radio" class="white access_filter" name="view_filter" id="view_filter_2" value="vool"
                                        ${originalAccessView.contains('vool') ? 'checked' : ''}/>
                                        <label class="main-search-check-label white" for="view_filter_2" title="<spring:message code="search.side.view.2" />"> <spring:message code="search.side.view.2" /> <span class="label-counts">(<span class="results-count"><c:out value="${voolCount}"/></span>)</span></label>
                                    </div>
                                </div>
                            </div>
                            <div role="tablist">




                                    <%--   Document filter by language  --%>
                                    <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
                                        <div class="sidebar-filter-header-title" id="t_language_doctype">Language</div>
                                        <div class="help-button small white" title="<spring:message code="search.side.doctype.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
                                    </div>
                                    <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_phrase_doctype">

                                        <c:if test="${contentLanguages.size() > 1}">

                                            <c:forEach begin="0" end="${contentLanguages.size() - 1}" step="2" var="i">

                                                <c:if test="${contentLanguages.get(i + 1) != 0}">

                                                    <c:if test="${i < 9}">
                                                        <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                            <div class="form-check-cont padding-0" title="<c:out value="${contentLanguages.get(i)}"/>" tabindex="0">

                                                                <input type="checkbox" class="white" name="language" id="language_<c:out value="${i}"/>"
                                                                       value="${contentLanguages.get(i)}"
                                                                    ${originalContentLanguages.contains(contentLanguages.get(i))? 'checked' : ''}/>
                                                                <label class="main-search-check-label white" for="language_<c:out value="${i}"/>">
                                                                    <c:out value="${contentLanguages.get(i)}"/>
                                                                    <span class="label-counts">(<span class="results-count"><c:out value="${contentLanguages.get(i + 1)}"/></span>)</span>

                                                                </label>
                                                            </div>
                                                        </div>
                                                    </c:if>

                                                    <c:if test="${i > 8}">

                                                        <div class="sidebar-filter-checkbox col-md-12 col-sm-12" style="display:none;">
                                                            <div class="form-check-cont padding-0" title="<c:out value="${contentLanguages.get(i)}"/>" tabindex="0">

                                                                <input type="checkbox" class="white" name="language" id="language_<c:out value="${i}"/>"
                                                                       value="${contentLanguages.get(i)}"
                                                                    ${originalContentLanguages.contains(contentLanguages.get(i))? 'checked' : ''}/>
                                                                <label class="main-search-check-label white" for="language_<c:out value="${i}"/>">
                                                                    <c:out value="${contentLanguages.get(i)}"/>
                                                                    <span class="label-counts">(<span class="results-count"><c:out value="${contentLanguages.get(i + 1)}"/></span>)</span>

                                                                </label>
                                                            </div>
                                                        </div>

                                                    </c:if>






                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>




                                <%--   Document filter by links domains  --%>
                                    <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
                                        <div class="sidebar-filter-header-title" id="t_links_domains_doctype">Links Domains</div>
                                        <div class="help-button small white" title="<spring:message code="search.side.doctype.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
                                    </div>
                                    <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_phrase_doctype">
                                        <c:if test="${linksDomains.size() > 1}">
                                            <c:forEach begin="0" end="${linksDomains.size() - 1}" step="2" var="i">
                                                <c:if test="${linksDomains.get(i + 1) != 0}">


                                                    <c:if test="${i < 9}">
                                                        <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                            <div class="form-check-cont padding-0" title="<c:out value="${linksDomains.get(i)}"/>" tabindex="0">
                                                                <input type="checkbox" class="white" name="links_domains" id="links_domains_<c:out value="${i}"/>"
                                                                       value="${linksDomains.get(i)}"
                                                                    ${originalLinksDomains.contains(linksDomains.get(i))? 'checked' : ''}/>
                                                                <label class="main-search-check-label white" for="links_domains_<c:out value="${i}"/>">
                                                                    <c:out value="${linksDomains.get(i)}"/>
                                                                    <span class="label-counts">(<span class="results-count"><c:out value="${linksDomains.get(i + 1)}"/></span>)</span></label>
                                                            </div>
                                                        </div>
                                                </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>

                                    <%--   Document filter by postcode district  --%>
                                    <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
                                        <div class="sidebar-filter-header-title" id="t_postcode_district_doctype">Postcode District</div>
                                        <div class="help-button small white" title="<spring:message code="search.side.doctype.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
                                    </div>
                                    <div class="sidebar-filter expanded no-collapse" role="tabpanel" aria-hidden="true" aria-labelledby="t_phrase_doctype">
                                        <c:if test="${postcodeDistricts.size() > 1}">
                                            <c:forEach begin="0" end="${postcodeDistricts.size() - 1}" step="2" var="i">
                                                <c:if test="${postcodeDistricts.get(i + 1) != 0}">
                                                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                        <div class="form-check-cont padding-0" title="<c:out value="${postcodeDistricts.get(i)}"/>" tabindex="0">
                                                            <input type="checkbox" class="white" name="postcode_district" id="postcode_district_<c:out value="${i}"/>"
                                                                   value="${postcodeDistricts.get(i)}"
                                                                ${originalPostcodeDistricts.contains(postcodeDistricts.get(i))? 'checked' : ''}/>
                                                            <label class="main-search-check-label white" for="postcode_district_<c:out value="${i}"/>">
                                                                <c:out value="${postcodeDistricts.get(i)}"/>
                                                                <span class="label-counts">(<span class="results-count"><c:out value="${postcodeDistricts.get(i + 1)}"/></span>)</span></label>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>


                                    <%--   Archived year collapse filter   --%>
                                    <div class="sidebar-filter-header border-top-white open archived-date" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.date.title" />" tabindex="0" id="dates_header" role="tab">
                                        <div class="sidebar-filter-header-title" id="t_date"><spring:message code="search.side.date.title" /></div>
                                        <div class="help-button small white" title="<spring:message code="search.side.date.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.date.tip" />" tabindex="0"></div>
                                    </div>
                                    <div class="sidebar-filter" id="dates_container" role="tabpanel" aria-hidden="true" aria-labelledby="t_date">
                                        <div class="row padding-bottom-20 padding-top-20">
                                            <div class="col-sm-6">
                                                <label for="from_date" class="white date-range-label"><spring:message code="search.side.date.from" /></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control blue form-white-placeholder" name="from_date" id="from_date" title="<spring:message code="search.side.date.from" />" placeholder="YYYY-MM-DD"
                                                       value="${originalFromDateText != null ? originalFromDateText : ''}"/>
                                            </div>
                                        </div>
                                        <div class="row padding-bottom-20">
                                            <div class="col-sm-6">
                                                <label for="to_date" class="white date-range-label"><spring:message code="search.side.date.to" /></label>
                                            </div>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control blue form-white-placeholder" name="to_date" id="to_date" title="<spring:message code="search.side.date.to" />" placeholder="YYYY-MM-DD"
                                                       value="${originalToDateText != null ? originalToDateText : ''}"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <button type="submit" title="<spring:message code="search.side.date.submit" />" class="button button-white float-sm-right margin-left-10 margin-top-10 text-small"><spring:message code="search.side.date.submit" /></button>
                                                <button type="button" title="<spring:message code="search.side.date.reset" />" class="button button-white float-sm-right margin-top-10 text-small" id="btn_reset_dates">X</button>
                                            </div>
                                        </div>
                                    </div>



                                <%--   Document type collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title" id="t_doctype"><spring:message code="search.side.doctype.title" /></div>
                                    <div class="help-button small white" title="<spring:message code="search.side.doctype.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter" role="tabpanel" aria-hidden="true" aria-labelledby="t_doctype">
                                    <c:if test="${contentTypes.size() > 1}">
                                        <c:forEach begin="0" end="${contentTypes.size() - 1}" step="2" var="i">
                                            <c:if test="${contentTypes.get(i + 1) != 0}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                    <div class="form-check-cont padding-0" title="<c:out value="${contentTypes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="white" name="content_type" id="content_type_<c:out value="${i}"/>"
                                                               value="${contentTypes.get(i)}"
                                                            ${originalContentTypes.contains(contentTypes.get(i))? 'checked' : ''}/>
                                                        <label class="main-search-check-label white" for="content_type_<c:out value="${i}"/>">
                                                            <c:out value="${contentTypes.get(i)}"/>
                                                            <span class="label-counts">(<span class="results-count"><c:out value="${contentTypes.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>

                                <%--   Public suffix collapse filter   --%>
                                <div class="sidebar-filter-header border-top-white open" aria-selected="false" aria-expanded="false" title="<spring:message code="search.side.suffix.title" />" tabindex="0" role="tab">
                                    <div class="sidebar-filter-header-title" id="t_suffix"><spring:message code="search.side.suffix.title" /></div>
                                    <div class="help-button small white" title="<spring:message code="search.side.suffix.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="search.side.suffix.tip" />" tabindex="0"></div>
                                </div>
                                <div class="sidebar-filter" role="tabpanel" aria-hidden="true" aria-labelledby="t_suffix">
                                    <c:if test="${publicSuffixes.size() > 1}">
                                        <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
                                            <c:if test="${publicSuffixes.get(i + 1) != 0}">
                                                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                                                    <div class="form-check-cont padding-0" title="<c:out value="${publicSuffixes.get(i)}"/>" tabindex="0">
                                                        <input type="checkbox" class="white" name="public_suffix" id="public_suffix_<c:out value="${i}"/>"
                                                               value="${publicSuffixes.get(i)}"
                                                            ${originalPublicSuffixes.contains(publicSuffixes.get(i) )? 'checked' : ''}/>
                                                        <label class="main-search-check-label white" for="public_suffix_<c:out value="${i}"/>">
                                                            <c:out value="${publicSuffixes.get(i)}"/>
                                                            <span class="label-counts">(<span class="results-count"><c:out value="${publicSuffixes.get(i + 1)}"/></span>)</span></label>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </div>



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

            <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
                <div class="results-header border-bottom-gray">
                    <div class="row">
                        <div class="col-sm-12 padding-top-5">
                            <span class="results-count"><c:out value="${totalSearchResultsSize}"/></span>
                            <spring:message code="search.results.num" /> <span class="bold">&quot;<c:out value="${originalSearchRequest}" escapeXml="false"/>&quot;</span></div>

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
                        <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div></a> </c:if>
                        <c:if test="${targetPageNumber > 4 && !deepPaging}">
                            <div class="pagination-button dots inactive"></div>
                        </c:if>
                        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                            <c:if test="${i <= totalPages && !deepPaging}">
                                <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>">
                                    <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                        <c:out value="${i}"/>
                                    </div></a>
                            </c:if>
                        </c:forEach>
                        <c:if test="${targetPageNumber + 4 < totalPages && !deepPaging}">
                            <div class="pagination-button dots inactive"></div>
                        </c:if>
                        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit && !deepPaging}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"><div class="pagination-button arrow right-arrow"></div></a> </c:if>
                    </div>
                </div>
                <div class="row border-bottom-gray margin-0">
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
                        <div class="search-results-top-filters results-items-per-page">
                            <label for="count" title="<spring:message code="search.results.items" />" class="margin-top-10 text-small"><spring:message code="search.results.items" /></label>
                            <select class="form-control search-results-display-count" name="count" id="count" tabindex="0">
                                <option value="50" ${rowsPerPageLimit == 50 ? 'selected' : ''}>50</option>
                                <option value="100" ${rowsPerPageLimit == 100 ? 'selected' : ''}>100</option>
                                <option value="200" ${rowsPerPageLimit == 200 ? 'selected' : ''}>200</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="results-container">
                    <c:forEach items="${advancedSearchResults}" var="searchResult">
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
                                <span class="results-title-text results-title-date padding-0 padding-top-20">
          <spring:message code="search.results.archived.date" /> <c:out value="${searchResult.date}"/>
          </span>

                                <span class="results-title-text clearfix padding-vert-10"> <a title="<c:out value="${searchResult.displayUrl}"/>" class="break-all" href="<c:out value="${searchResult.url}"/>">           <span class="results-for-highlight"><c:out value="${searchResult.displayUrl}"/></span>
          </a> </span> <span class="results-title-text clearfix break-all">
           <span class="results-for-highlight"><c:out value="${searchResult.text}"/></span>
          </span> </div>
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
                        <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div></a> </c:if>
                        <c:if test="${targetPageNumber > 4 && !deepPaging}">
                            <div class="pagination-button dots inactive"></div>
                        </c:if>
                        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                            <c:if test="${i <= totalPages && !deepPaging}">
                                <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>">
                                    <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                        <c:out value="${i}"/>
                                    </div></a>
                            </c:if>
                        </c:forEach>
                        <c:if test="${targetPageNumber + 4 < totalPages && !deepPaging}">
                            <div class="pagination-button dots inactive"></div>
                        </c:if>
                        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit && !deepPaging}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"><div class="pagination-button arrow right-arrow"></div></a> </c:if>
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

</body>
</html>
