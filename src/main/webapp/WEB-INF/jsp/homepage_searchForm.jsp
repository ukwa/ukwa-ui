<div class="col-sm-12 padding-mobile-side-15 white main-search-input-new left" style="padding-bottom:170px;padding-top:40px;padding-left:15%;padding-right:15%">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
        <div class="main-heading-2-redesign white padding-bottom-20">Search the UK Web Archive</div>
        <div>
            <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button">Search</button>
        </div>
    </form>
</div>