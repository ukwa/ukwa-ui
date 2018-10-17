<div class="col-sm-12 col-xs-6 padding-mobile-side-15 white left searchpage_search_bg_settings">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">

            <div class="row">
                <div class="col-md-10 col-sm-10 col-xs-12">
                    <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field-redesign" value="${originalSearchRequest}" style="color: #0c49b0" required/>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12">
                    <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button-blue white">Search</button>
                </div>
            </div>
            <div class="row">
                <div class="col-12 left dialog-link">
                    <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="Get the most from searching the UKWA" style="color: #0c49b0">Help with searching</a>
                </div>
            </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
                <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
    </form>
</div>