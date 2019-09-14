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
<spring:message code="about.header.title" />
</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<spring:message code='main.menu.about' var="title"/>
<%@include file="title.jsp" %>


<section id="content">
  <div class="row default-padding page-content">
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h2 class="light-blue bold">
          <spring:message code="about.page.title2" />
        </h2>
        <spring:message code="about.page.p2" />

      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/47007971.JPG" alt="About UKWA"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/47008070.jpg" alt="About UKWA"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h2 class="light-blue bold">
          <spring:message code="about.page.title1" />
        </h2>
        <spring:message code="about.page.p1" />

      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h2 class="light-blue bold">
          <spring:message code="about.page.title3" />
        </h2>
          <spring:message code="about.page.p3" />
      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about-logos.png" alt="About UKWA"/> </figure>
    </div>
  </div>
</section>

<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_about").addClass('active');
    });
</script>
</body>
</html>
