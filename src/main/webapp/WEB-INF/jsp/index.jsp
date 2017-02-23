<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:set var="locale">${pageContext.response.locale}</c:set>


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="home.header.title" text="UKWA Home" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
    <div class="main-menu-button"></div>
    <div class="row margin-0">
      <div class="col-md-5 col-sm-12 home-title-cont">
        <div> UK<br/>
          WEB<br/>
          ARCHIVE
          <h2 class="home-subtitle">preserving uk websites</h2>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 home-header-text-cont">
        <div>
          <h1 class="light-blue padding-bottom-20"><spring:message code="home.page.title"/></h1>
          <h3 class="text-medium padding-0 margin-0"><spring:message code="home.page.subtitle"/></h3>
          <hr class="header-title-hr"/>
          <p><spring:message code="home.page.description"/></p>
          <a href="info/about"><button type="button" class="button button-white button-shadow form-button-right-arrow float-md-right margin-top-20" role="link"><spring:message code="home.button.learn"/></button></a>
        </div>
      </div>
    </div>
  </header>
  <section id="content">
    <div class="row margin-0 border-top-gray">
      <div class="col-lg-8 col-md-6 col-sm-12 home-search-container">
      <form action="search" method="get" enctype="multipart/form-data" name="search_form">
        <h1 class="light-blue uppercase padding-bottom-20"><spring:message code="home.page.search.title"/></h1>
        <div class="row">
          <div class="col-lg-6 col-md-12 col-sm-12 padding-bottom-20">
            <div class="form-check-cont">
              <input type="radio" name="search_location" id="search_location_title" value="title" checked/>
              <label class="main-search-check-label" for="search_location_title"><strong class="bold"><spring:message code="header.radio.title" text="Title" /></strong> <spring:message code="header.radio.titletext" text="(for a specific archived website)" /></label>
            </div>
          </div>
          <div class="col-lg-6 col-md-12 col-sm-12  padding-bottom-20">
            <div class="form-check-cont">
              <input type="radio" name="search_location" id="search_location_full_text" value="full_text"/>
              <label class="main-search-check-label" for="search_location_full_text"><strong class="bold"><spring:message code="header.radio.full" text="Full text" /></strong> <spring:message code="header.radio.fulltext" text="(accross all archived websites)" /></label>
            </div>
          </div>
        </div>
        <div class="main-search-input noshadow">
        <input type="text" name="text" id="text" class="main-search-field"/>
        <button type="submit" class="main-search-button"></button>
        </div>
        <a href="advancedsearch"><button class="button button-white button-shadow margin-top-60 margin-bottom-20" role="link" type="button"><spring:message code="home.button.advanced"/></button></a>
        </form>
      </div>
      <div class="col-lg-4 col-md-6 col-sm-12 home-menu-cont">
        <nav>
          <div class="home-menu-title">
            <h1 class="uppercase padding-0 margin-0"><spring:message code="home.page.browse.title"/></h1>
          </div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Arts & Humanities" src="img/icons/arts-white.png"/><spring:message code="home.page.browse.arts"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Business, Economy & Industry" src="img/icons/business-white.png"/><spring:message code="home.page.browse.business"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Education & Research" src="img/icons/education-white.png"/><spring:message code="home.page.browse.education"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Government, Law & Politics" src="img/icons/government-white.png"/><spring:message code="home.page.browse.government"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Medicine & Health" src="img/icons/medicine-white.png"/><spring:message code="home.page.browse.medicine"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Science & Technology" src="img/icons/science-white.png"/><spring:message code="home.page.browse.science"/></div>
          <div class="home-menu-item"><img class="home-menu-img" alt="Society & Culture" src="img/icons/society-white.png"/><spring:message code="home.page.browse.society"/></div>
        </nav>
      </div>
    </div>
  </section>
  
    <section id="collections">
    
    <div class="row header-bar-2">
      <div class="col-lg-2  col-md-3 col-sm-12 main-heading-cont">
        <h1 class="main-heading"><spring:message code="home.page.collections.title"/></h1>
        <hr class="header-title-hr"/>
      </div>
      <div class="col-lg-4 col-md-5 offset-md-1 col-sm-12 header-2-subtitle"><spring:message code="home.page.collections.subtitle"/></div>
    </div>

 
    <div class="row page-content padding-side-70 padding-top-0">
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Blogs</div>
        <figure><a href="collection/100698/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/subject1.png"/></a>
          <figcaption class="img-square-caption"> The UK Blogosphere(connected community of Web logs) has burgeoned... </figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Credit Crunch</div>
        <figure><a href="collection/22839323/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/credit.jpg"/></a>
          <figcaption class="img-square-caption">The UK Blogosphere(connected community of Web logs) has burgeoned...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Live Art</div>
        <figure><a href="collection/26312782/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/liveart.png"/></a>
          <figcaption class="img-square-caption">This collection of websites, covering the period July 2008 to January 2010...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">London Terrorist Attack</div>
        <figure><a href="collection/100757/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/terrorist.png"/></a>
          <figcaption class="img-square-caption">Collection of Internet sites with content about the terrorist attacks...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Olympic and Paraolympic Games 2012</div>
        <figure><a href="collection/4325386/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/olympic.jpg"/></a>
          <figcaption class="img-square-caption">The Olympic and Paralympic Games are the largest sporting event...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Personal Experiences of Illnes</div>
        <figure><a href="collection/98492/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/illnes.jpg"/></a>
          <figcaption class="img-square-caption">A collection created to record individuals experiences of illness...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Enegry</div>
        <figure><a href="collection/9895940/page/1/source/collection"><img class="img-responsive border-gray" alt="Collections" src="img/energy.jpeg"/></a>
          <figcaption class="img-square-caption">This collection of websites was selected around the theme of energy...</figcaption>
        </figure>
      </div>
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Queen's Diamond Jubilee 2012</div>
        <figure><a href="collection/62521384/page/1"><img class="img-responsive border-gray" alt="Collections" src="img/queen.png"/></a>
          <figcaption class="img-square-caption">This collection of websites is selected by the Library of the...</figcaption>
        </figure>
      </div>                                               
    </div>
    <div class="row margin-0">
      <div class="col-md-12 col-sm-12 center padding-bottom-80">
        <a href="collection"><button type="button" class="button button-blue" role="link"><spring:message code="home.button.viewmore"/></button></a>
      </div>
    </div>
  </section>
  
  <footer>
    <%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
