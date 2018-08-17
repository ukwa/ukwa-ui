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
<html lang="${locale}">
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
  </header>
        <div class="row bg-transparent">
            <div class="white main-search-input-new" style="padding-bottom:170px;padding-top:40px;padding-left:5%;padding-right:5%;">
                <div class="main-heading-2-bold-redesign white padding-top-40"><spring:message code="coll.main.heading" /></div>
            </div>
        </div>

<div class="row margin-0 padding-side-20 padding-top-80">
  <div class="col-lg-6 col-md-8 offset-md-1 col-md-offset-1 col-sm-12 header-2-subtitle padding-side-10"><spring:message code="coll.subtitle" /></div>

  <div class="col-lg-2 offset-lg-3 col-lg-offset-3 col-md-2 offset-md-1 col-md-offset-1 col-sm-12 right padding-top-mobile-20">
      <img title="<spring:message code="coll.thumbs" />" alt="<spring:message code="coll.thumbs" />" class="collections-display" id="btn_thumbs" src="img/icons/icn_grid.png" tabindex="0"/>
      <img title="<spring:message code="coll.list" />" alt="<spring:message code="coll.list" />" class="collections-display" id="btn_list" src="img/icons/icn_list.png" tabindex="0"/>
  </div>

</div>


    <section id="content">


  <!--THUMBNAIL DISPLAY-->
  <div class="row margin-0 padding-side-5 padding-mobile-side-20 padding-top-0 collections" id="collections_thumbs">
    <c:forEach items="${collections}" var="collection">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
          <a href="collection/<c:out value="${collection.id}"/>" class="collection-link">
              <figure><img class="img-responsive border-gray coll-img" alt="<c:out value="${collection.imageAltMessage}"/>"
                           src="img/collections/collection_<c:out value="${collection.id}"/>.png"/>
              </figure>
              <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold"><c:out value="${collection.name}"/></div>
              <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail"><c:out value="${collection.description}"/></div>
          </a>
        </div>
    </c:forEach>
  </div>

  <!--LIST DISPLAY-->

  <div class="row margin-0 padding-top-30 padding-mobile-side-20 collections" id="collections_list">
    <c:forEach items="${collections}" var="collection">
      <div class="col-sm-12 padding-bottom-20 padding-side-20 margin-bottom-20 padding-mobile-side-0">
      <div class="border-bottom-gray padding-bottom-20">
      	<a href="collection/<c:out value="${collection.id}"/>" class="collection-link"><h2 class="padding-bottom-0 collection-title"><c:out value="${collection.name}"/></h2></a><br/>
         <span class="collection-description"><c:out value="${collection.fullDescription}"/></span>
        <c:if test="${!empty collection.subCollections}">
       <!--Subcollections of current collection-->
       <div class="collections-subcollections">
      <c:forEach items="${collection.subCollections}" var="subCollection">
        <a href="collection/<c:out value="${subCollection.id}"/>"><c:out value="${subCollection.name}"/></a><br>
      </c:forEach>
      </div>
      <div class="collections-view-subcollections"><a href="#" class="collections-subcollections-link"><spring:message code="coll.subcollections.show" /></a></div>
      </c:if>
        </div></div>
    </c:forEach>
  </div>

</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<input type="hidden" id="no-coll-description" name="no-coll-description" value="<spring:message code="coll.nodescript" />" />
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
    var $menuItems = $('.header-menu-item');
    $menuItems.removeClass('active');
    $("#headermenu_collection").addClass('active');

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

	//view subcollections
	var text_show = '<spring:message code="coll.subcollections.show" />';
	var text_hide = '<spring:message code="coll.subcollections.hide" />';
	$(".collections-subcollections-link").each(function(index, element) {
        $(this).click(function(e) {
			e.preventDefault();
            if ($(this).parent().prev(".collections-subcollections").css("display")=="none") {
				$(this).parent().prev(".collections-subcollections").show(200);
				$(this).text(text_hide);
			} else {
				$(this).parent().prev(".collections-subcollections").hide(200);
				$(this).text(text_show);
			}
        });
    });

});

</script>
</body>
</html>
