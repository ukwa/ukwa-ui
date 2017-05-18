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


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="home.header.title" text="UKWA Home" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
    <%@include file="header.jsp" %>
  </header>
  
    <section id="home-header">
    <div class="row header-blue white padding-top-80 padding-bottom-60">
      <div class="col-md-6 offset-md-3">
        <p class="text-bigger"><spring:message code="home.header.text" /></p>
      </div>
    </div>
  </section>
  
    <section id="collections">
    
    <div class="row header-bar-2 padding-top-80">
      <div class="col-lg-2  col-md-3 col-sm-12 main-heading-cont">
        <h1 class="main-heading-2"><spring:message code="home.page.collections.title"/></h1>
        <hr class="header-title-hr"/>
      </div>
      <div class="col-lg-4 col-md-5 offset-md-1 col-sm-12 header-2-subtitle"><spring:message code="home.page.collections.subtitle"/></div>
    </div>

 
    <div class="row page-content padding-side-70 padding-top-0">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10"><a href="collection/329">British Stand-up Comedy Archive</a></div>
        <figure><a href="collection/329" title="Collection owned and adminstered by Elspeth Millar, Briti..."><img class="img-responsive border-gray" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/></a>
          <figcaption class="img-square-caption">Collection owned and adminstered by Elspeth Millar, Briti...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10"><a href="collection/309">French in London</a></div>
        <figure><a href="collection/309" title="This collection of websites has been selected by Saskia H..."><img class="img-responsive border-gray" alt="French in London" src="img/collections/collection_309.png"/></a>
          <figcaption class="img-square-caption">This collection of websites has been selected by Saskia H...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10"><a href="collection/65">Scottish Independence Referendum</a></div>
        <figure><a href="collection/65" title="Provisional title for collection on Scottish Devolution, ..."><img class="img-responsive border-gray" alt="Scottish Independence Referendum" src="img/collections/collection_65.png"/></a>
          <figcaption class="img-square-caption">Provisional title for collection on Scottish Devolution, ...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10"><a href="collection/138">News Sites</a></div>
        <figure><a href="collection/138" title="558 titles are included in this collection (30/01/2014). ..."><img class="img-responsive border-gray" alt="News Sites" src="img/collections/collection_138.png"/></a>
          <figcaption class="img-square-caption">558 titles are included in this collection (30/01/2014). ...</figcaption>
        </figure>
      </div>
      
    </div>
  </section>
  
  <footer>
    <%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
