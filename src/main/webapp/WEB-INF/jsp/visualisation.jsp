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
</c:if>


<html>
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Visualisation</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
	<%@include file="header.jsp" %>
  </header>
  <section id="visualisation-header">
    <div class="row header-blue white">
      <div class="col-md-6 offset-md-3"> <img class="h2-icon" src="img/icons/visualisation-white.png"/>
        <h2>Visualisation</h2>
        <p>Use data-based visual tools to access the archive's content as alternatives to the standard search and browse functions.</p>
      </div>
    </div>
  </section>
  <section id="content">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 page-content-col">
        <article>
          <h3 class="light-blue bold">Visualising the UK Web Archive</h3>
          <div class="row">
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">N-gram search</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption">The N-gram search is a phrase
                  usage visualisation tool which 
                  charts the monthly occurrence of 
                  user-defined search terms or 
                  phrases over time. </figcaption>
              </figure>
            </div>
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">Tag clouds</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption"> Special Collection "UK General 
                  Election 2005" consists of web 
                  pages with electoral content 
                  archived during and immediately 
                  after the UK general election 
                  campaign of 2005.</figcaption>
              </figure>
            </div>
          </div>
        </article>
      </div>
      <div class="col-md-6 col-sm-12 page-content-col">
        <article>
          <h3 class="light-blue bold">Visualising the JISC UK Web Domain Dataset (1996-2010)</h3>
          <p> Working with the JISC and the Internet Archive, we also provide visualisations of the UK Web Domain Dataset (1996-2010), which was extracted from the Internet Archive's collection and supported by funding from the JISC. </p>
          <div class="row">
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">N-gram search</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption"> The N-gram search is a phrase
                  usage visualisation tool which 
                  charts the monthly occurrence of 
                  user-defined search terms or 
                  phrases over time. </figcaption>
              </figure>
            </div>
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">Link analisys</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption"> This visualisation shows an 
                  overview of how a subset of the 
                  sites in the JISC UK Web Domain 
                  Dataset (1996-2010) are 
                  interlinked. </figcaption>
              </figure>
            </div>
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">Format profile</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption"> The dataset is a format profile, 
                  summarising the data formats 
                  (MIME types) contained within all 
                  of the HTTP 200 OK responses in 
                  the JISC UK Web Domain Dataset. </figcaption>
              </figure>
            </div>
            <div class="col-md-6 col-sm-12 padding-bottom-20 padding-top-30">
              <div class="center light-blue padding-bottom-10">Geoindex</div>
              <figure><img class="img-responsive border-gray" src="img/visualisation.png"/>
                <figcaption class="img-square-caption"> The ~2.5 billion 200 OK responses 
                  in the JISC UK Web Domain 
                  Dataset (1996-2010) have been 
                  scanned for geographic references 
                  specifically postcodes </figcaption>
              </figure>
            </div>
          </div>
        </article>
      </div>
    </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
