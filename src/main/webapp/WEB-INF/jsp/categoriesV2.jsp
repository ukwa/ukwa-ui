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

    <div class="row mb-4 white left bg-secondary">
            <div class="col-12 w-100 form-inline inline-block-items flex-nowrap">
                <input role="textbox" type="text" name="text" id="text"
                       title="<spring:message code="search.main.input.title" />"
                       aria-label="<spring:message code="search.main.input.title" />"
                       placeholder="Filter categories"
                       class="main-search-field-redesign" value="${originalSearchRequest}" required tabindex="0"
                       aria-required="true"/>
                <button role="button" type="submit" class="btn btn-lg main-search-button h-100 w-auto align-items-center"
                        title="<spring:message code="search.main.button.title" />">
                    <span class="d-none d-md-block align-middle">Filter</span>
                    <i class="fa fa-filter ml-2" aria-hidden="true"></i>
                </button>
            </div>
    </div>

    <div class="row row-cols-md-2">

        <%-- All Collections - 1 only --%>


        <c:forEach var="topLevelCategoriesList" items="${listOfMapsOfItemsOfCategories3}" varStatus="count">
            <c:forEach var="category" items="${topLevelCategoriesList.entrySet()}">

                <div class="col mb-4">
                    <div id="id_${category.key}" class="card mb-3 collection_list_8 top-category-card-2" style="min-width: 17rem;">
                        <img class="card-img-top" src="img/categories/<c:out value="${category.key}"/>.png" alt="<c:out value="${category.key}"/>" style="filter: grayscale(80%);">

                        <div class="card-body">
                            <div class="card-title"><spring:message code="category.title.${category.key}" />

                            </div>
<%--                            <a href="#" class="stretched-link"></a>--%>
                        </div>


                    </div>
                </div>

            </c:forEach>
        </c:forEach>

    </div>


    <hr class="my-5">

<%--    <div class="d-flex flex-wrap collections-items-2prow">--%>

<%--            <c:forEach var="category" items="${listOfMapsOfItemsOfCategories3.get(0)}" varStatus="theCount2">--%>
<%--                <c:set var="noUse" value="${collCountList.add(category.value.entrySet().size())}"/>--%>
<%--                        <c:forEach var="collection" items="${category.value}">--%>

<%--                            <div class="media w-50 p-4">--%>
<%--                                <svg class="mr-3 bd-placeholder-img" width="160" height="120" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 320x240" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6c757d"/><text x="20%" y="50%" fill="#dee2e6" dy=".3em">160x120</text></svg>--%>

<%--                                <div class="media-body">--%>
<%--                                    <div class="row">--%>
<%--                                        <div class="col-12 category-collection-search-result-ul">--%>

<%--                                            <a href="collection/<c:out value="${collection.key}"/>" class="collection-link">--%>
<%--                                                <h5 class="mt-0"><c:out value="${collection.value.name}"/></h5>--%>
<%--                                            </a>--%>
<%--                                        </div>--%>

<%--                                    </div>--%>

<%--                                    <p class="text-justify text-muted small overflow-auto" style="height: 6.2em;"><c:out value="${collection.value.description}"/></p>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </c:forEach>--%>
<%--            </c:forEach>--%>


<%--    </div>--%>

    <div class="tab-content " id="nav-tabContent">

        <c:forEach var="topcategory" items="${listOfMapsOfItemsOfCategories3}" varStatus="theCount">
            <c:forEach var="category" items="${topcategory}" varStatus="theCount2">
                <c:set var="noUse" value="${collCountList.add(category.value.entrySet().size())}"/>
                <div class="tab-pane fade show top-collection-list " id="top-collection-list-2-id_${category.key}" role="tabpanel" aria-labelledby="list-home-list">

                    <ul id="cat-search-items-2" class="list-group">
                        <div class="d-flex flex-wrap collections-items-2prow">

                        <c:forEach var="collection" items="${category.value}">

                            <li class="padding-bottom-10  list-group-item border-0 bg-gray w-50 ">


                                    <div class="media p-4">
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
                            </li>

                        </c:forEach>
                        </div>

                    </ul>

                </div>



            </c:forEach>
        </c:forEach>

    </div>


<%-- category top level cards --%>
    <%-- category top level cards --%>



<%-- category items - collections --%>
<div class="container category-items" style="display:none;">
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

        var previous_2_id = null;

        var arrayIndex = 0;

        $(".top-category-card-2").on('click', function(event) {

            console.log('previous_2_id = ', previous_2_id);

            var current_2_id = $(this).attr('id');
            console.log('current_2_id = ', current_2_id);

            $('#top-collection-list-2-'+previous_2_id).removeClass("active");
            $('#top-collection-list-2-'+current_2_id).addClass("active");

            previous_2_id = current_2_id;
        });

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

            //
            //
            // $('.collection_list_8').on('click', function () {
            //     $(this).parent().addClass('active');
            //
            //
            // });
            //
            // $('.collection_list_8').on('click', function () {
            //     $(this).parent().removeClass('active');
            // });



    });

</script>

</body>
</html>
