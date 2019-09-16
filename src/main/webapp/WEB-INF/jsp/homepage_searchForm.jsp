<div class="col-12 white main-search-input-new left homepage_search_bg_settings">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
            <div class="row">
                <h1 class="col-12 main-heading-2-redesign white padding-bottom-20"><spring:message code="search.main.webarchivename" /></h1>
            </div>
            <div class="row">                
                <div class="col-12 ">
                        <div class="input-group" >
                            <input type="text" name="text"  title="<spring:message code="search.main.input.title" />" aria-label="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />"
                                class="border bg-light homepage-search-form-input" value="${originalSearchRequest}" required/>
                            <div class="input-group-append form-inline">
                                <button class="d-none d-sm-block btn btn-outline-secondary bg-light homepage-search-button" type="submit" title="<spring:message code="search.main.button.title" />">
                                    <span style="color: #2e6ddf;"><spring:message code="search.main.button.title" />&nbsp;&nbsp;&nbsp;&nbsp;
                                        <i class="fa fa-search homepage-search-button-aw-icon"></i>
                                    </span>
                                </button>
                                <button class="d-block d-sm-none btn btn-outline-secondary border homepage-search-button" type="submit">
                                    <i class="fa fa-lg fa-search"></i>
                                </button>
                            </div>
                        </div>
                </div>
            </div>

            <div class="row"> 
                <div class="col-12 left white dialog-link">
                    <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="Get the most from searching the UKWA"><spring:message code="search.tips.tipsnotes" /></a>
                </div>
            </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
    </form>
</div>