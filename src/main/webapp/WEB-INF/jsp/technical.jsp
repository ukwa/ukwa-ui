<%--
  Created by IntelliJ IDEA.
  User: mvidmantas
  Date: 19/11/2018
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
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
    <title><spring:message code="technical.title" /></title>
    <%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>

<c:set var="title" value="Technical Information"/>
<%@include file="title.jsp" %>

    <section id="content">
      <div class="row default-padding page-content margin-0 px-md-3 px-sm-2 px-2">

        <div class="default-padding text-content">

            <p class="main-subheading-2-redesign black padding-bottom-40">Click on the question to see the answer</p>


            <div class="padding-bottom-10">
            <a href="#crawlersettings" data-toggle="collapse" class="q-grid no-decoration">UK Web Archive Crawler
                Settings</a>
            <div id="crawlersettings" class="collapse padding-bottom-20 padding-top-20">

                <p>We run a number of different web crawlers for different purposes. Our main crawler visit hundreds of
                    sites on a daily, weekly, monthly, quarterly or six-monthly basis. This crawl process uses two
                    different
                    approaches for capturing web pages. For some URLs, we use an automated web browser to download the
                    page,
                    including images, stylesheets, and some dynamic JavaScript content. We identify this crawling
                    process by
                    including the following declaration in the <a href="https://en.wikipedia.org/wiki/User_agent"
                                                                  target="_blank" class="no-decoration">User Agent:</a>
                </p>

                <figure>
                <pre>
                    <code>bl.uk_lddc_renderbot/{{VERSION}} (+ http://www.bl.uk/aboutus/legaldeposit/websites/websites/faqswebmaster/index.html)</code>
                </pre>
                </figure>

                <p>
                    Where the <code>{{VERSION}}</code> part indicates which version of our crawler is in use, e.g.
                    <code>bl.uk_lddc_renderbot/2.0.0</code>.
                </p>
                <p>
                    Because this process involves running an actual web browser, it can download quite a lot of URLs in
                    a short time, just like a normal user would. However, only a very small set of URLs use this crawl
                    method -- the vast majority of URLs are downloaded using a more traditional web crawler that works a
                    bit more like a normal search engine web crawler. This identifies itself as:
                </p>
                <figure>
                <pre>
                    <code>bl.uk_ldfc_bot/{{VERSION}} (+ http://www.bl.uk/aboutus/legaldeposit/websites/websites/faqswebmaster/index.html)</code>
                </pre>
                </figure>
                <p>for the usual regular crawling activity, or as
                </p>
                <figure>
                <pre>
                    <code>bl.uk_lddc_bot/{{VERSION}} (+ http://www.bl.uk/aboutus/legaldeposit/websites/websites/faqswebmaster/index.html)</code>
                </pre>
                </figure>
                <p>if it's part of our less frequent domain crawls, where we attempt to download content from all UK web
                    sites, which we usually do once per year.</p>
                <p>These larger-scale crawls are more polite, and will download resources from a given web site at no
                    more than two requests per second, will 'back off' if the site is responding slowly.</p>
                <p>In general <code><a href="https://en.wikipedia.org/wiki/User_agent" target="_blank"
                                       class="no-decoration">robots.txt</a></code> is respected and is checked every
                    hour for any changes. We do occasionally chose to disobey <code>robots.txt</code> if necessary.
                    Those 'robot exclusion' directives are usually composed with search engines in mind, and as such,
                    tend to block resources that are unimportant to search engines like stylesheets or JavaScript.
                    However, as an archive, we need those resources in order to be able to replay the content, so
                    sometimes have to ignore <code>robots.txt</code> in order to get them.</p>
                <p>In general a limit is set on the amount of data we download from a given web host: exceeding the
                    limit will automatically stop the crawler. This ensures that if the crawler is in some kind of
                    "trap" it will stop automatically. These download caps are occasionally lifted for large sites where
                    we wish to ensure we get as much of the content as possible.</p>


            </div>
            </div>


            <div class="padding-bottom-10">
            <a href="#crawlerfriendly" data-toggle="collapse" class="q-grid no-decoration">Making Your Website
                Crawler-Friendly</a>
            <div id="crawlerfriendly" class="collapse padding-bottom-20 padding-top-20">

                <p>
                    There are a number of things which you can do to help the UK Web Archive capture as much content as
                    possible from your website:
                </p>
                <ul>
                    <li>Create a <a href="https://en.wikipedia.org/wiki/Site_map" target="_blank"
                                    class="no-decoration">Site Map</a>, and if possible a XML site map too. Creating a
                        site
                        map ensures all the website content can be crawled (some pages may not be discoverable by the
                        crawler, for example pages which use Flash or JavaScript navigation). Having a site map will
                        also
                        help users to find your pages via search engines.
                    </li>
                    <li>Use <code><a href="https://en.wikipedia.org/wiki/User_agent" target="_blank"
                                     class="no-decoration">robots.txt</a></code> to prevent access to areas of the site
                        which may cause problems if crawled e.g. databases, including online catalogues; "shopping
                        baskets",
                        etc.
                    </li>
                    <li>Provide standard links to content which would otherwise only be accessed via selecting drop down
                        menus, certain dynamic kinds of navigation (e.g JavaScript) or by conducting searches on the
                        website. This is because the crawler cannot access content hidden behind search forms. Websites
                        can
                        of course still use those devices but if standard links are also provided on the website then
                        the
                        content is more likely to be captured properly.
                    </li>
                </ul>
                <p>
                    For more information, please see:
                </p>
                <ul>
                    <li>Columbia Universities Libraries' <a
                            href="https://library.columbia.edu/bts/web_resources_collection/guidelines_for_preservable_websites.html"
                            target="_blank"
                            class="no-decoration">Guidelines for Preservable Websites</a></li>
                    <li>Stanford Libraries' <a href="https://library.stanford.edu/projects/web-archiving/archivability"
                                               target="_blank"
                                               class="no-decoration">Archivability</a></li>
                </ul>


            </div>
        </div>



            <div class="padding-bottom-10">
            <a href="#cantatchive" data-toggle="collapse" class="q-grid no-decoration">What Can't Yet Be Archived</a>
            <div id="cantatchive" class="collapse padding-bottom-20 padding-top-20">
                <p>
                    The current generation of web crawlers cannot capture:
                </p>
                <ul>
                    <li>Interactive, dynamically generated content
                    </li>
                    <li>Content that is only available via a search engine on the website, or some other form submission method
                    </li>
                    <li>Some types of JavaScript-driven menus
                    </li>
                    <li>YouTube videos, Flash movies and similar streaming audio or video (some audio and video files can be captured, e.g. those embedded via the standard <a href="https://en.wikipedia.org/wiki/HTML5" target="_blank"
                                                                                                                                                                               class="no-decoration">HTML5</a> <code>&lt;video&gt;</code> or <code>&lt;audio&gt;</code> tags).</li>
                </ul>
                <p>
                    Unlike static HTML, which is relatively easy to capture, script code is very hard for traditional web crawlers to analyse, which is why we run web browsers for a limited part of our crawls. Even that cannot capture very interactive web sites, like single-page web applications, or any site feature that needs a remote server to function. In practical terms this means that entering queries into the search box of an archived version of a website will not work. Standard links on the website, however, will work as normal.
                </p>

                <p>
                    Many sites provide both a search box and a site map to help their users search content in different ways, but if there is only search engine retrieval the UK Web Archive will not be able to harvest the content.
                </p>

                <p>
                    Some JavaScript driven menus do not function well once archived. YouTube videos, Flash movies, and similar streaming audio or video are also beyond the capability of web crawlers. However, as members of the International Internet Preservation Consortium, contributors to the UK Web Archive are developing tools which will help capture this content in the future.
                </p>

                <p>
                    The crawler software cannot automatically gather any material that is protected behind a password, without the owner's collaboration. Web site owners may however choose to divulge confidentially a user ID and password to allow archiving of these areas. Please <a href="contact" class="no-decoration">contact us</a> for more information.
                </p>

            </div>
        </div>


            <div class="padding-bottom-10">
            <a href="#searchengines" data-toggle="collapse" class="q-grid no-decoration">Search Engines and the UK Web
                Archive</a>
            <div id="searchengines" class="collapse padding-bottom-20 padding-top-20">
                <p>The UK Web Archive site is indexed by search engines but only to the level of the information pages:
                    search engines are not allowed to index the archived sites.
                </p>
                <p>For example, if you search for the 'Arts and Humanities Research Council' on Google , you will only
                    find the live site on the initial pages of hits. If you search for 'UKWA' and the 'Arts and
                    Humanities Research Council', you will find a UK Web Archive information page which links to the
                    archived instances of the AHRC website.
                </p>
                <p>This is to stop the Archive diverting traffic from the live site and to prevent users thinking that
                    information on the archived version is actually the latest version of events. The archived version
                    of your website will not appear in a search engine without your permission.
                </p>
            </div>
</div>


            <div class="padding-bottom-10">
            <a href="#linking" data-toggle="collapse" class="q-grid no-decoration">Linking to the UK Web Archive</a>
            <div id="linking" class="collapse padding-bottom-20 padding-top-20">
                <p>All sites are welcome to link to the UK Web Archive.
                </p>
                <p>To use a plain text link, simply copy and paste the following code below onto your page. Please
                    customise the text between > and < to suit your own house style of citation:
                </p>
                <figure>
                <pre>
                    <code>&lt;div style=...&gt;&lt;a href="http://www.webarchive.org.uk/"&gt;Click here for the UK Web Archive&lt;/a&gt;&lt;/div&gt;</code>
                </pre>
                </figure>
                <p>To use a link that has the UK Web Archive logo, then copy and paste this code:
                </p>
                <p align="left">
                    <figure>
                <pre>
                    <code>&lt;div style=...&gt;&lt;a href="http://www.webarchive.org.uk/"&gt;&lt;img alt="UK Web Archive" src="https://www.webarchive.org.uk/en/ukwa/img/ukwa-logo-60px.jpg"&gt;&lt;/img&gt;&lt;/a&gt;&lt;/div&gt;</code>
                </pre>
                    </figure>
                </p>

            </div>
        </div>


            <div class="padding-bottom-10">
            <a href="#techbkg" data-toggle="collapse" class="q-grid no-decoration">Technical Background</a>
            <div id="techbkg" class="collapse padding-bottom-20 padding-top-20">
                <p>Before the 2013 <a href="https://www.bl.uk/legal-deposit" target="_blank"
                                      class="no-decoration">Legal Deposit</a> regulations came into force, websites were gathered for the UK Web
                    Archive strictly on a by-permission-only basis using the Web Curator Tool (WCT) which was developed
                    collaboratively by the National Library of New Zealand and the British Library, under the auspices
                    of the International Internet Preservation Consortium. <a href="http://dia-nz.github.io/webcurator/" target="_blank"
                                                                              class="no-decoration">WCT is an open-source software</a>, freely
                    available under the terms of the Apache Public License.</p>
                <p>Due to the increase volume of continual crawling activity required to meet our Legal Deposit
                    responsibilities, we have moved to different crawl tools. Like WCT, we use the core <a href="https://github.com/internetarchive/heritrix3" target="_blank"
                                                                                                           class="no-decoration">Heritrix</a>
                    archival crawler software, developed by the Internet Archive, but as part of a different suite of
                    lifecycle management tools. All of these tools are available for re-use via <a href="https://github.com/ukwa" target="_blank"
                                                                                                   class="no-decoration">our GitHub organisation</a>.</p>
            </div>
        </div>

        </div>
        </div>
    </section>
    <footer class="footer-content">
        <%@include file="footer.jsp" %>
    </footer>
</div>
</body>
</html>
