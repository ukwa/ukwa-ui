<div class="col-12 white left searchpage_search_bg_settings">
    <form role="form" action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
        <div class="row">
            <div class="col-12">
                <div class="container-search-field-group" role="group">
                    <input role="textbox" type="text" name="text" id="text"
                           title="<spring:message code="search.main.input.title" />"
                           aria-label="<spring:message code="search.main.input.title" />"
                           placeholder="<spring:message code="search.main.input.title" />"
                           class="main-search-field-redesign" value="${originalSearchRequest}" required tabindex="0"
                           aria-required="true"/>
                    <button role="button" type="submit" class="btn btn-lg homepage-search-button"
                            id="ss-button"
                            tabindex="-1"
                            title="<spring:message code="search.main.button.title"/>">Search <i
                            class="fa fa-search ml-2"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <label class="lb-sm padding-left-20 font-italic label-for-accessibility-placeholder" for="text" id="label-for-placeholder"><spring:message code="search.main.input.title"/>&nbsp</label>
        </div>
        <div class="row">
            <div class="col-12 left dialog-link">
                <a role="dialog" href="#" data-toggle="modal" data-target="#searchingUKWAModalCenter"
                   class="no-decoration search-tips-href" title="Get the most from searching the UKWA"><spring:message
                        code="search.tips.tipsnotes"/></a>
            </div>
        </div>
        <input aria-hidden="true" type="hidden" name="search_location" id="search_location_full_text"
               value="full_text"/>
        <input aria-hidden="true" type="hidden" name="reset_filters" id="reset_filters" value="false"/>
    </form>
</div>

<script>
    $(document).ready(function (e) {
        $("#ss-button").focus();
    });
</script>
