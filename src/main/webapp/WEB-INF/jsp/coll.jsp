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
<spring:message code='coll.title' var="sectionTitle"/>
<c:set var="headerTitle" value="${currentCollection.name} | ${sectionTitle}"/>
<html lang="${locale}">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>${headerTitle}</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>

<c:set var="title" value="${currentCollection.name}"/>
<%@include file="title.jsp" %>

<section id="content">

    <div class="">
<div class="row margin-0 px-md-3 px-sm-0">

  <div class="col-sm-12" id="coll_header">

        <div class="row results-header margin-0 border-bottom-gray px-md-3 px-sm-0">

<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><spring:message code="coll.breadcrumb.text1" />&nbsp;<a href="collection" title="<spring:message code="coll.breadcrumb.text2" />"><spring:message code="coll.breadcrumb.text2" /></a></li>
    <c:forEach var="pathItem" items="${breadcrumbPath}">
      <c:set var="pathCount" value="${pathCount + 1}"/>
      <c:choose>
        <c:when test="${pathCount < fn:length(breadcrumbPath)}">
         <li class="breadcrumb-item" aria-current="page">
          <a href="collection/<c:out value="${pathItem.key}"/>" title="<c:out value="${pathItem.value}"/>"><c:out value="${pathItem.value}"/></a>
         </li>
        </c:when>
        <c:otherwise>
          <li class="breadcrumb-item active" aria-current="page">${pathItem.value}</li>
        </c:otherwise>
      </c:choose>
    </c:forEach>
  </ol>
</nav>

    <div class="row margin-0 padding-side-5">
      <div class="col-md-12 col-sm-12 pl-0 pr-0 padding-top-20 padding-bottom-20">
        <p class="margin-top-20 margin-bottom-0 hidden topics-themes-description" id="coll_description" data-descript="<c:out value="${currentCollection.description}"/>"></p>
        <p class="margin-bottom-0"><a href="#" class="hidden" title="<spring:message code="coll.readmore" />" id="readmore"><spring:message code="coll.readmore" /></a></p>
      </div>
    </div>

         <div class="row margin-0 border-bottom-gray">
   <div class="col-md-6 col-sm-12 padding-bottom-20 padding-20">
       <form role="form" action="search" method="get" enctype="multipart/form-data" name="search_coll_form" id="search_coll_form">
           <div class="row padding-bottom-20">
               <div class="col-sm-12">
                   <div class="container-search-field-group" role="group">
                       <input role="textbox" type="text" class="homepage-search-input" name="text" id="text_collections"
                              title="<spring:message code="coll.search.text1" /> &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />"
                              aria-label="<spring:message code="coll.search.text1" /> &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />"
                              placeholder="<spring:message code="coll.search.text1" /> within &quot;<c:out value="${currentCollection.name}"/>&quot; <spring:message code="coll.search.text2" />"
                              required tabindex="0"/>
                       <input aria-hidden="true" type="hidden" name="search_location" value="full_text"/>
                       <input aria-hidden="true" type="hidden" name="collection"
                              value="<c:out value="${currentCollection.name}"/>"/>
                       <button role="button" type="submit" class="btn btn-lg homepage-search-button"
                               aria-label="Search within <c:out value="${currentCollection.name}"/> Collection"
                               title="<spring:message code="coll.search.button" />" tabindex="0">Search <i
                               class="fa fa-search ml-2"></i>
                       </button>
                   </div>
                </div>
              </div>
           <input aria-hidden="true" type="hidden" name="filter_source" id="input_hidden_field_filter_source" value="3" />
       </form>
    </div>
    </div>

    <c:if test="${!empty subCollections}">
      <%--Do something if subCollections not empty--%>
      <ul class="row margin-0">
        <%--LOOP of Sub collections--%>
        <c:forEach items="${subCollections}" var="subCollection">
          <li class="col-lg-3 col-md-6 col-sm-12 image-grid-col padding-20 padding-bottom-20" style="list-style: none;"> <a href="collection/<c:out value="${subCollection.id}"/>" class="collection-link">
            <div class="center padding-bottom-10 collection-heading">
              <c:out value="${subCollection.name}"/>
            </div>
              <div class="sub-coll-descript shadow collection-description">
                <c:out value="${subCollection.description}"/>
              </div>
            </a>
          </li>
        </c:forEach>
      </ul>
    </c:if>

<c:if test="${currentCollection.websitesNum != 0}"> <%--START if no results does not show results rows and pagination at all--%>
      <div class="row border-bottom-gray margin-0 padding-20">
        <div class="col-sm-12 padding-0">
            <c:choose>
              <c:when test="${currentCollection.websitesNum == 1}">
                  <span class="results-count">1&nbsp;<span class="results-count"><spring:message code="coll.results.num.single" /></span></span>
              </c:when>
              <c:when test="${currentCollection.websitesNum > 1}">
                  <span class="results-count"><c:out value="${currentCollection.websitesNum}"/>&nbsp;<span class="results-count"><spring:message code="coll.results.num.plural" /></span></span>
              </c:when>
            </c:choose>
        </div>
      </div>

    <c:choose>
        <c:when test="${fn:length(targetWebsites) > 0}">
            <%-- TOP PAGINATION ROW --%>
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
                    <c:if test="${targetPageNumber > 1}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-number-redesign arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div><spring:message code="search.results.previous" /></a></c:if>
                    <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                        <c:if test="${i <= totalPages}">
                            <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>"> <div class="pagination-number-redesign ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                <c:out value="${i}"/>
                            </div></a>
                        </c:if>
                    </c:forEach>

                    <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"><spring:message code="search.results.next" /><div class="pagination-number-redesign arrow right-arrow"></div></a> </c:if>
                </div>
            </div>
            <%-- /TOP PAGINATION ROW --%>
            <div class="results-container">
            <%-- RESULT ROW --%>
                    <c:forEach items="${targetWebsites}" var="targetWebsite">
                        <!--RESULT ROW-->
                        <li class="row margin-0 padding-0 border-bottom-gray col-md-12 col-sm-12">
                            <div class=" results-result">
                                <h2 class="main-heading-2-bold-redesign margin-0">
                                    <c:out value="${targetWebsite.name}"/>
                                </h2><br/>
                                <c:choose>
                                    <c:when test="${targetWebsite.access == 'RRO' && userIpFromBl}">
              <span class="results-title-text results-lib-premises text-smaller">
                <spring:message code="search.results.library.premises" />
              </span>
                                    </c:when>
                                    <c:when test="${targetWebsite.access == 'RRO' && !userIpFromBl}">
              <span class="results-title-text results-lib-premises text-smaller">
                <spring:message code="search.results.library.premises" />
              </span>
                                    </c:when>
                                </c:choose>

                                <c:out value="${targetWebsite.description}"/>
                                <c:if test="${not empty targetWebsite.startDate}">
                        <span class="results-title-text margin-top-10 clearfix"> <spring:message code="coll.archived.date"/>
            <c:out value="${targetWebsite.startDate}"/>
          </span>
                                </c:if>
                                <span class="results-title-text clearfix padding-vert-10">
              <a href="<c:out value="${targetWebsite.archiveUrl}"/>" class="break-all"><c:out value="${targetWebsite.url}"/></a>
            </span>
                            </div>
                        </li>
                        <!--/RESULT ROW-->
                        <%-- /RESULT ROW --%>
                    </c:forEach>
                </ul>
            </div>
            <%--BOTTOM PAGINATION ROW --%>
            <div class="row padding-0 margin-0">
                <div class="col-md-12 pagination-cont ">
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
                    <c:if test="${targetPageNumber > 1}"><a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-number-redesign arrow left-arrow" title="<spring:message code="pagination.previous" />" aria-label="<spring:message code="pagination.previous" />"></div><spring:message code="search.results.previous" /></a></c:if>
                    <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
                        <c:if test="${i <= totalPages}">
                            <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>" title="${i == targetPageNumber ? currentPage : goToPage} <c:out value="${i}"/>" aria-label="${i == targetPageNumber ? currentPage : goToPage } <c:out value="${i}"/>"><div class="pagination-number-redesign ${i == targetPageNumber ? "active" : "inactive hide-mobile"}">
                                <c:out value="${i}"/>
                            </div></a>
                        </c:if>
                    </c:forEach>

                    <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="collection/<c:out value="${currentCollection.id}"/><c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>" title="<spring:message code="pagination.next" />" aria-label="<spring:message code="pagination.next" />"><spring:message code="search.results.next" /><div class="pagination-number-redesign arrow right-arrow"></div></a> </c:if>
                </div>
            </div>
            <%--/BOTTOM PAGINATION ROW --%>
        </c:when>
        <c:otherwise>
            <c:choose>
                <%-- NO RESULTS --%>
                <c:when test="${currentCollection.websitesNum == 0 && empty subCollections}">
                    <div class="row margin-0 padding-0 border-bottom-gray">
                        <div class="col-md-12 col-sm-12 results-result">
                            <div class="main-heading-2-bold-redesign margin-0 padding-top-20 ">
                                <spring:message code="coll.noresults" />
                            </div>
                        </div>
                    </div>
                </c:when>
                <%-- /NO RESULTS --%>
                <c:otherwise>
                    <%-- CASE OF MANUAL PAGINATION ATTEMPT  --%>
                    <div class="row margin-0 padding-0 border-bottom-gray">
                        <div class="col-md-12 col-sm-12 results-result">
                            <div class="main-heading-2-bold-redesign margin-0 padding-top-20 ">
                                <spring:message code="coll.nopagingresults" />
                            </div>
                        </div>
                    </div>
                    <%-- /CASE OF MANUAL PAGINATION ATTEMPT  --%>
                    <%--BOTTOM PAGINATION ROW --%>
                    <div class="row padding-0 margin-0">
                        <div class="col-md-12 pagination-cont">
                                <%--preserve all current parameters in URL and change only page parameter--%>
                                    <c:if test="${targetPageNumber > totalSearchResultsSize/rowsPerPageLimit}">
                                        <a href="collection/<c:out value="${currentCollection.id}"/>?page=<c:out value="${(totalPages)}"/>" title="<spring:message code="pagination.next" />"  aria-label="<spring:message code="pagination.next" />"><div class="pagination-number-redesign arrow left-arrow"></div>
                                            Return to nearest result list</a>
                                    </c:if>
                        </div>
                    </div>
                    <%--/BOTTOM PAGINATION ROW --%>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>

</c:if> <%--END if no results does not show results rows and pagination at all--%>
  </div>
</div>
    </div>
    </div>
</section>
<div class="up-button" role="button" title="<spring:message code="top.of.page" />" aria-label="<spring:message code="top.of.page" />" tabindex="0"></div>
<footer class="footer-content">
  <%@include file="footer.jsp" %>
</footer>
</div>
<input aria-hidden="true" type="hidden" id="no-coll-description" name="no-coll-description" value="<spring:message code="coll.nodescript" />" />
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
