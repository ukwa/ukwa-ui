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
<jsp:useBean id="alphabetSet" scope="request"  type="java.util.HashSet<java.lang.Character>"/>
<jsp:useBean id="listOfAlphabetical" scope="request"  type="java.util.List<java.util.HashSet<java.lang.Character>>"/>

<jsp:useBean id="random" class="java.util.Random" scope="application" />
<jsp:useBean id="collCountList" class="java.util.ArrayList"/>


<html lang="${locale}">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title>
        <spring:message code="categories.header.title" />
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
                                            <h4>Current status: available</h4>
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



<%-- category items - collections --%>
<div class="container category-items" style="display:none;">
    <div class="blue border-dark" role="group" aria-label="...">

        <div class="row bg-dark py-3">
            <div class="col-4">
                <div class="list-group" id="list-tab" role="tablist">

                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto category-item-card-frame" id="list-category-list" data-toggle="list" href="#list-category-list" role="tab" aria-controls="profile">

                        <article class="text-left">
                            <h2 id="current_top_coll_h2">Category Title</h2>
                            <h4 id="current_top_coll_h4">Category: Description</h4>
                        </article>
                        <img id="current_top_coll_image" src="img/categories/2941.png" alt="">


                    </div>
                    <%--        search field --%>
                    <div class="category-search-search-field py-3 px-1 mx-1 bg-dark">
                        <div class="row align-content-center">
                            <div class="col py-3">
                                <p id="current_top_coll_p" class="text-muted small align-items-end">Last updated 3 days ago</p>

                                <div class="container white py-5">
                                    <h2><i class="fas fa-chart-pie mr-2"></i></i>Category stats</h2>
                                    <h3 id="cat-coll-count" class="ml-3">0 coll<small class="text-muted">/ cat</small></h3>

                                    <ul class="list-group bg-dark rounded border border-light mb-2 py-3" id="CategoryList2">
                                        <li class="list-group-item d-inline-flex justify-content-between align-items-center white bg-dark"><div>Common Collections: </div><span class='align-items-end badge badge-primary'>2</span></li>
                                        <div class="badge badge-primary ml-3 my-2" style="width: 6rem;">
                                            Brexit
                                        </div>
                                        <div class="badge badge-primary ml-3" style="width: 6rem;">
                                            Global UK
                                        </div>
                                    </ul>
                                </div>
                                <a class="align-self-end btn btn-lg btn-block btn-secondary category-item-card-frame-button rounded-pill white">Back to Categories</a>
                            </div>

                        </div>

                    </div>

                </div>


            </div>
            <div class="col-8">
                <%-- search by alphabet && MINI menu--%>
                <div class="category-search-searchbar p-2 my-1 bg-dark">
                    <div class="row py-2 px-3">
                        <div class="col">
                            <div class="text-bigger white">Discover Topics by category</div>
                        </div>
                    </div>
                    <div class="row py-2 px-3">
                        <div class="col">
                            <div class="btn-group" role="group" aria-label="Basic example">
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">Science</button>
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">Sport</button>
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">History</button>
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">Politics</button>
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">Arts</button>
                                <button type="button" class="btn btn-secondary rounded-pill mr-1">Places</button>
                                <button type="button" class="btn btn-secondary rounded-pill">Society</button>
                            </div>
                        </div>
                    </div>
                    <div class="row py-3 px-3">
                        <div class="col">
                            <div class="text-bigger white">Discover Topics alphabetically</div>
                        </div>
                    </div>
                    <div class="row px-3">
                        <div class="col">
                            <nav aria-label="Search within category navigation">
                                <ul class="pagination justify-content-start">

                                    <c:forEach var="alphabetItem" items="${alphabetSet}" varStatus="theCountAlphab">
                                        <li class="alphabetic-page-item"><a class="page-link">
                                            <c:out value="${alphabetItem.charValue()}"/></a></li>
                                    </c:forEach>

                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="row px-3">
                        <div class="col d-inline-flex align-items-center">
                            <span class="fas fa-search fa-2x red"></span>
                            <input id="cat-search-input" type="text" name="" value="" class=" category-collection-search-input mb-2 text-big bg-dark gray" placeholder="Filter a Topic" style="margin-left: 0.5rem;  padding-left: 1rem;border-color: red; -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 5px darkred; box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 2px red;  border-radius: 20px; -moz-border-radius: 20px; -webkit-border-radius: 20px; overflow: hidden; -webkit-backface-visibility: hidden; -webkit-transform: translate3d(0, 0, 0);"/>
                        </div>
                    </div>
                </div>

                    <div class="tab-content" id="nav-tabContent">

                        <c:forEach var="topcategory" items="${listOfMapsOfItemsOfCategories3}" varStatus="theCount">
                            <c:forEach var="category" items="${topcategory}" varStatus="theCount2">
                                <c:set var="noUse" value="${collCountList.add(category.value.entrySet().size())}"/>
                                <div class="tab-pane fade show top-collection-list" id="top-collection-list-${category.key}" role="tabpanel" aria-labelledby="list-home-list">

                                    <ul id="cat-search-items" class="list-group bg-dark">
                                        <c:forEach var="collection" items="${category.value}">
                                            <li class="padding-bottom-10  list-group-item border-0 bg-gray">


                                                <div class="row border-bottom">
                                                    <div class="media">
                                                        <svg class="mr-3 bd-placeholder-img" width="160" height="120" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 320x240" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6c757d"/><text x="20%" y="50%" fill="#dee2e6" dy=".3em">160x120</text></svg>

                                                        <div class="media-body">
                                                            <div class="row">
                                                                <div class="col-12 category-collection-search-result-ul">

                                                                    <a href="collection/<c:out value="${collection.key}"/>" class="collection-link">
                                                                        <h5 class="mt-0"><c:out value="${collection.value.name}"/></h5>
                                                                    </a>
                                                                </div>

                                                            </div>

                                                            <p class="text-justify text-muted small overflow-auto" style="height: 6.2em;"><c:out value="${collection.value.description}"/></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>

                                </div>



                            </c:forEach>
                        </c:forEach>

                    </div>

            </div>
        </div>




    </div>


<%-- search within category --%>

    <div class="row padding-top-10">
        <div class="col-4">

        </div>

        <%--   START: list of collection for spacific category     --%>
        <div class="col-6">
        </div>
        <%--   END: list of collection for spacific category     --%>

    </div>

</div>
    <%-- category items --%>



    <footer class="footer-content">
        <%@include file="footer.jsp" %>
    </footer>
</div>
<%--container-fluid--%>




<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_categories").addClass('active');


        $("#cat-search-input").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#cat-search-items li").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });

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
                case '2938':
                    text_h2 = "Science, Technology & Medicine";
                    arrayIndex = 0; //ok
                    break;
                case '2939':
                    text_h2 = "Sport & Recreation";
                    arrayIndex = 1; //ok
                    break;
                case '2940':
                    text_h2 = "History";
                    arrayIndex = 2; //ok
                    break;
                case '2941':
                    text_h2 = "Politics & Government";
                    arrayIndex = 3;
                    break;
                case '2942':
                    text_h2 = "Arts & Culture";
                    arrayIndex = 4; //22
                    break;
                case '2943':
                    text_h2 = "Places";
                    arrayIndex = 5; //ok

                    break;
                case '2944':
                    text_h2 = "Society & Communities";
                    arrayIndex = 6; //ok 31!
                    break;
                case '2945':
                    text_h2 = "Currently Working On";
                    arrayIndex = 7;
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


            $("#cat-coll-count").html(array[arrayIndex] + ' collections<small class="text-muted">/ category</small>');

            $("#current_top_coll_h4").html('Description');
//            $("#current_top_coll_h2").html(<c:out value="${categoriesHashMap.get(identifier).value}"/>);
//            $("#current_top_coll_h4").html(<c:out value="${categoriesHashMap.get(identifier).value}"/>);

            $('#top-collection-list-'+previous_id).removeClass("active");
            $('#top-collection-list-'+current_id).addClass("active");

            // $('#top-collection-grid-list-'+previous_id).removeClass("active");
            // $('#top-collection-grid-list-'+current_id).addClass("active");


            $(".categories-cards").toggle();
            $(".category-items").toggle();

            previous_id = current_id;
        });

        $(".category-item-card-frame, .category-item-card-frame-button, .page-link").on('click', function(event){
            $(".categories-cards").toggle();
            $(".category-items").toggle();
        });



    });

</script>

</body>
</html>
