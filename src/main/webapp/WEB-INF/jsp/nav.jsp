<nav>
  <div class="main-menu-block"></div>
  <div class="main-menu">
    <div class="main-menu-close" title="<spring:message code="main.menu.close.title" />
    " tabindex="-1"></div>
  <div class="main-menu-cont"> <a href="index" title="<spring:message code="main.menu.home.title" />" tabindex="-1">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.home" text="Home" />
    </div>
    </a> <a href="collection" title="<spring:message code="main.menu.collections.title" />" tabindex="-1">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.collections" />
    </div>
    </a> <a href="nominate" title="<spring:message code="main.menu.nominate.title" />" tabindex="-1">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.nominate" />
    </div>
    </a> <a href="contact" title="<spring:message code="main.menu.contact.title" />" tabindex="-1">
    <div class="main-menu-item border-none">
      <spring:message code="main.menu.contact" />
    </div>
    </a>
    <c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}"/>
    <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
    <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                  ? '/'
                                  : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
    <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
          && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
      <a href="/en<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.english.title" />" tabindex="-1">
      <div class="main-menu-item border-none"><span lang="en"><spring:message code="main.menu.english.title" /></span></div>
      </a> </c:if>
    <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}"> <a href="/cy<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.welsh.title" />" tabindex="-1">
      <div class="main-menu-item border-none"><span lang="cy"><spring:message code="main.menu.welsh.title" /></span> </div>
      </a></c:if>
    <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}"> <a href="/gd<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.scottish.title" />" tabindex="-1">
      <div class="main-menu-item border-none"><span lang="gd"><spring:message code="main.menu.scottish.title" /></span></div>
      </a> </c:if>
  </div>
  </div>
</nav>
