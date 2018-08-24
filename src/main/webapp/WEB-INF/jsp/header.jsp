<!-- Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="padding-top:15%" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title text-center">Your search is in progress  Please wait...</h2>
            </div>
            <div class="modal-body center" style="max-height: calc(100vh - 143px);overflow-y: auto;">
                <div class="center-block align-items-center" >
                        <img src="img/icons/gif4.gif">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Top Line -->
<div>
    <hr style="width: 100%; color: darkblue; height: 2px; background-color:royalblue; margin-bottom:1px !important;margin-top:1px !important;" />
</div>
<div class="relative shadow-redesign" style="z-index: 1001">
<!-- Language menu -->
<div class="row  navbar-collapse justify-content-end">
<div class="col-lg-3 col-md-12 padding-right-20 right">
        <c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}"/>
        <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
        <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
            <div class="header-menu-language-item margin-0"><a href="/cy<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.welsh.title" />">
                <span lang="cy"><spring:message code="main.menu.welsh" /></span>
            </a></div>
        </c:if>
        <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
            <div class="header-menu-language-item"><a href="/gd<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.scottish.title" />">
                <span lang="gd"><spring:message code="main.menu.scottish" /></span>
            </a></div>
        </c:if>
        <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
          && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
            <div class="header-menu-language-item"><a href="/en<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="main.menu.english.title" />">
                <span lang="en"><spring:message code="main.menu.english" /></span>
            </a></div>
        </c:if>
</div>
</div>
<div id="header-menu" class="row center padding-left-60 padding-bottom-20 align-items-end">
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
  <div id="headermenu_about" class="col-sm-auto header-menu-item padding-bottom-10"><a href="about" title="<spring:message code="main.menu.about.title" />">
    <spring:message code="main.menu.about" />
    </a></div>
  <div id="headermenu_contact" class="col-sm-auto header-menu-item padding-bottom-10"><a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <spring:message code="main.menu.contact" />
    </a></div>
  </div>
</div>