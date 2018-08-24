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
  <div class="row bg-transparent">
    <div class="white main-search-input-new" style="padding-bottom:170px;padding-top:40px;padding-left:5%;padding-right:5%;">
      <div class="main-heading-2-bold-redesign white padding-top-40"><spring:message code="main.menu.nominate" /></div>
    </div>
  </div>
<section id="nominate-header">
  <div class="row header-2-subtitle-redesign padding-top-40 padding-bottom-20">
    <div class="col-md-12 mr-auto ml-auto col-md-offset-2 padding-mobile-side-0" style="padding-right: 15%; padding-left: 5%">
      <spring:message code="nominate.text" />
    </div>
  </div>
  <div class="row header-blue padding-side-70 white">
    <div class="col-md-6 col-sm-12 padding-bottom-20 padding-side-10 padding-mobile-side-0">
      <h2><spring:message code="nominate.subtitle1" /></h2>
      <spring:message code="nominate.list1" />
    </div>
    <div class="col-md-6 col-sm-12 padding-bottom-20 padding-side-10 padding-mobile-side-0">
      <h2><spring:message code="nominate.subtitle2" /></h2>
     <spring:message code="nominate.list2" />
    </div>
  </div>
</section>
<section id="content">
<c:if test="${sent}">
<div class="row page-content padding-bottom-20">
<div class="col-sm-12 form-content-col bold red">
<spring:message code="nominate.sent.message"/>
</div>
</div>
</c:if>

  <form action="info/nominate" method="post" enctype="multipart/form-data" name="nominate" id="nominate-form">
    <div class="row page-content padding-top-40">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h3 class="light-blue bold"><spring:message code="nominate.form.heading" /></h3>
        <spring:message code="nominate.form.notice" />
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="title"><spring:message code="nominate.form.input.title" /></label>
          <input type="text" name="title" id="title" class="form-control" placeholder="<spring:message code="nominate.form.input.title.placeholder" />" required/>
        </div>
        <div class="form-group">
          <label for="url"><spring:message code="nominate.form.input.url" /></label>
          <input type="text" name="url" id="url" class="form-control" placeholder="<spring:message code="nominate.form.input.url.placeholder" />" required/>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
	        <div class="form-group">
          <label for="name"><spring:message code="nominate.form.input.name" /></label>
          <input type="text" name="name" id="name" class="form-control" placeholder="<spring:message code="nominate.form.input.name.placeholder" />" required/>
        </div>      
        <div class="form-group">
          <label for="email"><spring:message code="nominate.form.input.email" /></label>
          <input type="email" name="email" id="email" class="form-control" placeholder="<spring:message code="nominate.form.input.email.placeholder" />" required/>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="notes"><spring:message code="nominate.form.input.notes" /></label>
          <textarea name="notes" id="notes" class="form-control height-145" placeholder="<spring:message code="nominate.form.input.notes.placeholder" />"></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
      <span><spring:message code="nominate.form.email.notice" /></span>
        <div class=" margin-top-30 clearfix">
         <div class="g-recaptcha" data-sitekey="6Lcn5C4UAAAAAFzANA394u7Jqfk2QmvxyUjM8UiM"></div>
      <div class="captcha-message"><spring:message code="captcha.message" /></div>
        <button type="submit" class="button button-blue margin-top-30" title="<spring:message code="nominate.form.button.submit" />"><spring:message code="nominate.form.button.submit" /></button></div>
        
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
    var $menuItems = $('.header-menu-item');
    $menuItems.removeClass('active');
    $("#headermenu_save").addClass('active');
   	
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
