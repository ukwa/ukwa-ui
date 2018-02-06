<div id="betadiv" class="d-flex justify-content-between flex-wrap bg-dark my-auto">
    <div class="p-2 main-header-heading my-auto">
        <span class="text-white">Beta version</span>
    </div>
    <div id="betadivlink" name="betadivlink" style="display:none;"  class="p-2 white my-auto">
        <a target="_blank" href="<spring:message code="survey.url"/>" title="survey">
            <h4><u>Help us improve, complete our survey</u></h4>
        </a>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="pleaseWaitDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title text-center">Your search is in progress. Please wait..</h2>
            </div>
            <div class="modal-body">
                <div class="center-block" >
                    <div class="progress-bar progress-bar-striped active" role="progressbar" style="width: 100%;">
                        <span class="sr-only">Please wait...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="main-menu-button" title="<spring:message code="main.menu.title" /> "> </div>
<div class="row header-bar border-bottom-gray">
    <div class="col-lg-3 col-md-4 col-sm-12 main-heading-cont">
 
    <h1 class="main-header-heading"><a href="index" title="<spring:message code="header.main.heading.title" />"><spring:message code="header.main.heading"/></a></h1>
    <span class="main-subheading"><spring:message code="header.subtitle"/></span> </div>
    
  <div class="col-lg-9 col-md-8 col-sm-12 main-search-container padding-side-10">
  
  <div class="row margin-0 header-menu">
  <div class="col-lg-9 col-md-12 padding-0 margin-bottom-10">
  <div class="header-menu-item"><a href="index" title="<spring:message code="main.menu.home.title" />">
    <spring:message code="main.menu.home" />
    </a></div>
  <div class="header-menu-item"><a href="collection" title="<spring:message code="main.menu.collections.title" />">
    <spring:message code="main.menu.collections" />
    </a></div>
  <div class="header-menu-item"><a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />">
    <spring:message code="main.menu.nominate" />
    </a></div>
  <div class="header-menu-item"><a href="contact" title="<spring:message code="main.menu.contact.title" />">
    <spring:message code="main.menu.contact" />
    </a></div>
    
  </div>
  <div class="col-lg-3 col-md-12 padding-0 margin-bottom-10 right">
  <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
  <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
                                        
  <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
    <div class="header-menu-item language"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />">
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

<div class="row padding-top-20">
  
  <div class="col-sm-12 padding-mobile-side-15">
    <form action="advancedsearch" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
      <div class="main-search-input">
        <input type="text" name="text" id="text" title="<spring:message code="search.main.input.title" />" placeholder="<spring:message code="search.main.input.title" />" class="main-search-field" value="${originalSearchRequest}" required/>
        <input type="hidden" name="search_location" id="search_location_full_text" value="full_text"/>
        <input type="hidden" name="reset_filters" id="reset_filters" value="false"/>
        <button type="submit" class="main-search-button" title="<spring:message code="search.main.button.title" />">
        </button>
      </div>

        <div class="row padding-10 padding-bottom-10 margin-0">
            <div class="col-md-12 col-sm-12 padding-top-20 search-notice">
                <spring:message code="search.main.tip" />&nbsp;&nbsp;
                <a href="javascript:void(0);" id="advancedSearchLink" title="<spring:message code="search.main.advanced.title" />">
                    <spring:message code="search.main.advanced" />
                </a>&nbsp;&nbsp;
                <a href="search_tips" title="<spring:message code="search.main.tip.link.title" />">
                    <spring:message code="search.main.tip.link" />
                </a> </div>
        </div>

        <!-- Advanced search form -->
        <!-- Functionality Migration from Shine  -->
        <!-- Columns start at 50% wide on mobile and bump up to 33.3% wide on desktop -->
        <div id="advanced-search-div" class="row padding-10 margin-0 clearfix" style="display:none;">
            <div class="col-md-12 padding-0">
                <!-- filters -->
                <!-- Columns start at 50% wide on mobile and bump up to 33.3% wide on desktop -->
                <div class="row padding-10 padding-bottom-20 margin-0" >
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>Proximity:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="proximityPhrase1" name="proximityPhrase1" value="${originalproximityPhrase1}" class="advanced-search-field" placeholder="phrase" >
                        </div>
                    </div>

                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="proximityPhrase2" name="proximityPhrase2" value="${originalproximityPhrase2}" class="advanced-search-field" placeholder="phrase" >
                        </div>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="number" id="proximityDistance" name="proximityDistance" value="${originalproximityDistance}" class="advanced-search-field"  min="1" max="10000" step="1" placeholder="25">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>Proximity search</label><div class="help-button small gray" title="<spring:message code="advancedsearch.proximity.tip.title" />" data-toggle="tooltip" data-selector="true" data-title="<spring:message code="advancedsearch.proximity.tip" />" tabindex="0"></div>
                    </div>
                </div>
                <div class="row padding-10 padding-bottom-20 margin-0 border-bottom-gray" >
                    <div class="col-md-2 col-sm-2 text-right my-auto" style="height: 45px;">
                        <label>None of these words:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="excludedWords" name="excludedWords" value="${originalExcludedWords}" class="advanced-search-field" placeholder="rodent, Jack Russell">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>Exclude words</label>
                    </div>
                </div>
                <div class="row padding-20 padding-bottom-10 margin-0" >
                    <div class="col-md-2 col-sm-2 text-right border-bottom-gray text-smaller">
                        <label><b>Within Resources</b></label>
                    </div>
                </div>

                <div class="row padding-10 padding-bottom-10 margin-0 align-baseline">
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>Host, Domain or Public Suffix:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="hostDomainPublicText" name="hostDomainPublicText" value="${originalhostDomainPublicText}" class="advanced-search-field"  placeholder="Host, Domain or Public Suffix">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-small text-left text-muted my-auto">
                        <label>'host', 'domain' or 'public_suffix' fields</label>
                    </div>
                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>File Format:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="fileFormatText" name="fileFormatText" value="${originalfileFormatText}" class="advanced-search-field"  placeholder="File Format">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>File format</label>
                    </div>
                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>Website Title:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="websiteTitleText" name="websiteTitleText" value="${originalwebsiteTitleText}" class="advanced-search-field"  placeholder="Website Title">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>Website title</label>
                    </div>
                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>Page Title:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="pageTitleText" name="pageTitleText" value="${originalpageTitleText}" class="advanced-search-field"  placeholder="Page Title">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>Page title</label>
                    </div>

                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right my-auto">
                        <label>Author:</label>
                    </div>
                    <div class="col">
                        <div class="advanced-search-input">
                            <input type="text" id="authorText" name="authorText" value="${originalauthorText}" class="advanced-search-field"  placeholder="Author">
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted my-auto">
                        <label>Author</label>
                    </div>
                </div>
                <div class="row adding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-1 col-sm-1">
                    </div>
                    <div class="col-md-4 col-sm-4 text-right">
                        <button type="submit" class="btn btn-primary button-shadow" name="searchButtons" value="advancedsearch" id="advancedsearchbutton">Search</button>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <button type="reset" class="btn btn-primary button-shadow" name="resetadvancedsearchform" value="reset" id="resetadvancedsearchform">Reset</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- / Advanced search form -->
      
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
               &quot;<b><i><c:out value="${doctype}"/></i></b>&nbsp;&quot;
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




            <c:choose>
                <c:when test="${fn:length(originalproximityPhrase1) > 0 || fn:length(originalproximityPhrase2) > 0}">
                    <p class="margin-0">
                        Proximity search phrases:&nbsp;&quot;<b><i><c:out value="${originalproximityPhrase1}"/></i></b>&nbsp;&quot;,&nbsp;&quot;<b><i><c:out value="${originalproximityPhrase2}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>
            <c:choose>

                <c:when test="${fn:length(originalproximityDistance) > 0}">
                    <p class="margin-0">
                        Proximity search distance:&nbsp;&quot;<b><i><c:out value="${originalproximityDistance}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalExcludedWords) > 0}">
                    <p class="margin-0">
                        Excluded Words:&nbsp;&quot;<b><i><c:out value="${originalExcludedWords}"/></i></b>&quot;&nbsp;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalhostDomainPublicText) > 0}">
                    <p class="margin-0">
                        'host', 'domain' or 'public_suffix' fields:&nbsp;&quot;<b><i><c:out value="${originalhostDomainPublicText}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>

            <c:choose>

                <c:when test="${fn:length(originalfileFormatText) > 0}">
                    <p class="margin-0">
                        File Formats :&nbsp;&quot;<b><i><c:out value="${originalfileFormatText}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalwebsiteTitleText) > 0}">
                    <p class="margin-0">
                        Website Titles:&nbsp;&quot;<b><i><c:out value="${originalwebsiteTitleText}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalpageTitleText) > 0}">
                    <p class="margin-0">
                        Page Titles:&nbsp;&quot;<b><i><c:out value="${originalpageTitleText}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalauthorText) > 0}">
                    <p class="margin-0">
                        Authors:&nbsp;&quot;<b><i><c:out value="${originalauthorText}"/></i></b>&nbsp;&quot;
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:if test="${hasFilters == 'true' || hasAdvancedSearchInput == 'true'}">
                <p class="margin-0">
                    <c:choose>
                        <c:when test="${hasFilters == 'true'}">
                            <button type="button" id="btn_reset_filters" title="<spring:message code="search.filters.reset" />" class="button margin-top-10 text-small"><spring:message code="search.filters.reset" /></button>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${hasAdvancedSearchInput == 'true'}">
                            <button type="button" id="btn_reset_form_fields" title="<spring:message code="search.filters.reset" />" class="button margin-top-10 text-small">Reset advanced search</button>
                        </c:when>
                    </c:choose>
                </p>
            </c:if>




        </div>
      </div> 
      
    </form>
    </div>
    </div>
  </div>
</div>