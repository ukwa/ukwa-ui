<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="url">${pageContext.request.requestURL}</c:set>
<c:set var="uri" value="${pageContext.request.requestURI}"/>
<c:set var="locale">${pageContext.response.locale}</c:set>
<c:set var="contextPath" value="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${pageContext.request.contextPath}/${locale}/ukwa/"/>

<html>
    <head>
        <c:if test="${msb.urlSet}">
            <title>Mementos - Archived history of ${msb.url}</title>
        </c:if>
        <c:if test="${!msb.urlSet}">
            <title>Mementos - Finding historical archives across the world wide web.</title>
        </c:if>

        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta name="description" content="Mementos - World Wide Web Archives Browser"/>
        <meta name="author" content="www.webarchive.org.uk"/>

        <link rel="stylesheet" media="screen" href="${contextPath}/assets/stylesheets/main.css"/>
        <link rel="stylesheet" media="screen" href="${contextPath}/assets/stylesheets/jquery.dataTables.css"/>
        <link rel="stylesheet" media="screen" href="${contextPath}/assets/bootstrap/css/bootstrap.min.css"/>
        <link rel="stylesheet" media="screen" href="${contextPath}/assets/bootstrap/css/bootstrap-responsive.css"/>
        <link rel="stylesheet" media="screen" href="${contextPath}/assets/nvd3/src/nv.d3.css"/>
        <link rel="shortcut icon" type="image/png" href="${contextPath}/assets/images/favicon.png"/>
        <script src="${contextPath}/assets/javascripts/jquery-1.9.1.min.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/javascripts/jquery.dataTables.min.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/nvd3/lib/d3.v2.min.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/nvd3/nv.d3.min.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container">

            <div class="row">
                <div class="span8">

                    <div class="row" style="padding-top: 10px;">
                        <div class="span8">
                            <table class="table table-striped table-condensed table-bordered">
                                <tr>
                                    <th>URL</th>
                                    <td><a href="${msb.url}">${msb.shortUrl}</a></td>
                                </tr>
                                <c:if test="${!msb.archive.equals(\"\")}">
                                    <tr>
                                        <th>Archived By</th>
                                        <td>${msb.archive} <a href="${contextPath}/mementos/search/${msb.url}"
                                                              title="Remove this filter and view results from all archives.">(×)</a>
                                        </td>
                                    </tr>
                                </c:if>
                                <tr>
                                    <th>Snapshots</th>
                                    <td>${msb.totalCount} in ${msb.numHosts} archive(s)</td>
                                </tr>
                                <tr>
                                    <c:if test="${msb.firstMemento != null}">
                                        <th>Date Range</th>
                                        <td>
                                            <a href="${msb.firstMemento.waybackUrl}">${msb.firstMemento.dateTime.year}</a>
                                            to <a
                                                href="${msb.lastMemento.waybackUrl}">${msb.lastMemento.dateTime.year}</a>
                                            (${msb.timeSinceLastMemento})
                                        </td>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th>Request Archive</th>
                                    <td><a href="http://www.webarchive.org.uk/ukwa/info/nominate?url=${msb.url}">via the
                                        UK Web Archive</a>, <a href="http://webcitation.org/archive?url=${msb.url}">via
                                        WebCite&#153;</a></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <c:if test="${msb.firstMemento != null}">
                        <div class="row">
                            <div class="span8">

                                <ul class="thumbnails" id="thumbnail_summary">
                                    <li class="span2">
                                        <div class="thumbnail">
                                            <a href="${msb.firstMemento.waybackUrl}">
                                                <img src="${contextPath}mementos/api/screenshot?url=${msb.firstMemento.waybackUrl}"/></a>
                                            <p>${msb.firstMemento.dateTime.year}</p>
                                        </div>
                                    </li>
                                    <li class="span2">
                                        <div class="thumbnail">
                                            <a href="${msb.midpointMemento.waybackUrl}">
                                                <img src="${contextPath}mementos/api/screenshot?url=${msb.midpointMemento.waybackUrl}"/></a>
                                            <p>${msb.midpointMemento.dateTime.year}</p>
                                        </div>
                                    </li>
                                    <li class="span2">
                                        <div class="thumbnail">
                                            <a href="${msb.lastMemento.waybackUrl}">
                                                <img src="${contextPath}mementos/api/screenshot?url=${msb.lastMemento.waybackUrl}"/></a>
                                            <p>${msb.lastMemento.dateTime.year}</p>
                                        </div>
                                    </li>
                                    <li class="span2">
                                        <div class="thumbnail">
                                            <a href="${msb.url}">
                                                <img src="${contextPath}mementos/api/screenshot?url=${msb.url}"/></a>
                                            <p>LIVE</p>
                                        </div>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </c:if>


                </div>
                <div class="span4">

                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1" data-toggle="tab">Host Chart</a></li>
                            <li><a href="#tab2" data-toggle="tab">Host Table</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab1" style="height: 250px;">

                                <svg id="test1" style="height: 250px;"></svg>

                                <script type="text/javascript">


                                    var testdata = [
                                        {
                                            key: "Archive Hosts",
                                            values: [
                                                ${msb.hostPieData}
                                            ]
                                        }];

                                    nv.addGraph(function(){

                                        var chart = nv.models.pieChart()
                                            .x(function(d){
                                                return d.label
                                            })
                                            .y(function(d){
                                                return d.value
                                            })
                                            .showLabels(false)
                                            .color(d3.scale.category10().range());

                                        chart.tooltipContent(
                                            function(key, y, e, graph){
                                                return '<p><img style="width: 16px; height: 16px;" src="${contextPath}/assets/images/favicons/")' + key + '/favicon.ico"/>&#160;<b>' + key + '</b></p>' +
                                                    '<p>' + e.value + ' snapshots</p>'
                                            });

                                        d3.select("#test1")
                                            .datum(testdata)
                                            .transition().duration(1200)
                                            .call(chart);

                                        nv.utils.windowResize(chart.update);

                                        chart.pie.dispatch.on('elementClick.link', function(e){
                                            <c:if test="${msb.archive.equals(\"\")}">
                                            window.location.href = "${contextPath}/mementos/search?url=${msb.url}&archive=" + e.label;
                                            </c:if>
                                            <c:if test="${!msb.archive.equals(\"\")}">
                                            window.location.href = "${contextPath}/mementos/search?url=${msb.url}";
                                            </c:if>
                                        });

                                        return chart;
                                    });

                                </script>
                            </div>
                            <div class="tab-pane" id="tab2">
                                <table id="host_summary" class="table table-striped table-condensed">
                                    <thead>
                                        <th>Archive</th>
                                        <th>Snapshots</th>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${msb.hostCounts}" var="h">
                                            <tr>
                                                <td>
                                                    <a href="${contextPath}/mementos/search/${msb.url}?archive=${h.key}"><img
                                                            src="${contextPath}/assets/images/favicons/${h.key}/favicon.ico")/>&#160;${h.key}</a>
                                                </td>
                                                <td>${h.value}</td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>

                                <script type="text/javascript">
                                    $(document).ready(function(){
                                        $('#host_summary').dataTable({
                                            "bPaginate": false,
                                            "bLengthChange": false,
                                            "bFilter": false,
                                            "bSort": true,
                                            "bInfo": false,
                                            "bAutoWidth": false,
                                            "aaSorting": [[1, "desc"]]
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="span12">

                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab21" data-toggle="tab">Snapshot Chart</a></li>
                            <li><a href="#tab22" data-toggle="tab">Snapshot Table</a></li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab21">

                                <div id="chart3" class="" style="height: 200px;">
                                    <svg style="height: 200px;"></svg>
                                </div>

                                <script type="text/javascript">

                                    function dateLegend(e){
                                        return d3.time.format('%a %e/%m, %I%p')(new Date(e.point[0] + 1000 * 60 * 60)) + '-' + d3.time.format('%I%p BST')(new Date(e.point[0] + 2 * 1000 * 60 * 60));
                                    }


                                    d3.json("${contextPath}/mementos/api/timegraph/?url=${msb.url}&archive=${msb.archive}", function(data){

                                        nv.addGraph(function(){
                                            var chart = nv.models.multiBarChart()
                                                .showLegend(true)
                                                .showControls(true)
                                                .reduceXTicks(false)
                                                .stacked(true);
                                            /*
                                                nv.models.stackedAreaChart()
                                                  .showLegend(true)
                                                          .clipEdge(true);
                                            */

                                            chart.tooltipContent(function(key, x, y, e, graph){
                                                return '<p><img style="width: 16px; height: 16px;" src="${contextPath}/assets/images/favicons" + key + "/favicon.ico"/>&#160;<b>' + key + '</b></p>' +
                                                    '<p>' + y + ' snapshots during ' + x + '</p>'
                                            });


                                            /*
                                               chart.tooltipContent( function(key, x, y, e, graph) { return '<h3>' + y + ' ' + key + '</h3>' + '<p>at ' + dateLegend(e) + '</p>' } );
                                                 chart.xAxis
                                                     .tickFormat(function(d) { return d3.time.format('%a %e/%m')(new Date(d)) });

                                                 chart.yAxis
                                                     .tickFormat(d3.format(',.0f'));
                                             */

                                            chart.xAxis
                                                .tickFormat(d3.format('.f'));

                                            chart.yAxis
                                                .tickFormat(d3.format('.f'));

                                            d3.select('#chart3 svg')
                                                .datum(data)
                                                .transition().duration(500).call(chart);

                                            chart.multibar.dispatch.on('elementClick.link', function(e){
                                                <c:if test="${msb.archive.equals(\"\")}">
                                                window.location.href = "${contextPath}/mementos/search?url=${msb.url}?archive=" + e.series.key;
                                                </c:if>
                                                <c:if test="${!msb.archive.equals(\"\")}">
                                                window.location.href = "${contextPath}/mementos/search?url=${msb.url}";
                                                </c:if>
                                            });


                                            nv.utils.windowResize(chart.update);

                                            return chart;
                                        });

                                        function exampleData(){
                                            return stream_layers(3, 10 + Math.random() * 100, .1).map(function(data, i){
                                                return {
                                                    key: 'Stream' + i,
                                                    values: data
                                                };
                                            });
                                        }

                                        function stream_layers(n, m, o){
                                            if(arguments.length < 3) o = 0;

                                            function bump(a){
                                                var x = 1 / (.1 + Math.random()),
                                                    y = 2 * Math.random() - .5,
                                                    z = 10 / (.1 + Math.random());
                                                for(var i = 0; i < m; i++) {
                                                    var w = (i / m - y) * z;
                                                    a[i] += x * Math.exp(-w * w);
                                                }
                                            }

                                            return d3.range(n).map(function(){
                                                var a = [], i;
                                                for(i = 0; i < m; i++) a[i] = o + o * Math.random();
                                                for(i = 0; i < 5; i++) bump(a);
                                                return a.map(stream_index);
                                            });
                                        }

                                        /* Another layer generator using gamma distributions. */
                                        function stream_waves(n, m){
                                            return d3.range(n).map(function(i){
                                                return d3.range(m).map(function(j){
                                                    var x = 20 * j / m - i / 3;
                                                    return 2 * x * Math.exp(-.5 * x);
                                                }).map(stream_index);
                                            });
                                        }

                                        function stream_index(d, i){
                                            return {x: i, y: Math.max(0, d)};
                                        }


                                    });

                                </script>

                            </div>
                            <div class="tab-pane" id="tab22">

                                <table id="mementos_list" class="table table-striped table-condensed table-bordered">
                                    <thead>
                                        <th>Date &amp; Time</th>
                                        <th>Link to snapshot</th>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${msb.mementos}" var="m">
                                            <tr>
                                                <td>${m.dateTime}</td>
                                                <td><a href="${m.waybackUrl}">${m.rel} @ ${m.archiveHost}</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <script type="text/javascript" charset="utf-8">
                                    jQuery.extend(jQuery.fn.dataTableExt.oSort, {
                                        "date-euro-pre": function(a){
                                            if($.trim(a) != '') {
                                                var frDatea = $.trim(a).split(' ');
                                                var frTimea = frDatea[1].split(':');
                                                var frDatea2 = frDatea[0].split('/');
                                                var yr = parseInt(frDatea2[2]);
                                                if(yr > 50) frDatea2[2] = "19" + frDatea2[2];
                                                if(yr <= 50) frDatea2[2] = "20" + frDatea2[2];
                                                var x = parseInt(frDatea2[2] + frDatea2[1] + frDatea2[0] + frTimea[0] + frTimea[1]);
                                            }
                                            else {
                                                var x = 10000000000000; // = l'an 1000 ...
                                            }

                                            return x;
                                        },

                                        "date-euro-asc": function(a, b){
                                            return a - b;
                                        },

                                        "date-euro-desc": function(a, b){
                                            return b - a;
                                        }
                                    });

                                    $(document).ready(function(){
                                        $('#mementos_list').dataTable({
                                            "aoColumns": [
                                                {"sType": "date-euro"},
                                                null
                                            ]
                                        });
                                    });
                                </script>

                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="row">
                <div class="span12" style="text-align: center;margin: 1em;">
                    <p>
                        Bookmarklet:&#160;<a
                            href="javascript:void(location.href='http://www.webarchive.org.uk/mementos/search/' + escape(location.href) + '?referrer=' + escape(document.referrer))">
                        Find Mementos</a>.
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="span8 offset2">
                    <div class="well" style="text-align: center;">
                        <p>
                            For more information, see&#160;<a href="http://www.webarchive.org.uk/ukwa/info/mementos">the
                            Mementos homepage</a>.<br/>
                        </p>
                        <p>
                            This web interface uses the Memento aggregate TimeGate hosted by&#160;<a
                                href="http://lanl.gov">lanl.gov</a>.<br/>
                            For more information on Memento, see&#160;<a href="http://www.mementoweb.org/">www.mementoweb.org</a>.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">

            var _gaq = _gaq || [];
            _gaq.push(['_setAccount', 'UA-7571526-1']);
            _gaq.push(['_trackPageview']);

            (function(){
                var ga = document.createElement('script');
                ga.type = 'text/javascript';
                ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(ga, s);
            })();

        </script>


    </body>
</html>