<div class="col-sm-12 padding-mobile-side-15 white main-search-input-new left homepage_search_bg_settings">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">

            <div class="row">
                <div class="col-12 main-heading-2-redesign white padding-bottom-20">Search the UK Web Archive</div>
            </div>
            <div class="row">                
                <div class="col-xl-8 col-lg-7 col-md-7 col-sm-8 col-xs-12">
                    <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
                </div>
                <div class="col-xl-4 col-lg-5 col-md-5 col-sm-4 col-xs-12">
                    <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button">Search</button>
                </div>
            </div>
            <div class="row"> 
                <div class="col-12 left white dialog-link">
                        <a href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter" class="no-decoration" title="Get the most from searching the UKWA" >Help with searching</a>
                </div>
            </div>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
     
    </form>
</div>