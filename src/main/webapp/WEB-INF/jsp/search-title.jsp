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
      <div class="sidebar-back-item border-bottom-white">Back to the list</div>
      <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
      <div class="sidebar-collapse">
      <div class="sidebar-title border-bottom-white">
        <h2 class="white margin-0 padding-0">Post the results for:</h2>
      </div>
      <div class="border-bottom-white padding-20">
        <label class="bold white text-medium width-100">Text Search</label>
        <label class="white width-100">Search all instances by text</label>
        <input type="text" name="search" id="search" class="form-search-input margin-top-20 margin-bottom-20"/>
      </div>
      <div class="padding-20">
        <label class="bold white text-medium width-100">Restrict by date</label>
        <div class="row margin-0 padding-0">
          <div class="col-md-3 padding-0 padding-vert-10">
            <label class="white padding-top-5">From</label>
          </div>
          <div class="col-md-5 padding-0 padding-vert-10">
            <input type="text" name="from" id="from" class="form-control blue"/>
          </div>
        </div>
        <div class="row margin-0 padding-0">
          <div class="col-md-3 padding-0 padding-vert-10">
            <label class="white padding-top-5">To</label>
          </div>
          <div class="col-md-5 padding-0 padding-vert-10">
            <input type="text" name="from" id="from" class="form-control blue"/>
          </div>
        </div>
      </div>
      </div>
    </div>
    <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
      <div class="results-header border-bottom-gray">
        <div class="float-left padding-top-5">20 results for <span class="bold">"Interactive Design"</span></div>
        <div class="help-button small"></div>
        <div class="clearfix"></div>
      </div>
      <div class="row margin-0 results-title border-bottom-gray">
        <div class="col-lg-8 offset-lg-1 col-md-9 col-sm-12 padding-0">
          <h1 class="light-blue">Arts, Design and the Built Environment</h1>
          <span class="results-title-text clearfix">10/09/2015</span> <span class="results-title-text clearfix">This site is part of the following subject(s): <span class="light-blue">Arts & letters > Art et Design</span></span> </div>
        <div class="col-md-3 col-sm-12">
          <div class="social-button fb float-right margin-left-10"></div>
          <div class="social-button twitter float-right margin-left-10"></div>
        </div>
      </div>
      <div class="row margin-0 padding-left-60 results-result border-bottom-gray">
        <div class="col-lg-9 offset-lg-1 col-md-12 col-sm-12 padding-0 padding-left-60">
          <h2 class="margin-0">Title</h2>
          <span class="results-title-text clearfix padding-0">10/09/2015</span> <span class="results-title-text clearfix padding-vert-10 ellipsis"><a href="#">https://www.webarchive.org.uk/ukwa/target/50659337/source/search</a></span> <span class="results-title-text clearfix">Lorem ipsum dolor sit amet, <strong class="bold">Interaction design</strong> elit. Curabitur vel enim efficitur, 
          ornare felis a, faucibus turpis. Cras varius nisi vulputate ante ultrices, quis feugiat mi convallis.</span> </div>
      </div>
      <div class="row margin-0 padding-left-60 results-result border-bottom-gray">
        <div class="col-lg-9 offset-lg-1 col-md-12 col-sm-12 padding-0 padding-left-60">
          <h2 class="margin-0">Title</h2>
          <span class="results-title-text clearfix padding-0">10/09/2015</span> <span class="results-title-text clearfix padding-vert-10"><a href="#">https://www.webarchive.org.uk/ukwa/target/50659337/source/search</a></span> <span class="results-title-text clearfix">Lorem ipsum dolor sit amet, <strong class="bold">Interaction design</strong> elit. Curabitur vel enim efficitur, 
          ornare felis a, faucibus turpis. Cras varius nisi vulputate ante ultrices, quis feugiat mi convallis.</span> </div>
      </div>
      <div class="row margin-0 padding-left-60 results-result border-bottom-gray">
        <div class="col-lg-9 offset-lg-1 col-md-12 col-sm-12 padding-0 padding-left-60">
          <h2 class="margin-0">Title</h2>
          <span class="results-title-text clearfix padding-0">10/09/2015</span> <span class="results-title-text clearfix padding-vert-10"><a href="#">https://www.webarchive.org.uk/ukwa/target/50659337/source/search</a></span> <span class="results-title-text clearfix">Lorem ipsum dolor sit amet, <strong class="bold">Interaction design</strong> elit. Curabitur vel enim efficitur, 
          ornare felis a, faucibus turpis. Cras varius nisi vulputate ante ultrices, quis feugiat mi convallis.</span> </div>
      </div>
      <div class="row margin-0 padding-left-60 results-result border-bottom-gray">
        <div class="col-lg-9 offset-lg-1 col-md-12 col-sm-12 padding-0 padding-left-60">
          <h2 class="margin-0">Title</h2>
          <span class="results-title-text clearfix padding-0">10/09/2015</span> <span class="results-title-text clearfix padding-vert-10"><a href="#">https://www.webarchive.org.uk/ukwa/target/50659337/source/search</a></span> <span class="results-title-text clearfix">Lorem ipsum dolor sit amet, <strong class="bold">Interaction design</strong> elit. Curabitur vel enim efficitur, 
          ornare felis a, faucibus turpis. Cras varius nisi vulputate ante ultrices, quis feugiat mi convallis.</span> </div>
      </div>
      <div class="row margin-0 padding-left-60 results-result border-bottom-gray">
        <div class="col-lg-9 offset-lg-1 col-md-12 col-sm-12 padding-0 padding-left-60">
          <h2 class="margin-0">Title</h2>
          <span class="results-title-text clearfix padding-0">10/09/2015</span> <span class="results-title-text clearfix padding-vert-10"><a href="#">https://www.webarchive.org.uk/ukwa/target/50659337/source/search</a></span> <span class="results-title-text clearfix">Lorem ipsum dolor sit amet, <strong class="bold">Interaction design</strong> elit. Curabitur vel enim efficitur, 
          ornare felis a, faucibus turpis. Cras varius nisi vulputate ante ultrices, quis feugiat mi convallis.</span> </div>
      </div>
      <div class="row padding-0 margin-0">
        <div class="col-md-12 pagination-cont">
          <div class="pagination-button arrow left-arrow"></div>
          <div class="pagination-button active">2</div>
          <div class="pagination-button inactive">3</div>
          <div class="pagination-button inactive">4</div>
          <div class="pagination-button dots inactive"></div>
          <div class="pagination-button inactive">8</div>
          <div class="pagination-button arrow right-arrow"></div>
        </div>
      </div>
    </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
