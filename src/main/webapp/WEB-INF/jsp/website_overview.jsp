<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="req" value="${pageContext.request}" />
<c:set var="uri" value="${req.requestURI}" />
<c:set var="url">${req.requestURL}</c:set>
<c:if test="${setProtocolToHttps}">
</c:if>

<jsp:useBean id="targetWebsite" scope="request" type="com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO"/>

<html lang="Lang(en,GB)">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/ukwa/" />

    <title><c:out value="${targetWebsite.name}"/> - UK Web Archive</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" type="text/css" media="screen" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="assets/stylesheets/main.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.9/css/dataTables.bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span> <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="">
            <img src="assets/images/ukwa-icon-nobg-16.png" />
            UK Web Archive
        </a>
    </div>
    <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">About<b class="caret"></b></a>
                <ul class="dropdown-menu">

                    <li><a href="https://github.com/ukwa">
                        <span class="username">On GitHub</span>
                    </a></li>



                    <li><a href="https://twitter.com/UKWebArchive">
                        <span class="username">On Twitter</span>
                    </a></li>

                </ul>
            </li>
            <li><a href="collection/">Browse</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="http://britishlibrary.typepad.co.uk/webarchive/">Our Blog</a>
            <li><a href="mailto:web-archivist@bl.uk">Contact Us</a></li>
        </ul>
    </div><!-- /.nav-collapse -->
</nav>
<div class="container">

    <header class="page-header">
        <h1><c:out value="${targetWebsite.name}"/></h1>
    </header>

    <article>



        <div class="row">
            <div class="col-md-6 col-xs-12">

                ${targetWebsite.description}

                <ul>
                    <li><a href="/<c:out value="${targetWebsite.archiveUrl}"/>"><c:out value="${targetWebsite.url}"/></a></li>
                    <li><a href="<c:out value="${targetWebsite.url}"/>">Original site</a> (may now be offline)</li>
                    <li>Archived since <c:out value="${targetWebsite.startDate}"/></li>
                    <li>Language: <c:out value="${targetWebsite.language}"/></li>
                    <li>Additional URLs:
                        <ul>
                            <c:forEach items="${targetWebsite.additionalUrls}" var="additionalUrl">
                                <li><c:out value="${additionalUrl}"/></li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>

            </div>
            <div id="instances" class="col-md-6 col-xs-12">

                <ul>

                </ul>

            </div>
        </div>



    </article>

    <footer>

        <div class="well">

            Understanding UK web history

            <div class="pull-right">

                <a href="language/cy-GB">Translate to Welsh</a>

                | Cookie warning | Notice and takedown | Terms and conditions | Privacy statement
            </div>

        </div>

    </footer>

</div>


<script src="assets/javascripts/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>



</body>
</html>

