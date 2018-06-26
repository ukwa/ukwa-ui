
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

<!-- Top Line
dotted version:
border-top: 1px dotted #000000 !important;
-->
<div>
    <hr style="width: 100%; color: darkblue; height: 2px; background-color:royalblue; margin-bottom:5px !important;margin-top:5px !important;" />
</div>

<!-- Language menu -->
<div class="row  navbar-collapse justify-content-end">
<div class="col-lg-3 col-md-12 padding-0 margin-bottom-10 right">
        <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>

        <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
            <div class="header-menu-item language margin-0"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />">
                <span lang="cy"><spring:message code="main.menu.welsh" /></span>
            </a></div>
        </c:if>

        <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
            <div class="header-menu-item language"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />">
                <span lang="gd"><spring:message code="main.menu.scottish" /></span>
            </a></div>
        </c:if>

        <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
      && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
            <div class="header-menu-item language"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />">
                <span lang="en"><spring:message code="main.menu.english" /></span>
            </a></div>
        </c:if>
</div>
</div>


<div class="row center padding-left-60 padding-bottom-20 align-items-end">
    <div class="col-sm-auto col-md-auto col-sm-auto">
        <a href="index" ><img src="img/ukwa-logo-4.jpg" class="header-logo"></a>
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1">&nbsp;</div>

  <div class="col-sm-auto header-menu-item padding-bottom-10"><a href="index" title="<spring:message code="main.menu.home.title" />">
    <spring:message code="main.menu.home" />
    </a></div>
  <div class="col-sm-auto header-menu-item padding-bottom-10"><a href="collection" title="<spring:message code="main.menu.collections.title" />">
    <spring:message code="main.menu.collections" />
    </a></div>
  <div class="col-sm-auto header-menu-item padding-bottom-10"><a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />">
    <spring:message code="main.menu.nominate" />
    </a></div>
  <div class="col-sm-auto header-menu-item padding-bottom-10"><a href="about" title="<spring:message code="main.menu.about.title" />">
    <spring:message code="main.menu.about" />
    </a></div>
  <div class="col-sm-auto header-menu-item padding-bottom-10"><a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <spring:message code="main.menu.contact" />
    </a></div>
  </div>





<div class="col-sm-12 padding-mobile-side-15  white main-search-input-new left" style="padding-bottom:140px;padding-top:30px;padding-left:15%;padding-right:15%">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">

        <div class="main-heading padding-bottom-20">Search the UK Web Archive</div>
        <div>
            <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button" style="border-radius: 5px;">Search
            </button>
        </div>

        <div class="row padding-top-10 dark-gray">
            <div class="col-md-12 col-sm-12">

                <c:set var = "hasFilters" value = "false"/>
                <c:if test="${searchPage == 'true'}">
                    <p class="margin-0"><spring:message code="search.filters.access" />&nbsp;

                        <c:if test="${originalAccessView.contains('va') || empty originalAccessView}">
                            <spring:message code="search.filters.access.open" />
                        </c:if>

                        <c:if test="${originalAccessView.contains('vool')}">
                            <spring:message code="search.filters.access.all" />
                        </c:if>

                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>

                <c:if test="${fn:length(originalDomains) > 0}">
                    <p class="margin-0"><spring:message code="search.filters.domain" />&nbsp;
                        <c:forEach items="${originalDomains}" var="domain">
                            &quot;<c:out value="${domain}"/>&quot;&nbsp;
                        </c:forEach>
                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>

                <c:if test="${fn:length(originalContentTypes) > 0}">
                    <p class="margin-0"><spring:message code="search.filters.doctype" />&nbsp;
                        <c:forEach items="${originalContentTypes}" var="doctype">
                            &quot;<c:out value="${doctype}"/>&quot;&nbsp;
                        </c:forEach>
                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>

                <c:if test="${fn:length(originalPublicSuffixes) > 0}">
                    <p class="margin-0"><spring:message code="search.filters.suffix" />&nbsp;
                        <c:forEach items="${originalPublicSuffixes}" var="suffix">
                            &quot;<c:out value="${suffix}"/>&quot;&nbsp;
                        </c:forEach>
                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>


                <c:if test="${fn:length(originalFromDateText) > 0 || fn:length(originalToDateText) > 0}">
                    <p class="margin-0"><spring:message code="search.filters.date" />&nbsp;

                        <c:choose>
                            <c:when test="${fn:length(originalFromDateText) > 0}">
                                <c:out value="${originalFromDateText}"/>
                            </c:when>
                            <c:otherwise>
                                <spring:message code="search.filters.date.any" />
                            </c:otherwise>
                        </c:choose>

                        &nbsp;-&nbsp;

                        <c:choose>
                            <c:when test="${fn:length(originalToDateText) > 0}">
                                <c:out value="${originalToDateText}"/>
                            </c:when>
                            <c:otherwise>
                                <spring:message code="search.filters.date.any" />
                            </c:otherwise>
                        </c:choose>

                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>

                <c:if test="${fn:length(originalCollections) > 0}">
                    <p class="margin-0"><spring:message code="search.filters.collection" />&nbsp;
                        <c:forEach items="${originalCollections}" var="collection">
                            &quot;<c:out value="${collection}"/>&quot;&nbsp;
                        </c:forEach>
                    </p>
                    <c:set var = "hasFilters" value = "true"/>
                </c:if>

                <c:if test="${hasFilters == 'true'}">
                    <p class="margin-0">
                        <button type="button" id="btn_reset_filters" title="<spring:message code="search.filters.reset" />" class="button margin-top-10 text-small"><spring:message code="search.filters.reset" /></button>
                    </p>
                </c:if>

            </div>
        </div>

    </form>
</div>
