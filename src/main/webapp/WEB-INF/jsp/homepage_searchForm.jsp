<form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
    <div class="container-fluid d-flex ukwa-hero-banner mb-3 pt-2 px-md-5 px-sm-3 px-xs-3 px-2">
        <div class="row justify-content-center align-self-center w-100" role="group">

            <div class="col-12 offset-md-2">
                <h1 class="main-heading-2-redesign padding-bottom-20"><spring:message
                        code="search.main.webarchivename"/></h1>
            </div>
            <div class="col-12 offset-lg-2 offset-md-2 form-inline inline-block-items flex-nowrap">
                <input role="textbox" type="search" name="text" class="form-control form-control-lg homepage-search-input mr-lg-5 mr-md-5"
                       placeholder="" aria-label="Input search text" title="Search field" required aria-required="true" id="hs-input-field" />
                <button role="button" type="submit" class="btn btn-lg homepage-search-button h-100 w-auto align-items-center"
                        title="<spring:message code="search.main.button.title" />">
                    <span class="d-none d-md-block align-middle"><spring:message code="search.main.button.title" /></span>
                    <i class="fa fa-search ml-2" aria-hidden="true"></i>
                </button>
            </div>
            <div class="col-md-12 offset-md-2 dialog-link">
                <label for="hs-input-field" id="tipsDialog"><spring:message code="search.main.input.title"/>&nbsp</label>
                <a role="dialog" aria-labelledby="tipsDialog" href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter"
                   class="no-decoration bg-transparent" title="<spring:message code="search.tips.tipsnotes" />"><i
                        class="fas fa-info-circle white"></i></a>
            </div>
            <input aria-hidden="true" type="hidden" name="search_location" id="search_location_full_text"
                   value="full_text"/>
            <input aria-hidden="true" type="hidden" name="reset_filters" id="reset_filters" value="false"/>
        </div>
    </div>
</form>
