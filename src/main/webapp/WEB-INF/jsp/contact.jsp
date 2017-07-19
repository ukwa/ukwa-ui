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
    <div class="col-md-6 offset-md-3 padding-mobile-side-0">
      <h2><spring:message code="contact.main.heading" /></h2>
      <spring:message code="contact.text" />
    </div>
  </div>
</section>
<section id="content">
  <form action="#" method="get" enctype="multipart/form-data" name="contact">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h3 class="light-blue bold"><spring:message code="contact.form.heading" /></h3>
        <spring:message code="contact.form.notice" />
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="name"><spring:message code="contact.form.input.name" /></label>
          <input type="text" name="name" id="name" class="form-control" placeholder="<spring:message code="contact.form.input.name.placeholder" />" required/>
        </div>
        <div class="form-group">
          <label for="position"><spring:message code="contact.form.input.position" /></label>
          <input type="text" name="position" id="position" class="form-control" placeholder="<spring:message code="contact.form.input.position.placeholder" />"/>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="comments"><spring:message code="contact.form.input.comments" /></label>
          <textarea name="comments" id="comments" class="form-control height-145" placeholder="<spring:message code="contact.form.input.comments.placeholder" />"></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="organisation"><spring:message code="contact.form.input.organisation" /></label>
          <input type="text" name="organisation" id="organisation" class="form-control" placeholder="<spring:message code="contact.form.input.organisation.placeholder" />"/>
        </div>
        <div class="form-group">
          <label for="email"><spring:message code="contact.form.input.email" /></label>
          <input type="email" name="email" id="email" class="form-control" placeholder="<spring:message code="contact.form.input.email.placeholder" />" required/>
        </div>
      </div>
      <div class="col-md-12 col-sm-12 form-content-col">
        <div class="row">
          <div class="col-md-12 col-sm-12 form-group margin-0">
            <label><spring:message code="contact.form.input.recipient" /></label>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="1" id="recipient_1" checked/>
              <label class="form-radio-label bold" for="recipient_1"><spring:message code="contact.form.input.recipient.general" /></label>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="2" id="recipient_2" />
              <label class="form-radio-label bold" for="recipient_2"><spring:message code="contact.form.input.recipient.jisc" /></label>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="3" id="recipient_3" />
              <label class="form-radio-label bold" for="recipient_3"><spring:message code="contact.form.input.recipient.tna" /></label>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="4" id="recipient_4" />
              <label class="form-radio-label bold" for="recipient_4"><spring:message code="contact.form.input.recipient.wl" /></label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="5" id="recipient_5" />
              <label class="form-radio-label bold" for="recipient_5"><spring:message code="contact.form.input.recipient.bl" /></label>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="6" id="recipient_6" />
              <label class="form-radio-label bold" for="recipient_6"><spring:message code="contact.form.input.recipient.nls" /></label>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont form-margin-check" tabindex="0">
              <input type="radio" name="recipient" value="7" id="recipient_7" />
              <label class="form-radio-label bold" for="recipient_7"><spring:message code="contact.form.input.recipient.nlw" /></label>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col padding-top-30">
        <button type="button" class="button button-blue" role="button" title="<spring:message code="contact.form.button.submit" />"><spring:message code="contact.form.button.submit" /></button>
      </div>
    </div>
  </form>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
