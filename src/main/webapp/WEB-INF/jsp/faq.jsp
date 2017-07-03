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
<html lang="en">
<head>
<base href="${fn:substring(url, 0, fn:length(url) - fn:length(uri))}${req.contextPath}/${locale}/ukwa/" />
<title>UKWA Frequently asked questions</title>
<%@include file="head.jsp" %>
</head>

<body>
<%@include file="nav.jsp" %>
<div class="container-fluid">
  <header>
  <%@include file="header.jsp" %>
</header>
<section id="noresults-header">
  <div class="row header-blue white">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12">
      <h2 class="uppercase">Frequently asked questions</h2>
      <p class="text-medium">If your question isn't answered below please <a href="contact">contact us</a>.</p>
    </div>
  </div>
</section>
<section id="content">
  <div class="row margin-0">
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="1">What is the UK Web Archive?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="2">How frequently are sites gathered?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="3">Are &quot;trivial&quot; sites included?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="1"> There are millions of UK websites. They are constantly changing and even disappearing. Often they contain information that is only available online. Responding to the challenge of a potential "digital black hole" the UK Web Archive is there to safeguard as many of these websites as practical. Its purpose is to give permanent online access to key UK websites for future generations.<br/>
      <br/>
      The UK Web Archive contains websites that publish research, that reflect the diversity of lives, interests and activities throughout the UK, and demonstrate web innovation. This includes "grey literature" sites: those that carry briefings, reports, policy statements, and other ephemeral but significant forms of information.<br/>
      <br/>
      Because websites are revisited and snapshots ("instances") taken at regular intervals, readers can see how a website evolves over time. The archive is free to view, accessed directly from the Web itself and, since archiving began in 2004, has collected thousands of websites.<br/>
      <br/>
      Since April 2013 the British Library has begun to archive the whole of the UK web domain, under the terms of the Non-Print Legal Deposit Regulations 2013. This is in partnership with the other five legal deposit libraries for the UK: the National Library of Scotland, the National Library of Wales, Cambridge University Library, the Bodleian Library in Oxford, and the library of Trinity College Dublin. Access to the whole legal deposit web archive will be possible only on premises controlled by one of the six legal deposit libraries. However, the UK Web Archive team will seek additional permissions from the owners of a small selected group of sites for offsite access through this site. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="2"> There are millions of UK websites. They are constantly changing and even disappearing. Often they contain information that is only available on the Web. Responding to the challenge of a potential "digital black hole" web archives are designed to safeguard as many of these websites as practical. The purpose of the UK Web Archive is to collect, preserve and give permanent access to key UK websites for future generations. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="3"> All are welcome to use the UK Web Archive-and to nominate sites that are not yet in the collections.<br/>
      <br/>
      The UK Web Archive is designed to appeal to users across a wide spectrum of interest and knowledge: the general reader, the teacher, the journalist, the policy maker, the academic and personal researcher, and many more besides. Most users will find archived sites that deal with their particular area of interest or subject, and which may contain information that is no longer given on the equivalent live site. Sometimes the live site will no longer exist: in which case the UK Web Archive is likely to hold the only copy that remains.<br/>
      <br/>
      Those represented by the sites themselves, in all the diversity of the United Kingdom, are also intended to be prime users. Website owners themselves use the UK Web Archive to locate information misplaced from previous versions of their sites. Because the Web is of such cultural importance in itself researchers of the history of the Internet will also find the UK Web Archive of great interest.<br/>
      <br/>
      In addition to working radically to increase the amount of content in the UK Web Archive, the British Library, which provides the underpinning infrastructure, is committed to improving the user experience of the Archive. The web site will gradually be developed to bring even better search capabilities and other features of value to the user. The UK Web Archive will also be stored in the British Library's secure digital repository, designed to enable the UK to preserve and make accessible its digital output forever, as well as offering further opportunities of searching across various kinds of archive. </div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="4">How big is the archive?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="5">Who are the organisations behind the UK Web Archive?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="6">Where is the archive held?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="4"> Please check the Archive statistics page for up to date figures on the size of the archive. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="5"> Typically a website is gathered at six monthly intervals, although the gather frequency varies depending on the likelihood of a change in content or the scope of a particular Special Collection.<br/>
      <br/>
      Some websites are archived only once, for example because they are about to close and are only presenting material that will not change again.
      Decisions are made on a case by case basis. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="6"> Our Search help has a detailed section on how to search the UK Web Archive </div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="7">Why is a web archive needed?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="8">How are websites selected?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="9">Does the UK Web Archive endorse websites?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="7"> The UK Web Archive is provided by the British Library in partnership with the National Library of Wales, JISC and The Wellcome Library. In the past, The National Archives and the National Library of Scotland have also been involved. The British Library also has worked with the The Live Art Development Agency, The Society of Friends Library, The Women's Library at London Metropolitan University and other key institutions to build special collections within the UK Web Archive. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="8"> Contributors to the UK Web Archive select websites according to their own collection development policies and areas of expertise. Selected websites are considered to be of long term research value, either in themselves or as part of a Special Collection of themed materials. Typically, archived websites publish research, reflect the diversity of lives, interests and activities throughout the UK, or demonstrate web innovation. They are chosen to represent a range of social, political, cultural, religious, scientific or economic activities. Members of the public, including website owners themselves, are welcome to nominate a website for the archive. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="9"> Contributors to the UK Web Archive seek permission from the website owner for every website it archives unless the website already states that is has given permission (for example through a Creative Commons Licence) or the contributor already has rights to the site (for example, the British Library archives its own site). Asking permission is costly and difficult (many owners simply don't respond to the request) so we have been advising the Government on the necessary regulations required to gather all in-scope UK websites automatically. The British Library and other "legal deposit libraries" have this right in principle under the Legal Deposit Libraries Act (2003) but need a further legal regulation to go ahead. </div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="10">Who is the UK Web Archive for?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="11">Is permission asked first before a website is archived?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="12">Can anyone nominate a UK website?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="10">The Legal Deposit Libraries Act (2003) extended the right of the Legal Deposit Libraries to claim online publications, subject to regulations required by the Act and to be determined by the Government. The process of forming such regulations is still underway so contributors to the UK Web Archive ask permission before archiving UK sites. The UK Legal Deposit Libraries are The British Library, The National Library of Scotland, The National Library of Wales, The Bodleian Library, Oxford and Cambridge University Library. The British Library is currently preparing the technical infrastructure to support the larger scale harvesting that regulation would allow.</div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="11"> Beauty and &quot;trivia&quot; are in the eye of the beholder. The approach of the UK Web Archive is to take a broad view and to build as far as practicable a balanced overall collection. There will be some archived websites that divide users between those who regard them as inappropriate and those who regard them as significant aspects of contemporary life secured for future researchers. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="12"> No. Websites are selected from right across the legal spectrum of opinion and political range, on all sides of any particular debate. Websites in the archive also vary in the sophistication of their production values: from the basic to the equivalent of "glossy". </div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="13">How do you search the UK Web Archive?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="14">Does Legal Deposit legislation apply to websites?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="15">Can I link to the UK Web Archive?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="13"> The UK Web Archive's are stored at the British Library. Plans are underway to store it within the British Library's Digital Library System. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="14"> Yes, if you have a UK favourite and would like to suggest it for archiving, you are most welcome to nominate a website. If you are the owner of a UK website you are especially encouraged to nominate your own site: this will make the permissions process as straightforward as possible. However, please note that we reserve the right to decide whether to include a site and that for technical reasons we may not be able to archive all sites. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="15"> Some websites haven't been selected yet: please nominate a website you notice isn't in the archive but you think should be. Sometimes websites have been identified already but the website owner hasn't responded to a request to archive, or (very rarely) they have refused.<br/>
      <br/>
      Websites are gathered at a particular point in time by harvesting software and are intended to reflect as completely as possible how the website looked and behaved on the Internet at that time. An attempt is made to gather all of the objects associated with a website including html, images, PDF documents, audio and video files and other objects such as programming scripts.<br/>
      <br/>
      However, even the state-of-the-art web crawlers used by the UK Web Archive have technical limitations and are currently unable to capture streaming media, deep web or database content requiring user input, interactive components based on programming scripts or content which requires plug-ins for rendering. This means that certain elements in some of the archived websites are not present.<br/>
      <br/>
      Another reason some archived websites are not complete is that occasionally only one page of the site was ever intended for the archive. This may be due to the kind of permission granted for archiving or may be because the selector regarded the single page as sufficiently representing one aspect within a Special Collection.<br/>
      <br/>
      Finally, websites often link to other websites and it is not always clear to the user that they are doing so. Unless the linked-to website has also been archived by the UK Web Archive when the user clicks on the link they will go to the "Resource Not in Archive" message.<br/>
      <br/>
      The archive is designed to support as many browsers as possible but sometimes different browsers will give different display results: please try a different browser if you are having difficulties with display. </div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="16">How can I get my website removed from the archive?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="17">How can I protect my privacy if information about me is archived?</a></div>
    <div class="col-md-4 col-sm-12 q-grid bg-gray"><a href="#" class="q-question" data-descriptid="18">Why are some archived websites absent, incompleteor?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="16"> We respect intellectual property rights (IPR) and data privacy. We seek the appropriate permissions from rights holders and operate a Notice and Take-down Procedure which notifies us to take down web sites from UK Web Archive under appropriate circumstances. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="17"> It's important for any person making work publicly available on the Internet to be careful with their personal information and that of others. The UK Web Archive collects web pages that are freely and openly available on the Internet. The Archive does not collect pages that require a password to access them (unless specific permission has been given), pages tagged for "robots exclusion" by their owners, pages that are only accessible when a person types into and sends a form, or pages on secure servers such as intranets.<br/>
      <br/>
      However, if you have queries about material in the archive that you feel may infringe your privacy please contact the Archive. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="18"> Yes. Please follow the instructions given in Technical information. </div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="19">Are there other web archives?</a></div>
    <div class="col-md-4 col-sm-12 q-grid"><a href="#" class="q-question" data-descriptid="20">When will my site appear in the archive?</a></div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="19"> Yes. A number of countries and organisations have developed web archives, each with their own approach and range of accessibility. Please see links for more information. </div>
    <div class="col-md-10 offset-md-1 col-sm-12 q-description hidden" id="20"> As soon as practically possible, but please bear with us because we need to spread our archiving schedules to maintain efficiency overall. Websites also need to go through a quality assurance process once they have been harvested: this is the checking that makes sure all archivable elements of the site have transferred properly. Contact the Archive if you have a query about your site. </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
