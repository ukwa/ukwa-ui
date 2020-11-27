<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="locale">${pageContext.response.locale}</c:set>
<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<html lang="${locale}">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>
<spring:message code="accessibility.header.title" />
</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<spring:message code='accessibility.page.title' var="title"/>
<%@include file="title.jsp" %>

<section id="content">
  <div class="row default-padding page-content margin-0 px-md-3 px-sm-2 px-2">
    <div class="col-md-12 col-sm-12 page-content-col">
      <article>
        <c:choose>
          <c:when test="${locale == 'en'}">
            <%@include file="accessibility_statement_body_en.jsp" %>
            <hr/>
          </c:when>
          <c:when test="${locale == 'cy'}">
            <%@include file="accessibility_statement_body_cy.jsp" %>
          </c:when>
          <c:otherwise>
          </c:otherwise>
        </c:choose>

      </article>
    </div>
  </div>
</section>

<footer class="footer-content">
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
