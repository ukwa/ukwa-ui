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

    <div class="padding-top-80 padding-bottom-10 padding-side-70">
  <section id="home-pre-header">

      <!-- Modal -->
      <div class="modal fade" id="searchingUKWAModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
          <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
              <div class="modal-content">
                  <div class="modal-header d-block">
                      <button type="button" class="close float-right" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body" style="padding: 0">
                      <div class="main-heading-2-redesign padding-top-40 bg-gray2" id="exampleModalLongTitle" style="padding-left: 40px;padding-bottom: 40px">How to get the most from searching the UKWA</div>
                      <div class="padding-left-20">
                          <div class="row padding-top-40 padding-bottom-10">
                              <div class="col-md-2 col-sm-2 circle"><span>1</span></div>
                              <div class="col-md-10 col-sm-9 circle-text"><b>Tip 1 - </b>If you are looking for a single website that you believe may be in the UK Web Archive, you can search for it via the Search tab. Use a phrase or name that you think is most likely to be in the website and in that website alone. This will search across all the archived websites.</div>
                          </div>
                          <div class="row padding-top-10 padding-bottom-10">
                              <div class="col-md-2 col-sm-2 circle"><span>2</span></div>
                              <div class="col-md-10 col-sm-9 circle-text"><b>Tip 2 - </b>There are several options for narrowing your search. For example, a phrase search uses more than one term (i.e. more than a single word). If two (or more) terms are submitted without the use of quotes, only one of those terms need appear in the documents to produce a result. If the terms are quoted, then only that precise string will be returned. See the Query Syntax section below for full details.</div>
                          </div>
                          <div class="row padding-top-10 padding-bottom-10">
                              <div class="col-md-2 col-sm-12 circle"><span>3</span></div>
                              <div class="col-md-10 col-sm-12 circle-text"><b>Tip 3 - </b>Having submitted your query you can further refine your search using the facets on the left-hand side of the full text search results page. This allows the matching results to be filtered by various properties, such as content type, collection and crawl year. For example, you can use the Refine by domain suffix facet to limit the results set to those resources hosted on domains with names that share the same common suffix, such as co.uk, ac.uk or com.</div>
                          </div>
                          <div class="row padding-top-10 padding-bottom-10">
                              <div class="col-md-2 col-sm-12 circle"><span>4</span></div>
                              <div class="col-md-10 col-sm-12 circle-text"><b>Tip 4 - </b>Note that all queries are case-insensitive.</div>
                          </div>
                      </div>
                  </div>
                  <div class="modal-footer inline-block-items justify-content-center" style="width: 100%;">
                      <button type="button" class="btn btn-primary" style="width: 20%;" data-dismiss="modal">Close</button>
                  </div>
              </div>
          </div>
      </div>

      <div>
          <p class="main-heading-2-bold-redesign">
              What we do
          </p>
      </div>

        <div class="row padding-top-20">
            <div class="col-md-8">
            <p class="main-subheading-bold-2-redesign">
                <spring:message code="home.header.text1" />
            </p><br/>
            <p class="main-subheading-2-redesign">
                <spring:message code="home.header.text2" />
            </p><br/>
                <p>
                    <span class="right light-blue collection-heading">
                        <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter"  title="Get the most from searching the UKWA" >Get the most from searching the UKWA</a>
                    </span>
                </p>
            </div>
            <div class="col-md-4 embed-responsive">
                <video controls class="embed-responsive-item">
                    <source src="img/WhatUKWAcollect.mp4" type="video/mp4">
                </video>
            </div>
        </div>

  </section>

<section id="collections">
    <div class="padding-top-40">
        <p class="main-heading-2-bold-redesign">
            <spring:message code="home.page.collections.title"/>
        </p>
    </div>
    <div class="row padding-top-20">
        <div class="col-md-8">
            <p class="main-subheading-2-redesign">
                <spring:message code="home.page.collections.subtitle"/>
                        <a href="collection" title="Find out more about Topics and Themes">Find out more</a>
            </p>
        </div>
        <div class="col-md-4">
            &nbsp;
        </div>
    </div>


  <div class="row padding-top-40">
    <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/329" class="collection-link">
      <figure><img class="img-responsive border-gray coll-img" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/>
        <figcaption class="img-square-caption shadow">FEATURED</figcaption>
      </figure>
        <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">British Stand-up Comedy Archive</div>
        <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">Collection owned and adminstered by Elspeth Millar.</div>
      </a> </div>

    <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/309" class="collection-link">
      <figure><img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
        <figcaption class="img-square-caption shadow">FEATURED</figcaption>
      </figure>
        <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">French in London</div>
        <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">This collection of websites has been selected by Saskia Huc-Hepher.</div>
      </a></div>

    <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/138" class="collection-link">
      <figure><img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
        <figcaption class="img-square-caption shadow">FEATURED</figcaption>
      </figure>
        <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">News Sites</div>
        <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">558 titles are included in this collection.</div>
      </a></div>
  </div>

    <div class="row ">
        <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col">
            <hr class="topics-themes-hr"/>
        </div>
        <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col ">
            <hr class="topics-themes-hr"/>
        </div>
        <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col">
            <hr class="topics-themes-hr"/>
        </div>
    </div>

    <div class="padding-bottom-60 center">
        <a href="collection" class="no-decoration" title="<spring:message code="home.button.viewmore.title"/>">
            <div class="button button-blue width-auto-inline "><spring:message code="home.button.viewmore"/></div></a>
    </div>
</section>

        </div>
    </div>

</div>
</div>
<footer>
    <%@include file="footer.jsp" %>
</footer>
<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_index").addClass('active');
    });
</script>
</body>
</html>
