<div class="main-menu-button" title="<spring:message code="main.menu.title" />"></div>
<div class="row header-menu margin-0">
<div class="header-menu-item"><a href="index" title="<spring:message code="main.menu.home.title" />"><spring:message code="main.menu.home" /></a></div>
<div class="header-menu-item"><a href="collection" title="<spring:message code="main.menu.collections.title" />"><spring:message code="main.menu.collections" /></a></div>
<div class="header-menu-item"><a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />"><spring:message code="main.menu.nominate" /></a></div>
<div class="header-menu-item"><a href="contact" title="<spring:message code="main.menu.contact.title" />"><spring:message code="main.menu.contact" /></a></div>

<c:if test="${!fn:startsWith(textUri, '/en/')}">
  <div class="header-menu-item"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />"><spring:message code="main.menu.english" /></a></div>
</c:if>

<c:if test="${!fn:startsWith(textUri, '/cy/')}">
  <div class="header-menu-item"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />"><spring:message code="main.menu.welsh" /></a></div>
</c:if>

<c:if test="${!fn:startsWith(textUri, '/gd/')}">
  <div class="header-menu-item"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />"><spring:message code="main.menu.scottish" /></a></div>
</c:if>

</div>
<div class="row header-bar border-bottom-gray">
  <div class="col-lg-2 col-md-3 col-sm-12 main-heading-cont">
    <h1 class="main-heading"><a href="index" title="<spring:message code="header.main.heading.title" />">UK<br/>
      Web<br/>
      Archive</a></h1>
      <span class="main-subheading">Preserving UK Websites</span>
  </div>
  <div class="col-lg-10 col-md-9 col-sm-12 main-search-container">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form">
      <div class="main-search-input" tabindex="1"> 
        <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/><input type="radio" name="search_location" id="search_location_full_text" value="full_text"/>
        <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
        <button type="submit" class="main-search-button" tabindex="1" title="<spring:message code="search.main.button.title" />"></button>
      </div>
      <div class="row">
        <div class="col-md-9 col-sm-12 padding-top-20 search-notice">
          <spring:message code="search.main.tip" /> <a href="#" title="<spring:message code="search.main.tip.link.title" />"><spring:message code="search.main.tip.link" /></a>
          <!--<div class="form-check-cont" title="<spring:message code="search.label.title" />">
             <input type="radio" name="search_location" id="search_location_title"
                    value="title" ${!"full_text".equals(originalSearchLocation) ? "checked" : ""}/>
            <label class="main-search-check-label" for="search_location_title">
              <strong class="bold"> <spring:message code="header.radio.title" text="Title" /></strong>
              <spring:message code="header.radio.titletext" text="(for a specific archived website)" />
            </label>
          </div>-->
        </div>
        <div class="col-md-3 col-sm-12 padding-top-20 padding-bottom-20 search-advanced">
        <a href="advancedsearch" title="<spring:message code="search.main.advanced.title" />"><spring:message code="search.main.advanced" /></a>
<!--          <div class="form-check-cont" title="<spring:message code="search.label.full" />">
            <input type="radio" name="search_location" id="search_location_full_text"
                   value="full_text" ${"full_text".equals(originalSearchLocation) ? "checked" : ""}/>
            <label class="main-search-check-label" for="search_location_full_text">
              <strong class="bold"><spring:message code="header.radio.full" text="Full text" /></strong>
              <spring:message code="header.radio.fulltext" text="(accross all archived websites)" />
            </label>
          </div>-->
        </div>
      </div>
    </form>
  </div>
</div>
