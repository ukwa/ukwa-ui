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
<title>UKWA Advanced Search</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <div class="main-menu-button" title="Main menu"></div>
  <div class="row header-bar">
    <div class="col-md-2 col-sm-12 main-heading-cont">
      <h1 class="main-heading"><a href="/">UK<br/>
        Web<br/>
        Archive</a></h1>
    </div>
  </div>
</div>
</header>
<section id="content">
  <div class="row header-blue padding-top-40">
    <div class="col-md-10 col-sm-12 offset-md-1 advanced-cont">
      <h1 class="light-blue uppercase padding-bottom-20">Advanced<br/>
        Search</h1>
              <form action="" method="get" enctype="multipart/form-data" name="search_form">
      <div class="row">
        <div class="col-md-4 col-sm-12 padding-bottom-20">
          <div class="form-check-cont">
            <input type="radio" name="how" id="how_1" value="1" checked/>
            <label class="main-search-check-label" for="how_1">Web title</label>
          </div>
        </div>
        <div class="col-md-4 col-sm-12  padding-bottom-20">
          <div class="form-check-cont">
            <input type="radio" name="how" id="how_2" value="2"/>
            <label class="main-search-check-label" for="how_1">Website URL</label>
          </div>
        </div>
        <div class="col-md-4 col-sm-12  padding-bottom-20">
          <div class="form-check-cont">
            <input type="radio" name="how" id="how_3" value="3"/>
            <label class="main-search-check-label" for="how_1">Website title and URL</label>
          </div>
        </div>
      </div>
      <input class="main-search-input noshadow" type="text" name="search" id="search"/>
      <div class="row padding-top-30">
        <div class="col-lg-4 col-md-5 col-sm-12 padding-bottom-20">
          <h3 class="light-blue bold text-bigger">Restrict by date :</h3>
          <div class="row">
            <div class="col-sm-5 float-right padding-vert-10">
              <label>From</label>
            </div>
            <div class="col-sm-7 padding-vert-10">
              <input type="text" class="form-control" name="from" id="from"/>
            </div>
            <div class="col-sm-5 float-right padding-vert-10">
              <label>To</label>
            </div>
            <div class="col-sm-7 padding-vert-10">
              <input type="text" class="form-control" name="to" id="to"/>
            </div>
          </div>
        </div>
        <div class="col-md-6 offset-md-1 col-sm-12 padding-bottom-20">
          <h3 class="light-blue bold text-bigger">Group by result by :</h3>
          <div class="row">
            <div class="col-md-5 col-sm-12 padding-bottom-20">
              <div class="form-check-cont">
                <input type="radio" name="group" id="group_1" value="1" checked/>
                <label class="main-search-check-label" for="group_1">Domain</label>
              </div>
            </div>
            <div class="col-md-5 col-sm-12  padding-bottom-20">
              <div class="form-check-cont">
                <input type="radio" name="group" id="group_2" value="2"/>
                <label class="main-search-check-label" for="group_2">None</label>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row padding-top-20">
        <div class="col-md-4 col-sm-12 padding-vert-10">
          <button title="Select a subject" type="button" class="button button-blue width-100 text-small form-button-down-arrow">
          Select a subject</button>
        </div>
        <div class="col-md-4 col-sm-12 padding-vert-10">
          <button title="Select a special collection" type="button" class="button button-blue width-100 text-small form-button-down-arrow">
          Select a special collection</button>
        </div>
        <div class="col-md-4 col-sm-12 padding-vert-10">
          <button title="Select an organisation" type="button" class="button button-blue width-100 text-small form-button-down-arrow">
          Select an organisation</button>
        </div>
      </div>
      <div class="row padding-top-20">
        <div class="col-lg-3 col-md-4 col-sm-12 padding-vert-10">
          <label class="light-blue bold text-bigger">Filter by host :</label>
        </div>
        <div class="col-lg-3 col-md-4 col-sm-12 padding-vert-10">
          <input type="text" class="form-control" name="host" id="host"/>
        </div>
      </div>
      <div class="row padding-top-20">
        <div class="col-sm-12">
          <button type="submit" title="Search" class="button button-white form-button-right-arrow right-arrow float-right">
          Search</button>
        </div>
      </div>
       </form>
    </div>
  </div>
</section>
<footer>
	<%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
