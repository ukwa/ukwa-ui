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
  <div class="row bg-transparent">
    <div class="white main-search-input-new" style="padding-bottom:170px;padding-top:40px;padding-left:5%;padding-right:5%;">
      <div class="main-heading-2-bold-redesign white padding-top-40"><spring:message code="main.menu.about" /></div>
    </div>
  </div>

<figure>
  <div class="header-white about-video-container padding-0">
<div class="embed-responsive embed-responsive-16by9">
  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/ubDHY-ynWi0" allowfullscreen></iframe>
</div>
</div>
</figure>
<section id="content">
  <div class="row page-content">
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title1" />
        </h3>
          <spring:message code="about.page.p1" />

      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about1.png" alt="About UKWA"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about2.png" alt="About UKWA"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title2" />
        </h3>
          <spring:message code="about.page.p2" />

      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title3" />
        </h3>
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
