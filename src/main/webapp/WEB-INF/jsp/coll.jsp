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
<c:if test="${setProtocolToHttps}">
    <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>

<jsp:useBean id="targetWebsites" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO>"/>
<jsp:useBean id="subCollections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>
<jsp:useBean id="rootCollections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>
<jsp:useBean id="currentCollection" scope="request" type="com.marsspiders.ukwa.controllers.data.CollectionDTO"/>

<html lang="en">
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
      <div class="col-lg-3 col-md-4 col-sm-12 sidebar padding-0 white">

      <a href="collection" class="no-decoration" title="Back to the list"><div class="sidebar-back-item border-bottom-white">Back to the list</div></a>
      <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
      <div class="sidebar-collapse">
      <p class="sidebar-coll-title padding-20 padding-bottom-0">Special collections</p>
      <p class="sidebar-coll-link padding-20 white">
      <c:forEach items="${rootCollections}" var="rootCollection">
        <a href="collection/<c:out value="${rootCollection.id}"/>"><c:out value="${rootCollection.name}"/></a><br/>
      </c:forEach>
      </p>
      </div>
      </div>
      <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
      <div class="row margin-0 border-bottom-gray">
      <div class="col-md-9 offset-md-1 col-sm-12 padding-top-40 padding-bottom-20 light-blue">
      <h1><c:out value="${currentCollection.name}"/></h1>
      <p class="black"><c:out value="${currentCollection.description}"/></p>
      </div>
      </div>
      
     
           
      <c:if test="${!empty subCollections}">
  <%--Do something if subCollections not empty--%>
 <div class="row margin-0 border-bottom-gray">
  <%--LOOP of Sub collections--%>
  <c:forEach items="${subCollections}" var="subCollection">
  
  <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-30 padding-bottom-20">
        <a href="collection/<c:out value="${subCollection.id}"/>"><div class="center light-blue padding-bottom-10 collection-heading">
          <c:out value="${subCollection.name}"/>
        </div>
        <figure><img class="img-responsive border-gray coll-img" alt="Collections" src="img/collections/collection_<c:out value="${subCollection.id}"/>.png"/>
          <figcaption class="img-square-caption shadow"> <c:out value="${subCollection.description}"/><div class="collection-readmore-cont" data-descript="<c:out value="${subCollection.fullDescription}"/>"><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div></figcaption>
        </figure></a>
  </div>
  

  </c:forEach>
      </div>
</c:if>



      
        <c:forEach items="${targetWebsites}" var="targetWebsite">
        <!--RESULT ROW-->
        <div class="row margin-0 padding-0 border-bottom-gray">

          <div class="col-md-7 offset-md-2 col-sm-12 results-result">
            <h2 class="margin-0"><c:out value="${targetWebsite.name}"/></h2>
           <span class="results-title-text clearfix">
              <c:out value="${targetWebsite.description}"/>
            </span>
            <span class="results-title-text clearfix">
              Archived date: <c:out value="${targetWebsite.startDate}"/>
            </span>
            <span class="results-title-text clearfix padding-0">
              <a href="<c:out value="${targetWebsite.url}"/>"><c:out value="${targetWebsite.url}"/></a>
            </span>
            <span class="results-title-text clearfix padding-vert-10">
              <a href="<c:out value="${targetWebsite.archiveUrl}"/>"><c:out value="${targetWebsite.archiveUrl}"/></a>
            </span>
          </div>
          <div class="col-lg-3 col-md-12 padding-20">
            <!--<div class="social-button fb float-right margin-left-10" title="Facebook"></div>
            <div class="social-button twitter float-right margin-left-10" title="Twitter"></div>-->
          </div>
        </div>
        <!--/RESULT ROW-->
        </c:forEach>

        <div class="row padding-0 margin-0">
          <div class="col-md-12 pagination-cont">
          <c:if test="${targetPageNumber > 1}">

              <a href="collection/<c:out value="${currentCollection.id}"/>?page=<c:out value="${targetPageNumber - 1}"/>" title="Previous page">
                  <div class="pagination-button arrow left-arrow"></div></a>
          </c:if>
          <c:forEach begin="1" end="${currentCollection.websitesNum/rowsPerPageLimit + 1}" var="i">
              <a href="collection/<c:out value="${currentCollection.id}"/>?page=<c:out value="${i}"/>" title="<c:out value="${i}"/>">
                  <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}">
                      <c:out value="${i}"/>
                  </div></a>
          </c:forEach>
          <c:if test="${targetPageNumber < currentCollection.websitesNum/rowsPerPageLimit}">

              <a href="collection/<c:out value="${currentCollection.id}"/>?page=<c:out value="${targetPageNumber + 1}"/>" title="Next page">
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
</body>
</html>
