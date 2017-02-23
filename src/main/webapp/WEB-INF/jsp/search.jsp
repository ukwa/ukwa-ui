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
<c:set var="locale">
    ${pageContext.response.locale}
</c:set>

<jsp:useBean id="searchResults" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.SearchResultDTO>"/>


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Browse by subject</title>
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
          <div class="sidebar-item border-bottom-white">Restrict by Archiving Organisation</div>
          <div class="sidebar-item border-bottom-white">Restrict to a subject</div>
          <div class="sidebar-item border-bottom-white">Restrict to a collection</div>
          <div class="padding-20 border-bottom-white">
            <p class="text-medium bold">Type of document</p>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_1" value="1"/>
                <label class="main-search-check-label white text-medium" for="document_1">HTML</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_2" value="2"/>
                <label class="main-search-check-label white text-medium" for="document_2">PDF</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_3" value="3"/>
                <label class="main-search-check-label white text-medium" for="document_3">Word</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_4" value="4"/>
                <label class="main-search-check-label white text-medium" for="document_4">Excel</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_5" value="5"/>
                <label class="main-search-check-label white text-medium" for="document_5">Power Point</label>
              </div>
            </div>
            <div class="col-md-12 col-sm-12">
              <div class="form-check-cont padding-0">
                <input type="checkbox" class="white" name="document" id="document_6" value="6"/>
                <label class="main-search-check-label white text-medium" for="document_6">Text</label>
              </div>
            </div>
          </div>
          <div class="padding-20">
            <label class="bold white text-medium width-100">Restrict by date</label>
            <div class="row margin-0 padding-0">
              <div class="col-md-3 padding-0 padding-vert-10">
                <label class="white padding-top-5">From</label>
              </div>
              <div class="col-md-5 padding-0 padding-vert-10">
                <input type="text" name="from" id="from" class="form-control blue"/>
              </div>
            </div>
            <div class="row margin-0 padding-0">
              <div class="col-md-3 padding-0 padding-vert-10">
                <label class="white padding-top-5">To</label>
              </div>
              <div class="col-md-5 padding-0 padding-vert-10">
                <input type="text" name="from" id="from" class="form-control blue"/>
              </div>
            </div>
          </div>
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
          <div class="col-lg-6 col-md-12 results-result">
            <h2 class="margin-0"><c:out value="${searchResult.title}"/></h2>
            <span class="results-title-text clearfix padding-0">
              
            </span>
            <span class="results-title-text clearfix padding-vert-10">
              <a href="<c:out value="${searchResult.url}"/>"><c:out value="${searchResult.displayUrl}"/></a>
            </span>
            <span class="results-title-text clearfix">
              <c:out value="${searchResult.text}"/>
            </span>
          </div>
          <div class="col-lg-3 col-md-12 padding-20">
            <div class="social-button fb float-right margin-left-10"></div>
            <div class="social-button twitter float-right margin-left-10"></div>
          </div>
        </div>
        <!--/RESULT ROW-->
        </c:forEach>

        <div class="row padding-0 margin-0">
          <div class="col-md-12 pagination-cont">
            <div class="pagination-button arrow left-arrow"></div>
            <div class="pagination-button active">2</div>
            <div class="pagination-button inactive">3</div>
            <div class="pagination-button inactive">4</div>
            <div class="pagination-button dots inactive"></div>
            <div class="pagination-button inactive">8</div>
            <div class="pagination-button arrow right-arrow"></div>
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
</body>
</html>
