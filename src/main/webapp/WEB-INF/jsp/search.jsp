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
<jsp:useBean id="publicSuffixes" scope="request" type="java.util.List<java.lang.String>"/>


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Search</title>
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
        <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
        <div class="sidebar-collapse">
          <form action="" method="get" enctype="multipart/form-data" name="filter_form">
          <div class="padding-20 border-bottom-white">
            <p class="text-medium bold">Public suffix</p>

            <c:set var="suffixCount" value="0"/>
            <c:if test="${publicSuffixes.size() > 1}">
            <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
              <c:if test="${publicSuffixes.get(i + 1) != 0 && suffixCount < 5}">
                <c:set var="suffixCount" value="${suffixCount + 1}"/>

                <div class="col-md-12 col-sm-12">
                  <div class="form-check-cont padding-0">
                    <input type="checkbox" class="white" name="public_suffix" id="public_suffix_1" value="${publicSuffixes.get(i)}" ${fn:contains(originalPublicSuffixes, publicSuffixes.get(i) )? 'checked' : ''}/>
                    <label class="main-search-check-label white text-medium" for="public_suffix_1"><c:out value="${publicSuffixes.get(i)}"/> (<c:out value="${publicSuffixes.get(i + 1)}"/>)</label>
                  </div>
                </div>
              </c:if>
            </c:forEach>
            </c:if>
          </div>
          <div class="sidebar-item border-bottom-white">Restrict to a collection</div>
          <div class="padding-20 border-bottom-white">
            <p class="text-medium bold">Type of document</p>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_1" value="html" ${fn:contains(originalDocumentTypes, 'html' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_1">HTML</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_2" value="pdf" ${fn:contains(originalDocumentTypes, 'pdf' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_2">PDF</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_3" value="word" ${fn:contains(originalDocumentTypes, 'word' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_3">Word</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_4" value="excel" ${fn:contains(originalDocumentTypes, 'excel' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_4">Excel</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_5" value="power_point" ${fn:contains(originalDocumentTypes, 'power_point' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_5">Power Point</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="doc_type" id="doc_type_6" value="text" ${fn:contains(originalDocumentTypes, 'text' )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="doc_type_6">Text</label>
              </div>
            </div>
          </div>
          <div class="padding-20">
            <label class="bold white text-medium width-100">Restrict by date</label>
            <div class="row margin-0 padding-0">
              <div class="col-md-3 padding-0 padding-vert-10">
                <label class="white padding-top-5" for="from_date">From</label>
              </div>
              <div class="col-md-5 padding-0 padding-vert-10">
                <input type="text" name="from_date" id="from_date" class="form-control blue" value="${originalFromDateText != null ? originalFromDateText : ''}"/>
              </div>
            </div>
            <div class="row margin-0 padding-0">
              <div class="col-md-3 padding-0 padding-vert-10">
                <label class="white padding-top-5" for="to_date">To</label>
              </div>
              <div class="col-md-5 padding-0 padding-vert-10">
                <input type="text" name="to_date" id="to_date" class="form-control blue" value="${originalToDateText != null ? originalToDateText : ''}"/>
              </div>
            </div>
            <div class="row margin-0 padding-0">
            <div class="col-md-12 padding-0"><button class="button button-white margin-top-40 margin-bottom-20" role="button" type="submit">Filter</button></div>
            </div>
          </div>
            <input type="hidden" name="search_location" id="search_location" value="${originalSearchLocation}">
            <input type="hidden" name="text" id="text" value="${originalSearchRequest}">
          </form>
        </div>
      </div>
      <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
        <div class="results-header border-bottom-gray">
          <div class="float-left padding-top-5"><c:out value="${totalSearchResultsSize}"/> results for <span class="bold">"<c:out value="${originalSearchRequest}"/>"</span></div>
          <div class="help-button small"></div>
          <div class="clearfix"></div>
        </div>

        <c:forEach items="${searchResults}" var="searchResult">
        <!--RESULT ROW-->
        <div class="row margin-0 padding-0 border-bottom-gray">
          <div class="col-lg-3 col-md-12 padding-20 bg-gray results-border">
            <div class="row margin-0 padding-0">
              <div class="col-lg-12 col-md-6 col-sm-6 col-xs-6 padding-bottom-20 padding-left-0">
                <span class="light-blue bold text-bigger">5035</span><br/>
                results found for the domain:
                <a href="<c:out value="${searchResult.domain}"/>"><c:out value="${searchResult.domain}"/></a>
              </div>
              <div class="col-lg-12 col-md-6 col-sm-6 col-xs-6 padding-side-0">
                 Archived on:<br/>
                 <c:out value="${searchResult.date}"/> 
              </div>
            </div>
          </div>
          <div class="col-lg-7 col-md-12 results-result">
            <h2 class="margin-0"><c:out value="${searchResult.title}"/></h2>
            <span class="results-title-text clearfix padding-0">
              
            </span>
            <span class="results-title-text clearfix padding-vert-10">
              <a class="results-link" href="<c:out value="${searchResult.url}"/>"><c:out value="${searchResult.displayUrl}"/></a>
            </span>
            <span class="results-title-text clearfix">
              <c:out value="${searchResult.text}"/>
            </span>
          </div>
          <div class="col-lg-2 col-md-12 padding-20">
            <div class="social-button fb float-right margin-left-10"></div>
            <div class="social-button twitter float-right margin-left-10"></div>
          </div>
        </div>
        <!--/RESULT ROW-->
        </c:forEach>

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

          <c:if test="${targetPageNumber > 1}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>">
              <div class="pagination-button arrow left-arrow"></div></a>
          </c:if>

          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
            <c:if test="${i <= totalPages}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>">
              <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}">
                <c:out value="${i}"/>
              </div></a>
            </c:if>
          </c:forEach>
          <c:if test="${targetPageNumber + 4 < totalPages}">
           <div class="pagination-button dots inactive"></div>
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>">
              <div class="pagination-button inactive">
                <c:out value="${totalPages}"/>
              </div></a>
          </c:if>

          <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>">
              <div class="pagination-button arrow right-arrow"></div>
            </a>
          </c:if>
          </div>
        </div>
      </div>
    </div>
  </section>
  <div class="up-button"></div>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
<script>

$(document).ready(function(e) {
    $("#from_date, #to_date").datepicker({
		dateFormat: "yy-mm-dd"	
	});
});

</script>
</body>
</html>
