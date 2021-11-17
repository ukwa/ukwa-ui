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
<jsp:useBean id="listOfMapsOfItemsOfCategories3" scope="request" type="java.util.List<java.util.HashMap<java.lang.String, java.util.HashMap<java.lang.String, com.marsspiders.ukwa.controllers.data.CollectionDTO>>>"/>

<jsp:useBean id="random" class="java.util.Random" scope="application" />

<jsp:useBean id="collCountList" class="java.util.ArrayList"/>
<c:set var="noUse" value="${collCountList.add('YourThing')}"/>

<html>
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title>
        <spring:message code="categories.header.title" />
    </title>
    <%@include file="head.jsp" %>
</head>

<body data-spy="scroll" data-target="#myScrollspy" data-offset="50">
<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>

    <spring:message code='main.menu.categories' var="title"/>
    <%@include file="title.jsp" %>




<div class="row margin-0 padding-side-20">
    <div class="col-lg-6 col-md-8 offset-md-1 col-md-offset-1 col-sm-12 header-2-subtitle padding-side-10"><spring:message code="coll.subtitle" /></div>

    <div class="col-lg-2 offset-lg-3 col-lg-offset-3 col-md-2 offset-md-1 col-md-offset-1 col-sm-12 right padding-top-mobile-20">
        <img title="coll.thumbs" alt="coll.thumbs" class="collections-display" id="btn_thumbs" src="img/icons/icn_grid.png" tabindex="0"/>
        <img title="coll.list" alt="coll.list" class="collections-display" id="btn_list" src="img/icons/icn_list.png" tabindex="0"/>
    </div>
</div>

    <%-- category top level cards --%>
<div class="text-center categories-cards">
    <h1 class="text-center">Browse Categories</h1>

        <div class="container">
            <div class="row hidden-md-up justify-content-start">
                    <c:forEach var="topLevelCategoriesList" items="${listOfMapsOfItemsOfCategories3}" varStatus="count">
                        <c:forEach var="category" items="${topLevelCategoriesList.entrySet()}" >
                            <div class="col-md-4">

                                <div id="${category.key}" class="card mb-2 col-lg-4 col-md-4 col-sm-6 container_foto top-category-card">
                                    <div class="card-block">
                                        <div class="ver_mas text-center">
                                            <span  class="lnr lnr-eye"></span>
                                        </div>
                                        <img class="card-img-top img-fluid" src="img/categories/<c:out value="${category.key}"/>.png" alt="<c:out value="${category.key}"/>">
                                        <article class="text-left">
                                            <h2><spring:message code="category.title.${category.key}" /></h2>
                                            <h4>Description...<spring:message code="category.title.${category.key}" /> </h4>
                                        </article>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:forEach>
        </div>



        </div>
</div>
    <%-- category top level cards --%>

<%-- category items --%>
<div class="container category-items" style="display:none;">
    <div class="blue border-dark" role="group" aria-label="...">

    <div class="row">
        <div class="col-md-4 right">
            <p class="category-collection-search-title text-bigger">Alphabetical Search</p>
        </div>
        <div class="col-md-8 ">
            <nav aria-label="Search within category navigation">
                <ul class="pagination justify-content-start">

                    <li class="alphabetic-page-item"><a class="page-link" >B</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >C</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >D</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >E</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >O</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >P</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >Q</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >R</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >S</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >T</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >U</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >V</a></li>
                    <li class="alphabetic-page-item"><a class="page-link" >W</a></li>

                </ul>
            </nav>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 right">
            <p class="main-heading-2-bold-redesign category-collection-search-title text-bigger">Topics & Themes Availability</p>
        </div>
        <div class="col-md-4 category-collection-search-input-container border bg-gray2 gray rounded d-inline-flex align-items-center">
            <span class="fas fa-search"></span>
            <input type="text" name="" value="" class="border-0 category-collection-search-input form-control bg-gray2" placeholder="Search for a Topic or Theme..." />
        </div>
    </div>
    </div>


    <div class="row padding-top-10">
        <div class="col-4">
            <div class="list-group" id="list-tab" role="tablist">

                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto category-item-card-frame" id="list-category-list" data-toggle="list" href="#list-category-list" role="tab" aria-controls="profile">

                    <article class="text-left">
                        <h2 id="current_top_coll_h2">Category Title</h2>
                        <h4 id="current_top_coll_h4">Category: Description</h4>
                    </article>
                    <img id="current_top_coll_image" src="img/categories/2941.png" alt="">
                </div>
                <p id="current_top_coll_p" class="text-muted small">Last updated 3 days ago</p>
                <h1 id="cat-coll-count" class="card-title pricing-card-title">0 coll<small class="text-muted">/ cat</small></h1>
                <ul class="list-unstyled mt-3 mb-4">
                    <li>238 sites included</li>
                    <li>45 active connections</li>
                </ul>
                <div class="container">
                    <h3>Category stats</h3>
                    <ul class="list-group" id="CategoryList2">
                        <li class="list-group-item d-inline-flex justify-content-between align-items-center"><div>Other Collections: </div><span class='align-items-end badge badge-primary'>2</span></li>
                        <li class="list-group-item d-inline-flex justify-content-between align-items-center"><div>Shared Collections: </div><span class='align-items-end badge badge-primary'>3</span></li>
                    </ul>
                </div>
                <a class="align-self-end btn btn-lg btn-block btn-primary category-item-card-frame-button">Go Back</a>

            </div>
        </div>

        <%--   START: list of collection for spacific category     --%>
        <div class="col-6">
            <div class="tab-content" id="nav-tabContent">

                <c:forEach var="topcategory" items="${listOfMapsOfItemsOfCategories3}" varStatus="theCount">
                    <c:forEach var="category" items="${topcategory}" varStatus="theCount2">
                        <c:set var="noUse" value="${collCountList.add(category.value.entrySet().size())}"/>
                        <div class="tab-pane fade show top-collection-list" id="top-collection-list-${category.key}" role="tabpanel" aria-labelledby="list-home-list">

                            <ul class="list-group">
                            <c:forEach var="collection" items="${category.value}">
                            <li class="padding-bottom-10  list-group-item border-0 d-inline-flex justify-content-between align-items-center">
                                <div class="category-collection-search-result-ul">
                                    <a href="collection/<c:out value="${collection.key}"/>" class="collection-link ">
                                        <c:out value="${collection.value.name}"/>
                                    </a>
                                </div>
                                <div class="category-collection-search-result-ul align-items-end">&nbsp;<span class='badge badge-primary'><c:out value="${random.nextInt(100)}"/></span></div>
                                <div class="category-collection-search-result-ul align-items-end">&nbsp;<i class="fa fa-info-circle category-search-popover" aria-hidden="true" data-toggle="popover" title="Popover title" data-content="<c:out value="${collection.value.description}"/>"></i></div>
                            </li>
                            </c:forEach>
                            </ul>

                        </div>
                    </c:forEach>
                </c:forEach>

            </div>
        </div>
        <%--   END: list of collection for spacific category     --%>

    </div>

</div>
    <%-- category items --%>




<%-- List - Grid--%>
<div class="container p-4 category-item-grid" style="display:none;">
    <div class="row">
        <div class="col-12">
            <div class="btn-group float-right">
                <div class="btn-group btn-group-toggle" data-toggle="buttons">
                    <label id="list" class="btn btn-outline-dark active">
                        <input type="radio" name="layout" id="layout1" checked> List
                    </label>
                    <label id="grid" class="btn btn-outline-dark">
                        <input type="radio" name="layout" id="layout2"> Grid
                    </label>
                </div>
            </div>
        </div>
    </div>
    <c:forEach var="topcategory" items="${listOfMapsOfItemsOfCategories3}" varStatus="theCount">
        <c:forEach var="category" items="${topcategory}" varStatus="theCount2">
            <div id="top-collection-grid-list-${category.key}" class="row mt-4">

                <c:forEach var="collection" items="${category.value}">

                    <div class="item col-12 mb-3">
                        <div class="card rounded shadow border-0">
                            <a href="#">
                                <img class="w-100 d-none" style="height: 300px; object-fit: cover; border-top-right-radius: 5px; border-top-left-radius: 5px;" src="https://images.unsplash.com/photo-1572376313139-2d2c6ff7de20?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=648&q=80" alt="" />
                            </a>
                            <div class="card-body p-3">
                                <a href="#" class="text-dark"><h4><c:out value="${collection.value.name}"/></h4></a>
                                <p class="text-muted small">Last updated 3 days ago</p>
                                <p><c:out value="${collection.value.description}"/></p>
                                <a href="collection/<c:out value="${collection.key}"/>" class="btn btn-dark" >
                                    Read more
                                </a>
                            </div>
                        </div>
                    </div>

                </c:forEach>

            </div>
        </c:forEach>
    </c:forEach>

</div>

</div>
<%--container-fluid--%>


<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<script>
    $(document).ready(function(e) {


            $('.category-search-popover').popover({
                container: 'body'
            })

        //<c:set var="categoryListSize" value="${collCountList.get(2)}" />
        var array = new Array();
        <c:forEach items="${collCountList}" var="item">
        array.push("${item}");
        </c:forEach>




        var previous_id = null;
        var arrayIndex = 0;

        $(".top-category-card").on('click', function(event){

            console.log('previous_id = ', previous_id);

            var current_id = $(this).attr('id');
            console.log('current_id = ', current_id);

            $('#current_top_coll_image').attr('src','img/categories/'+current_id+'.png');

            var text_h2 = 'Title';

            //TODO: make dynamic
            switch(current_id) {
                case '2940':
                    text_h2 = "History";
                    arrayIndex = 3; //ok
                    break;
                case '2941':
                    text_h2 = "Politics & Government";
                    arrayIndex = 7;
                    break;
                case '2942':
                    text_h2 = "Arts & Culture";
                    arrayIndex = 4;
                    break;
                case '2943':
                    text_h2 = "Places";
                    arrayIndex = 6; //ok

                    break;
                case '2944':
                    text_h2 = "Society & Communities";
                    arrayIndex = 7;

                    break;
                case '2945':
                    text_h2 = "Currently Working On";
                    arrayIndex = 0;

                    break;
                case '2938':
                    text_h2 = "Science, Technology & Medicine";
                    arrayIndex = 1; //ok

                    break;
                case '2939':
                    text_h2 = "Sport & Recreation";
                    arrayIndex = 2; //ok

                    break;
                default:
                    text_h2 = 'Category'
                    arrayIndex = 0;

            }

            $("#current_top_coll_h2").html(text_h2);
            $("#current_top_coll_p").html("Last updated 3 days ago");

            var commonColl = 3;


            <%--            <c:if test="${ current_id  == '2938'}">--%>
<%--            $("#current_top_coll_h2").html(<spring:message code='category.title.2938' var="title"/>);--%>
<%--            </c:if>--%>
<%--            <c:if test="${ current_id  == '2939'}">--%>
<%--            $("#current_top_coll_h2").html('Sport & Recreation');--%>
<%--            </c:if>--%>


            $("#cat-coll-count").html(array[arrayIndex] + ' coll<small class="text-muted">/ cat</small>');

            $("#current_top_coll_h4").html('Description');
//            $("#current_top_coll_h2").html(<c:out value="${categoriesHashMap.get(identifier).value}"/>);
//            $("#current_top_coll_h4").html(<c:out value="${categoriesHashMap.get(identifier).value}"/>);

            $('#top-collection-list-'+previous_id).removeClass("active");
            $('#top-collection-list-'+current_id).addClass("active");

            // $('#top-collection-grid-list-'+previous_id).removeClass("active");
            // $('#top-collection-grid-list-'+current_id).addClass("active");


            $(".categories-cards").toggle();
            $(".category-items").toggle();
            $(".category-item-grid").toggle();

            previous_id = current_id;
        });

        $(".category-item-card-frame, .category-item-card-frame-button, .page-link").on('click', function(event){
            $(".categories-cards").toggle();
            $(".category-items").toggle();
            $(".category-item-grid").toggle();
        });

        $('#list').click(function(event){
            event.preventDefault();
            $('#posts .item').addClass('col-12');
            $('#posts img').addClass('d-none');
            $('#grid').removeClass('active');
            $('#list').addClass('active');
        });

        $('#grid').click(function(event){
            event.preventDefault();
            $('#posts .item').removeClass('col-12');
            $('#posts .item').addClass('col-4');
            $('#posts img').removeClass('d-none');
            $('#list').removeClass('active');
            $('#grid').addClass('active');
        });

        $('input[type="text"]').keyup(function(){
            var searchText = $(this).val().toUpperCase();
            $('.category-collection-search-result-ul > a, .category-collection-search-result-ul > i, .category-collection-search-result-ul > span').each(function(){
                var currentLiText = $(this).text().toUpperCase(),
                    showCurrentLi = currentLiText.indexOf(searchText) !== -1;
                if(showCurrentLi){
                    $(this).addClass('category-collection-in').removeClass('category-collection-out');
                }else{
                    $(this).addClass('category-collection-out').removeClass('category-collection-in');
                }
            });
        });
    });

</script>

</body>
</html>
