<div class="col-sm-12 padding-mobile-side-15 white left" style="padding-bottom:30px;padding-top:20px;padding-left:10px;padding-right:5%">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
    <div>
        <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
        <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
        <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>

        <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button-blue white">Search</button>
    </div>
    </form>
</div>