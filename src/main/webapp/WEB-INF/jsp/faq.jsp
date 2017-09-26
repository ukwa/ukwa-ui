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
<title><spring:message code="faq.title" /></title>
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
    <div class="col-lg-8 mr-auto ml-auto col-lg-offset-2 col-md-10 col-md-offset-1 col-sm-12 padding-mobile-side-0">
      <h2 class="uppercase"><spring:message code="faq.main.heading" /></h2>
      <p class="text-medium"><spring:message code="faq.subtitle" /></p>
    </div>
  </div>
  <div class="row margin-0">
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="1"><spring:message code="faq.q1" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="2"><spring:message code="faq.q2" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="3"><spring:message code="faq.q3" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="1"><spring:message code="faq.a1" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="2"><spring:message code="faq.a2" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="3"><spring:message code="faq.a3" /></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="4"><spring:message code="faq.q4" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="5"><spring:message code="faq.q5" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="6"><spring:message code="faq.q6" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="4"><spring:message code="faq.a4" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="5"><spring:message code="faq.a5" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="6"><spring:message code="faq.a6" /></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="7"><spring:message code="faq.q7" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="8"><spring:message code="faq.q8" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="9"><spring:message code="faq.q9" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="7"><spring:message code="faq.a7" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="8"><spring:message code="faq.a8" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="9"><spring:message code="faq.a9" /></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="10"><spring:message code="faq.q10" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="11"><spring:message code="faq.q11" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="12"><spring:message code="faq.q12" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="10"><spring:message code="faq.a10" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="11"><spring:message code="faq.a11" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="12"><spring:message code="faq.a12" /></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="13"><spring:message code="faq.q13" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="14"><spring:message code="faq.q14" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="15"><spring:message code="faq.q15" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="13"><spring:message code="faq.a13" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="14"><spring:message code="faq.a14" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="15"><spring:message code="faq.a15" /></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="16"><spring:message code="faq.q16" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="17"><spring:message code="faq.q17" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="18"><spring:message code="faq.q18" /></a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="16"><spring:message code="faq.a16" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="17"><spring:message code="faq.a17" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="18"><spring:message code="faq.a18" /></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="19"><spring:message code="faq.q19" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="20"><spring:message code="faq.q20" /></a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="21">&nbsp;</a></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="19"><spring:message code="faq.a19" /></div>
    <div class="col-md-10 offset-md-1 col-md-offset-1 col-sm-12 q-description hidden" id="20"><spring:message code="faq.a20" /></div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
