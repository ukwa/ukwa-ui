<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="targetWebsites" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.TargetWebsiteDTO>"/>
<jsp:useBean id="subCollections" scope="request" type="java.util.List<com.marsspiders.ukwa.controllers.data.CollectionDTO>"/>



<html lang="Lang(en,GB)">
<head>
    <title>British Stand-up Comedy Archive - UK Web Archive</title>
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


    <div id="global-breadcrumb" class="header-context">
        <nav>
            <ol class="group">

                <li><a href="/ukwa/collection/all">Collections</a></li>

                <li><a href="/ukwa/collection/329">British Stand-up Comedy Archive</a></li>


            </ol>
        </nav>
    </div>

    <header class="page-header">
        <h1>British Stand-up Comedy Archive</h1>
    </header>

    <article>




        <div class="row">
            <div class="col-md-4 col-xs-12">

                <p>
                    Collection owned and adminstered by Elspeth Millar, British Stand-up Comedy Archive at the University of Kent
                </p>


                <table class="table table-striped">
                    <thead>
                    <tr><th colspan="2" class="text-center">Collection Statistics</th></tr>
                    </thead>
                    <tbody>
                    <tr><td>Total websites</td><td><c:out value="${targetWebsites.size()}"/></td></tr>
                    <%--<tr><td>Open access websites</td><td>0</td></tr>--%>
                    <tr><td>Total sub-sections</td><td><c:out value="${subCollections.size()}"/></td></tr>

                    </tbody>
                </table>


                <ul id="collection-tree-list" class="list-group">

                    <c:forEach items="${subCollections}" var="collection">
                        <li class="list-group-item">&nbsp;
                            <a href="/ukwa/collection/<c:out value="${collection.id}"/>">
                                <c:out value="${collection.name}"/>
                            </a> (<c:out value="${collection.websitesNum + collection.subCollectionsNum}"/>)
                        </li>
                    </c:forEach>


                </ul>


            </div>
            <div class="col-md-8 col-xs-12">




                <form action="/ukwa/collection/329/submit" method="POST" >



                    <input type="hidden" name="collectionId" id="collectionId" value="329">


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="input-group">

                                <input type="text" name="filter" id="filter" value="" class="form-control"  placeholder="Search">
  
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="submit">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>  
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    Sorted by title <span class="caret"></span>
  </button>
  <ul class="dropdown-menu">
    <li><a href="#">Sort by title (reversed)</a></li>
    <li><a href="#">Oldest first</a></li>
    <li><a href="#">Newest first</a></li>
    <li role="separator" class="divider"></li>
    <li><a href="#">Search within</a></li>
  </ul>
</span>
                            </div>
                        </div>
                    </div>

                </form>




                <div class="collection-targets-view">
                    <div class="row collection-targets-thumbnails">



                        <c:forEach items="${targetWebsites}" var="targetWebsite">
                            <div class="col-lg-3 col-md-3 col-sm-4 col-xs-6 target-thumbnail">
                                <div class="thumbnail">
                                    <a href="/target/<c:out value="${targetWebsite.id}"/>">

                                        <img class="img-responsive img-rounded" src="/assets/images/thumbnail-default.jpg" alt="Screenshot" title="<c:out value="${targetWebsite.name}"/>">

                                        <div class="caption">
                                            <c:out value="${targetWebsite.name}"/>
                                        </div>
                                    </a>
                                </div>
                            </div>

                        </c:forEach>


                    </div>
                </div>






            </div>
        </div>



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


  