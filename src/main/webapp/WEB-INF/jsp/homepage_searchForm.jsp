<div class="col-12 white main-search-input-new left homepage_search_bg_settings">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
            <div class="row">
                <h1 class="col-12 main-heading-2-redesign white padding-bottom-20"><spring:message code="search.main.webarchivename" /></h1>
            </div>
            <div class="row">
    <div class="col-lg-10 col-md-10 col-sm-12 mb-3">
      <input type="text" name="text" class="form-control form-control-lg" placeholder="">
    </div>
    <div class="col-lg-2 col-md-2 col-sm-12">
      <button type="submit" class="btn btn-light mb-2 pl-4 pr-4 btn-lg homepage-search-button" title="<spring:message code="search.main.button.title" />">Search <i class="fa fa-search ml-2"></i></button>
    </div>            
            </div>

            <div class="row"> 
                <div class="col-12 left white dialog-link">
                    <spring:message code="search.main.input.title" />&nbsp;
                    <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="<spring:message code="search.tips.tipsnotes" />"><i class="fas fa-info-circle"></i></a>
                </div>
            </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
    </form>
</div>