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
<title>UKWA Nominate</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="nominate-header">
  <div class="row header-white light-blue">
    <div class="col-md-6 offset-md-3">
      <h2>Nominate a Site</h2>
      <p>Since April 2013, the British Library has begun to archive the whole of the UK web domain under the terms of the Non-Print Legal Deposit Regulations 2013. This is done in an automated way, typically once a year.</p>
    </div>
  </div>
  <div class="row header-blue padding-side-70 white">
    <div class="col-md-6 col-sm-12 padding-bottom-20">
      <h2>We will be archiving sites:</h2>
      <ol>
        <li>that are issued from a .uk or other UK geographic 
          top-level domain.</li>
        <li>where part of the publishing process takes place in the UK.</li>
      </ol>
    </div>
    <div class="col-md-6 col-sm-12 padding-bottom-20">
      <h2>We will <em>not</em> be archiving:</h2>
      <ol>
        <li>sites concerning film and recorded sound where the audio-visual content predominates (but, for example, web pages containing video clips alongside text or images are within scope).</li>
        <li>private intranets and emails.</li>
        <li>personal data in social networking sites or that are only available to restricted groups.</li>
      </ol>
    </div>
  </div>
</section>
<section id="content">
  <form action="#" method="get" enctype="multipart/form-data" name="nominate">
    <div class="row page-content">
      <div class="col-md-6 col-sm-12 form-content-col padding-bottom-20">
        <h3 class="light-blue bold">Nominate a site</h3>
        <p>Fields marked with <span class="light-blue">*</span> are mandatory</p>
        <p>Personal details you provide on this form are protected by UK data protection law. Please view our <a href="privacy">Privacy Statement</a>.</p>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="name">* Full name</label>
          <input type="text" name="name" id="name" class="form-control" placeholder="Please enter your full name" required/>
        </div>
        <div class="form-group">
          <label for="title">* Title of website</label>
          <input type="text" name="title" id="title" class="form-control" placeholder="Please enter the title of the website" required/>
        </div>
        <div class="form-group">
          <label for="url">* URL of the website</label>
          <input type="text" name="url" id="url" class="form-control" placeholder="Please enter URL of the website" required/>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="email">* Email address</label>
          <input type="email" name="email" id="email" class="form-control" placeholder="Please enter your email address" required/>
        </div>
        <div class="form-group">
          <label for="address">Address</label>
          <textarea name="address" id="address" class="form-control" placeholder=""></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="phone">Telephone number</label>
          <input type="text" name="phone" id="phone" class="form-control" placeholder="Please enter your telephone number"/>
        </div>
        <div class="form-group">
          <label>
          * Are you the copyright holder or owner of the website?
          <div class="row">
            <div class="col-md-12">
              <div class="form-check-cont">
                <input type="radio" name="owner" value="1" id="owner_0" required>
                <label for="owner_0">Yes</label>
              </div>
            </div>
            <div class="col-md-12">
              <div class="form-check-cont">
                <input type="radio" name="owner" value="0" id="owner_1" required>
                <label for="owner_1">No</label>
              </div>
            </div>
          </div>
          </label>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="notes">Notes about your special request e.g. 'please archive urgently as this site will disappear next month' or 'this site relies on a database. Is this a problem?'</label>
          <textarea name="notes" id="notes" class="form-control" placeholder=""></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
        <div class="form-group">
          <label for="justification">Your justification - this will aid selection e.g. 'a typical business blog' or a 'prize winning site' or 'representative of Internet culture' or even 'humorous.'</label>
          <textarea name="justification" id="justification" class="form-control" placeholder=""></textarea>
        </div>
      </div>
      <div class="col-md-6 col-sm-12 form-content-col">
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
