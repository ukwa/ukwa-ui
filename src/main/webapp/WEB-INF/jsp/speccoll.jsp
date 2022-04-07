<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="locale">${pageContext.response.locale}</c:set>
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
    <spring:message code="coll.title" />
</title>
<%@include file="head.jsp" %>
</head>


<body>

<c:set var = "category" value = "true"/>

<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
  </header>

<spring:message code='coll.main.heading' var="title"/>
<%@include file="title.jsp" %>

    <c:set var="categoryPlaceHolderVar" value="Filter within All Categories" />

    <div>
        <div id="someDOMReference" class="row mb-1 center">

        </div>
    </div>


    <%-- filter button for collections --%>
    <div class="row mb-1 center">
        <div class="col-sm-11 col-md-12 col-lg-offset-2 col-lg-11 ml-lg-3 ml-md-3 ml-sm-3  form-inline inline-block-items flex-nowrap">
            <input role="textbox" type="search" name="text" id="cat-search-input"
                   title="<spring:message code="categories.filter.input.title" />"
                   aria-label="<spring:message code="categories.filter.input.title" />"
                   placeholder="<spring:message code="categories.filter.input.title" />"
                   class="main-search-field-redesign" value="${originalSearchRequest}" required tabindex="0"
                   aria-required="true"/>
        </div>
        <div>
            <label for="cat-search-input" id="catInfo" class="pl-lg-5 pl-sm-5 pl-md-5 pt-lg-3 col-lg-12 col-md-12 col-sm-12 header-2-subtitle-redesign align-content-start text-wrap">&nbsp</label>
        </div>

    </div>

    <%-- search results --%>
    <div class="row">
        <div class="pl-lg-5 pl-sm-5 pl-md-5 pt-lg-3 pb-lg-5 col-lg-12 col-md-12 col-sm-12 header-2-subtitle-redesign align-content-start text-wrap" id="cat-filter-results"></div>
    </div>

    <%-- category top level cards --%>
    <div class="row" tabindex="-1">

        <%-- All Collections --%>

        <c:forEach var="topLevelCategoriesList" items="${listOfMapsOfItemsOfCategories3}" varStatus="count">
            <c:forEach var="category" items="${topLevelCategoriesList.entrySet()}">

                <div class="col-lg-3 col-md-6 col-sm-12 top-category-card" tabindex="-1" aria-label="Main List of Categories">
                    <div id="id_${category.key}" class="card mb-4 ml-3 mr-3 top-category-card-v2 fast-transition align-items-center" tabindex="0">
                        <img class="card-img-top center" id="id_image_id_${category.key}" src="img/categories/<c:out value="${category.key}"/>.png" alt="<c:out value="${category.key}"/>">

                        <div class="card-img-overlay cursor-pointer" >
                            <div class="card-footer">
                                <div class="text-uppercase bold" style="color: white!important; text-shadow: 1px 1px 2px black, 3px 3px 25px black, 2px 2px 15px black;position:absolute;bottom:2px;left:5px;"><spring:message code="category.title.${category.key}" /></div>
                                <c:set var="categoryPlaceHolderVar">
                                    <spring:message code="category.title.${category.key}" />
                                </c:set>
                            </div>

<%--                                                            <a href="#" class="stretched-link" target="_blank"></a>--%>
                        </div>

                    </div>
                </div>


            </c:forEach>
        </c:forEach>

    </div>

<%-- category collections list  --%>
    <div class="tab-content" id="nav-tabContent">

        <c:forEach var="topcategory" items="${listOfMapsOfItemsOfCategories3}" varStatus="theCount">
            <c:forEach var="category" items="${topcategory}" varStatus="theCount2">
                <c:set var="noUse" value="${collCountList.add(category.value.entrySet().size())}"/>
                <div class="tab-pane fade show top-collection-list mt-5" id="top-collection-list-2-id_${category.key}" role="tabpanel" aria-labelledby="list-home-list">

                    <ul id="cat-search-items-2" class="list-group">
                        <div class="row collections-items-2prow ml-0 mr-1" id="tabContent">

                            <c:forEach var="collection" items="${category.value}">

                                <li class="list-group-item col-lg-6 col-md-6 col-sm-12">

                                    <div class="media">
                                        <a href="collection/<c:out value="${collection.key}"/>" class="collection-link">
                                            <img style="width:160px;height:auto;" alt="<c:out value="${collection.value.name}"/>" src="img/collections/collection_<c:out value="${collection.key}"/>.png"/>
                                        </a>
                                        <div class="ml-3 media-body">
                                            <div class="row">
                                                <div class="col-12 category-collection-search-result-ul">
                                                    <a href="collection/<c:out value="${collection.key}"/>" class="collection-link">
                                                        <h5><c:out value="${collection.value.name}"/></h5>
                                                    </a>
                                                </div>
                                            </div>

                                            <div id="colmodule" class="collection-descr" >
                                                <p id="collapseCollection-<c:out value="${collection.key}"/>" class="collapse text-justify text-muted small col-descr" data-content="crappy 4" aria-expanded="false"><c:out value="${collection.value.description}"/></p>
                                                <a role="button" data-content="<spring:message code="categories.filter.results.showmore" />" class="collapsed showmoreless" data-toggle="collapse" href="#collapseCollection-<c:out value="${collection.key}"/>" aria-expanded="false" aria-controls="collapseCollection-<c:out value="${collection.key}"/>"></a>
                                            </div>

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

    <%-- description --%>
    <div class="row my-3">
        <div class="p-lg-5 col-lg-12 col-md-12 col-sm-12 header-2-subtitle align-content-center text-wrap"><spring:message code="coll.subtitle" /></div>
    </div>

<footer class="footer-content">
  <%@include file="footer.jsp" %>
</footer>
</div>

<script>



    $(document).ready(function(e) {

        let $menuItems = $('.header-menu-item');

        let current_2_id = 'id_2222';
        let listIndex=0; // for 'id_2222' - All Collections
        let items_length = $("#top-collection-list-2-id_2222").find("li").length;
        let items_in_current = items_length;

        $.ajax({
            type: 'get',
            url: '/${locale}/ukwa/category/gettransplaceholderfull/${locale}/'+current_2_id.substring(3)+'/'+items_length,
            success: function(data) {
                $('#catInfo').text(data);
            }
        });

        var onclick_category = false;
        var previous_2_id = null;

        $('#top-collection-list-2-'+current_2_id).addClass("active");
        $('#id_image_'+current_2_id).addClass('border border-danger fast-transition-2');

    $menuItems.removeClass('active');
    $("#headermenu_categories").addClass('active');

        $("#cat-search-input").on("input", function() {

            setTimeout(function(){
                let searchValue = $("#cat-search-input").val();

                if( jQuery.trim(searchValue).length > 0 ){ //searchValue == $('#cat-search-input').val() && searchValue !== "") {
                    // logic to fetch data based on searchValue

                    $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li').filter(function() {
                        items_length = $(this).length;
                        //console.log("--- items_length 1 = ", items_length, ' when previous_2_id = ', previous_2_id);
                        return $(this).text().toLowerCase().indexOf(searchValue.toLowerCase()) !== -1;
                    }).show();

                    items_length = $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li:visible').length;

                    $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li').filter(function() {
                        return $(this).text().toLowerCase().indexOf(searchValue.toLowerCase()) === -1;
                    }).hide();

                    items_length = $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li:visible div.media-body .col-descr').length;
                    $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li:visible div.media-body .col-descr').each(function () {
                        let currentLiText = $(this).text();
                        $(this).html(currentLiText.replace(new RegExp(searchValue, "ig"), "<mark>"+searchValue+"</mark>"))
                    });

                    $.ajax({
                        type: 'get',
                        url: '/${locale}/ukwa/category/gettransplaceholderfull/${locale}/'+previous_2_id.substring(3)+'/'+items_in_current,
                        success: function(data) {
                            $('#catInfo').text(data);
                        }
                    });
                }
                else{
                    // logic to load all the data
                    //console.log("KEYDOWN - else - searchValue is NOT > 0 or NULL, searchValue = ", searchValue);
                    $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li').filter(function() {
                        items_length = $('#top-collection-list-2-' + previous_2_id + ' ul#cat-search-items-2 li:visible').length;
                        $(this).toggle($(this).text().toLowerCase().indexOf(searchValue.toLowerCase()) > -1);
                        $('#cat-filter-results').text("");
                    });//filter
                    $('#top-collection-list-2-'+previous_2_id).find('mark').contents().unwrap();

                    $.ajax({
                        type: 'get',
                        url: '/${locale}/ukwa/category/gettransplaceholderfull/${locale}/'+previous_2_id.substring(3)+'/'+items_in_current,
                        success: function(data) {
                            $('#catInfo').text(data);
                        }
                    });
                }
                if ($("#cat-search-input").val().length === 0)
                    $('#cat-filter-results').text("");
                else if (items_length > 0)
                    $.ajax({
                        type: 'get',
                        url: '/${locale}/ukwa/category/gettransresultsfound/${locale}',
                        success: function(data) {
                            $('#cat-filter-results').text(data + ': ' +items_length );
                        }
                    });
                else
                    $.ajax({
                        type: 'get',
                        url: '/${locale}/ukwa/category/gettransnoresults/${locale}',
                        success: function(data) {
                            $('#cat-filter-results').text(data);
                        }
                    });

            },800); // setTimeout

        }); //input

    $('.category-search-popover').popover({
        container: 'body'
    })

    //<c:set var="categoryListSize" value="${collCountList.get(2)}" />
    var array = new Array();
    <c:forEach items="${collCountList}" var="item">
    array.push("${item}");
    </c:forEach>


    if (current_2_id !== null && current_2_id !== undefined && onclick_category !== true){
        $('#top-collection-list-2-'+previous_2_id).removeClass("active");
        $('#top-collection-list-2-'+current_2_id).addClass("active");

        $(".top-category-card-v2").addClass("w-75");

        $('#id_image_'+previous_2_id).removeClass('border border-danger fast-transition-2');//.css({"filter":blur(35px)});//filter: grayscale(100%);
        $('#id_image_'+current_2_id).addClass('border border-danger fast-transition-2');

        // console.log('new - test current ID = ', 'id_image_'+current_2_id);
        previous_2_id = current_2_id;
    }


    $(".top-category-card-v2").on('click', function(event) {

        //$('#top-collection-list-2-'+previous_2_id).find('mark').remove();
        $('#top-collection-list-2-'+previous_2_id).find('mark').contents().unwrap();

        $.ajax({
            type: 'get',
            url: '/${locale}/ukwa/category/gettransfilterscope/${locale}',
            success: function(data) {
                $('#catInfo').text(data);
            }
        });

        onclick_category = true;
        //console.log('previous_2_id = ', previous_2_id);
        let current_2_id = $(this).attr('id');
        console.log('current_2_id = ', current_2_id);
        $('#top-collection-list-2-'+previous_2_id).removeClass("active");
        $('#top-collection-list-2-'+current_2_id).addClass("active");

        switch (current_2_id) {
            case 'id_2222': listIndex=0; break;
            case 'id_2940': listIndex=1; break;
            case 'id_2941': listIndex=2; break;
            case 'id_2942': listIndex=3; break;
            case 'id_2943': listIndex=4; break;
            case 'id_2944': listIndex=5; break;
            case 'id_2938': listIndex=6; break;
            case 'id_2939': listIndex=7; break;
        }

        //----- Data initialization
        //$('#top-collection-list-2-'+current_2_id).find('mark').remove();
        $('#cat-filter-results').text("");
        $('#cat-search-input').val("");

        $("ul#cat-search-items-2 li").filter(function() {
            items_length = $('ul#cat-search-items-2 li:visible').length;
            $(this).toggle($(this).text().indexOf("") > -1);
        });
        items_length = $('ul#cat-search-items-2 li:visible').length;
        items_in_current = items_length;

        $.ajax({
            type: 'get',
            url: '/${locale}/ukwa/category/gettransplaceholderfull/${locale}/'+current_2_id.substring(3)+'/'+items_length,
            success: function(data) {
                //$('#cat-search-input').attr("placeholder", data );
                $('#catInfo').text(data);
            }
        });

        $(".top-category-card-v2").addClass("w-75");

        $('#id_image_'+previous_2_id).removeClass('border border-danger fast-transition-2');//.css({"filter":blur(35px)});//filter: grayscale(100%);
        $('#id_image_'+current_2_id).addClass('border border-danger fast-transition-2');

        // console.log('id image current = ', 'id_image_'+current_2_id);
        previous_2_id = current_2_id;
    });

        $('.col-descr').on('hidden.bs.collapse', function () {
            //console.log("hidden.bs.collapse");
            let element = $(this).next();
            $.ajax({
                type: 'get',
                url: '/${locale}/ukwa/category/getcattransshowmore/${locale}',
                success: function(data) {
                    //console.log('show more, data = ', data);
                    element.attr("data-content", data);
                }
            });
        });

        $('.col-descr').on('show.bs.collapse', function () {
            //console.log("show.bs.collapse");
            let element = $(this).next();
            $.ajax({
                type: 'get',
                url: '/${locale}/ukwa/category/getcattransshowless/${locale}',
                success: function(data) {
                    //console.log('show less, data = ', data);
                    element.attr("data-content", data);
                }
            });
        });
    });

</script>
</body>
</html>
