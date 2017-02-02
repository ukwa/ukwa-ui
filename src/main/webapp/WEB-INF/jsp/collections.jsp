<!DOCTYPE html>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="collections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>


<html lang="Lang(en,GB)">
<head>
    <title>Special Collections - UK Web Archive</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" type="text/css" media="screen" href="/ukwa/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="/ukwa/assets/stylesheets/main.css">
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
        <a class="navbar-brand" href="/ukwa/">
            <img src="/ukwa/assets/images/ukwa-icon-nobg-16.png" />
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
            <li><a href="/ukwa/collection/">Browse</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="http://britishlibrary.typepad.co.uk/webarchive/">Our Blog</a>
            <li><a href="mailto:web-archivist@bl.uk">Contact Us</a></li>
        </ul>
    </div><!-- /.nav-collapse -->
</nav>
<div class="container">

    <header class="page-header">
        <h1>Special Collections</h1>
    </header>

    <article>


        <p>
            Special Collections are groups of websites brought together on a particular theme by librarians, curators and other specialists, often working in collaboration with key organisations in the field. They can be events-based (e.g The Olympic & Paralympic Games 2012), topical (e.g. The Credit Crunch Collection) or subject-oriented (e.g. The British Countryside Collections).
        </p>




        <div class="collection-view">
            <table id="collections-table" class="table table-striped table-bordered table-reponsive sortable-table">
                <thead>
                <tr>
                    <th>Title</th>
                    <th>Sections</th>
                    <th>Websites (Open Access)</th>
                </tr>
                </thead>


                <c:forEach items="${collections}" var="collection">
                    <tr>
                        <td><a href="/ukwa/collection/<c:out value="${collection.id}"/>"><c:out value="${collection.name}"/></a></td>
                        <td><c:out value="${collection.subCollectionsNum}"/></td>
                        <td><c:out value="${collection.websitesNum}"/> </td>
                    </tr>
                </c:forEach>

            </table>
        </div>

        <!--
          <div class="col-md-6 col-xs-12">
              collectionSummary(ct)
          </div>
         -->




    </article>

    <footer>

        <div class="well">

            Understanding UK web history

            <div class="pull-right">

                <a href="/ukwa/language/cy-GB">Translate to Welsh</a>

                | Cookie warning | Notice and takedown | Terms and conditions | Privacy statement
            </div>

        </div>

    </footer>

</div>


<script src="/ukwa/assets/javascripts/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="/ukwa/assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.9/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.9/js/dataTables.bootstrap.min.js"></script>


<!-- From include. -->
<script>
    $(document).ready(function() {
        $('.sortable-table').DataTable();
    } );
</script>


</body>
</html>
