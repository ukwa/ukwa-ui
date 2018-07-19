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


      <div>
          <p class="main-heading-2-redesign">
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
            </p>
            <p class="text-bigger">
                <a href="about" title="<spring:message code="home.header.text.link" />"><spring:message code="home.header.text.link" /></a>
            </p>
            </div>
            <div class="col-md-4">
                    <a href="index" ><figure><img class="img-responsive" src="img/about2.png" alt="About UKWA"/> </figure></a>
            </div>
        </div>


  </section>

<section id="collections">
    <div class="padding-top-40">
        <p class="main-heading-2-redesign">
            <spring:message code="home.page.collections.title"/>
        </p>
    </div>


    <div class="row padding-top-20">
        <div class="col-md-8">
            <p class="main-subheading-2-redesign">
                <spring:message code="home.page.collections.subtitle"/>
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
        <div class="center light-blue padding-bottom-10 collection-heading">British Stand-up Comedy Archive</div>
        <div class="center black padding-bottom-10 collection-heading">Collection owned and adminstered by Elspeth Millar.</div>
      </a> </div>

    <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/309" class="collection-link">
      <figure><img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
        <figcaption class="img-square-caption shadow">FEATURED</figcaption>
      </figure>
        <div class="center light-blue padding-bottom-10 collection-heading">French in London</div>
        <div class="center black padding-bottom-10 collection-heading">This collection of websites has been selected by Saskia Huc-Hepher.</div>
      </a></div>

    <div class="col-lg-4 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/138" class="collection-link">
      <figure><img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
        <figcaption class="img-square-caption shadow">FEATURED</figcaption>
      </figure>
        <div class="center light-blue padding-bottom-10 collection-heading">News Sites</div>
        <div class="center black padding-bottom-10 collection-heading thumbnail">558 titles are included in this collection.</div>
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
</body>
</html>
