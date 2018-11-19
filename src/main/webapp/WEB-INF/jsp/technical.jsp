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
    <title><spring:message code="privacy.title" /></title>
    <%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
    <header>
        <%@include file="header.jsp" %>
    </header>
    <div class="row">
        <div class="col-12 white main-search-input-new left background-settings-default">
            <div class="main-heading-2-bold-redesign white">Technical information</div>
        </div>
    </div>

    <section id="content">

        <div class="default-padding text-content">

            <p class="main-subheading-2-redesign black padding-bottom-40">Click on the question to see the answer</p>

            <p>
                <a href="#crawlersettings" data-toggle="collapse">UK Web Archive Crawler Settings</a>
            <div id="crawlersettings" class="collapse">
                The UK Web Archive endeavours to request permissions from website content owners before crawling a site, usually by email or letter. Our crawler is set to a polite rate to minimise traffic on websites. Its IP address is 194.66.232.85, and it identifies itself as: "Mozilla/5.0 (compatible; heritrix/1.14.1 +http://www.webarchive.org.uk/)".
                The crawl engine imposes a delay between fetching URLs (Uniform Resource Locators) from the same host which is a multiple of the amount of time it took to fetch the last URL downloaded from that host. The delay­factor is set to 5 so that if for example it took 800 milliseconds to fetch the last URL from the host then the crawler will wait 4000 milliseconds (4 seconds) before allowing another URL from the host to be processed. It is not possible to have multiple concurrent URLs being processed from the same host. In general "robots.txt" is respected and is checked every hour for any changes. An exception is made for some folders, e.g. images and layout folders that are needed to make a complete copy of the site, but which the website owner naturally might not want a search engine to copy. We make this exception because we have permission to crawl the whole site.
                In general a limit is set on the number of URLs downloaded and the size: exceeding the limit will automatically stop the crawler. This ensures that if the crawler is in some kind of "trap" it will stop automatically when either of the limits is reached.
            </div>
            </p>


            <p>
                <a href="#crawlerfriendly" data-toggle="collapse">Making Your Website Crawler-Friendly</a>
            <div id="crawlerfriendly" class="collapse">
                There are a number of things which you can do to help the UK Web Archive capture as much content as possible from your website:
                Create a Site Map page. An XML site map can also be useful. Creating a sitemap ensures all the website content can be crawled (some pages may not be discoverable by the crawler, for example pages which use Flash or JavaScript navigation).
                Use robots.txt to prevent access to areas of the site which may cause problems if crawled e.g. databases, including online catalogues; "shopping baskets", etc.
                Provide standard links to content which would otherwise only be accessed via selecting drop down menus, certain dynamic kinds of navigation (e.g JavaScript) or by conducting searches on the website. This is because the crawler cannot access content hidden behind search forms. Websites can of course still use those devices but if standard links are also provided on the website then the content is more likely to be captured properly.
            </div>
            </p>


            <p>
                <a href="#cantatchive" data-toggle="collapse">What Can't Yet Be Archived</a>
            <div id="cantatchive" class="collapse">
                The current generation of web crawlers cannot capture:

                Dynamically generated content
                Content that is only available via a search engine on the website
                Some types of JavaScript-driven menus
                YouTube videos, Flash movies and similar streaming audio or video (some audio files can, however, be captured)
                Unlike static HTML, which is relatively easy to capture, script code is almost impossible for web crawlers to analyse. In practical terms this means that entering queries into the search box of an archived version of a website will not work. Standard links on the website, however, will work as normal.

                Many sites provide both a search box and a site map to help their users search content in different ways, but if there is only search engine retrieval the UK Web Archive will not be able to harvest the content.

                Some JavaScript driven menus do not function well once archived. YouTube videos, Flash movies, and similar streaming audio or video are also beyond the capability of web crawlers. However, as members of the International Internet Preservation Consortium, contributors to the UK Web Archive are developing tools which will help capture this content in the future.

                The crawler software cannot gather any material that is protected behind a password, without the owner's collaboration. Web site owners may however choose to divulge confidentially a user ID and password to allow archiving of these areas. Please email us for more information.
            </div>

            </p>

            <p>
                <a href="#searchengines" data-toggle="collapse">Search Engines and the UK Web Archive</a>
            <div id="searchengines" class="collapse">
                The UK Web Archive site is indexed by search engines but only to the level of the information pages: search engines are not allowed to index the archived sites.

                For example, if you search for the ‘Arts and Humanities Research Council’ on Google , you will only find the live site on the initial pages of hits. If you search for ‘Archive’ and the ‘Arts and Humanities Research Council’, you will find a UK web Archive information page which links to the archived instances of the AHRC website.

                This is to stop the Archive diverting traffic from the live site and to prevent users thinking that information on the archived version is actually the latest version of events. The archived version of your website will not appear in a search engine.
            </div>

            </p>

            <p>
                <a href="#linking" data-toggle="collapse">Linking to the UK Web Archive</a>
            <div id="linking" class="collapse">
                All sites are welcome to link to the UK Web Archive.

                To use a plain text link, simply copy and paste the following code below onto your page. Please customise the text between > and < to suit your own house style of citation:

                <div style=...><a href="http://www.webarchive.org.uk/">Click here for the UK Web Archive</a></div>

                To use a link that has the UK Web Archive logo, then copy and paste this code:

                <div style=...><a href="http://www.webarchive.org.uk/"><img alt="UK Web Archive" src="http://www.webarchive.org.uk/images/ukwa.jpg"></img></a></div>
            </div>

            </p>

            <p>
                <a href="#techbkg" data-toggle="collapse">Technical Background</a>
            <div id="techbkg" class="collapse">
                Websites are gathered for the UK Web Archive with the Web Curator Tool (WCT) which was developed collaboratively by the National Library of New Zealand and the British Library, under the auspices of the International Internet Preservation Consortium. WCT is an open­source software, freely available under the terms of the Apache Public License. WCT manages the selective web harvesting process.

                WCT allows web archivists to manage their workflows for the following core processes:

                Harvest authorisation: getting permission to harvest Web material and make it available
                Selection, scoping and scheduling: what will be harvested, how, when and how often
                Description: adding descriptive metadata
                Harvesting: downloading the material at the appointed time using the Heritrix Web harvester
                Quality Assurance (QA): making sure the harvest worked as expected, and correcting simple harvest errors.
                The Web Curator Tool works in a similar way to a browser in that it makes requests of a host for files. The software follows links within a site and gathers the accessible files it finds. It is capable of gathering database driven sites such as PHP or ASP sites, but cannot however gather contents of databases ­ the so-called "deep web" ­ such as library catalogues.

                WCT uses the Heritrix crawler software, developed by the Internet Archive, which is tuned to "polite" to minimise the impact on the websites being crawled.
            </div>

            </p>
        </div>
    </section>    <footer>
        <%@include file="footer.jsp" %>
    </footer>
</div>
</body>
</html>
