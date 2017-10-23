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
<title><spring:message code="search.tips.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="content">
  <div class="row header-blue white">
    <div class="col-lg-8 mr-auto ml-auto col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12  padding-mobile-side-0">
      <h2 class="uppercase"><spring:message code="search.tips.main.heading" /></h2>
    </div>
  </div>
  <div class="row margin-0 padding-side-20 padding-top-80 padding-bottom-80">
    <div class="col-lg-8 mr-auto ml-auto col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 text-content padding-mobile-side-0">

<spring:message code="search.tips.text" />
    </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
