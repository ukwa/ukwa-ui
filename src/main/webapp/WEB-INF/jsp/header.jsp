<a class="sr-only sr-only-focusable" href="${requestScope['javax.servlet.forward.request_uri']}#content" tabindex="0" aria-hidden="false" aria-label="Skip to main content">Skip to main content</a>
<!-- Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="progressbar">
    <div class="modal-dialog" style="padding-top:15%" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="main-heading-2-bold-redesign modal-title mobile-dialog text-center"><spring:message code="header.modal.pleasewait.text"/>
                </h2>
            </div>
            <div class="modal-body center pleasewait-modal-body-config">
                <div class="center-block align-items-center">
                    <img alt="Progress Bar" src="img/icons/gif4.gif">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Top Line -->
<div>
    <hr class="topline"/>
</div>
<div class="relative shadow-redesign" style="z-index: 1001">

<c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}"/>
<c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:choose>
 <c:when test="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'}">
  <c:set var="textUriWithoutLang" value="/"/>
 </c:when>
 <c:otherwise>
  <c:set var="textUriWithoutLang" value="${fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/cy/', '/'), '/gd/', '/')}"/>
 </c:otherwise>
</c:choose>

<header>
    <nav role="navigation" class="navbar navbar-light navbar-expand-md" id="main-nav" aria-label="Main">
        <a class="navbar-brand" href="index" tabindex="-1">
            <img class="logo-svg" src="img/ukwa-2018-onwhite-close.svg" alt="UK Web Archive">
        </a>
        <button role="button" class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon">
                <i class="navbar-toggler-icon-2 fas fa-bars" style="font-size:28px;"></i>
            </span>
        </button>
        <div role="navigation" class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <ul class="navbar-nav" role="menu">
                <li class="nav-item ${textUriWithoutLang == '/ukwa/index' ? 'active' : ''}" role="menuitem">
                        <a class="nav-link" href="index" tabindex="0"><spring:message code="main.menu.home"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/collection') ? 'active' : ''}" role="menuitem">
                        <a class="nav-link" href="collection" tabindex="0"><spring:message code="main.menu.collections"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/info/nominate') ? 'active' : ''}" role="menuitem">
                        <a class="nav-link" href="info/nominate" tabindex="0"><spring:message code="main.menu.nominate"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/about') ? 'active' : ''}" role="menuitem">
                        <a class="nav-link" href="about" tabindex="0"><spring:message code="main.menu.about"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/contact') ? 'active' : ''}" role="menuitem">
                        <a class="nav-link" href="contact" tabindex="0"><spring:message code="main.menu.contact"/></a>
                </li>
            </ul>
            <ul class="navbar-nav" role="menu">
                <li class="nav-item dropdown" role="menu">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" tabindex="0">
                        <spring:message code="main.menu.language"/>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="/en<c:out value="${textUriWithoutLang}?${params}"/>"
                               title="<spring:message code="main.menu.english.title" />" lang="en" role="menuitem" tabindex="0">
                                <spring:message code="main.menu.english"/>
                            </a>
                            <a class="dropdown-item" href="/cy<c:out value="${textUriWithoutLang}?${params}"/>"
                               title="<spring:message code="main.menu.welsh.title" />" lang="cy" role="menuitem" tabindex="0">
                                <spring:message code="main.menu.welsh"/>
                            </a>
                    </div>
                </li>
                <li role="menuitem">
                    <a href="javascript:void(0)" id="universalaccess_href" class="col-md-1 col-sm-1" aria-label="High Contrast Mode Switch" title="High Contrast Mode Switch" tabindex="0">
                        <i class="fas fa-universal-access fa fa-2x highcontastUAIconOff"></i>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>
</div>
