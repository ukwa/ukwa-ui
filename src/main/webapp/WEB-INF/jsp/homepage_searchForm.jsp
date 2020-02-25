<form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
<div class="container-fluid d-flex ukwa-hero-banner mb-3 pt-2 px-md-5 px-sm-3 px-xs-3 px-2">
  <div class="row justify-content-center align-self-center">

    <div class="col-lg-12 col-md-12 offset-md-2 offset-sm-1">
                <h1 class="main-heading-2-redesign white padding-bottom-20"><spring:message code="search.main.webarchivename" /></h1>
    </div>

    <div class="col-lg-8 col-md-8 col-sm-12 mb-3">
      <input type="text" name="text" class="form-control form-control-lg" placeholder="">
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
      <button type="submit" class="btn btn-light mb-2 pl-4 pr-4 btn-lg homepage-search-button" title="<spring:message code="search.main.button.title" />">Search <i class="fa fa-search ml-2"></i></button>
    </div>            

    <div class="col-md-12 offset-md-2 white dialog-link">
                    <spring:message code="search.main.input.title" />&nbsp;
                    <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="<spring:message code="search.tips.tipsnotes" />"><i class="fas fa-info-circle"></i></a>
        <div class="padding-top-10"><span class="blinking">Please note that the UK Web Archive service will be unavailable on Thursday, February 27th, for maintenance.</span></div>
    </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
       </div>
    </div>
</form>