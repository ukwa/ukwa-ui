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
<title>UKWA Memento</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
	<%@include file="header.jsp" %>
  </header>
  <section id="memento-header">
    <div class="row header-blue white">
      <div class="col-md-6 offset-md-3"> <img class="h2-icon" src="img/icons/clock-white.png"/>
        <h2>Memento</h2>
        <h3>Finding historical versions of web pages (mementos) 
          captured by multiple archives across the world.</h3>
        <p>A 'memento' is a historical version of a web resource. Memento is also a method that allows seamless discovery and delivery of individual mementos, regardless where they are held. This is based on metadata aggregated from various web archives in the world, allowing you to find the historical pages you need across several archives.</p>
      </div>
    </div>
  </section>
  <section id="content">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 page-content-col">
        <article>
          <p>Our Mementos service exposes the Memento protocol via a simple web-based user interface, allowing you to look up which archives across the world hold mementos of any particular URL. It provides basic visualisations of this information, including breakdowns of how many mementos different archival organisations hold, and how the collection of those mementos has varied over time. Although direct browsing of the past web requires special tools or browser extensions (like MementoFox), our lookup service provides an easy way to start exploring the world wide archival history of the web.</p>
          <p>To get started, visit the Mementos service and enter a URL, or click on one of the examples below.</p>
        </article>
      </div>
      <div class="col-md-6 col-sm-12 page-content-col">
        <h3 class="light-blue bold">Examples</h3>
        <div class="row">
          <div class="col-md-6 col-sm-12 padding-bottom-20">
            <figure><img class="img-responsive border-gray" src="img/memento.png"/></figure>
            <figcaption class="light-blue">The history of www.webarchive.org.uk</figcaption>
          </div>
          <div class="col-md-6 col-sm-12 padding-bottom-20padding-bottom-20">
            <figure><img class="img-responsive border-gray" src="img/memento.png"/></figure>
            <figcaption class="light-blue">The history of www.webarchive.org.uk</figcaption>
          </div>
          <div class="col-md-6 col-sm-12 padding-bottom-20">
            <figure><img class="img-responsive border-gray" src="img/memento.png"/></figure>
            <figcaption class="light-blue">The history of www.webarchive.org.uk</figcaption>
          </div>
        </div>
      </div>
    </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
