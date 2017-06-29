<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="locale">${pageContext.response.locale}</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>

<jsp:useBean id="collections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>


<html lang="en">
<head>
  <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />

<title>UKWA Special collections</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  
  <%@include file="header.jsp" %>
  
 
    <div class="row header-bar-2 padding-top-80">
      <div class="col-lg-2  col-md-3 col-sm-12 main-heading-cont">
        <h1 class="main-heading">Explore<br/>
          The Special<br/>
          Collections </h1>
        <hr class="header-title-hr"/>
      </div>
      <div class="col-lg-4 col-md-5 offset-md-1 col-sm-12 header-2-subtitle"> Special Collections are groups of websites brought together 
        on a particular theme by librarians, curators and other specialists, 
        often working in collaboration with key organisations in the field. </div>
    </div>
  </header>
  <section id="content">
    <div class="row page-content padding-side-70 padding-top-0">

      <c:forEach items="${collections}" var="collection">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
         <a href="collection/<c:out value="${collection.id}"/>" class="collection-link"><div class="center light-blue padding-bottom-10 collection-heading">
         <c:out value="${collection.name}"/>
        </div>
        <figure><img class="img-responsive border-gray coll-img" alt="Collections" src="img/collections/collection_<c:out value="${collection.id}"/>.png"/>
          <figcaption class="img-square-caption shadow"><c:out value="${collection.description}"/><div class="collection-readmore-cont" data-descript="<c:out value="${collection.fullDescription}"/>"><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div></figcaption>
        </figure></a>
      </div>
      </c:forEach>

    </div>
<!--    <div class="row margin-0">
      <div class="col-md-12 col-sm-12 center padding-bottom-80">
        <button type="button" class="button button-blue">View more collections...</button>
      </div>
    </div>-->
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
