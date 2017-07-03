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
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Contact</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="contact-header">
  <div class="row header-blue white">
    <div class="col-md-6 offset-md-3">
      <h2>Contact</h2>
      <p><span class="bold clearfix">Technical Queries</span>In the unlikely event that the web crawler is causing problems with your website, please email us and we will take urgent action to resolve any issues.</p>
      <p>You may also find our <a href="info/technical">Technical information</a> useful. </p>
      <p><span class="bold clearfix">For other kinds of enquiries</span> Please first consult the quick links panel on your right or the <a href="info/faq">FAQ section</a> of the website where you will most likely find an answer. Alternatively, you may submit your comments or queries using the form below. </p>
    </div>
  </div>
</section>
<section id="content">
  <form action="#" method="get" enctype="multipart/form-data" name="contact">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h3 class="light-blue bold">Contact form</h3>
        <p>Fields marked with <span class="light-blue">*</span> are mandatory</p>
        <p>Personal details you provide on this form are protected by UK data protection law. Please view our <a href="info/privacy">Privacy Statement</a>.</p>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="name">* Full name</label>
          <input type="text" name="name" id="name" class="form-control" placeholder="Please enter your full name" required/>
        </div>
        <div class="form-group">
          <label for="position">Position</label>
          <input type="text" name="position" id="position" class="form-control" placeholder="Please enter your position"/>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="comments">Your comments, queries or requests</label>
          <textarea name="comments" id="comments" class="form-control" placeholder="Please enter your comments, queries or requests" style="height:145px;"></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="organisation">Organisation</label>
          <input type="text" name="organisation" id="organisation" class="form-control" placeholder="Please enter your organisation"/>
        </div>
        <div class="form-group">
          <label for="email">* Email</label>
          <input type="email" name="email" id="email" class="form-control" placeholder="Please enter your email address" required/>
        </div>
      </div>
      <div class="col-md-12 col-sm-12 form-content-col">
        <div class="row">
          <div class="col-md-12 col-sm-12 form-group margin-0">
            <label>Please select a recipient</label>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="1" id="recipient_1" checked/>
              <label class="form-radio-label bold" for="recipient_1">General enquiries</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="2" id="recipient_2" />
              <label class="form-radio-label bold" for="recipient_2">JISC</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex=",">
              <input type="radio" name="recipient" value="3" id="recipient_3" />
              <label class="form-radio-label bold" for="recipient_3">The National Archive</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="4" id="recipient_4" />
              <label class="form-radio-label bold" for="recipient_4">Wellcome Library</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="5" id="recipient_5" />
              <label class="form-radio-label bold" for="recipient_5">British Library</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="6" id="recipient_6" />
              <label class="form-radio-label bold" for="recipient_6">National Library of Scotland</label>
              <br/>
            </div>
          </div>
          <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="form-check-cont" tabindex="0">
              <input type="radio" name="recipient" value="7" id="recipient_7" />
              <label class="form-radio-label bold" for="recipient_7">National Library of Wales</label>
              <br/>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col padding-top-30">
        <button type="button" class="button button-blue" role="button" title="Submit">Submit</button>
      </div>
    </div>
  </form>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
