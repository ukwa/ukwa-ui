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
  
      <div class="row">
        <div class="col-md-12 col-sm-12 padding-top-20 search-notice">
          <spring:message code="search.main.tip" />
          <a href="search_tips" title="<spring:message code="search.main.tip.link.title" />">
          <spring:message code="search.main.tip.link" />
          </a> </div>
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
    </div>
  </div>
</div>
