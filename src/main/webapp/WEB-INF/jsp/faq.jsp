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
<title><spring:message code="faq.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<spring:message code='faq.main.heading' var="title"/>
<%@include file="title.jsp" %>


<section id="content">

    <div class="default-padding text-content">
        <p class="main-subheading-2-redesign black padding-bottom-40"><spring:message code="faq.subtitle"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q1"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a1"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q2"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a2"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q3"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a3"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q4"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a4"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q5"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a5"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q6"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a6"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q7"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a7"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q8"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a8"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q9"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a9"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q10"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a10"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q11"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a11"/>
        </p>

        <p class="q-grid"><spring:message code="faq.q12"/></p>
        <p class="q-description black padding-bottom-20"><spring:message code="faq.a12"/>
        </p>

    </div>
</section>

    <footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
