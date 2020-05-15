<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="uri" value="${req.requestURI}"/>
<c:set var="url">${req.requestURL}</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<c:set var="locale">${pageContext.response.locale}</c:set>
<html lang="${locale}">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="contact.title" /></title>
<%@include file="head.jsp" %>
<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<spring:message code='main.menu.contact' var="title"/>
<%@include file="title.jsp" %>

<section id="content">

<c:choose>
 <c:when test="${sent}">

<div class="row default-padding page-content margin-0 px-md-3 px-sm-2 px-2">
 <div class="col-sm-12">
  <div class="alert alert-success" role="alert">
   <spring:message code="contact.sent.message"/>
  </div>
 </div>
</div>

 </c:when>
 <c:otherwise>

    <div class="row default-padding page-content margin-0 px-md-3 px-sm-2 px-2">
        <p class="main-subheading-2-redesign">
            <spring:message code="contact.text"/>
        </p>
    </div>

    <form action="contact" method="post" enctype="multipart/form-data" name="contact" id="contact-form" class="needs-validation" novalidate>

    <div class="row default-padding page-content margin-0 px-md-3 px-sm-2 px-2">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h2 class="bold"><spring:message code="contact.form.heading" /></h2>
        <spring:message code="contact.form.notice" />
      </div>
            <div class="col-md-6 col-sm-12 form-content-col">
      &nbsp;
      </div>

      <div class="col-md-6 col-sm-12">
        <div class="form-group">
          <label for="name" class="ukwa-form-field">* <spring:message code="contact.form.input.name" /></label>
          <input type="text" name="name" id="name" class="form-control" placeholder="<spring:message code="contact.form.input.name.placeholder" />" required/>
          <div class="invalid-feedback">
            <spring:message code="contact.form.input.name.placeholder" />
          </div>
        </div>
         <div class="form-group">
          <label for="email" class="ukwa-form-field">* <spring:message code="contact.form.input.email" /></label>
          <input type="email" name="email" id="email" class="form-control" placeholder="<spring:message code="contact.form.input.email.placeholder" />" required/>
          <div class="invalid-feedback">
            <spring:message code="contact.form.input.email.placeholder" />
          </div>
        </div>
      </div>
                  <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="comments" class="ukwa-form-field">* <spring:message code="contact.form.input.comments" /></label>
          <textarea name="comments" id="comments" class="form-control height-145" aria-label="Input text for comment" title="Comments field" placeholder="<spring:message code="contact.form.input.comments.placeholder" />" required></textarea>
          <div class="invalid-feedback">
            <spring:message code="contact.form.input.comments.placeholder" />
          </div>
        </div>
      </div>


      <div class="col-md-6 col-sm-12 form-content-col padding-top-0" aria-label="Input captcha" title="captcha message field" id="ukwa-captchca">
      <div class="g-recaptcha" data-sitekey="6Lcn5C4UAAAAAFzANA394u7Jqfk2QmvxyUjM8UiM" aria-hidden="true"></div>
      <div class="captcha-message" aria-labelledby="ukwa-captchca"><spring:message code="captcha.message" /></div>
        <button type="submit" class="btn-primary margin-top-30 button_form_submit " aria-labelledby="ukwa-captchca" title="<spring:message code="contact.form.button.submit" />"><spring:message code="contact.form.button.submit" /></button>
      </div>
    </div>
  </form>

 </c:otherwise>
</c:choose>

</section>
<footer class="footer-content">
  <%@include file="footer.jsp" %>
</footer>
</div>
<script>

$(document).ready(function(e) {
    var $menuItems = $('.header-menu-item');
    $menuItems.removeClass('active');
    $("#headermenu_contact").addClass('active');

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });

	$("#contact-form").submit(function(e) {
    	var response = grecaptcha.getResponse();
		if (response.length == 0) {
			$(".captcha-message").show();
			var result=false;
		} else {
			$(".captcha-message").hide();
			var result=true;
		}
		return result;
	});

});

</script>
</body>
</html>
