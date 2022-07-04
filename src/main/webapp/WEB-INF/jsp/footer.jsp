<div class="container-fluid">
<hr/>
<div role="navigation" aria-label="Navigation footer" class="row margin-0 padding-30">
    <div class="col-md-4">
    <ul class="list-group list-group-flush" role="menu">
        <li class="list-group-item" role="menuitem">
            <a href="index" title="<spring:message code="footer.home.title" />">
                <spring:message code="footer.home" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="category" title="<spring:message code="footer.collections.title" />">
                <spring:message code="footer.collections" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/nominate" title="<spring:message code="footer.nominate.title" />">
                <spring:message code="footer.nominate" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/about" title="<spring:message code="footer.about.title" />">
                <spring:message code="footer.about" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="contact" title="<spring:message code="footer.contact.title" />">
                <spring:message code="footer.contact" />
            </a>
        </li>
    </ul>
    </div>
    <div class="col-md-4">
    <ul class="list-group list-group-flush" role="menu">
        <li class="list-group-item" role="menuitem">
            <a href="info/accessibility_statement" title="<spring:message code="accessibility.page.title" />">
                <spring:message code="accessibility.header.title" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/notice_takedown" title="<spring:message code="footer.notice.title" />">
                <spring:message code="footer.notice" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/terms_conditions" title="<spring:message code="footer.terms.title" />">
                <spring:message code="footer.terms" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="http://www.bl.uk/aboutus/terms/privacy/index.html" title="<spring:message code="footer.privacy.title" />" target="_blank" alt="Opens in a new window">
                <spring:message code="footer.privacy" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/cookies" title="<spring:message code="footer.cookies.title" />">
                <spring:message code="footer.cookies" />
            </a>
        </li>
    </ul>
    </div>
    <div class="col-md-4">
    <ul class="list-group list-group-flush" role="menu">
        <li class="list-group-item" role="menuitem">
            <a href="http://britishlibrary.typepad.co.uk/webarchive/" target="_blank" alt="Opens in a new window" title="<spring:message code="footer.blog.title" />">
                <spring:message code="footer.blog" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/faq" title="<spring:message code="footer.faq" />">
                <spring:message code="footer.faq" />
            </a>
        </li>
        <li class="list-group-item" role="menuitem">
            <a href="info/technical" title="<spring:message code="technical.title" />">
                <spring:message code="technical.title" />
            </a>
        </li>
        <!--
        <li class="list-group-item" role="menuitem">
            <a href="https://www.webarchive.org.uk/rss/recent.xml" title="<spring:message code="footer.rss.title" />">
                <spring:message code="footer.rss" />
            </a>
        </li>
         -->

        <c:set var="params" value="${requestScope['javax.servlet.forward.query_string']}"/>
        <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                         ? '/'
                                         : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
        <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
           && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
            <li class="list-group-item" role="menuitem">
                <a href="/en<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="footer.english.title" />">
                    <spring:message code="footer.english" /></a>
            </li>
        </c:if>
        <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}">
            <li class="list-group-item" role="menuitem">
                <a href="/cy<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="footer.welsh.title" />">
                    <spring:message code="footer.welsh" /></a>
            </li>
        </c:if>
        <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}">
            <li class="list-group-item" role="menuitem">
                <a href="/gd<c:out value="${textUriWithoutLang}?${params}"/>" title="<spring:message code="footer.scottish.title" />">
                    <spring:message code="footer.scottish" /></a>
            </li>
        </c:if>
    </ul>
</div>

    <div class="cookies-cont">
        <div class="row">
            <div class="col-md-8 col-sm-12"><spring:message code="footer.cookies.text" /></div>
            <div class="col-md-4 col-sm-12 padding-top-mobile-10"><button class="button float-sm-right" id="btn_cookies" title="<spring:message code="footer.cookies.button.title" />"><spring:message code="footer.cookies.button" /></button></div>
        </div>
    </div>

</div>

<hr/>
<div class="row margin-0 padding-30">
    <div class="col-12 center footer-legal-deposit">
        <spring:message code="footer.logos.title" />
    </div>
</div>

<div class="row">
    <div class="col-12">
    <div role="navigation" aria-label="Navigation BL partners" class="container-footer-logos-group">
        <div class="footer-logo-BW"><a href="http://www.bodleian.ox.ac.uk/" target="_blank"><img src="img/bodleian_logo_BW.jpg" alt="Opens in a new window <spring:message code="footer.logo.bl" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.library.wales/" target="_blank"><img src="img/llgc_logo_BW.png" alt="Opens in a new window <spring:message code="footer.logo.llgc" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.nls.uk/" target="_blank"><img src="img/NLS_logo_2_BW.jpg" alt="Opens in a new window <spring:message code="footer.logo.nls" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.bl.uk/" target="_blank"><img src="img/bl_logo_BW.png" alt="Opens in a new window <spring:message code="footer.logo.blib" />" /></a></div>
        <div class="footer-logo-BW"><a href="http://www.lib.cam.ac.uk/" target="_blank"><img src="img/cambrige_logo600_BW.png" alt="Opens in a new window <spring:message code="footer.logo.cul" />" /></a></div>
        <div class="footer-logo-BW"><a href="https://www.tcd.ie/" target="_blank"><img src="img/trinity-logo-3.png" alt="Opens in a new window <spring:message code="footer.logo.tcd" />" /></a></div>
    </div>
    </div>
</div>
</div>
<hr class="bottomline" />

<!--[if (gt IE 9)|!(IE)]><!-->
<script>


    $(document).ready(function(e) {

    	$(function () {
    		  $('[data-toggle="tooltip"]').tooltip()
		})


        $('.header-mobile-menu-link').click(function(){
            var ele = $('.icon-to-change');
            if(ele.hasClass('fa-bars')){
                ele.removeClass('fa-bars')
                    .addClass('fa-window-close')
            }
            else{
                ele.addClass('fa-bars')
                    .removeClass('fa-window-close')
            }
        })


        $('#mobilemenu2').on('show.bs.collapse', function () {
            $(this).css('background', '#333');

            $(".mobile-menu-icon-settings").css( 'color', '#fff' );
            $(".mobile-menu-icon-settings").css( 'background-color', '#333' );

            $(".header-mobile-menu-link").css( 'background-color', '#333' );
        });

        $('#mobilemenu2').on('hide.bs.collapse', function () {
            $(this).css('background', '#fff');

            $(".mobile-menu-icon-settings").css( 'color', '#2e6dd9' );
            $(".mobile-menu-icon-settings").css( 'background-color', '#fff' );

            $(".header-mobile-menu-link").css( 'background-color', '#fff' );
        });

        $(".header-mobile-menu-link").click(function(){

        });

        $(".menu-item-has-children").mouseleave(function(){
            $(".dropdown").removeClass("open");
        });

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

<!-- Global site tag (gtag.js) - Google Analytics - OLD version -->
<script> (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-7571526-1', 'auto'); ga('send', 'pageview');
</script>
<!-- Global site tag (gtag.js) - Google Analytics - NEW - Active From 2022.07.04 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-K5N6D6LKHP"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-K5N6D6LKHP');
</script>
