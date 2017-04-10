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


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Browse by subject</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
	<%@include file="header.jsp" %>
  </header>
  <section id="content">
    <div class="row margin-0 padding-0">
    <div class="col-lg-3 col-md-4 col-sm-12 sidebar padding-0">
      <div class="sidebar-title border-bottom-white">
        <h2 class="white margin-0 padding-0">Post the results for:</h2>
      </div>
      <div class="sidebar-title">
        <h3 class="white bold margin-0 padding-0">Browse by subject</h3>
      </div>
      <div class="sidebar-menu-item active"><img class="sidebar-menu-img" alt="Arts & Humanities" src="img/icons/arts-white.png"/>Arts & Humanities</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Business, Economy & Industry" src="img/icons/business-white.png"/>Business, Economy & Industry</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Education & Research" src="img/icons/education-white.png"/>Education & Research</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Government, Laq & Politics" src="img/icons/government-white.png"/>Government, Laq & Politics</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Medicine & Health" src="img/icons/medicine-white.png"/>Medicine & Health</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Science & Technology" src="img/icons/science-white.png"/>Science & Technology</div>
      <div class="sidebar-menu-item"><img class="sidebar-menu-img" alt="Society & Culture" src="img/icons/society-white.png"/>Society & Culture</div>
    </div>
    <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
    <div class="subject-title border-bottom-gray">
      <h1 class="float-left">Arts & Humanities</h1>
      <div class="help-button" title="Help"></div>
      <div class="clearfix"></div>
    </div>
    <div class="subject-subtitle">
      <h2 class="margin-0 padding-0">Sub categories</h2>
    </div>
    <div class="row padding-0 margin-0">
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Arhitecture</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Geography</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">News and Contemporary Events</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Art and Design</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">History</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Philosophy and Etics</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Comedy and Humor</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Languages</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Publiching, Printing and Bookselling</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Dance</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Literature</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Religion</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Family History / Genealogy</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Local History</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Theatre</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Film / Cinema</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">Music</div>
      <div class="col-lg-4 col-md-6 col-sm-12 subject-grid no-padding">TV and Radio</div>
    </div>
    <div class="subject-subtitle border-top-gray">
      <h2 class="margin-0 padding-0">Special collection</h2>
    </div>
    
    <div class="row padding-side-20">
    
      <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Blog</div>
        <figure><img class="img-responsive border-gray" src="img/subject1.png"/>
          <figcaption class="img-square-caption"> The UK Blogosphere 
            (connected community 
            of Web logs) has burgeoned... </figcaption>
        </figure>
      </div>
      
            <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Blog</div>
        <figure><img class="img-responsive border-gray" src="img/subject1.png"/>
          <figcaption class="img-square-caption"> The UK Blogosphere 
            (connected community 
            of Web logs) has burgeoned... </figcaption>
        </figure>
      </div>
      
            <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-bottom-20 padding-top-30">
        <div class="center light-blue padding-bottom-10">Blog</div>
        <figure><img class="img-responsive border-gray" src="img/subject1.png"/>
          <figcaption class="img-square-caption"> The UK Blogosphere 
            (connected community 
            of Web logs) has burgeoned... </figcaption>
        </figure>
      </div>
      
     
    </div>
  </section>
  <footer>
		<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
