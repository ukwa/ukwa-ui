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
<html lang="${locale}">
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
        <%@include file="homepage_searchForm.jsp" %>
    </header>

    <%@include file="searchtips_modal.jsp" %>


    <spring:message code="home.page.alert-warning"/>


    <div id="content" class="content padding-top-20 padding-bottom-10 px-md-5 px-sm-3 px-xs-3 px-2">
        <section id="home-pre-header">

            <h1 class="main-heading-2-bold-redesign">
                    <spring:message code="home.page.whatwedo" />
            </h1>

            <div class="row padding-top-20">
                <div class="col-md-12">
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.header.text1" />
                    </p><br/>
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.header.text2" />
                    </p><br/>
                </div>
            </div>

        </section>

        <section id="collections">
            <div class="padding-top-40">
	            <h2 class="main-heading-2-bold-redesign">
                    <spring:message code="home.page.collections.title"/>
    	        </h2>
            </div>
            <div class="row padding-top-20">
                <div class="col-md-12">
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.page.collections.subtitle"/>
                    </p>
                </div>
            </div>

            <div class="row padding-top-20">
                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/329" class="collection-link">
                    <img class="img-responsive border-gray coll-img" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/>
                    <h3 class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">British Stand-up Comedy Archive</h3>
                    <div class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail"><spring:message code="collection.ownedandadministredby"/>Elspeth Millar.</div>
                </a> </div>

                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/309" class="collection-link">
                    <img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
                    <h3 class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">French in London</h3>
                    <div class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail"><spring:message code="collection.selectedby"/>Saskia Huc-Hepher.</div>
                </a></div>

                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/138" class="collection-link">
                    <img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
                    <h3 class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">News Sites</h3>
                    <div class="left padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">558 <spring:message code="collection.titlecountwithin"/></div>
                </a></div>
            </div>

            <div class="padding-bottom-60 center ">
                <a href="collection" class="ukwa-button btn-lg no-decoration" title="<spring:message code="home.button.viewmore.title"/>"><spring:message code="home.button.viewmore"/></a>
            </div>
        </section>
    </div>


    <footer class="footer-content">
        <%@include file="footer.jsp" %>
    </footer>
</div>

<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_index").addClass('active');
    });
</script>
</body>
</html>
