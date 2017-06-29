<div class="row">
  <div class="col-md-8 offset-md-1 col-sm-12">
    <h2 class="footer-title light-blue"><spring:message code="footer.moreinfo" text="More information..." /></h2>
    <hr class="footer-title-hr"/>
  </div>
  <div class="col-md-5 offset-md-1 col-sm-12 footer-links footer-right-border">
    <a href="index" title="<spring:message code="footer.home.title" />"><spring:message code="footer.home" /></a><br/>
    <a href="info/about" title="<spring:message code="footer.about.title" />"><spring:message code="footer.about" text="About" /></a><br/>
    <a href="collection" title="<spring:message code="footer.collections.title" />"><spring:message code="footer.collections" /></a><br/>
	<a href="blog" title="<spring:message code="footer.blog.title" />"><spring:message code="footer.blog" /></a><br/>
    <a href="info/nominate" title="<spring:message code="footer.nominate.title" />"><spring:message code="footer.nominate" /></a><br/>
    <a href="info/faq" title="<spring:message code="footer.faq" />"><spring:message code="footer.faq" text="Notice and takedown" /></a><br/>
    <a href="contact" title="<spring:message code="footer.contact.title" />"><spring:message code="footer.contact" /></a><br/>
  </div>
  <div class="col-md-5 offset-md-1 col-sm-12 footer-links">

    <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
    <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>

  <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'}">
    <span lang="en"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.english.title" />"><spring:message code="footer.english" /></a></span><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
    <span lang="cy"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.welsh.title" />"><spring:message code="footer.welsh" /></a></span><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
    <span lang="gn"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.scottish.title" />"><spring:message code="footer.scottish" /></a></span><br/>
  </c:if>

    
    <a href="info/notice_takedown" title="<spring:message code="footer.notice.title" />"><spring:message code="footer.notice" text="Notice and takedown" /></a><br/>
    <a href="info/terms_conditions" title="<spring:message code="footer.terms.title" />"><spring:message code="footer.terms" text="Terms and conditions" /></a><br/>
    <a href="info/privacy" title="<spring:message code="footer.privacy.title" />"><spring:message code="footer.privacy" text="Privacy statement" /></a><br/>




    <a href="https://www.webarchive.org.uk/rss/recent.xml" title="<spring:message code="footer.rss.title" />"><spring:message code="footer.rss" text="RSS Feed" /></a><br/>
  </div>
</div>

<div class="row">
  <div class="col-md-12 col-sm-12 footer-logos">
  <img src="img/bl_logo.png" alt="British library" class="footer-logo"/>
  <img src="img/llgc_logo.png" alt="LLGC NLW" class="footer-logo"/>
  <img src="img/nls_logo.png" alt="National Library of Scotland" class="footer-logo"/><br/>
  <img src="img/bodleian_logo.jpg" alt="Bodleian Libraries" class="footer-logo"/>
  <img src="img/cambrige_logo.jpg" alt="Cambrige University Library" class="footer-logo"/>
  <img src="img/trinity_logo.jpg" alt="Trinity College Dublin" class="footer-logo"/>
  </div>
</div>