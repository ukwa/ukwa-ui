<nav>
  <div class="main-menu-block"></div>
  <div class="main-menu">
    <div class="main-menu-close" title="<spring:message code="main.menu.close.title" />
    " tabindex="0"></div>
  <div class="main-menu-cont"> <a href="index" title="<spring:message code="main.menu.home.title" />">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.home" text="Home" />
    </div>
    </a> <a href="collections" title="<spring:message code="main.menu.collections.title" />">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.collections" text="Special Collections" />
    </div>
    </a> <a href="nominate" title="<spring:message code="main.menu.nominate.title" />">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.nominate" text="Nominate a site" />
    </div>
    </a> <a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.contact" text="Contact" />
    </div>
    </a>
    <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
    <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                  ? '/'
                                  : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
    <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'}"> <span lang="en"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />">
      <div class="main-menu-item border-none">English</div>
      </a></span> </c:if>
    <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}"> <span lang="cy"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />">
      <div class="main-menu-item border-none">Cymraeg</div>
      </a></span> </c:if>
    <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}"> <span lang="gd"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />">
      <div class="main-menu-item border-none">Alba</div>
      </a></span> </c:if>
  </div>
  </div>
</nav>
