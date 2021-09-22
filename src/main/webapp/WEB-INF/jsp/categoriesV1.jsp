<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="locale">${pageContext.response.locale}</c:set>
<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:if test="${setProtocolToHttps}">
    <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<jsp:useBean id="itemsOfCategories" scope="request" type="java.util.List<java.lang.String>"/>

<html lang="${locale}">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title>
        Categories V1
    </title>
    <%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>

    <spring:message code='main.menu.categories' var="title"/>
    <%@include file="title.jsp" %>


    <section id="content">

        <div class="container">
            <div class="row padding-bottom-80">
                <div class="col-md-12" id="middiv" style="background-color: rgba(255, 255, 255, 0.1)">
                    <div id="ukwa-categories-carousel" class="carousel slide" data-ride="carousel" align="center">
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="img/categories/image9.png" alt="Arts and Culture" style="width:60%;">
                            </div>

                            <div class="carousel-item">
                                <img src="img/categories/image55.png" alt="History" style="width:60%;">
                            </div>

                            <div class="carousel-item">
                                <img src="img/categories/image4.png" alt="Politics and Government" style="width:60%;">
                            </div>

                            <div class="carousel-item">
                                <img src="img/categories/image22.png" alt="Places" style="width:60%;">
                            </div>



                            <div class="carousel-item">
                                <img src="img/categories/image7.png" alt="Science Technology and Medicine" style="width:60%;">
                            </div>

                            <div class="carousel-item">
                                <img src="img/categories/image1.png" alt="Society and Community" style="width:60%;">
                            </div>
                            <div class="carousel-item">
                                <img src="img/categories/image10.png" alt="Sport and Recreation" style="width:60%;">
                            </div>
                        </div>

                        <!-- Left and right controls -->
                        <a class="carousel-control-prev" href="#ukwa-categories-carousel" data-slide="prev">
                            <i class="fa fa-chevron-left"></i>
                        </a>
                        <a class="carousel-control-next" href="#ukwa-categories-carousel" data-slide="next">
                            <i class="fa fa-chevron-right" aria-hidden="true"></i>
                        </a>

                        <!-- Indicators -->
                        <ol class="carousel-indicators list-inline">
                            <li class="list-inline-item active">
                                <a id="carousel-selector-0" class="selected" data-slide-to="0" data-target="#ukwa-categories-carousel">
                                    <img src="https://dummyimage.com/600x400/000/fff" class="img-fluid">
                                </a>
                            </li>

                            <li class="list-inline-item">
                                <a id="carousel-selector-1" data-slide-to="1" data-target="#ukwa-categories-carousel">
                                    <img src="https://dummyimage.com/600x400/000/fff" class="img-fluid">
                                </a>
                            </li>

                            <li class="list-inline-item">
                                <a id="carousel-selector-2" data-slide-to="2" data-target="#ukwa-categories-carousel">
                                    <img src="https://dummyimage.com/600x400/000/fff"  class="img-fluid">
                                </a>
                            </li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>





        <div class="accordion padding-top-80" id="accordionExample">
            <div class="card">
                <div class="card-header" id="headingOne">
                    <h2 class="mb-0">
                        <button class="btn btn-link btn-block text-left" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Category: Science Technology and Medicine
                        </button>
                    </h2>
                </div>

                <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                    <div class="card-body">
                        <ul>
                            <c:forEach items="${itemsOfCategories}" var="itemOfCategories">

                                <li class="padding-bottom-10">
                                    <a href="collection/1090" class="collection-link" >
                                        <c:out value="${itemOfCategories}"/>
                                    </a>
                                </li>

                            </c:forEach>
                        </ul>                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header" id="headingTwo">
                    <h2 class="mb-0">
                        <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            Category: Politics and Government
                        </button>
                    </h2>
                </div>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                    <div class="card-body">
                        <ul>
                            <c:forEach items="${itemsOfCategories}" var="itemOfCategories">

                                <li class="padding-bottom-10">
                                    <a href="collection/1090" class="collection-link" >
                                        <c:out value="${itemOfCategories}"/>
                                    </a>
                                </li>

                            </c:forEach>
                        </ul>

                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="headingThree">
                    <h2 class="mb-0">
                        <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                            Category: History
                        </button>
                    </h2>
                </div>
                <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
                    <div class="card-body">
                        <c:forEach items="${itemsOfCategories}" var="itemOfCategories">
                            <div>
                                <a href="collection/1090" class="collection-link" >
                                    <c:out value="${itemOfCategories}"/>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>







    </section>

    <footer class="footer-content">
        <%@include file="footer.jsp" %>
    </footer>
</div>
<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_about").addClass('active');



    });


</script>
</body>
</html>