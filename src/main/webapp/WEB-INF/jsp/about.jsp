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
<title>
<spring:message code="about.header.title" text="UKWA About" />
</title>
<%@include file="head.jsp" %>
</head>

<body>
<div class="about-full-video-container">
  <video id="about-full-video" class="about-full-video" controls>
    <source src="img/about.mp4" type="video/mp4">
  </video>
  <div class="about-close-button" id="close-about-video" title="<spring:message code="about.closevideo.title" />
  "></div>
</div>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="about-header">
  <div class="header-white about-video-container padding-0">
    <video class="about-video" autoplay muted>
      <source src="img/about.mp4" type="video/mp4">
    </video>
    <div class="about-play-button" id="play-about-video" title="<spring:message code="about.playvideo.title" />
    "></div>
  </div>
</section>
<section id="content">
  <div class="row page-content">
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title1" />
        </h3>
        <p class="strong">
          <spring:message code="about.page.p1" />
        </p>
        <p>
          <spring:message code="about.page.p2" />
        </p>
        <p>
          <spring:message code="about.page.p3" />
        </p>
      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about1.png"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about2.png"/> </figure>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col text-right">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title2" />
        </h3>
        <p class="strong">
          <spring:message code="about.page.p4" />
        </p>
        <p>
          <spring:message code="about.page.p5" />
        </p>
        <p>
          <spring:message code="about.page.p6" />
        </p>
      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <article>
        <h3 class="light-blue bold">
          <spring:message code="about.page.title3" />
        </h3>
        <p>
          <spring:message code="about.page.p7" />
        </p>
      </article>
    </div>
    <div class="col-md-6 col-sm-12 page-content-col">
      <figure><img class="img-responsive" src="img/about-logos.png"/> </figure>
    </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
