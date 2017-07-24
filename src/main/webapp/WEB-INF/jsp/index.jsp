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
<title>
<spring:message code="home.header.title" />
</title>
<%@include file="head.jsp" %>
</head>

<body>

<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="home-header">
  <div class="row header-blue white padding-top-80 padding-bottom-60">
    <div class="col-md-6 offset-md-3 padding-side-0">
      <p class="text-bigger">
        <spring:message code="home.header.text1" />
      </p>
      <p class="text-bigger">
        <spring:message code="home.header.text2" />
      </p> 
      <p class="text-bigger">
        <a href="about" title="<spring:message code="home.header.text.link" />"><spring:message code="home.header.text.link" /></a>
      </p>     
    </div>
  </div>
</section>
<section id="collections">
  <div class="row padding-top-80 margin-0 padding-side-20">
    <div class="col-lg-2  col-md-3 col-sm-12 main-heading-cont">
      <h1 class="main-heading-2">
        <spring:message code="home.page.collections.title"/>
      </h1>
      <hr class="header-title-hr"/>
    </div>
    <div class="col-lg-5 col-md-6 offset-md-1 col-sm-12 header-2-subtitle">
      <span class="clearfix"><spring:message code="home.page.collections.subtitle"/></span>
      <a href="collection" title="<spring:message code="home.button.viewmore.title"/>"><button class="button button-blue white no-decoration margin-top-30 clearfix" tabindex="-1" role="link"><spring:message code="home.button.viewmore"/></button></a>
    </div>
  </div>
  

  <div class="row padding-top-0 padding-side-5  margin-0 padding-mobile-side-20">
    <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/329" class="collection-link">
      <div class="center light-blue padding-bottom-10 collection-heading">British Stand-up Comedy Archive</div>
      <figure><img class="img-responsive border-gray coll-img" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/>
        <figcaption class="img-square-caption shadow">Collection owned and adminstered by Elspeth Millar. </figcaption>
      </figure>
      </a> </div>
    <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/309" class="collection-link">
      <div class="center light-blue padding-bottom-10 collection-heading">French in London</div>
      <figure><img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
        <figcaption class="img-square-caption shadow">This collection of websites has been selected by Saskia Huc-Hepher.</figcaption>
      </figure>
      </a> </div>
    <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/65" class="collection-link">
      <div class="center light-blue padding-bottom-10 collection-heading">Scottish Independence Referendum</div>
      <figure><img class="img-responsive border-gray coll-img" alt="Scottish Independence Referendum" src="img/collections/collection_65.png"/>
        <figcaption class="img-square-caption shadow">Provisional title for collection on Scottish Devolution. </figcaption>
      </figure>
      </a> </div>
    <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/138" class="collection-link">
      <div class="center light-blue padding-bottom-10 collection-heading">News Sites</div>
      <figure><img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
        <figcaption class="img-square-caption shadow">558 titles are included in this collection. </figcaption>
      </figure>
      </a> </div>
  </div>

</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<!--[if (gt IE 9)|!(IE)]><!-->
<script>
$(document).ready(function(e) {
    //survey monkey
	var content = '<div class="padding-20 black center width-100"><h2><spring:message code="survey.text"/></h2></div><div class="padding-20 clearfix center width-100"><a href="<spring:message code="survey.url"/>" title="<spring:message code="survey.button"/>" target="_blank"><button class="button button-blue white padding-20" role="link" tabindex="-1"><spring:message code="survey.button"/></button></a><div class="padding-20 padding-top-40 black center width-100"><img class="img-survey" alt="MonkeySurvey" src="img/surveymonkeylogo.jpg"/></div>';
	if (typeof $.cookie('survey_viewed') === 'undefined' || $.cookie('survey_viewed')!=="true") {
		$.SimpleLightbox.open({
			content: content,
			elementClass: 'slbContentEl'
		});
		$.cookie("survey_viewed", "true", { expires: 365, path: '/' });
	} 
});
</script>
<!--<![endif]-->
</body>
</html>
