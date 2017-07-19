<div class="main-menu-button" title="<spring:message code="main.menu.title" /> "> </div>

<div class="row header-bar border-bottom-gray">

  <div class="col-lg-3 col-md-4 col-sm-12 main-heading-cont">
  
  
    <h1 class="main-header-heading"><a href="index" title="<spring:message code="header.main.heading.title" />"><spring:message code="header.main.heading" /></a></h1>
    <span class="main-subheading"><spring:message code="header.subtitle" /></span> </div>
    
  <div class="col-lg-9 col-md-8 col-sm-12 main-search-container padding-side-10">
  
  <div class="row margin-0 header-menu">
  <div class="col-lg-9 col-md-12 padding-0 margin-bottom-10">
  <div class="header-menu-item"><a href="index" title="<spring:message code="main.menu.home.title" />">
    <spring:message code="main.menu.home" />
    </a></div>
  <div class="header-menu-item"><a href="collection" title="<spring:message code="main.menu.collections.title" />">
    <spring:message code="main.menu.collections" />
    </a></div>
  <div class="header-menu-item"><a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />">
    <spring:message code="main.menu.nominate" />
    </a></div>
  <div class="header-menu-item"><a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <spring:message code="main.menu.contact" />
    </a></div>
    
  </div>
  <div class="col-lg-3 col-md-12 padding-0 margin-bottom-10 right">
  <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
  <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
                                        
  <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
    <div class="header-menu-item language"><span lang="cy"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />">
      <spring:message code="main.menu.welsh" />
      </a></span></div>
  </c:if>                                        
                                        
  <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
    <div class="header-menu-item language"><span lang="gd"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />">
      <spring:message code="main.menu.scottish" />
      </a></span></div>
  </c:if>                                        
                                        
  <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
      && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
    <div class="header-menu-item language"><span lang="en"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />">
      <spring:message code="main.menu.english" />
      </a></span></div>
  </c:if>
</div>
</div>

<div class="row padding-top-20">
  
  <div class="col-sm-12 padding-mobile-side-5">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
      <div class="main-search-input">
        <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
        <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
        <button type="submit" class="main-search-button" title="<spring:message code="search.main.button.title" />">
        </button>
      </div>
      <div class="row">
        <div class="col-md-12 col-sm-12 padding-top-20 search-notice">
          <spring:message code="search.main.tip" />
          <a href="search_tips" title="<spring:message code="search.main.tip.link.title" />">
          <spring:message code="search.main.tip.link" />
          </a> </div>
      </div>
    </form>
    </div>
    </div>
  </div>
</div>
