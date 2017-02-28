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
<title>UKWA No results</title>
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
      <div class="col-md-12 col-sm-12 margin-top-minus-20"><img class="h3-icon" src="img/icons/left-arrow-white.png"/>
        <h3 class="bold">Back to the list</h3>
      </div>
      <div class="col-md-6 offset-md-3">
        <h2 class="uppercase">THE RESOURCE IS NOT FREELY AVAILABLE ONLINE</h2>
        <p class="text-medium">Many links to content are freely available online 
          but some content may be subscribed and unavailable 
          unless you use the Library PCs in our Reading Rooms. </p>
      </div>
    </div>
  </section>
  <section id="content">
    <div class="row margin-0">
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right"> <span class="no-result-title bold clearfix">Title</span> Tony Blair's Warfare State </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right"> <span class="no-result-title bold clearfix">Author</span> Edgerton, David </div>
      <div class="col-md-4 col-sm-12 no-result-grid"> <span class="no-result-title bold clearfix">Subjects</span> Socialism </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right no-results-border-top"> <span class="no-result-title bold clearfix">Identifier</span> Journal ISSN: 2044-0480 </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right no-results-border-top"> <span class="no-result-title bold clearfix">Journal Title</span> New left review </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-top"> <span class="no-result-title bold clearfix">Language</span> English </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right no-results-border-top"> <span class="no-result-title bold clearfix">In</span> New left review volume NLR<br/>
        I issue 230, July-August 1998 page 123 </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-right no-results-border-top"> <span class="no-result-title bold clearfix">Rights</span> LegalDeposit<br/>
        Reading Room Access </div>
      <div class="col-md-4 col-sm-12 no-result-grid no-results-border-top"> <span class="no-result-title bold clearfix">Publication details</span> New left review
        Tony Blair's Warfare State </div>
    </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
