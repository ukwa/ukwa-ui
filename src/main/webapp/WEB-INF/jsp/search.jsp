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
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="search.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="content">
  <div class="row margin-0 padding-0">
    
    <div class="col-lg-3 col-md-4 col-sm-12 sidebar padding-0">
    <aside id="sidebar">
    <span class="hidden"><spring:message code="search.filter.notice" /></span>
      <form action="#" method="get" enctype="multipart/form-data" name="filter_form" id="filter_form">
        <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
        <div class="sidebar-collapse" role="region">
          <%--   View facet   --%>
          <div class="sidebar-filter-header no-collapse" id="t_access" title="<spring:message code="search.side.view.title" />"> <spring:message code="search.side.view.title" />
            <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.view.tip" />" tabindex="0"></div>
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
            <%--   Domains collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" aria-expanded="false" title="<spring:message code="search.side.domain.title" />" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title" id="t_domain"><spring:message code="search.side.domain.title" /></div>
              <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.domain.tip" />" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel" aria-hidden="true" aria-labelledby="t_domain">
              <c:if test="${domains.size() > 1}">
                <c:forEach begin="0" end="${domains.size() - 1}" step="2" var="i">
                  <c:if test="${domains.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${domains.get(i)}"/>" tabindex="0">
                        <input type="checkbox" class="white" name="domain_filter" id="domain_filter_<c:out value="${i}"/>"
                             value="${domains.get(i)}"
                        ${originalDomains.contains(domains.get(i) )? 'checked' : ''}/>
                        <label class="main-search-check-label white" for="domain_filter_<c:out value="${i}"/>" title="<c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)">
                          <c:out value="${domains.get(i)}"/>
                          <span class="label-counts">(<span class="results-count"><c:out value="${domains.get(i + 1)}"/></span>)</span></label>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <%--   Document type collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" aria-expanded="false" title="<spring:message code="search.side.doctype.title" />" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title" id="t_doctype"><spring:message code="search.side.doctype.title" /></div>
              <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.doctype.tip" />" tabindex="0"></div>
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
            <div class="sidebar-filter-header border-top-white open" aria-expanded="false" title="<spring:message code="search.side.suffix.title" />" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title" id="t_suffix"><spring:message code="search.side.suffix.title" /></div>
              <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.suffix.tip" />" tabindex="0"></div>
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
            <%--   Archived year collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open archived-date" aria-expanded="false" title="<spring:message code="search.side.date.title" />" tabindex="0" id="dates_header" role="tab">
              <div class="sidebar-filter-header-title" id="t_date"><spring:message code="search.side.date.title" /></div>
              <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.date.tip" />" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" id="dates_container" role="tabpanel" aria-hidden="true" aria-labelledby="t_date">
              <div class="row padding-bottom-20 padding-top-20">
                <div class="col-sm-3">
                  <label for="from_date" class="white"><spring:message code="search.side.date.from" /></label>
                </div>
                <div class="col-sm-9">
                  <input type="text" class="form-control blue form-white-placeholder" name="from_date" id="from_date" title="<spring:message code="search.side.date.from" />" placeholder="YYYY-MM-DD"
                       value="${originalFromDateText != null ? originalFromDateText : ''}"/>
                </div>
              </div>
              <div class="row padding-bottom-20">
                <div class="col-sm-3">
                  <label for="to_date" class="white"><spring:message code="search.side.date.to" /></label>
                </div>
                <div class="col-sm-9">
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
            <%--   Collection collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" aria-expanded="false" title="<spring:message code="search.side.coll.title" />" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title" id="t_coll"><spring:message code="search.side.coll.title" /></div>
              <div class="help-button small white" data-toggle="tooltip" title="<spring:message code="search.side.coll.tip" />" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel" aria-hidden="true" aria-labelledby="t_coll">
              <c:if test="${collections.size() > 1}">
                <c:forEach begin="0" end="${collections.size() - 1}" step="2" var="i">
                  <c:if test="${collections.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${collections.get(i)}"/>" tabindex="0">
                        <input type="checkbox" class="white" name="collection" id="collection_<c:out value="${i}"/>"
                             value="${collections.get(i)}"
                        ${originalCollections.contains(collections.get(i) )? 'checked' : ''}/>
                        <label class="main-search-check-label white" for="collection_<c:out value="${i}"/>"
                             title="<c:out value="${collections.get(i)}"/> (<c:out value="${collections.get(i + 1)}"/>)">
                          <c:out value="${collections.get(i)}"/>
                          <span class="label-counts">(<span class="results-count"><c:out value="${collections.get(i + 1)}"/></span>)</span></label>
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
        </div>
      </form>
      </aside>
    </div>
    
    <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
      <div class="results-header border-bottom-gray">
      <div class="row">
        <div class="col-sm-12 padding-top-5">
          <span class="results-count"><c:out value="${totalSearchResultsSize}"/></span>
          <spring:message code="search.results.num" /> <span class="bold">&quot;<c:out value="${originalSearchRequest}"/>&quot;</span></div>
          
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
          <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div></a> </c:if>
          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
          <c:if test="${i <= totalPages}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>">
          <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}" title="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>">
          <c:out value="${i}"/>
        </div></a>
        </c:if>
        </c:forEach>
        <c:if test="${targetPageNumber + 4 < totalPages}">
          <div class="pagination-button dots inactive"></div>
          <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>" aria-label="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>">
            <c:out value="${totalPages}"/>
          </div></a> </c:if>
        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"></div></a> </c:if>
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
    <c:forEach items="${searchResults}" var="searchResult"> 
      <!--RESULT ROW-->
      <div class="row margin-0 padding-0 border-bottom-gray">
        <div class="col-md-12 results-result">
          <h2 class="margin-0">
            <c:out value="${searchResult.title}"/>
          </h2><br/>
          <c:if test="${searchResult.access == 'RRO'}">
            <span class="results-title-text results-lib-premises text-smaller">
              <spring:message code="search.results.library.premises" />
            </span>
          </c:if>
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
    <c:if test="${totalPages == 0}">
          <div class="row margin-0 padding-0 border-bottom-gray">
        <div class="col-md-12 results-result">
          <h2 class="margin-0 padding-top-20 gray">
            <spring:message code="search.noresults" />
          </h2>
        </div>
      </div>
      </c:if>
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
        
        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
        <c:if test="${i <= totalPages}">
        <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>"> <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}" title="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>">
        <c:out value="${i}"/>
      </div></a>
      </c:if>
      </c:forEach>
      
      <c:if test="${targetPageNumber + 4 < totalPages}">
        <div class="pagination-button dots inactive"></div>
<a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>" aria-label="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>">
          <c:out value="${totalPages}"/>
        </div></a> </c:if>
      <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"></div></a> </c:if>
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

$(document).ready(function(e) {

	$("#from_date, #to_date").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true,
        changeYear: true,
		//minDate: new Date('1996/01/01'),
		yearRange: "-50:+0"
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
			
				//down arrow
				case 40: {
					e.preventDefault();
					if ($(this).nextAll(".sidebar-filter-header:not(.no-collapse)").first().attr("class")!==undefined) {
						$(this).nextAll(".sidebar-filter-header:not(.no-collapse)").first().focus();
					} else {
						$(".sidebar-filter-header:not(.no-collapse)").first().focus();
					}
					break;
				}
			
				//up arrow
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

		//expand selected
		if ($(this).next(".sidebar-filter").children(".sidebar-filter-checkbox").children(".form-check-cont").children("input:checked").length!=0) {
			//$(this).removeClass("open").addClass("closee").next(".sidebar-filter").addClass("expanded");
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
	$("input[type='checkbox'], .access_filter").click(function(e) {
        $("#filter_form").submit();
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
        
		var isValid = true;
		var from = Date.parse($("#from_date").val())
		var to = Date.parse($("#to_date").val())
		
		if ($("#from_date").val().trim()!=="" && !from) isValid=false;
		if ($("#to_date").val().trim()!=="" && !to) isValid=false;
		if (isValid && to<from) isValid=false;
		
		if (isValid) {
			return true;
		} else {
			alert('<spring:message code="notice.date.range" />');
			return false;
		}
		
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
