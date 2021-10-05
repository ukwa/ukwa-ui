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
<jsp:useBean id="categoriesList" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="listOfMapsOfItemsOfCategories" scope="request" type="java.util.List<java.util.HashMap<java.lang.String, java.lang.String>>"/>



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

            <div class="row justify-content-end">
                <!--Grid row-->
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">

                        <li class="page-item"><a class="page-link" href="#">A</a></li>
                        <li class="page-item"><a class="page-link" href="#">B</a></li>

                        <li class="page-item"><a class="page-link" href="#">C</a></li>
                        <li class="page-item"><a class="page-link" href="#">D</a></li>
                        <li class="page-item"><a class="page-link" href="#">E</a></li>
                        <li class="page-item"><a class="page-link" href="#">F</a></li>
                        <li class="page-item"><a class="page-link" href="#">G</a></li>
                        <li class="page-item"><a class="page-link" href="#">H</a></li>
                        <li class="page-item"><a class="page-link" href="#">I</a></li>
                        <li class="page-item"><a class="page-link" href="#">J</a></li>
                        <li class="page-item"><a class="page-link" href="#">K</a></li>

                        <li class="page-item"><a class="page-link" href="#">L</a></li>
                        <li class="page-item"><a class="page-link" href="#">M</a></li>
                        <li class="page-item"><a class="page-link" href="#">N</a></li>
                        <li class="page-item"><a class="page-link" href="#">O</a></li>
                        <li class="page-item"><a class="page-link" href="#">P</a></li>
                        <li class="page-item"><a class="page-link" href="#">Q</a></li>
                        <li class="page-item"><a class="page-link" href="#">R</a></li>
                        <li class="page-item"><a class="page-link" href="#">S</a></li>
                        <li class="page-item"><a class="page-link" href="#">T</a></li>
                        <li class="page-item"><a class="page-link" href="#">U</a></li>
                        <li class="page-item"><a class="page-link" href="#">V</a></li>
                        <li class="page-item"><a class="page-link" href="#">W</a></li>
                        <li class="page-item"><a class="page-link" href="#">X</a></li>
                        <li class="page-item"><a class="page-link" href="#">Y</a></li>
                        <li class="page-item"><a class="page-link" href="#">Z</a></li>

                    </ul>
                </nav>
            </div>
            <div class="row justify-content-end">

                <!--Grid column-->
                <div class="col-md-6 mb-4">

                    <div class="table-responsive shadow p-3 mb-5 bg-light rounded">
                        <table id="grid" class="table table-hover sortable">
                            <thead class="thead-dark">
                            <tr>
                                <th data-type="string">Sort by:</th>
                                <th data-type="string"></i>Name:<i class="fas fa-sort text-right"/></th>
                                <th data-type="number"></i>Sub collections size<i class="fas fa-sort text-right"/>:</th>
                            </tr>

                            </thead>
                        </table>
                    </div>

                </div>
                <!--Grid column-->
                <!--Grid column-->
                <div class="col-md-6 mb-4 align-baseline">

                    <!-- Search form -->
                    <form class="form-inline">
                        <i class="fas fa-search" aria-hidden="true"></i>
                        <input class="form-control form-control-sm ml-3 w-75" type="text" placeholder="Search" aria-label="Search">
                    </form>

                </div>
                <!--Grid column-->
            </div>
        </div>

        <div class="accordion" id="accordionExample">

            <c:forEach items="${categoriesList}" var="categoriesList" varStatus="theCount">


                    <div class="card">
                    <div class="card-header">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse${theCount.count}" aria-expanded="false" aria-controls="collapse${theCount.count}">
                                <c:out value="${categoriesList}"/>
                            </button>
                        </h2>
                    </div>
                    <div id="collapse${theCount.count}" class="collapse" aria-labelledby="heading${theCount.count}" data-parent="#accordionExample">
                        <div class="card-body">
                            <ul>
                                <c:forEach var="entry" items="${listOfMapsOfItemsOfCategories.get(theCount.count-1)}">
                                    <li class="padding-bottom-10">
                                        <a href="collection/<c:out value="${entry.value}"/>" class="collection-link" >
                                            <c:out value="${entry.key}"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>

            </c:forEach>

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
