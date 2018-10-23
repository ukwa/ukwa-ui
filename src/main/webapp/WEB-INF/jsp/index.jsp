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
<html lang="${locale}">
<head>
    <base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
    <title>
        <spring:message code="home.header.title" />
    </title>
    <%@include file="head.jsp" %>
</head>

<body>

<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
        <%@include file="homepage_searchForm.jsp" %>
    </header>

                <!-- Modal -->
            <div class="modal fade" id="searchingUKWAModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog tips-dialog modal-lg modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header d-block">
                            <button type="button" class="close float-right" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" style="padding: 0">
                            <div class="main-heading-2-redesign bg-gray2" id="exampleModalLongTitle" style="padding-left: 40px;padding-bottom: 40px"><spring:message code="search.tips.tipsnotes" /></div>
                            <div class="padding-left-20">
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>1</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 1 - </b><spring:message code="search.tip.1.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>2</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 2 - </b><spring:message code="search.tip.2.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>3</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 3 - </b><spring:message code="search.tip.3.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>4</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 4 - </b><spring:message code="search.tip.4.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>5</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 5 - </b><spring:message code="search.tip.5.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>6</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 6 - </b><spring:message code="search.tip.6.text" /></div>
                                </div>
                                <div class="row padding-top-10 padding-bottom-10">
                                    <div class="col-md-2 col-sm-2 circle"><span>7</span></div>
                                    <div class="col-md-10 col-sm-10 circle-text"><b>Tip 7 - </b><spring:message code="search.tip.7.text" /></div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer inline-block-items justify-content-center" style="width: 100%;">
                            <button type="button" class="btn btn-primary" style="width: 20%;" data-dismiss="modal"><spring:message code="main.menu.close.title" /></button>
                        </div>
                    </div>
                </div>
            </div>


    <div class="padding-top-20 padding-bottom-10 padding-side-70">
        <section id="home-pre-header">

            <div>
                <p class="main-heading-2-bold-redesign">
                    <spring:message code="home.page.whatwedo" />
                </p>
            </div>

            <div class="row padding-top-20">
                <div class="col-md-8">
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.header.text1" />
                    </p><br/>
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.header.text2" />
                    </p><br/>
                </div>
                <div class="col-md-4 embed-responsive">
                    <div class="embed-responsive embed-responsive-16by9">
                        <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/1QLMPIRwJEo" allowfullscreen></iframe>
                    </div>
                </div>
            </div>

        </section>

        <section id="collections">
            <div class="padding-top-40">
                <p class="main-heading-2-bold-redesign">
                    <spring:message code="home.page.collections.title"/>
                </p>
            </div>
            <div class="row padding-top-20">
                <div class="col-md-8">
                    <p class="main-subheading-2-redesign">
                        <spring:message code="home.page.collections.subtitle"/>
                        <a href="collection" title="<spring:message code="home.page.findoutmore"/>"><spring:message code="home.page.findoutmore"/></a>.
                    </p>
                </div>
                <div class="col-md-4">
                    &nbsp;
                </div>
            </div>

            <div class="row padding-top-40">
                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/329" class="collection-link">
                    <figure><img class="img-responsive border-gray coll-img" alt="British Stand-up Comedy Archive" src="img/collections/collection_329.png"/>
                        <figcaption class="img-square-caption shadow"><spring:message code="home.page.featured.text"/></figcaption>
                    </figure>
                    <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">British Stand-up Comedy Archive</div>
                    <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">Collection owned and adminstered by Elspeth Millar.</div>
                </a> </div>

                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/309" class="collection-link">
                    <figure><img class="img-responsive border-gray coll-img" alt="French in London" src="img/collections/collection_309.png"/>
                        <figcaption class="img-square-caption shadow"><spring:message code="home.page.featured.text"/></figcaption>
                    </figure>
                    <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">French in London</div>
                    <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">This collection of websites has been selected by Saskia Huc-Hepher.</div>
                </a></div>

                <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col padding-bottom-20 padding-top-30"> <a href="collection/138" class="collection-link">
                    <figure><img class="img-responsive border-gray coll-img" alt="News Sites" src="img/collections/collection_138.png"/>
                        <figcaption class="img-square-caption shadow"><spring:message code="home.page.featured.text"/></figcaption>
                    </figure>
                    <div class="left light-blue padding-bottom-10 padding-left-20 padding-right-20 collection-heading-bold">News Sites</div>
                    <div class="left black padding-bottom-10 padding-left-20 padding-right-20 collection-heading thumbnail">558 titles are included in this collection.</div>
                </a></div>
            </div>

            <div class="d-none d-lg-block">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col">
                        <hr class="topics-themes-hr"/>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col ">
                        <hr class="topics-themes-hr"/>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12 image-grid-col">
                        <hr class="topics-themes-hr"/>
                    </div>
                </div>
            </div>

            <div class="padding-bottom-60 center">
                <a href="collection" class="no-decoration" title="<spring:message code="home.button.viewmore.title"/>">
                    <div class="button button-blue width-auto-inline view-more-button"><spring:message code="home.button.viewmore"/></div></a>
            </div>
        </section>

    </div>
</div>

</div>
</div>
<footer>
    <%@include file="footer.jsp" %>
</footer>
<script>
    $(document).ready(function(e) {
        var $menuItems = $('.header-menu-item');
        $menuItems.removeClass('active');
        $("#headermenu_index").addClass('active');
    });
</script>
</body>
</html>
