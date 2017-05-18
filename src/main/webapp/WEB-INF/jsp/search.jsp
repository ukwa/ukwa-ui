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
<jsp:useBean id="collectionsNamesToId" scope="request" type="java.util.Map<java.lang.String, java.lang.String>"/>


<html>
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
        <div class="sidebar-item toggle open" id="toggle-sidebar"></div>
        <div class="sidebar-collapse">
          <form action="" method="get" enctype="multipart/form-data" name="filter_form" id="filter_form">

		
          <%--   Domains collapse filter   --%>
          <div class="sidebar-filter-header open" title="Domain" tabindex="1">
            Domain
            <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text"></div>
          </div>
          <div class="sidebar-filter">

            <c:if test="${domains.size() > 1}">
              <c:forEach begin="0" end="${domains.size() - 1}" step="2" var="i">
                <c:if test="${domains.get(i + 1) != 0}">

                  <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                    <div class="form-check-cont padding-0" title="<c:out value="${domains.get(i)}"/>">
                      <input type="checkbox" class="white" name="domain_filter" id="domain_filter_<c:out value="${i}"/>"
                             value="${domains.get(i)}"
                        ${originalDomains.contains(domains.get(i) )? 'checked' : ''}/>
                      <label class="main-search-check-label white text-medium" for="domain_filter_<c:out value="${i}"/>" title="<c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)">
                        <c:out value="${domains.get(i)}"/> (<c:out value="${domains.get(i + 1)}"/>)
                      </label>
                    </div>
                  </div>

                </c:if>
              </c:forEach>
            </c:if>

          </div>



          <%--   Document type collapse filter   --%>
          <div class="sidebar-filter-header border-top-white open"  title="Document Type" tabindex="1">
            Document Type
            <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text"></div>
          </div>
          <div class="sidebar-filter">

      <c:if test="${contentTypes.size() > 1}">
        <c:forEach begin="0" end="${contentTypes.size() - 1}" step="2" var="i">
          <c:if test="${contentTypes.get(i + 1) != 0}">

            <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
              <div class="form-check-cont padding-0" title="<c:out value="${contentTypes.get(i)}"/>">
                <input type="checkbox" class="white" name="content_type" id="content_type_<c:out value="${i}"/>"
                       value="${contentTypes.get(i)}"
                       ${originalContentTypes.contains(contentTypes.get(i))? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="content_type_<c:out value="${i}"/>">
                  <c:out value="${contentTypes.get(i)}"/> (<c:out value="${contentTypes.get(i + 1)}"/>)
                </label>
              </div>
            </div>

          </c:if>
        </c:forEach>
      </c:if>

          </div>

          <%--   Public suffix collapse filter   --%>
          <div class="sidebar-filter-header border-top-white open" title="Public suffix" tabindex="1">
           Public Suffix
            <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text"></div>
          </div>
          <div class="sidebar-filter">

      <c:if test="${publicSuffixes.size() > 1}">
        <c:forEach begin="0" end="${publicSuffixes.size() - 1}" step="2" var="i">
          <c:if test="${publicSuffixes.get(i + 1) != 0}">

            <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
              <div class="form-check-cont padding-0" title="<c:out value="${publicSuffixes.get(i)}"/>">
                <input type="checkbox" class="white" name="public_suffix" id="public_suffix_<c:out value="${i}"/>"
                       value="${publicSuffixes.get(i)}"
                  ${originalPublicSuffixes.contains(publicSuffixes.get(i) )? 'checked' : ''}/>
                <label class="main-search-check-label white text-medium" for="public_suffix_<c:out value="${i}"/>">
                  <c:out value="${publicSuffixes.get(i)}"/> (<c:out value="${publicSuffixes.get(i + 1)}"/>)
                </label>
              </div>
            </div>

          </c:if>
        </c:forEach>
      </c:if>

          </div>



            <%--   Archived year collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open" title="Date archived" tabindex="1" id="dates_header">
              Date Archived
               <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text"></div>
            </div>
            <div class="sidebar-filter" id="dates_container">

              <div class="row padding-bottom-20">
              <div class="col-sm-3"><label for="from_date" class="white">From</label></div>
              <div class="col-sm-7">
                <input type="text" class="form-control blue" name="from_date" id="from_date" title="From"
                       value="${originalFromDateText != null ? originalFromDateText : ''}"/></div>
              </div>
              <div class="row padding-bottom-20">
              <div class="col-sm-3"><label for="to_date" class="white">To</label></div>
              <div class="col-sm-7">
                <input type="text" class="form-control blue" name="to_date" id="to_date" title="From"
                       value="${originalToDateText != null ? originalToDateText : ''}"/>
              </div>
			</div>
            
              <div class="row">
              <div class="col-sm-12"><button type="submit" title="Confirm date range" class="button button-white float-sm-right">Confirm date range</button></div>
			</div>

            </div>

                      <%--   Collection collapse filter   --%>
            <div class="sidebar-filter-header border-top-white open"  title="Restrict to collection" tabindex="1">
              Special Collection
              <div class="help-button small white" data-toggle="tooltip" title="This is placeholder text"></div>
            </div>
            <div class="sidebar-filter">
              <c:forEach items="${collectionsNamesToId}" var="collection">

                <div class="sidebar-filter-checkbox col-md-12 col-sm-12">
                  <div class="form-check-cont padding-0" title="<c:out value="${collection.value}"/>">
                    <input type="checkbox" class="white" name="collection" id="collection_<c:out value="${i}"/>"
                           value="${collection.key}"
                      ${originalCollectionIds.contains(collection.key) ? 'checked' : ''}
                    />
                    <label class="main-search-check-label white text-medium" for="collection_suffix_<c:out value="${i}"/>">
                      <c:out value="${collection.value}"/>
                    </label>
                  </div>
                </div>

              </c:forEach>

            </div>

            <input type="hidden" name="search_location" id="search_location" value="${originalSearchLocation}">
            <input type="hidden" name="text" id="text" value="${originalSearchRequest}">

            <input type="hidden" name="view_sort" id="view_sort" value="nto">
            <input type="hidden" name="view_count" id="view_count" value="100">

          </form>
        </div>
      </div>


      <div class="col-lg-9 col-md-8 col-sm-12 padding-0">
        <div class="results-header border-bottom-gray">
          <div class="float-left padding-top-5"><c:out value="${totalSearchResultsSize}"/> results for <span class="bold">"<c:out value="${originalSearchRequest}"/>"</span></div>
          <div class="help-button small" data-toggle="tooltip" title="This is placeholder text" style="margin-right:60px;"></div>
          <div class="help-button-text">Help</div>
          <div class="clearfix"></div>
        </div>

        <div class="row padding-0 margin-0 border-bottom-gray">
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

          <c:if test="${targetPageNumber > 1}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>">
              <div class="pagination-button arrow left-arrow" title="Previous page"></div></a>
          </c:if>

          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
            <c:if test="${i <= totalPages}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>">
              <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}" title="<c:out value="${i}"/>">
                <c:out value="${i}"/>
              </div></a>
            </c:if>
          </c:forEach>
          <c:if test="${targetPageNumber + 4 < totalPages}">
           <div class="pagination-button dots inactive"></div>
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>">
              <div class="pagination-button inactive" title="<c:out value="${totalPages}"/>">
                <c:out value="${totalPages}"/>
              </div></a>
          </c:if>

          <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>">
              <div class="pagination-button arrow right-arrow" title="Next page"></div>
            </a>
          </c:if>
          </div>
        </div>



        <c:forEach items="${searchResults}" var="searchResult">
        <!--RESULT ROW-->
        <div class="row margin-0 padding-0 border-bottom-gray">
          <div class="col-lg-3 col-md-12 padding-20 bg-gray results-border">
            <div class="row margin-0 padding-0">
              <div class="col-lg-12 col-md-6 col-sm-6 col-xs-6 padding-bottom-20 padding-left-0">
                <!--<span class="light-blue bold text-bigger">5035</span><br/>-->
                Results found for the domain:
                <a href="<c:out value="${searchResult.domain}"/>"><c:out value="${searchResult.displayDomain}"/></a>
              </div>
              <div class="col-lg-12 col-md-6 col-sm-6 col-xs-6 padding-side-0">
                 Archived on:<br/>
                 <c:out value="${searchResult.date}"/>
              </div>
            </div>
          </div>
          <div class="col-lg-7 col-md-12 results-result">
            <h2 class="margin-0"><c:out value="${searchResult.title}"/></h2>
            <span class="results-title-text clearfix padding-0">
              
            </span>
            <span class="results-title-text clearfix padding-vert-10">
              <a class="results-link" href="<c:out value="${searchResult.url}"/>"><c:out value="${searchResult.displayUrl}"/></a>
            </span>
            <span class="results-title-text clearfix">
              <c:out value="${searchResult.text}"/>
            </span>
          </div>
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

          <c:if test="${targetPageNumber > 1}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber - 1))}"/>">
              <div class="pagination-button arrow left-arrow" title="Previous page"></div></a>
          </c:if>

          <c:forEach begin="${targetPageNumber > 4 ? targetPageNumber : 1}" end="${targetPageNumber + 4}" var="i">
            <c:if test="${i <= totalPages}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', i)}"/>">
              <div class="pagination-button ${i == targetPageNumber ? "active" : "inactive"}" title="<c:out value="${i}"/>">
                <c:out value="${i}"/>
              </div></a>
            </c:if>
          </c:forEach>
          <c:if test="${targetPageNumber + 4 < totalPages}">
           <div class="pagination-button dots inactive"></div>
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', totalPages)}"/>">
              <div class="pagination-button inactive" title="<c:out value="${totalPages}"/>">
                <c:out value="${totalPages}"/>
              </div></a>
          </c:if>

          <c:if test="${targetPageNumber < totalSearchResultsSize/rowsPerPageLimit}">
            <a href="search<c:out value="${fn:replace(nextUrl, 'PAGE_NUM_PLACEHOLDER', (targetPageNumber + 1))}"/>">
              <div class="pagination-button arrow right-arrow" title="Next page"></div>
            </a>
          </c:if>
          </div>
        </div>
      </div>
    </div>
  </section>
  <div class="up-button" title="To top of page"></div>
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
	$(".sidebar-filter-header").each(function(index, element) {

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
	$("input[type='checkbox']").click(function(e) {
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


});

</script>
</body>
</html>
