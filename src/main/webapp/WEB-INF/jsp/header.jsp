<!-- Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" style="padding-top:15%" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title mobile-dialog text-center"><spring:message code="header.modal.pleasewait.text"/>
                </h2>
            </div>
            <div class="modal-body center pleasewait-modal-body-config">
                <div class="center-block align-items-center">
                    <img src="img/icons/gif4.gif">
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
 <c:when test="${textUri == '/en' || textUri == '/cy'}">
  <c:set var="textUriWithoutLang" value="/"/>
 </c:when>
 <c:otherwise>
  <c:set var="textUriWithoutLang" value="${fn:replace(fn:replace(textUri, '/en/', '/'), '/cy/', '/')}"/>
 </c:otherwise>
</c:choose>

<header class="header">
    <nav class="navbar navbar-expand-md navbar-light bg-white">
        <a class="navbar-brand" href="index">
            <img class="logo-svg" src="img/ukwa-2018-onwhite-close.svg" alt="UK Web Archive">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-between" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item ${textUriWithoutLang == '/ukwa/index' ? 'active' : ''}">
                        <a class="nav-link" href="index"><spring:message code="main.menu.home"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/collection') ? 'active' : ''}">
                        <a class="nav-link" href="collection"><spring:message code="main.menu.collections"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/info/nominate') ? 'active' : ''}">
                        <a class="nav-link" href="info/nominate"><spring:message code="main.menu.nominate"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/about') ? 'active' : ''}">
                        <a class="nav-link" href="about"><spring:message code="main.menu.about"/></a>
                </li>
                <li class="nav-item ${textUriWithoutLang.startsWith('/ukwa/contact') ? 'active' : ''}">
                        <a class="nav-link" href="contact"><spring:message code="main.menu.contact"/></a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <spring:message code="main.menu.language"/>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="/en<c:out value="${textUriWithoutLang}?${params}"/>"
                               title="<spring:message code="main.menu.english.title" />">
                                <spring:message code="main.menu.english"/>
                            </a>
                            <a class="dropdown-item" href="/cy<c:out value="${textUriWithoutLang}?${params}"/>"
                               title="<spring:message code="main.menu.welsh.title" />">
                                <spring:message code="main.menu.welsh"/>
                            </a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>
</header>
</div>