<div class="col-sm-12 padding-mobile-side-15 white main-search-input-new left" style="padding-bottom:170px;padding-top:40px;padding-left:15%;padding-right:15%">
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">

        <div class="main-heading padding-bottom-20">Search the UK Web Archive</div>
        <div>
            <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
            <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
            <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" title="<spring:message code="search.main.button.title" />" class="main-search-button" style="border-radius:5px;">Search</button>
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