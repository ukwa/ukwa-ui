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
<title>UKWA Notice and Takedown Policy</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
	<%@include file="header.jsp" %>
  </header>
  <section id="noresults-header">
    <div class="row header-blue white">
      <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
        <h2 class="uppercase">UK Web Archive Notice and Takedown Policy</h2>
      </div>
    </div>
  </section>
  <section id="content">
	<div class="row margin-0 padding-side-20 padding-top-80 padding-bottom-80">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12 text-justify">
      <p>We, the British Library Board, are committed to ensuring that the material displayed on the UK Web Archive Website ("the Archive") is lawful and in accordance with our <a href="terms_conditions">Terms and Conditions</a>.</p>
      <p>If you object to any material on the Archive, please notify us by contacting the Notice and Takedown Team by email <a href="mailto:web-archivisit@bl.uk">web-archivisit@bl.uk or post</a> (Notice and Takedown Team, Web Archiving Programme, The British Library, St Pancras, 96 Euston Road, London NW1 2DB).</p>
      <p> To help us deal with your complaint as quickly as possible, please	include the following information in your correspondence and mark it as "URGENT":</p>
      <ol>
        <li>Your contact details - including your name, email address and daytime telephone number.</li>
        <li>Identify the material in question - please include sufficient detail to enable us to identify the material complained of, including the	full URL and where it can be found.</li>
        <li>The reasons for your objection.</li>
      </ol>
      <p>We will review each objection on its merits and pending our	inquiries, may remove or disable access to the relevant material from the Archive. If the material has been supplied to us by a third party it may be appropriate for us to contact them.</p>
    </div>
    </div>
  </section>
  <footer>
	<%@include file="footer.jsp" %>
  </footer>
</div>
</body>
</html>
