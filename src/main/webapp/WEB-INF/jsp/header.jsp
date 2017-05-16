<div class="main-menu-button" title="<spring:message code="main.menu.title" />"></div>
<div class="row header-bar border-bottom-gray">
  <div class="col-md-2 col-sm-12 main-heading-cont">
    <h1 class="main-heading"><a href="index" title="<spring:message code="header.main.heading.title" />">UK<br/>
      Web<br/>
      Archive</a></h1>
  </div>
  <div class="col-md-8 col-sm-12 main-search-container">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form">
      <div class="main-search-input" tabindex="1"> 
        <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
        <button type="submit" class="main-search-button" tabindex="1" title="<spring:message code="search.main.button.title" />"></button>
      </div>
      <div class="row">
        <div class="col-md-6 col-sm-12 padding-top-20 padding-top-mobile-0">
          <div class="form-check-cont" title="<spring:message code="search.label.title" />">
             <input type="radio" name="search_location" id="search_location_title"
                    value="title" ${!"full_text".equals(originalSearchLocation) ? "checked" : ""}/>
            <label class="main-search-check-label" for="search_location_title">
              <strong class="bold"> <spring:message code="header.radio.title" text="Title" /></strong>
              <spring:message code="header.radio.titletext" text="(for a specific archived website)" />
            </label>
          </div>
        </div>
        <div class="col-md-6 col-sm-12 padding-top-20">
          <div class="form-check-cont" title="<spring:message code="search.label.full" />">
            <input type="radio" name="search_location" id="search_location_full_text"
                   value="full_text" ${"full_text".equals(originalSearchLocation) ? "checked" : ""}/>
            <label class="main-search-check-label" for="search_location_full_text">
              <strong class="bold"><spring:message code="header.radio.full" text="Full text" /></strong>
              <spring:message code="header.radio.fulltext" text="(accross all archived websites)" />
            </label>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
