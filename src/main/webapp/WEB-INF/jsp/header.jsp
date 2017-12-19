<div id="betadiv" class="d-flex justify-content-between flex-wrap bg-dark padding-side-10 ">
    <div class="p-2 main-header-heading">
        <span class="text-white">Beta version</span>
    </div>
    <div id="betadivlink" name="betadivlink" style="display:none;"  class="p-2  white align-content-center">
        <a target="_blank" href="<spring:message code="survey.url"/>" title="survey">
            <h4><u>Help us improve, complete our survey</u></h4>
        </a>
    </div>
</div>

<div class="main-menu-button" title="<spring:message code="main.menu.title" /> "> </div>
<div class="row header-bar border-bottom-gray">
    <div class="col-lg-3 col-md-4 col-sm-12 main-heading-cont">
 
    <h1 class="main-header-heading"><a href="index" title="<spring:message code="header.main.heading.title" />"><spring:message code="header.main.heading" /></a></h1>
    <span class="main-subheading"><spring:message code="header.subtitle" /></span> </div>
    
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
    <form action="search" method="get" enctype="multipart/form-data" name="search_form" id="search_form">
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
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Proximity:</label>
                    </div>

                    <div class="col" >
                        <input type="text" id="proximityPhrase1" name="proximityPhrase1" value="${originalproximityPhrase1}" class="coll-search-field button-shadow " placeholder="phrase">
                    </div>
                    <div class="col mh-50" >
                        <input type="text" id="proximityPhrase2" name="proximityPhrase2" value="${originalproximityPhrase2}" class="coll-search-field button-shadow " placeholder="phrase">
                    </div>
                    <div class="col w-50" >
                        <input type="text" id="proximityDistance" name="proximityDistance" value="${originalproximityDistance}" class="coll-search-field button-shadow " placeholder="25">
                    </div>

                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
                        <label>Proximity search.</label>
                    </div>

                </div>

                <div class="row padding-10 padding-bottom-20 margin-0" >
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>None of these words:</label>
                    </div>

                    <div class="col">
                        <input type="text" id="excludedWords" name="excludedWords" value="${originalExcludedWords}" class="coll-search-field button-shadow " placeholder="rodent, Jack Russell">
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-4 col-sm-4 search-help-button text-center" style="width: 120px; background-color: rgba(0,0,255,.1)">
                        <label>Within Resources:</label>
                    </div>
                    <div class="col-md-8 col-sm-8">
                    </div>
                </div>

                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Date Range:</label>
                    </div>

                    <div class="col-md-4 col-sm-4">
                        <input type="text" class="form-control button-shadow" id="from_date_advanced" name="dateStart" title="From" placeholder="YYYY-MM-DD"
                               value="${originaldateStart != null ? originaldateStart : ''}"/>
                    </div>
                    <div class="col-md-4 col-sm-4">
                        <input type="text" class="form-control button-shadow" id="to_date_advanced" name="dateStop" title="To" placeholder="YYYY-MM-DD"
                               value="${originaldateStop != null ? originaldateStop : ''}"/>
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
                        <label>Restrict by date (Format: YYYY-MM-DD)</label>
                    </div>

                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 align-baseline">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Host, Domain or Public Suffix:</label>
                    </div>
                    <div class="col-md-8 col-sm-8" >
                        <input type="text" id="hostDomainPublicText" name="hostDomainPublicText" value="${originalhostDomainPublicText}" class="coll-search-field button-shadow"  placeholder="Host, Domain or Public Suffix">
                    </div>
                    <div class="col-md-2 col-sm-2 text-small text-left text-muted">
                        <label>'host', 'domain' or 'public_suffix' fields</label>
                    </div>

                </div>

                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>File Format:</label>
                    </div>
                    <div class="col-md-8 col-sm-8" >
                        <input type="text" id="fileFormatText" name="fileFormatText" value="${originalfileFormatText}" class="coll-search-field button-shadow"  placeholder="File Format">
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
                        <label>File Format</label>
                    </div>

                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Website Title:</label>
                    </div>
                    <div class="col-md-8 col-sm-8" >
                        <input type="text" id="websiteTitleText" name="websiteTitleText" value="${originalwebsiteTitleText}" class="coll-search-field button-shadow"  placeholder="Website Title">
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
                        <label>Website Title</label>
                    </div>

                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Page Title:</label>
                    </div>
                    <div class="col-md-8 col-sm-8" >
                        <input type="text" id="pageTitleText" name="pageTitleText" value="${originalpageTitleText}" class="coll-search-field button-shadow"  placeholder="Page Title">
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
                        <label>Page Title</label>
                    </div>

                </div>
                <div class="row padding-10 padding-bottom-10 margin-0 ">
                    <div class="col-md-2 col-sm-2 text-right">
                        <label>Author:</label>
                    </div>
                    <div class="col-md-8 col-sm-8" >
                        <input type="text" id="authorText" name="authorText" value="${originalauthorText}" class="coll-search-field button-shadow"  placeholder="Author">
                    </div>
                    <div class="col-md-2 col-sm-2 text-smaller text-left text-muted">
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




            <c:choose>
                <c:when test="${fn:length(originalproximityPhrase1) > 0 || fn:length(originalproximityPhrase2) > 0}">
                    <p class="margin-0">
                        Proximity search phrases:&quot;&nbsp;<b><i><c:out value="${originalproximityPhrase1}"/>, <c:out value="${originalproximityPhrase2}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>
            <c:choose>

                <c:when test="${fn:length(originalproximityDistance) > 0}">
                    <p class="margin-0">
                        Proximity search distance:&quot;&nbsp;<b><i><c:out value="${originalproximityDistance}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalExcludedWords) > 0}">
                    <p class="margin-0">
                        Excluded Words:&quot;&nbsp;<b><i><c:out value="${originalExcludedWords}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>



            <c:if test="${fn:length(originaldateStart) > 0 || fn:length(originaldateStop) > 0}">
                <p class="margin-0"><spring:message code="search.filters.date" />&nbsp;

                    <c:choose>
                    <c:when test="${fn:length(originaldateStart) > 0}">
                    <b><i><c:out value="${originaldateStart}"/>
                        </c:when>
                        <c:otherwise>
                            <spring:message code="search.filters.date.any" />
                        </c:otherwise>
                        </c:choose>

                        &nbsp;-&nbsp;

                        <c:choose>
                        <c:when test="${fn:length(originaldateStop) > 0}">
                        <c:out value="${originaldateStop}"/>
                    </b></i>
                    </c:when>
                    <c:otherwise>
                        <spring:message code="search.filters.date.any" />
                    </c:otherwise>
                    </c:choose>

                </p>
                <c:set var = "hasFilters" value = "true"/>
            </c:if>

            <c:choose>

                <c:when test="${fn:length(originalhostDomainPublicText) > 0}">
                    <p class="margin-0">
                        'host', 'domain' or 'public_suffix' fields :&quot;&nbsp;<b><i><c:out value="${originalhostDomainPublicText}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>

            <c:choose>

                <c:when test="${fn:length(originalfileFormatText) > 0}">
                    <p class="margin-0">
                        File Formats :&quot;&nbsp;<b><i><c:out value="${originalfileFormatText}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalwebsiteTitleText) > 0}">
                    <p class="margin-0">
                        Website Titles :&quot;&nbsp;<b><i><c:out value="${originalwebsiteTitleText}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalpageTitleText) > 0}">
                    <p class="margin-0">
                        Page Titles :&quot;&nbsp;<b><i><c:out value="${originalpageTitleText}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>


            <c:choose>

                <c:when test="${fn:length(originalauthorText) > 0}">
                    <p class="margin-0">
                        Authors :&quot;&nbsp;<b><i><c:out value="${originalauthorText}"/></i></b>
                    </p>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>




            <c:if test="${hasFilters == 'true'}">
          <p class="margin-0">
          		<button type="button" id="btn_reset_filters" title="<spring:message code="search.filters.reset" />" class="button margin-top-10 text-small"><spring:message code="search.filters.reset" /></button>
          </p>
          </c:if> 
          
         </div>
      </div> 
      
    </form>
    </div>
    </div>
  </div>
</div>
