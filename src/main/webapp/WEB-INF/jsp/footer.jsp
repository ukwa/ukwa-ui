<div class="row">
  <div class="col-md-1">&nbsp;</div>
  <div class="col-md-3 col-md-offset-1 col-sm-12 footer-links footer-right-border"> <a href="index" title="<spring:message code="footer.home.title" />">
    <spring:message code="footer.home" /></a><br/>
    <a href="info/about" title="<spring:message code="footer.about.title" />">
    <spring:message code="footer.about" text="About" /></a><br/>
    <a href="collection" title="<spring:message code="footer.collections.title" />">
    <spring:message code="footer.collections" /></a><br/>
    <a href="http://britishlibrary.typepad.co.uk/webarchive/" target="_blank" title="<spring:message code="footer.blog.title" />">
    <spring:message code="footer.blog" /></a><br/>
    <a href="info/nominate" title="<spring:message code="footer.nominate.title" />">
    <spring:message code="footer.nominate" /></a><br/>

  </div>
  <div class="col-md-1">&nbsp;</div>
  <div class="col-md-3 col-md-offset-1 col-sm-12 footer-links footer-right-border">

    <a href="info/notice_takedown" title="<spring:message code="footer.notice.title" />">
    <spring:message code="footer.notice" /></a><br/>
    <a href="info/terms_conditions" title="<spring:message code="footer.terms.title" />">
    <spring:message code="footer.terms" /></a><br/>
    <a href="info/privacy" title="<spring:message code="footer.privacy.title" />">
    <spring:message code="footer.privacy" /></a><br/>
        <a href="info/cookies" title="<spring:message code="footer.cookies.title" />">
    <spring:message code="footer.cookies" /></a><br/>
  </div>
  <div class="col-md-1">&nbsp;</div>
  <div class="col-md-3 col-md-offset-1 col-sm-12 footer-links">
        <a href="info/faq" title="<spring:message code="footer.faq" />">
    <spring:message code="footer.faq" /></a><br/>
    <a href="contact" title="<spring:message code="footer.contact.title" />">
    <spring:message code="footer.contact" /></a><br/>
    <c:set var="textUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
    <c:set var="textUriWithoutLang" value="${textUri == '/en' || textUri == '/cy' || textUri == '/gd'
                                        ? '/'
                                        : fn:replace(fn:replace(fn:replace(textUri, '/en/', '/'), '/gd/', '/'), '/cy/', '/')}"/>
    <c:if test="${!fn:startsWith(textUri, '/en/') && textUri != '/en'
          && (fn:contains(textUri, '/gd/') || textUri =='/gd' || fn:contains(textUri, '/cy/')  || textUri =='/cy')}">
      <span lang="en"><a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.english.title" />">
      <spring:message code="footer.english" /></a></span><br/>
    </c:if>
    <c:if test="${!fn:startsWith(textUri, '/cy/') && textUri != '/cy'}"> <span lang="cy"><a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.welsh.title" />">
      <spring:message code="footer.welsh" /></a></span><br/>
    </c:if>
    <c:if test="${!fn:startsWith(textUri, '/gd/') && textUri != '/gd'}"> <span lang="gn"><a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="footer.scottish.title" />">
      <spring:message code="footer.scottish" /></a></span><br/>
    </c:if>
    
    <a href="https://www.webarchive.org.uk/rss/recent.xml" title="<spring:message code="footer.rss.title" />">
    <spring:message code="footer.rss" /></a><br/>
  </div>
</div>
<div class="row">
  <div class="col-md-12 col-sm-12 footer-logos"> <a href="https://www.bl.uk/" target="_blank"><img src="img/bl_logo.png" alt="<spring:message code="footer.logo.blib" />" class="footer-logo"/></a> <a href="https://www.llgc.org.uk/" target="_blank"><img src="img/llgc_logo.png" alt="<spring:message code="footer.logo.llgc" />" class="footer-logo"/></a> <a href="https://www.
    .uk/" target="_blank"><img src="img/NLS_logo_2.jpg" alt="<spring:message code="footer.logo.nls" />" class="footer-logo"/></a><br/>
    <a href="http://www.bodleian.ox.ac.uk/" target="_blank"><img src="img/bodleian_logo.jpg" alt="<spring:message code="footer.logo.bl" />" class="footer-logo"/></a> <a href="http://www.lib.cam.ac.uk/" target="_blank"><img src="img/cambrige_logo600.png" alt="<spring:message code="footer.logo.cul" />" class="footer-logo"/></a> <a href="https://www.tcd.ie/" target="_blank"><img src="img/trinity_logo.jpg" alt="<spring:message code="footer.logo.tcd" />" class="footer-logo"/></a> </div>
</div>

<div class="cookies-cont">
<div class="row">
<div class="col-md-8 col-sm-12"><spring:message code="footer.cookies.text" /></div>
<div class="col-md-4 col-sm-12 padding-top-mobile-10"><button class="button button-white float-sm-right" id="btn_cookies" title="<spring:message code="footer.cookies.button.title" />"><spring:message code="footer.cookies.button" /></button></div>
</div>
</div>

<!--[if (gt IE 9)|!(IE)]><!-->
<script>
    $(document).ready(function(e) {
        //survey monkey
        var content = '<div class="padding-20 black center width-100"><h2><spring:message code="survey.text"/></h2></div><div id="surveymonkeydiv" class="padding-20 clearfix center width-100"><a href="<spring:message code="survey.url"/>" title="<spring:message code="survey.button"/>" target="_blank"><button id="surveybutton" class="button button-blue white padding-20" role="link" tabindex="-1"><spring:message code="survey.button"/></button></a><div class="padding-20 padding-top-40 black center width-100"><img class="img-survey" alt="MonkeySurvey" src="img/surveymonkeylogo.jpg"/></div>';
        if (typeof $.cookie('survey_viewed') === 'undefined' || $.cookie('survey_viewed')!=="true") {
            $('#betadivlink').show();
            $.SimpleLightbox.open({
                content: content,
                elementClass: 'slbContentEl'
            });
            $.cookie("survey_viewed", "true", { expires: 365, path: '/',  });
        }

        if (typeof $.cookie('survey_link_pressed_in_banner') === 'undefined' || $.cookie('survey_link_pressed_in_banner')!=="true") {
            $('#betadivlink').show();
        }

        $('#betadivlink a').click(function(evt) {
            $.cookie("survey_link_pressed_in_banner", "true", { expires: 365, path: '/',  });
            $.cookie("survey_viewed", "true", { expires: 365, path: '/',  });
        });

        $("#surveybutton").button().click(function(){
            $.cookie("survey_link_pressed_in_banner", "true", { expires: 365, path: '/',  });
            $.cookie("survey_viewed", "true", { expires: 365, path: '/',  });
        });

    });

</script>
<!--<![endif]-->

<script> (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){ (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o), m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m) })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
ga('create', 'UA-7571526-5', 'auto'); ga('send', 'pageview');
</script>
