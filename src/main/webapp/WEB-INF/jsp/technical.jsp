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


<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Technical information</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
	<%@include file="header.jsp" %>
  </header>
  <section id="noresults-header">
    <div class="row header-blue white">
      <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
        <h2 class="uppercase">Technical information</h2>
      </div>
    </div>
  </section>
  <section id="content">
    <div class="row margin-0 padding-bottom-80">
      <div class="col-md-4 col-sm-12 faq-grid">UK Web Archive Crawler Settings</div>
      <div class="col-md-4 col-sm-12 faq-grid">Making Your Website Crawler-Friendly</div>
      <div class="col-md-4 col-sm-12 faq-grid">What Can't Yet Be Archived</div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray">Search Engines and the UK Web Archive</div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray">Linking to the UK Web Archive</div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray">Technical Background</div>
      </div>          
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
