<div class="row">
  <div class="col-md-8 offset-md-1 col-sm-12">
    <h2 class="footer-title light-blue"><spring:message code="footer.moreinfo" text="More information..." /></h2>
    <hr class="footer-title-hr"/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links footer-right-border"> <a href="info/faq" title="<spring:message code="footer.faq.title" />"><spring:message code="footer.faq" text="FAQ" /></a><br/>
    <a href="info/technical" title="<spring:message code="footer.technical.title" />"><spring:message code="footer.technical" text="Technical information" /></a><br/>
    <a href="statistics" title="<spring:message code="footer.statistics.title" />"><spring:message code="footer.statistics" text="Archive statistics" /></a><br/>
    <a href="http://britishlibrary.typepad.co.uk/webarchive/" title="<spring:message code="footer.webarchive.title" />"><spring:message code="footer.webarchive" text="UK web archive blog" /></a><br/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links footer-right-border"> <a href="info/contact" title="<spring:message code="footer.contact.title" />"><spring:message code="footer.contact" text="Contact" /></a><br/>
    <a href="info/notice_takedown" title="<spring:message code="footer.notice.title" />"><spring:message code="footer.notice" text="Notice and takedown" /></a><br/>
    <a href="info/terms_conditions" title="<spring:message code="footer.terms.title" />"><spring:message code="footer.terms" text="Terms and conditions" /></a><br/>
    <a href="info/privacy" title="<spring:message code="footer.privacy.title" />"><spring:message code="footer.privacy" text="Privacy statement" /></a><br/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links">
  <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
  <c:set var="textUriWithoutLang" value="${fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>

  <c:if test="${!fn:startsWith(textUri, '/en/') && (fn:startsWith(textUri, '/gd/') || fn:startsWith(textUri, '/cy/'))}">
    <a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.english.title" />"><spring:message code="footer.english" /></a><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/cy/')}">
    <a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.welsh.title" />"><spring:message code="footer.welsh" /></a><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/gd/')}">
    <a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.scottish.title" />"><spring:message code="footer.scottish" /></a><br/>
  </c:if>

    <a href="https://www.webarchive.org.uk/rss/recent.xml" title="<spring:message code="footer.rss.title" />"><spring:message code="footer.rss" text="RSS Feed" /></a><br/>
  </div>
</div>
