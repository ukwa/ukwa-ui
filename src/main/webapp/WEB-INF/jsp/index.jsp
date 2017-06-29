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


<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="home.header.title" text="UKWA Home" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
    <%@include file="header.jsp" %>
  </header>
  
    <section id="home-header">
    <div class="row header-blue white padding-top-80 padding-bottom-60">
      <div class="col-md-6 offset-md-3">
        <p class="text-bigger"><spring:message code="home.header.text" /></p>
      </div>
    </div>
  </section>
  
    <section id="collections">
    
    <div class="row header-bar-2 padding-top-80">
      <div class="col-lg-2  col-md-3 col-sm-12 main-heading-cont">
        <h1 class="main-heading-2"><spring:message code="home.page.collections.title"/></h1>
        <hr class="header-title-hr"/>
      </div>
      <div class="col-lg-4 col-md-5 offset-md-1 col-sm-12 header-2-subtitle"><spring:message code="home.page.collections.subtitle"/></div>
    </div>

 
    <div class="row page-content padding-side-70 padding-top-0">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <a href="collection/329" class="collection-link"><div class="center light-blue padding-bottom-10 collection-heading">British Stand-up Comedy Archive</div>
        <figure><img class="img-responsive border-gray coll-img" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/>
          <figcaption class="img-square-caption shadow">Collection owned and adminstered by Elspeth Millar, Briti...
          <div class="collection-readmore-cont" data-descript="Collection owned and adminstered by Elspeth Millar, British something or other and something else and bla bla bla bla and this is a test. An this is another sentence for more testing and testing and testing..."><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div>
          </figcaption>
        </figure></a>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <a href="collection/309" class="collection-link"><div class="center light-blue padding-bottom-10 collection-heading">French in London</div>
        <figure><img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
          <figcaption class="img-square-caption shadow">This collection of websites has been selected by Saskia H...
          <div class="collection-readmore-cont" data-descript="Test descript"><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div>
          </figcaption>
        </figure></a>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <a href="collection/65" class="collection-link"><div class="center light-blue padding-bottom-10 collection-heading">Scottish Independence Referendum</div>
        <figure><img class="img-responsive border-gray coll-img" alt="Scottish Independence Referendum" src="img/collections/collection_65.png"/>
          <figcaption class="img-square-caption shadow">Provisional title for collection on Scottish Devolution, ...
          <div class="collection-readmore-cont" data-descript="Test descript"><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div>
          </figcaption>
        </figure></a>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <a href="collection/138" class="collection-link"><div class="center light-blue padding-bottom-10 collection-heading">News Sites</div>
        <figure><img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
          <figcaption class="img-square-caption shadow">558 titles are included in this collection (30/01/2014).
          <div class="collection-readmore-cont" data-descript="Test descript"><img src="img/icons/down-arrow-gray.png" class="collection-readmore-arrow collection-readmore-down" tabindex="0" title="Read more"/></div>
          </figcaption>
        </figure></a>
      </div>
      
    </div>
    
        <div class="row margin-0">
      <div class="col-md-12 col-sm-12 center padding-bottom-80">
        <a href="collection"><button type="button" class="button button-blue" role="link" title="<spring:message code="home.button.viewmore.title"/>"><spring:message code="home.button.viewmore"/></button></a>
      </div>
    </div>
    
  </section>
  
  <footer>
    <%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
