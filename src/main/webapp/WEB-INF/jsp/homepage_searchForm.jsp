<form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
<div class="container-fluid d-flex ukwa-hero-banner mb-3 pt-2 px-md-5 px-sm-3 px-xs-3 px-2">
  <div class="row justify-content-center align-self-center" role="group">

    <div class="col-lg-12 col-md-12 offset-md-2 offset-sm-1">
        <h1 class="main-heading-2-redesign padding-bottom-20"><spring:message code="search.main.webarchivename" /></h1>
    </div>

    <div class="col-lg-8 col-md-8 col-sm-12 mb-3">
      <input role="textbox" type="text" name="text" class="form-control form-control-lg homepage-search-input" placeholder="" aria-label="Input search text" title="Search field" required>
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
      <button role="button" type="submit" class="btn btn-lg homepage-search-button" title="<spring:message code="search.main.button.title" />">Search <i class="fa fa-search ml-2"></i></button>
    </div>

    <div class="col-md-12 offset-md-2 dialog-link">
        <spring:message code="search.main.input.title" />&nbsp;
        <a role="dialog" href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="<spring:message code="search.tips.tipsnotes" />"><i class="fas fa-info-circle"></i></a>
    </div>
            <input aria-hidden="true" type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input aria-hidden="true" ype="hidden" name="reset_filters" id="reset_filters" value="false"/>
       </div>
    </div>
</form>
