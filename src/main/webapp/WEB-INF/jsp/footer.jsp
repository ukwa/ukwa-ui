<div class="row margin-0 padding-30">
    <div class="col-lg-auto col-md-auto col-sm-auto padding-0">
        <a href="index"><img src="img/ukwa-2018-onwhite-close-125px.png" class="header-logo img-responsive-576"></a>
        <a href="index"><img src="img/ukwa-2018-onwhite-close-150px.png" class="header-logo img-responsive-1024"></a>
        <a href="index"><img src="img/ukwa-2018-onwhite-close-200px.png" class="header-logo img-responsive-1440"></a>
        <a href="index"><img src="img/ukwa-2018-onwhite-close-250px.png" class="header-logo img-responsive-1900"></a>
        <a href="index"><img src="img/ukwa-2018-onwhite-close-350px.png" class="header-logo img-responsive-2500"></a>
    </div>
</div>
<div class="row">
    <div class="col-12">
    <div class="container-footer-menu-group">

        <a href="index" title="<spring:message code="footer.home.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue dialog-link"><spring:message code="footer.home" /></div>
        </a>
        <a href="info/about" title="<spring:message code="footer.about.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue   dialog-link"><spring:message code="footer.about" /></div>
        </a>
        <a href="collection" title="<spring:message code="footer.collections.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue   dialog-link"><spring:message code="footer.collections" /></div>
        </a>
        <a href="http://britishlibrary.typepad.co.uk/webarchive/" target="_blank" title="<spring:message code="footer.blog.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue   dialog-link"><spring:message code="footer.blog" /></div>
        </a>
        <a href="info/nominate" title="<spring:message code="footer.nominate.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue   dialog-link"><spring:message code="footer.nominate" /></div>
        </a>

        <a href="info/notice_takedown" class="collection-link footer-menu-item" title="<spring:message code="footer.notice.title" />">
            <div class="left light-blue   dialog-link"><spring:message code="footer.notice" /></div>
        </a>
        <a href="info/terms_conditions" class="collection-link footer-menu-item" title="<spring:message code="footer.terms.title" />">
            <div class="left light-blue   dialog-link"><spring:message code="footer.terms" /></div>
        </a>
        <a href="http://www.bl.uk/aboutus/terms/privacy/index.html" class="collection-link footer-menu-item" title="<spring:message code="footer.privacy.title" />" target="_blank">
            <div class="left light-blue   dialog-link"><spring:message code="footer.privacy" /></div>
        </a>
        <a href="info/cookies" class="collection-link footer-menu-item" title="<spring:message code="footer.cookies.title" />">
            <div class="left light-blue dialog-link"><spring:message code="footer.cookies" /></div>
        </a>

        <a href="info/faq" title="<spring:message code="footer.faq" />" class="collection-link footer-menu-item">
            <div class="left light-blue  dialog-link"><spring:message code="footer.faq" /></div>
        </a>
        <a href="contact" title="<spring:message code="footer.contact.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue dialog-link"><spring:message code="footer.contact" /></div>
        </a>
        <c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}"/>
        <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy'
                                        ? '/'
                                        : fn:replace(fn:replace(textUri, '/en/', '/'), '/cy/', '/')}"/>
        <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
          && (fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
      <span lang="en"><a href="/en<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="footer.english.title" />" class="collection-link footer-menu-item">
      <div class="left light-blue dialog-link"><spring:message code="footer.english" /></div></a></span>
        </c:if>
        <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}"> <span lang="cy"><a href="/cy<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="footer.welsh.title" />" class="collection-link footer-menu-item">
      <div class="left light-blue dialog-link"><spring:message code="footer.welsh" /></div></a></span>
        </c:if>
        <a href="https://www.webarchive.org.uk/rss/recent.xml" title="<spring:message code="footer.rss.title" />" class="collection-link footer-menu-item">
            <div class="left light-blue dialog-link"><spring:message code="footer.rss" /></div>
        </a>

    </div>
</div>

<div class="cookies-cont">
    <div class="row">
        <div class="col-md-8 col-sm-12"><spring:message code="footer.cookies.text" /></div>
        <div class="col-md-4 col-sm-12 padding-top-mobile-10"><button class="button button-white float-sm-right" id="btn_cookies" title="<spring:message code="footer.cookies.button.title" />"><spring:message code="footer.cookies.button" /></button></div>
    </div>
</div>

</div>

<hr/>
<div class="row margin-0 padding-30">
    <div class="col-12 center footer-legal-deposit">
        The UK Web Archive collects on behalf of these UK Legal deposit Libraries
    </div>
</div>

<div class="row">
    <div class="col-12">
    <div class="container-footer-group">
        <div class="footer-logo-BW"><a href="http://www.bodleian.ox.ac.uk/" target="_blank"><img src="img/bodleian_logo_BW.jpg" alt="<spring:message code="footer.logo.bl" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.llgc.org.uk/" target="_blank"><img src="img/llgc_logo_BW.png" alt="<spring:message code="footer.logo.llgc" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.nls.uk/" target="_blank"><img src="img/NLS_logo_2_BW.jpg" alt="<spring:message code="footer.logo.nls" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.bl.uk/" target="_blank"><img src="img/bl_logo_BW.png" alt="<spring:message code="footer.logo.blib" />" /></a></div>
        <div class="footer-logo-BW"><a href="http://www.lib.cam.ac.uk/" target="_blank"><img src="img/cambrige_logo600_BW.png" alt="<spring:message code="footer.logo.cul" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.tcd.ie/" target="_blank"><img src="img/trinity_logo_BW.jpg" alt="<spring:message code="footer.logo.tcd" />" /></a></div>
    </div>
    </div>
</div>
<hr style="width: 100%; color: darkblue; height: 7px; background-color:royalblue; margin-bottom:1px !important;margin-top:1px !important;" />

<!--[if (gt IE 9)|!(IE)]><!-->
<script>
    if(jQuery){
        console.log('yes');
    }
    $(document).ready(function(e) {
        $("#showMoreDomainLink").click(function() {
            if($("#domains_filter_div").is(":visible")){ //hide then
                $("#domains_filter_div").hide(300);
                $('#showMoreDomainLink').html('Show more');
            }
            else{
                $("#domains_filter_div").show(300);
                $('#showMoreDomainLink').html('Hide');
            }
        });
        $("#showMoreCollectionLink").click(function() {
            if($("#collections_filter_div").is(":visible")){ //hide then
                $("#collections_filter_div").hide(300);
                $('#showMoreCollectionLink').html('Show more');
            }
            else{
                $("#collections_filter_div").show(300);
                $('#showMoreCollectionLink').html('Hide');
            }
        });
        $("#showMoreSuffixLink").click(function() {
            if($("#suffix_filter_div").is(":visible")){ //hide then
                $("#suffix_filter_div").hide(300);
                $('#showMoreSuffixLink').html('Show more');
            }
            else{
                $("#suffix_filter_div").show(300);
                $('#showMoreSuffixLink').html('Hide');
            }
        });
        $("#showMoreDocumentTypeLink").click(function() {
            if($("#content_type_filter_div").is(":visible")){ //hide then
                $("#content_type_filter_div").hide(300);
                $('#showMoreDocumentTypeLink').html('Show more');
            }
            else{
                $("#content_type_filter_div").show(300);
                $('#showMoreDocumentTypeLink').html('Hide');
            }
        });
    });

    //progress bar
    var pleaseWait = $('#pleaseWaitDialog');
    showPleaseWait = function () {
        pleaseWait.modal('show');
    };
    hidePleaseWait = function () {
        pleaseWait.modal('hide');
    };
    //hidePleaseWait();
</script>
<!--<![endif]-->

<script> (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-7571526-1', 'auto'); ga('send', 'pageview');
</script>
