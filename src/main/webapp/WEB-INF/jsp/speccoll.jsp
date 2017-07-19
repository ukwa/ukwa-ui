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
<jsp:useBean id="collections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="coll.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
<div class="row header-bar-2 padding-top-80">
  <div class="col-lg-2 col-md-3 col-sm-12 main-heading-cont">
    <h1 class="main-heading"><spring:message code="coll.main.heading" /></h1>
    <hr class="header-title-hr"/>
  </div>
  <div class="col-lg-4 col-md-5 offset-md-1 col-sm-12 header-2-subtitle"><spring:message code="coll.subtitle" /></div>

  <div class="col-lg-2 offset-lg-3 col-md-2 offset-md-1 col-sm-12 right padding-top-mobile-20"> 
    <img title="<spring:message code="coll.thumbs" />" alt="<spring:message code="coll.thumbs" />" class="collections-display" id="btn_thumbs" src="img/icons/icn_grid.png" tabindex="0"/>
    <img title="<spring:message code="coll.list" />" alt="<spring:message code="coll.list" />" class="collections-display" id="btn_list" src="img/icons/icn_list.png" tabindex="0"/>
  </div>
  
</div>

</header>
<section id="content">


  <!--THUMBNAIL DISPLAY-->
  <div class="row page-content padding-side-70 padding-top-0 collections" id="collections_thumbs">
    <c:forEach items="${collections}" var="collection">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/<c:out value="${collection.id}"/>" class="collection-link">
        <div class="center light-blue padding-bottom-10 collection-heading">
          <c:out value="${collection.name}"/>
        </div>
        <figure><img class="img-responsive border-gray coll-img" alt="Collections" src="img/collections/collection_<c:out value="${collection.id}"/>.png"/>
          <figcaption class="img-square-caption shadow">
            <c:out value="${collection.description}"/>
          </figcaption>
        </figure>
        </a> </div>
    </c:forEach>
  </div>
  
  <!--LIST DISPLAY-->
  
  <div class="row page-content padding-top-30 collections" id="collections_list">
    <c:forEach items="${collections}" var="collection">
      <div class="col-sm-12 padding-bottom-20 padding-side-30 margin-bottom-20 padding-mobile-side-0">
      <div class="border-bottom-gray padding-bottom-20">
      	<a href="collection/<c:out value="${collection.id}"/>" class="collection-link"><h2 class="padding-bottom-0"><c:out value="${collection.name}"/></h2></a><br/>
         <span><c:out value="${collection.fullDescription}"/></span>
        </a> </div></div>
    </c:forEach>
  </div>  
  
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<script>

function toggleView(action, fcs) {
	
	if (action === "list") {
        $("#collections_thumbs").hide();
		$("#collections_list").show();
		$("#btn_list").hide();		
		$("#btn_thumbs").show();
		if (fcs) $("#btn_thumbs").focus();
		$.cookie("collections_display", "list", { expires: 365, path: '/' });	
	} else { 
        $("#collections_list").hide();
		$("#collections_thumbs").show();
		$("#btn_thumbs").hide();
		$("#btn_list").show();
		if (fcs) $("#btn_list").focus();
		$.cookie("collections_display", "thumbnails", { expires: 365, path: '/' });	
	}
	
	return true;
}

$(document).ready(function(e) {
    
	if (typeof $.cookie('collections_display') === 'undefined' || $.cookie('collections_display')!=="list") {
		toggleView("thumbs", false);
	} else {
		toggleView("list", false);	
	}
	
	$("#btn_thumbs").on("click keypress", function(e) {
		if (e.which == 1 || e.which == 13) {
			e.preventDefault();
			toggleView("thumbs", true);
		}
    });
	
	$("#btn_list").on("click keypress", function(e) {
		if (e.which == 1 || e.which == 13) {
			e.preventDefault();
			toggleView("list", true);
		}
    });	
	
});

</script>
</body>
</html>
