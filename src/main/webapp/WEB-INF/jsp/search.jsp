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
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<c:set var="locale">
${pageContext.response.locale}
</c:set>
<jsp:useBean id="searchResults" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.SearchResultDTO>"/>
<jsp:useBean id="contentTypes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="publicSuffixes" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="domains" scope="request" type="java.util.List<java.lang.String>"/>
<jsp:useBean id="collections" scope="request" type="java.util.List<java.lang.String>"/>
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Search</title>
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
    <div class="col-lg-3 col-md-4 col-sm-12 sidebar padding-0">
      <form action="" method="get" enctype="multipart/form-data" name="filter_form" id="filter_form">
        <div class="sidebar-item toggle open" id="toggle-sidebar" role="tab"></div>
        <div class="sidebar-collapse">
          <%--   View facet   --%>
          <div class="sidebar-filter-header no-collapse" title="Access"> Access
            <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
          </div>
          <div class="sidebar-filter expanded">
            <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
              <div class="form-check-cont padding-0" title="Viewable anywhere" tabindex="0">
                <input type="radio" class="white access_filter" name="view_filter" id="view_filter_1" value="oa"
                      ${originalAccessView.contains('oa') || empty originalAccessView ? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="view_filter_1" title="Viewable anywhere"> Viewable anywhere </label>
              </div>
            </div>
            <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
              <div class="form-check-cont padding-0" title="Viewable only on Library permises" tabindex="0">
                <input type="radio" class="white access_filter" name="view_filter" id="view_filter_2" value="rro"
                      ${originalAccessView.contains('rro') ? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="view_filter_2" title="Viewable only on Library permises"> Viewable only on Library permises </label>
              </div>
            </div>
          </div>
          <section role="tablist">
            <%--   Domains collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" title="Domain" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title">Domain</div>
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel">
              <c:if test="${domains.size() > 1}">
                <c:forEach begin="0" end="${domains.size() - 1}" step="2" var="i">
                  <c:if test="${domains.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${domains.get(i)}"/>" tabindex="0">
                        <input type="checkbox" class="white" name="domain_filter" id="domain_filter_<c:out value="${i}"/>"
                             value="${domains.get(i)}"
                        ${originalDomains.contains(domains.get(i) )? 'checked' : ''}/>
                        <label class="main-search-check-label white text-medium" for="domain_filter_<c:out value="${i}"/>" title="<c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)">
                          <c:out value="${domains.get(i)}"/>
                          (
                          <c:out value="${domains.get(i + 1)}"/>
                          ) </label>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <%--   Document type collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open"  title="Document Type" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title">Document Type</div>
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel">
              <c:if test="${contentTypes.size() > 1}">
                <c:forEach begin="0" end="${contentTypes.size() - 1}" step="2" var="i">
                  <c:if test="${contentTypes.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${contentTypes.get(i)}"/>" tabindex="0">
                        <input type="checkbox" class="white" name="content_type" id="content_type_<c:out value="${i}"/>"
                       value="${contentTypes.get(i)}"
                       ${originalContentTypes.contains(contentTypes.get(i))? 'checked' : ''}/>
                        <label class="main-search-check-label white text-medium" for="content_type_<c:out value="${i}"/>">
                          <c:out value="${contentTypes.get(i)}"/>
                          (
                          <c:out value="${contentTypes.get(i + 1)}"/>
                          ) </label>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <%--   Public suffix collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" title="Public suffix" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title">Public Suffix</div>
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel">
              <c:if test="${publicSuffixes.size() > 1}">
                <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
                  <c:if test="${publicSuffixes.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${publicSuffixes.get(i)}"/>" tabindex="0">
                        <input type="checkbox" class="white" name="public_suffix" id="public_suffix_<c:out value="${i}"/>"
                       value="${publicSuffixes.get(i)}"
                  ${originalPublicSuffixes.contains(publicSuffixes.get(i) )? 'checked' : ''}/>
                        <label class="main-search-check-label white text-medium" for="public_suffix_<c:out value="${i}"/>">
                          <c:out value="${publicSuffixes.get(i)}"/>
                          (
                          <c:out value="${publicSuffixes.get(i + 1)}"/>
                          ) </label>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <%--   Archived year collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" title="Date archived" tabindex="0" id="dates_header" role="tab">
              <div class="sidebar-filter-header-title">Date Archived</div>
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" id="dates_container" role="tabpanel">
              <div class="row padding-bottom-20">
                <div class="col-sm-3">
                  <label for="from_date" class="white">From</label>
                </div>
                <div class="col-sm-7">
                  <input type="text" class="form-control blue form-white-placeholder" name="from_date" id="from_date" title="From" placeholder="YYYY-MM-DD"
                       value="${originalFromDateText != null ? originalFromDateText : ''}"/>
                </div>
              </div>
              <div class="row padding-bottom-20">
                <div class="col-sm-3">
                  <label for="to_date" class="white">To</label>
                </div>
                <div class="col-sm-7">
                  <input type="text" class="form-control blue form-white-placeholder" name="to_date" id="to_date" title="From" placeholder="YYYY-MM-DD"
                       value="${originalToDateText != null ? originalToDateText : ''}"/>
                </div>
              </div>
              <div class="row">
                <div class="col-sm-12">
                  <button type="submit" title="Confirm date range" class="button button-white float-sm-right">Confirm date range</button>
                </div>
              </div>
            </div>
            <%--   Collection collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" title="Restrict to collection" tabindex="0" role="tab">
              <div class="sidebar-filter-header-title">Special Collection</div>
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text" tabindex="0"></div>
            </div>
            <div class="sidebar-filter" role="tabpanel">
              <c:if test="${collections.size() > 1}">
                <c:forEach begin="0" end="${collections.size() - 1}" step="2" var="i">
                  <c:if test="${collections.get(i + 1) != 0}">
                    <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                      <div class="form-check-cont padding-0" title="<c:out value="${collections.get(i)}"/>">
                        <input type="checkbox" class="white" name="collection" id="collection_<c:out value="${i}"/>"
                             value="${collections.get(i)}"
                        ${originalCollections.contains(collections.get(i) )? 'checked' : ''}/>
                        <label class="main-search-check-label white text-medium" for="collection_<c:out value="${i}"/>"
                             title="<c:out value="${collections.get(i)}"/> (<c:out value="${collections.get(i + 1)}"/>)">
                          <c:out value="${collections.get(i)}"/>
                          (
                          <c:out value="${collections.get(i + 1)}"/>
                          ) </label>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </div>
            <input type="hidden" name="search_location" id="search_location" value="${originalSearchLocation}">
            <input type="hidden" name="text" id="text" value="${originalSearchRequest}">
            <input type="hidden" name="view_sort" id="view_sort" value="${empty originalSortValue ? 'nto' : originalSortValue}">
            <input type="hidden" name="view_count" id="view_count" value="${empty rowsPerPageLimit ? '50' : rowsPerPageLimit}">
          </section>
        </div>
      </form>
    </div>
    <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
      <div class="results-header border-bottom-gray">
        <div class="float-left padding-top-5">
          <c:out value="${totalSearchResultsSize}"/>
          results for <span class="bold">"
          <c:out value="${originalSearchRequest}"/>
          "</span></div>
        <div tabindex="0">
          <div class="help-button small search-help-button" data-toggle="tooltip" title="This is placeholder text"></div>
          <div class="help-button-text">Help</div>
        </div>
        <div class="clearfix"></div>
      </div>
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
          <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="Previous page" aria-label="Previous page"></div></a> </c:if>
          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
          <c:if test="${i <= totalPages}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>">
          <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}" title="${i == targetPageNumber ? "Current page - page " : "Go to page "}<c:out value="${i}"/>" aria-label="${i == targetPageNumber ? "Current page - page " : "Go to page "}<c:out value="${i}"/>">
          <c:out value="${i}"/>
        </div></a>
        </c:if>
        </c:forEach>
        <c:if test="${targetPageNumber + 4 < totalPages}">
          <div class="pagination-button dots inactive"></div>
          <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="Go to page <c:out value="${totalPages}"/>" aria-label="<c:out value="Go to page ${totalPages}"/>">
            <c:out value="${totalPages}"/>
          </div></a> </c:if>
        <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="Next page" aria-label="Next page"></div></a> </c:if>
      </div>
    </div>
    <div class="row border-bottom-gray margin-0">
      <div class="col-md-12 padding-20">
        <div class="search-results-top-filters" style="width:200px;">
          <div class="form-check-cont padding-0" title="Newest to Oldest">
            <input type="radio" name="sort" id="sort_1" value="nto" class="sort"
              ${originalSortValue.contains('nto') || empty originalSortValue ? 'checked' : ''}/>
            <label class="main-search-check-label" for="sort_1" title="Newest to Oldest"> Newest to Oldest </label>
          </div>
        </div>
        <div class="search-results-top-filters" style="width:200px;">
          <div class="form-check-cont padding-0" title="Oldest to Newest">
            <input type="radio" name="sort" id="sort_2" value="otn" class="sort"
              ${originalSortValue.contains('otn') ? 'checked' : ''}/>
            <label class="main-search-check-label" for="sort_2" title="Oldest to Newest"> Oldest to Newest </label>
          </div>
        </div>
        <div class="search-results-top-filters" style="width:280px;padding-top:5px;padding-right:50px;">
          <label for="count" title="Items per page" style="margin-top:5px;">Items per page</label>
          <select class="form-control search-results-display-count" name="count" id="count">
            <option value="50" ${rowsPerPageLimit == 50 ? 'selected' : ''}>50</option>
            <option value="100" ${rowsPerPageLimit == 100 ? 'selected' : ''}>100</option>
            <option value="200" ${rowsPerPageLimit == 200 ? 'selected' : ''}>200</option>
          </select>
        </div>
      </div>
    </div>
    <c:forEach items="${searchResults}" var="searchResult"> 
      <!--RESULT ROW-->
      <div class="row margin-0 padding-0 border-bottom-gray">
        <div class="col-lg-10 col-md-12 results-result">
          <h2 class="margin-0">
            <c:out value="${searchResult.title}"/>
          </h2>
          <span class="results-title-text results-title-date padding-0"> &nbsp;&nbsp;-&nbsp;&nbsp;
          <c:out value="${searchResult.date}"/>
          </span> <span class="results-title-text clearfix padding-vert-10"> <a class="results-link" href="<c:out value="${searchResult.url}"/>">
          <c:out value="${searchResult.displayUrl}"/>
          </a> </span> <span class="results-title-text clearfix">
          <c:out value="${searchResult.text}"/>
          </span> </div>
        <div class="col-lg-2 col-md-12 padding-20"> 
          <!--<div class="social-button fb float-right margin-left-10" title="Facebook"></div>
            <div class="social-button twitter float-right margin-left-10" title="Twitter"></div>--> 
        </div>
      </div>
      
      <!--/RESULT ROW--> 
    </c:forEach>
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
        <c:if test="${targetPageNumber > 1}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>"><div class="pagination-button arrow left-arrow" title="Previous page" aria-label="Previous page"></div></a> </c:if>
        <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
        <c:if test="${i <= totalPages}">
        <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>"> <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}" title="${i == targetPageNumber ? "Current page - page " : "Go to page "}<c:out value="${i}"/>" aria-label="${i == targetPageNumber ? "Current page - page " : "Go to page "}<c:out value="${i}"/>">
        <c:out value="${i}"/>
      </div></a>
      </c:if>
      </c:forEach>
      <c:if test="${targetPageNumber + 4 < totalPages}">
        <div class="pagination-button dots inactive"></div>
        <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>"><div class="pagination-button inactive" title="Go to page <c:out value="${totalPages}"/>" aria-label="Go to page <c:out value="${totalPages}"/>">
          <c:out value="${totalPages}"/>
        </div></a> </c:if>
      <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}"> <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>"><div class="pagination-button arrow right-arrow" title="Next page" aria-label="Next page"></div></a> </c:if>
    </div>
  </div>
  </div>
  </div>
</section>
<div class="up-button" title="To top of page" aria-label="To top of page"  tabindex="0"></div>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
<script>

$(document).ready(function(e) {

	$("#from_date, #to_date").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true,
        changeYear: true,
		//minDate: new Date('1996/01/01'),
		yearRange: "-50:+0"
	});

	//filters toggle and count
	$(".sidebar-filter-header:not(.no-collapse)").each(function(index, element) {

		//toggle
		$(this).click(function(e) {
            if ($(this).hasClass("open")) {
				$(this).next(".sidebar-filter").addClass("expanded");
				$(this).removeClass("open");
				$(this).addClass("closee");
			} else {
				$(this).next(".sidebar-filter").removeClass("expanded");
				$(this).removeClass("closee");
				$(this).addClass("open");
			}
        });

		//count
		$(this).children(".sidebar-filter-count").text($(this).next(".sidebar-filter").children(".sidebar-filter-checkbox").children(".form-check-cont").children("input:checked").length);
		
		//expand selected
		if ($(this).next(".sidebar-filter").children(".sidebar-filter-checkbox").children(".form-check-cont").children("input:checked").length!=0) {
			$(this).removeClass("open");
			$(this).addClass("closee");
			$(this).next(".sidebar-filter").addClass("expanded");
		}
		
    });
	
	//expand if dates inputed
	if ($("#from_date").val()!=="" || $("#to_date").val()!=="") {
		$("#dates_header").removeClass("open");
		$("#dates_header").addClass("closee");
		$("#dates_container").addClass("expanded");
	}

	//change filters
	$("input[type='checkbox'], .access_filter").click(function(e) {
        $("#filter_form").submit();
    });

	//submit on resort
	$(".sort").each(function(index, element) {
        $(this).click(function(e) {
            $("#view_sort").val($(this).val());
			$("#filter_form").submit();
        });
    });

	//form count
	$("#count").change(function(e) {
		$("#view_count").val($(this).val());
		$("#filter_form").submit();
	});
	
	//form validation
	$("#filter_form").submit(function(e) {
        
		var isValid = true;
		
		if ($("#from_date").val().trim()!=="" && !Date.parse($("#from_date").val())) isValid=false;
		if ($("#to_date").val().trim()!=="" && !Date.parse($("#to_date").val())) isValid=false;
		
		if (isValid) {
			return true;
		} else {
			alert("Please enter valid date(s) for the date range.");
			return false;
		}
		
    });

});

</script>
</body>
</html>
