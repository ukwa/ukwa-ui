<!-- Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="padding-top:15%" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title text-center">Your search is in progress. Please wait..</h2>
            </div>
            <div class="modal-body">
                <div class="center-block" >
                    <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 100%;">
                        <span class="sr-only">Please wait...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="searchingUKWAModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title main-heading-2-redesign" id="exampleModalLongTitle">Get the most from searching the UKWA</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <dl>
                    <dd>
                        <ul>
                            <li>If you are looking for a single website that you believe may be in the UK Web Archive, you can search for it via the Search tab. Use a phrase or name that you think is most likely to be in the website and in that website alone. This will search across all the archived websites.</li>
                        </ul>
                    </dd>
                    <dd>
                        <ul>
                            <li>
                                There are several options for narrowing your search. For example, a phrase search uses more than one term (i.e. more than a single word). If two (or more) terms are submitted without the use of quotes, only one of those terms need appear in the documents to produce a result. If the terms are quoted, then only that precise string will be returned. See the Query Syntax section below for full details.
                            </li></ul>
                    </dd>
                    <dd>
                        <ul><li>
                            Having submitted your query you can further refine your search using the facets on the left-hand side of the full text search results page. This allows the matching results to be filtered by various properties, such as content type, collection and crawl year. For example, you can use the Refine by domain suffix facet to limit the results set to those resources hosted on domains with names that share the same common suffix, such as co.uk, ac.uk or com.
                        </li></ul>
                    </dd>
                    <dd>
                        <ul><li>
                            Note that all queries are case-insensitive.
                        </li></ul>
                    </dd>
                </dl>
            </div>
            <div class="modal-footer center">
                <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- Language menu & Header Menu -->
<div class="shadow-redesign" style="position: relative">
<!-- Language menu -->
<div class="row  navbar-collapse justify-content-end background-white" style="margin-left: 0px; margin-right: 0px">
<div class="col-lg-3 col-md-12 padding-right-20 right">
        <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>

        <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
            <div class="header-menu-language-item margin-0"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />">
                <span lang="cy"><spring:message code="main.menu.welsh" /></span>
            </a></div>
        </c:if>

        <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
            <div class="header-menu-language-item"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />">
                <span lang="gd"><spring:message code="main.menu.scottish" /></span>
            </a></div>
        </c:if>

        <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
      && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
            <div class="header-menu-language-item"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />">
                <span lang="en"><spring:message code="main.menu.english" /></span>
            </a></div>
        </c:if>
</div>
</div>

    <!-- Header menu -->
<div id="header-menu" class="row center padding-left-60 padding-bottom-20 align-items-end background-white" style="margin-left: 0px; margin-right: 0px">
    <div class="col-sm-auto col-md-auto col-sm-auto">
        <a href="index"><img src="img/ukwa-logo-60px.jpg" class="header-logo"></a>
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1">&nbsp;</div>

  <div id="headermenu_index" class="col-sm-auto header-menu-item padding-bottom-10"><a href="index" title="<spring:message code="main.menu.home.title" />">
    <spring:message code="main.menu.home" />
    </a></div>
  <div id="headermenu_collection" class="col-sm-auto header-menu-item padding-bottom-10"><a href="collection" title="<spring:message code="main.menu.collections.title" />">
    <spring:message code="main.menu.collections" />
    </a></div>
  <div id="headermenu_save" class="col-sm-auto header-menu-item padding-bottom-10"><a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />">
    <spring:message code="main.menu.nominate" />
    </a></div>
  <div id="headermenu_about" class="col-sm-auto header-menu-item active padding-bottom-10"><a href="about" title="<spring:message code="main.menu.about.title" />">
    <spring:message code="main.menu.about" />
    </a></div>
  <div id="headermenu_contact" class="col-sm-auto header-menu-item padding-bottom-10"><a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <spring:message code="main.menu.contact" />
    </a></div>
</div>

</div>
