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
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<c:set var="locale">
  ${pageContext.response.locale}
</c:set>
<html lang="${locale}">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="nominate.title" /></title>
<%@include file="head.jsp" %>
<script src='https://www.google.com/recaptcha/api.js'></script>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<spring:message code='main.menu.nominate' var="title"/>
<%@include file="title.jsp" %>

<section id="nominate-header">

    <div class="padding-30">
        <div class="padding-30">
            <p class="main-subheading-2-redesign">
                <spring:message code="nominate.text"/>
            </p>
        </div>
    </div>

    <div class="row padding-30 nominate-result-row">
      <div class="col-md-6 col-sm-12 padding-bottom-20 padding-30">
        <h2><spring:message code="nominate.subtitle1" /></h2>
        <spring:message code="nominate.list1" />
      </div>
      <div class="col-md-6 col-sm-12 ">
        <h2><spring:message code="nominate.subtitle2" /></h2>
        <spring:message code="nominate.list2" />
      </div>
  </div>
</section>
<section id="content">

<c:choose>
 <c:when test="${sent}">

<div class="row page-content padding-bottom-20">
 <div class="col-sm-12">
  <div class="alert alert-success" role="alert">
   <spring:message code="nominate.sent.message"/>
  </div>
 </div>
</div>

 </c:when>
 <c:otherwise>


  <form role="form" action="info/nominate" method="post" enctype="multipart/form-data" name="nominate" id="nominate-form" class="needs-validation" novalidate>
    <div class="row page-content padding-top-40" role="group">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h2 class="main-heading-2-bold-redesign"><spring:message code="nominate.form.heading" /></h2>
        <spring:message code="nominate.form.notice" />
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="title" class="ukwa-form-field">* <spring:message code="nominate.form.input.title" /></label>
          <input role="textbox" type="text" tabindex="0" name="title" id="title" class="form-control" placeholder="<spring:message code="nominate.form.input.title.placeholder" />" required/>
          <div class="invalid-feedback">
            <spring:message code="nominate.form.input.title.placeholder" />
          </div>
        </div>
        <div class="form-group">
          <label for="url" class="ukwa-form-field">* <spring:message code="nominate.form.input.url" /></label>
          <input role="textbox" type="text" tabindex="0" name="url" id="url" class="form-control" placeholder="<spring:message code="nominate.form.input.url.placeholder" />" required/>
          <div class="invalid-feedback">
            <spring:message code="nominate.form.input.url.placeholder" />
          </div>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
	        <div class="form-group">
          <label for="name" class="ukwa-form-field">* <spring:message code="nominate.form.input.name" /></label>
          <input role="textbox" type="text" tabindex="0" name="name" id="name" class="form-control" placeholder="<spring:message code="nominate.form.input.name.placeholder" />" required/>
          <div class="invalid-feedback">
            <spring:message code="nominate.form.input.name.placeholder" />
          </div>
        </div>
        <div class="form-group">
          <label for="email" class="ukwa-form-field"><spring:message code="nominate.form.input.email" /></label>
          <input role="textbox" type="email" tabindex="0" name="email" id="email" class="form-control" placeholder="<spring:message code="nominate.form.input.email.placeholder"/>" aria-describedby="emailHelp"/>
          <small id="emailHelp" class="form-text"><spring:message code="nominate.form.email.notice" /></small>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="notes" class="ukwa-form-field"><spring:message code="nominate.form.input.notes" /></label>
          <textarea role="textbox" tabindex="0" name="notes" id="notes" class="form-control height-145" placeholder="" aria-describedby="notesHelp"></textarea>
          <small id="notesHelp" class="form-text"><spring:message code="nominate.form.input.notes.placeholder" /></small>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
          <div class=" margin-top-30 clearfix">
              <div class="g-recaptcha" data-sitekey="${google.recaptcha.site.key}" aria-hidden="true"
                   aria-label="do not use" aria-readonly="true"></div>
              <div class="captcha-message" aria-hidden="true" aria-label="do not use" aria-readonly="true">
                  <spring:message code="captcha.message"/></div>
              <button role="button" type="submit" aria-label="submit form Save a UK Website"
                      tabindex="0"
                      class="ukwa-button margin-top-30 button_form_submit"
                      title="<spring:message code="nominate.form.button.submit" />"><spring:message
                      code="nominate.form.button.submit"/></button>
          </div>
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
    $("#headermenu_save").addClass('active');


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
	

	$("#nominate-form").submit(function(e) {
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
