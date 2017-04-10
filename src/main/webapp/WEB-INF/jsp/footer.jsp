<div class="row">
  <div class="col-md-8 offset-md-1 col-sm-12">
    <h2 class="footer-title light-blue"><spring:message code="footer.moreinfo" text="More information..." /></h2>
    <hr class="footer-title-hr"/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links footer-right-border"> <a href="info/faq" title="FAQ"><spring:message code="footer.faq" text="FAQ" /></a><br/>
    <a href="info/technical" title="Technical information"><spring:message code="footer.technical" text="Technical information" /></a><br/>
    <a href="statistics" title="Statistics"><spring:message code="footer.statistics" text="Archive statistics" /></a><br/>
    <a href="http://britishlibrary.typepad.co.uk/webarchive/" title="UK web archive log"><spring:message code="footer.webarchive" text="UK web archive blog" /></a><br/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links footer-right-border"> <a href="info/contact" title="Contact"><spring:message code="footer.contact" text="Contact" /></a><br/>
    <a href="info/notice_takedown" title="Notice and takedown"><spring:message code="footer.notice" text="Notice and takedown" /></a><br/>
    <a href="info/terms_conditions" title="Terms and conditions"><spring:message code="footer.terms" text="Terms and conditions" /></a><br/>
    <a href="info/privacy" title="Privacy statement"><spring:message code="footer.privacy" text="Privacy statement" /></a><br/>
  </div>
  <div class="col-md-3 offset-md-1 col-sm-12 footer-links">
  <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
  <c:set var="textUriWithoutLang" value="${fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>

  <c:if test="${!fn:startsWith(textUri, '/en/') && (fn:startsWith(textUri, '/gd/') || fn:startsWith(textUri, '/cy/'))}">
    <a href="/en<c:out value="${textUriWithoutLang}"/>" title="Translate to English">Translate to English</a><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/cy/')}">
    <a href="/cy<c:out value="${textUriWithoutLang}"/>" title="Translate to Welsh">Translate to Welsh</a><br/>
  </c:if>
  <c:if test="${!fn:startsWith(textUri, '/gd/')}">
    <a href="/gd<c:out value="${textUriWithoutLang}"/>" title="Translate to Scottish">Translate to Scottish</a><br/>
  </c:if>

    <a href="https://www.webarchive.org.uk/rss/recent.xml" title="RSS Feed"><spring:message code="footer.rss" text="RSS Feed" /></a><br/>
  </div>
</div>
