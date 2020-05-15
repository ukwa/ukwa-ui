<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">
${req.requestURL}
</c:set>
<c:set var="locale">
${pageContext.response.locale}
</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<html lang="${locale}">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="error.404.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
    <%@include file="header.jsp" %>
  </header>

<spring:message code='error.404.heading' var="title"/>
<%@include file="title.jsp" %>

  <section id="content">

  <div class="row margin-0 padding-side-10 padding-mobile-side-5 padding-top-80 padding-bottom-80">
    <div class="col-lg-6 ml-auto mr-auto col-lg-offset-3 col-md-10 col-md-offset-1 col-sm-12 text-bigger bold">
		<spring:message code="error.404.text" />
    </div>
    <div class="coll-sm-12">&nbsp;</div>
    <div class="col-lg-6 ml-auto mr-auto col-lg-offset-3 col-md-10 col-md-offset-1 col-sm-12 margin-top-60">
		<spring:message code="error.404.note" />
    </div>
  </div>
</section>
<footer class="footer-content">
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
