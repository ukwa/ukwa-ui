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
<title><spring:message code="faq.title" /></title>
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
            <div class="main-heading-2-bold-redesign white padding-top-40"><spring:message code="faq.main.heading" /></div>
        </div>
    </div>

    <section id="content">
  <div class="row margin-0 padding-top-20 padding-bottom-80 text-content padding-mobile-side-5">

      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid main-subheading-2-redesign black padding-bottom-60"><spring:message code="faq.subtitle" /></div>

      <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q1" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a1" /></div>

    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q2" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a2" /></div>
    
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q3" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a3" /></div>
           
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q4" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a4" /></div>
    
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q5" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a5" /></div>
  
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q6" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a6" /></div>

    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q7" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a7" /></div>

    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q8" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a8" /></div>
 
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q9" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a9" /></div>
            
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q10" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a10" /></div>

    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q11" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a11" /></div>
    
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-grid"><spring:message code="faq.q12" /></div>
    <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 q-description"><spring:message code="faq.a12" /></div>
    
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
