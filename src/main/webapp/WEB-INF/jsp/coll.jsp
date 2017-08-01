<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}"/>
<c:set var="uri" value="${req.requestURI}"/>
<c:set var="url">
${req.requestURL}
</c:set>
<c:set var="locale">
${pageContext.response.locale}
</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<jsp:useBean id="targetWebsites" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO>"/>
<jsp:useBean id="subCollections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>
<jsp:useBean id="currentCollection" scope="request" type="com.marsspiders.ukwa.controllers.data.CollectionDTO"/>
<jsp:useBean id="breadcrumbPath" scope="request" type="java.util.Map<java.lang.String, java.lang.String>"/>
<spring:message code="pagination.goto" var="goToPage"/>
<spring:message code="pagination.current" var="currentPage"/>
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title><spring:message code="coll.title" /></title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="content">
<div class="row margin-0 padding-0">


  <div class="col-sm-12 padding-0" id="coll_header">
  
        <div class="row results-header margin-0 border-bottom-gray">
        <div class="col-sm-12 padding-left-0">
          <span class="bold"><spring:message code="coll.breadcrumb.text1" /></span>
          <a href="collection" title="<spring:message code="coll.breadcrumb.text2" />"><spring:message code="coll.breadcrumb.text2" /></a>
          <c:forEach var="pathItem" items="${breadcrumbPath}">
            <c:set var="pathCount" value="${pathCount + 1}"/>
            &gt;
            <c:choose>
              <c:when test="${pathCount < fn:length(breadcrumbPath)}">
                <a href="collection/<c:out value="${pathItem.key}"/>" title="<c:out value="${pathItem.value}"/>"><c:out value="${pathItem.value}"/></a>
              </c:when>
              <c:otherwise>
                <c:out value="${pathItem.value}"/>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          </div>
      </div>
  
    <div class="row margin-0 padding-side-5">
      <div class="col-md-12 col-sm-12 padding-top-40 padding-bottom-20 light-blue">
        <h2 class="padding-0 margin-0 collection-main-heading">
          <c:out value="${currentCollection.name}"/>
        </h2>
        <p class="black margin-top-20 margin-bottom-0 hidden" id="coll_description" data-descript="<c:out value="${currentCollection.description}"/>"></p>
        <p class="margin-bottom-0"><a href="#" class="hidden" title="<spring:message code="coll.readmore" />" id="readmore"><spring:message code="coll.readmore" /></a></p>
      </div>
    </div>
    
         <div class="row margin-0 border-bottom-gray">
   <div class="col-md-6 col-sm-12 padding-bottom-20 padding-20 light-blue">
       <form action="search" method="get" enctype="multipart/form-data" name="search_coll_form" id="search_coll_form">
       <div class="row padding-bottom-20">
            <div class="col-sm-12">
                  <div class="coll-search-input">
                  <input type="text" class="coll-search-field" name="text" id="text_collections" title="<spring:message code="coll.search.text1" /> &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />" aria-label="<spring:message code="coll.search.text1" /> &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />" placeholder="<spring:message code="coll.search.text1" /> &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />" required/>
                  <input type="hidden" name="search_location" value="full_text"/>
                  <input type="hidden" name="collection" value="<c:out value="${currentCollection.name}"/>"/>
                  <button type="submit" class="coll-search-button" title="<spring:message code="coll.search.button" />
        ">
        </button>
      </div>

                </div>
              </div>

        </form>
    </div>
    </div>
    
    <c:if test="${!empty subCollections}">
      <%--Do something if subCollections not empty--%>
      <div class="row margin-0 border-bottom-gray">
        <%--LOOP of Sub collections--%>
        <c:forEach items="${subCollections}" var="subCollection">
          <div class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-20 padding-bottom-20"> <a href="collection/<c:out value="${subCollection.id}"/>" class="collection-link">
            <div class="center light-blue padding-bottom-10 collection-heading">
              <c:out value="${subCollection.name}"/>
            </div>
              <div class="sub-coll-descript shadow collection-description">
                <c:out value="${subCollection.description}"/>
              </div>
            </a> </div>
        </c:forEach>
      </div>
    </c:if>

      
      <div class="row border-bottom-gray margin-0 padding-20">
        <div class="col-sm-12 padding-0">
          <span class="results-count">
          <c:out value="${currentCollection.websitesNum}"/></span> <spring:message code="coll.results.num" />
      
      </div>
      </div>
      


    <div class="row padding-0 margin-0">
        <div class="col-md-12 pagination-cont border-bottom-gray">
          <%--preserve all current parameters in URL and change only page parameter--%>
          <c:url var="nextUrl" value="">
            <c:forEach items="${param}" var="entry">
              <c:if test="${entry.key != 'page'}">
                <c:param name="${entry.key}" value="${entry.value}" />
              </c:if>
            </c:forEach>
            <%--set page value as a placeholder as it is going to be changed for each link--%>
            <c:param name="page" value="PAGE_NUM_PLACEHOLDER" />
          </c:url>
          <c:if test="${targetPageNumber > 1}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div></a> </c:if>

          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
            <c:if test="${i <= totalPages}">
              <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>"> <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}" title="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>">
                <c:out value="${i}"/>
              </div></a>
            </c:if>
          </c:forEach>

          <c:if test="${targetPageNumber + 4 < totalPages}">
            <div class="pagination-button dots inactive"></div>
            <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>" aria-label="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>">
              <c:out value="${totalPages}"/>
            </div></a> </c:if>
          <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"></div></a> </c:if>
        </div>
    </div>

    <c:forEach items="${targetWebsites}" var="targetWebsite"> 
      <!--RESULT ROW-->
      <div class="row margin-0 padding-0 border-bottom-gray">
        <div class="col-md-12 col-sm-12 results-result">
          <h2 class="margin-0">
            <c:out value="${targetWebsite.name}"/>
          </h2>
          <span class="results-title-text clearfix">
          <c:out value="${targetWebsite.description}"/>
          </span> <span class="results-title-text clearfix"> <spring:message code="coll.archived.date" />
          <c:out value="${targetWebsite.startDate}"/>
          </span>
          <span class="results-title-text clearfix padding-vert-10">
              <a href="<c:out value="${targetWebsite.archiveUrl}"/>" class="break-all"><c:out value="${targetWebsite.archiveUrl}"/></a>
            </span>
        </div>
      </div>
      <!--/RESULT ROW--> 
    </c:forEach>
	
    <!--NO RESULTS-->
    <c:if test="${currentCollection.websitesNum == 0}">
    <div class="row margin-0 padding-0 border-bottom-gray">
        <div class="col-md-12 col-sm-12 results-result">
          <h2 class="margin-0 padding-top-20 gray">
            <spring:message code="coll.noresults" />
          </h2>
        </div>
      </div>
    </c:if>
    <!--/NO RESULTS-->
    
    <div class="row padding-0 margin-0">
      <div class="col-md-12 pagination-cont">
        <%--preserve all current parameters in URL and change only page parameter--%>
        <c:url var="nextUrl" value="">
          <c:forEach items="${param}" var="entry">
            <c:if test="${entry.key != 'page'}">
              <c:param name="${entry.key}" value="${entry.value}" />
            </c:if>
          </c:forEach>
          <%--set page value as a placeholder as it is going to be changed for each link--%>
          <c:param name="page" value="PAGE_NUM_PLACEHOLDER" />
        </c:url>
        <c:if test="${targetPageNumber > 1}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div></a> </c:if>

        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
          <c:if test="${i <= totalPages}">
            <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>"> <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive hide-mobile"}" title="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>">
              <c:out value="${i}"/>
            </div></a>
          </c:if>
        </c:forEach>

        <c:if test="${targetPageNumber + 4 < totalPages}">
          <div class="pagination-button dots inactive"></div>
          <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>" aria-label="<spring:message code="pagination.goto" /> <c:out value="${totalPages}"/>">
            <c:out value="${totalPages}"/>
          </div></a> </c:if>
        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"></div></a> </c:if>
      </div>
    </div>
  </div>
</div>
</section>
<div class="up-button" title="<spring:message code="top.of.page" />" aria-label="<spring:message code="top.of.page" />" tabindex="0"></div>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<input type="hidden" id="no-coll-description" name="no-coll-description" value="<spring:message code="coll.nodescript" />" />
<script>

	function showDescript(descript, len) {
	
		if (descript.length>len) {
			$("#coll_description").text(descript.substr(0,len)+"...");
			$("#readmore").show();
		} else {
			$("#coll_description").text(descript);
		}
		
		return true;	
		
	}
	
	$(document).ready(function(e) {
		
		var descript=$("#coll_description").attr("data-descript");
		var len=360;
		var short=true;
		var readmore = '<spring:message code="coll.descript.readmore" />';
		var readless = '<spring:message code="coll.descript.readless" />';
		
		showDescript(descript, len);
		
		$("#coll_description").show();
		
		$("#readmore").click(function(e) {
			e.preventDefault();
			if (short) {
				$(this).attr("title", readless).text(readless);
				$("#coll_description").text(descript);
				short=false;
				
			} else {
				$(this).attr("title", readmore).text(readmore);
				showDescript(descript, len);
				short=true;
			}
		});
			
		
	});
	</script>
</body>
</html>
