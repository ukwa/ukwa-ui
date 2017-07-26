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
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="noresults.title" /></title>
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
    <div class="col-md-12 col-sm-12 margin-top-minus-20"><a href="javascript:window.history.back();" title="<spring:message code="noresults.back.button" />" class="no-decoration"><img class="h3-icon" src="img/icons/left-arrow-white.png" alt="<spring:message code="noresults.back.button" />"/><span class="text-big bold"><spring:message code="noresults.back.button" /></span></a>
    </div>
    <div class="col-md-6 offset-md-3">
      <h2 class="uppercase"><spring:message code="noresults.main.heading" /></h2>
    </div>
  </div>
</section>
<section id="content">
  <div class="row margin-0 padding-mobile-side-5 padding-top-80 padding-bottom-80">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12 text-justify">
<spring:message code="noresults.text" />
    </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
