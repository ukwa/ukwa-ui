<div class="col-sm-12 padding-mobile-side-15 white main-search-input-new left" style="padding-bottom:170px;padding-top:40px;padding-left:15%;padding-right:15%">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">

        <div class="col-md-12 col-sm-12 col-xs-12 main-heading-2-redesign white padding-bottom-20">Search the UK Web Archive</div>
        <div class="container">

            <div class="row">

                <div class="col-md-10 col-sm-11 col-xs-12">
                    <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
                </div>
                <div class="col-md-2 col-sm-1 col-xs-12">
                    <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button">Search</button>
                </div>

            </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
        </div>

    </form>
</div>