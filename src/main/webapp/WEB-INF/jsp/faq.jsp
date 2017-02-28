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
<title>UKWA Frequently asked questions</title>
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
      <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
        <h2 class="uppercase">Frequently asked questions</h2>
        <p class="text-medium">If your question isn't answered below please <a href="contact">contact us</a>.</p>
      </div>
    </div>
  </section>
  <section id="content">

    <div class="row margin-0 padding-bottom-80">
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">What is the UK Web Archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">How frequently are sites gathered?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">Are "trivial" sites included?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">How big is the archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Who are the organisations behind the UK Web Archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Where is the archive held?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">Why is a web archive needed?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">How are websites selected?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">Does the UK Web Archive endorse websites?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Who is the UK Web Archive for?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Is permission asked first before a website is archived?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Can anyone nominate a UK website?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">How do you search the UK Web Archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">Does Legal Deposit legislation apply to websites?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid"><a href="#">Can I link to the UK Web Archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">How can I get my website removed from the archive?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">How can I protect my privacy if information about me is archived?</a></div>
      <div class="col-md-4 col-sm-12 faq-grid bg-gray"><a href="#">Why are some archived websites absent, incompleteor?</a></div>            
     </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
