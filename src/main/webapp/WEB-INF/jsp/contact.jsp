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
<title><spring:message code="contact.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="contact-header">
  <div class="row header-blue white">
    <div class="col-md-6 offset-md-3 col-md-offset-3 padding-mobile-side-0">
      <h2><spring:message code="contact.main.heading" /></h2>
      <spring:message code="contact.text" />
    </div>
  </div>
</section>
<section id="content">
  <form action="/ukwa/contact" method="post" enctype="multipart/form-data" name="contact">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h3 class="light-blue bold"><spring:message code="contact.form.heading" /></h3>
        <spring:message code="contact.form.notice" />
      </div>
            <div class="col-md-6 col-sm-12 form-content-col">
      &nbsp;
      </div>

      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="name"><spring:message code="contact.form.input.name" /></label>
          <input type="text" name="name" id="name" class="form-control" placeholder="<spring:message code="contact.form.input.name.placeholder" />" required/>
        </div>
         <div class="form-group">
          <label for="email"><spring:message code="contact.form.input.email" /></label>
          <input type="email" name="email" id="email" class="form-control" placeholder="<spring:message code="contact.form.input.email.placeholder" />" required/>
        </div>
      </div>
                  <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="comments"><spring:message code="contact.form.input.comments" /></label>
          <textarea name="comments" id="comments" class="form-control height-145" placeholder="<spring:message code="contact.form.input.comments.placeholder" />" required></textarea>
        </div>
      </div>

      
      <div class="col-md-6 col-sm-12 form-content-col padding-top-30">
        <button type="submit" class="button button-blue" title="<spring:message code="contact.form.button.submit" />"><spring:message code="contact.form.button.submit" /></button>
      </div>
    </div>
  </form>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<script>
$(document).ready(function(e) {
    
	var message='<spring:message code="contact.sent.message"/>';
	if ($.urlParam('sent')=='true') alert(message);
	
});
</script>
</body>
</html>
