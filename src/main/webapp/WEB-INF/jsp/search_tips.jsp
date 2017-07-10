<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">
${req.requestURL}
</c:set>
<c:set var="locale">
${pageContext.response.locale}
</c:set>
<c:if test="${setProtocolToHttps}">
  <c:set var="url" value="${fn:replace(url, 'http:', 'https:')}"/>
</c:if>
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Search Tips</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="noresults-header">
  <div class="row header-blue white">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
      <h2 class="uppercase">Search tips</h2>
    </div>
  </div>
</section>
<section id="content">
  <div class="row margin-0 padding-side-20 padding-top-80 padding-bottom-80 text-justify">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
    <p>If you are looking for a single website that you believe may be in the UK Web Archive, you can search for it via the Search tab. Use a phrase or name that you think is most likely to be in the website and in that website alone. This will search across all the archived websites.</p>

<p>There are several options for narrowing your search. For example, a phrase search uses more than one term (i.e. more than a single word). If two (or more) terms are submitted without the use of quotes, only one of those terms need appear in the documents to produce a result. If the terms are quoted, then only that precise string will be returned. See the Query Syntax section below for full details.</p>

<p>Having submitted your query you can further refine your search using the facets on the left-hand side of the full text search results page. This allows the matching results to be filtered by various properties, such as content type, collection and crawl year. For example, you can use the &quot;Refine by domain suffix&quot; facet to limit the results set to those resources hosted on domains with names that share the same common suffix, such as &quot;co.uk&quot;, &quot;ac.uk&quot; or &quot;com&quot;.</p>

<p>Note that all queries are case-insensitive.</p>

<h3 class="margin-top-60">Query Syntax</h3>

<table class="table table-bordered table-striped">
<thead>
<tr>
<th>Query type</th>
<th>Example</th>
<th>Description</th>
</tr>
</thead>
<tr>
<td>Logical AND</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=economics+finance&year_start=1996&year_end=2013&action=update">economics finance</a>, <a href="https://www.webarchive.org.uk/shine/graph?query=economics+AND+finance&year_start=1996&year_end=2013&action=update">economics AND finance</a></td>
<td>Returns resources containing the words &quot;economics&quot; and &quot;finance&quot;, but not necessarilytogether.</td>
</tr>
<tr>
<td>Logical OR</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=breakfast+OR+marmalade&year_start=1996&year_end=2013&action=update">breakfast OR marmalade</a></td>
<td>Returns resources containing either the word &quot;breakfast&quot; or the work &quot;marmalade&quot;</td>
</tr>
<tr>
<td>Logical NOT</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=coffee+NOT+java&year_start=1996&year_end=2013&action=update">coffee NOT java</a></td>
<td>Returns resources containing the word &quot;coffee&quot;, but excluding all resources that contain the work &quot;java&quot;.</td>
</tr>
<tr>
<td>Phrase search</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=%22Tony+Blair%22&year_start=1996&year_end=2013&action=update">&quot;Tony Blair&quot;</a></td>
<td>Returns resources containing the exact phrase &quot;tony blair&quot;.</td>
</tr>
<tr>
<td>Proximity search</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=%22coffee+java%22~25&year_start=1996&year_end=2013&action=update">"coffee java"~25</a></td>
<td>Returns resources where the words &quot;coffee&quot; and &quot;java&quot; appear within 25 words of each other.</td>
</tr>
<tr>
<td>Proximity phrase search</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=%22%28\%22Tony+Blair\%22%29+%28\%22Rupert+Murdoch\%22%29%22~10&year_start=1996&year_end=2013&action=update">"(\"Tony Blair\") (\"Rupert Murdoch\")"~10</a></td>
<td>Returns resources where the exact phrases &quot;Tony Blair&quot; and &quot;Rupert Murdoch&quot;) appear within 10 words of each other.</td>
</tr>
<tr>
<td>Single character wildcard</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=mart%3Fn&year_start=1996&year_end=2013&action=update">mart?n</a></td>
<td>A &quot;wildcard&quot; search where a single character in the term might vary &emdash; the question mark symbol (i.e., &quot;?&quot;) can be used in its place. In this example, &quot;mart?n&quot; can find &quot;martin&quot;, &quot;martan&quot;, &quot;marten&quot; and so on.</td>
</tr>
<tr>
<td>Multiple character wildcard</td>
<td><a href="https://www.webarchive.org.uk/shine/graph?query=buil*&year_start=1996&year_end=2013&action=update">buil*</a></td>
<td>A &quot;wildcard&quot; search where multiple character in the term might vary &emdash; the asterisk symbol (i.e., &quot;*&quot;) can be used in its place.  In this example, &quot;buil*&quot; can find &quot;build&quot;, &quot;built&quot; and &quot;building&quot;.</td>
</tr>
</table>

    </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
