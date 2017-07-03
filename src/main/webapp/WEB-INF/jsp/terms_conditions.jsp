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
<title>UKWA Terms and Conditions of Use</title>
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
      <h2 class="uppercase">Terms and Conditions of Use for the UK Web Archive</h2>
    </div>
  </div>
</section>
<section id="content">
  <div class="row margin-0 padding-side-20 padding-top-80 padding-bottom-80">
    <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 col-sm-12 text-justify">
      <p>The UK Web Archive (the &ldquo;Archive&rdquo;) is operated by	the British Library Board, a body corporate established under the	British Library Act of 27 July 1972, of 96 Euston Road, London NW1	2DB, United Kingdom (&ldquo;We&rdquo; &ldquo;Us&rdquo; and &ldquo;Our&rdquo;). The Archive	contains selected websites from	across the UK and is provided to the user (&ldquo;You&rdquo;	and &ldquo;Your&rdquo;) solely in	accordance with these terms and conditions &ldquo;Terms and Conditions&rdquo;,	which are non-negotiable.</p>
      <h2 class="margin-top-20">1. GENERAL</h2>
      <p>1.1 If you use the Archive you agree to be bound by the	Terms and Conditions and any guidelines, rules or disclaimers that	may be posted and updated on specific Web pages or on notices that	are sent to you. If we believe you have breached any of the above, we may, at our sole discretion, suspend or cancel your access to the	Archive immediately, without giving you any advance notice and	we shall not be liable for any losses or damages that may arise from	such suspension or cancellation.</p>
      <h2 class="margin-top-20">2. GRANT OF LICENCE AND USE OF THE ARCHIVE</h2>
      <p>2.1 We grant to you, solely in accordance with the Terms	and Conditions, a non-transferable, non-exclusive licence to:</p>
      <p>2.1.1 search and browse the archive for the purposes of your non commercial research;</p>
      <p>2.1.2 temporarily download a single copy of the material in	the Archive on a single computer for your own private viewing /	listening purposes only.</p>
      <p>2.2 Your use of the Archive is solely permitted for the	purposes set out in clause 2.1 and for the avoidance of doubt, you	are specifically prohibited from:</p>
      <p>2.2.1 permanently downloading or copying the material in	the Archive;</p>
      <p>2.2.2 granting sub-licences;</p>
      <p>2.2.3 making any additions, deletions, modifications,	adjustments or alterations to the Archive;</p>
      <p>2.2.4 photographing, filming, reproducing, retransmitting,	distributing, disseminating, selling, reselling, transferring,	hiring, publishing, broadcasting or using the Archive or any part	thereof, for any monetary reward whatsoever;</p>
      <p>2.2.5 permitting equipment or software to be linked to or	communicate in any manner with or be used in connection with any	other service or website, whereby the information or material	obtained from the Archive or any part of it is being accessed,	used, stored or distributed as the case may be, by or through such	other service or website, equipment or software;</p>
      <p>2.2.6 attempting to rectify or permit any persons other	than us or our agents to rectify any fault or inaccuracy in the	Archive;</p>
      <p>2.2.7 using any equipment and/or software to access the	Archive in a manner which corrupts the Archive, or which is any	way inconsistent with the Terms and Conditions;</p>
      <p>2.2.8 infringing or permitting the infringement of our	proprietary rights or any intellectual property rights (&ldquo;IPR&rdquo;)	in any part of the Archive, or using the Archive in	any way that might be otherwise unlawful or that might bring us into disrepute.</p>
      <p>2.3 Not withstanding anything in these Terms and Conditions, you are not prohibited from doing any act in relation	to the Archive which would otherwise be permitted by law.</p>
      <h2 class="margin-top-20">3. ACCESS AND CHANGES TO THE ARCHIVE</h2>
      <p>3.1We may:</p>
      <p>3.1.1 make additions to, deletions from or otherwise change	the Archive without notice at any stage if we deem this necessary	or circumstances arise that are outside our control;</p>
      <p>3.1.2 remove any website from the Archive at our sole	discretion (including, but not limited to, websites notified to us	through our <a href="notice_takedown">Notice and Takedown procedure</a></p>
      <p>3.2 You may nominate specific websites for addition to the	Archive. However, such websites shall be added to the Archive solely at our discretion.</p>
      <p>3.3 We reserve the right to withdraw the Archive in part or in full at any time without prior written notice.</p>
      <p>3.4 You will be responsible for making the necessary arrangements for access to the Archive and for ensuring that all requirements, legal and technical, are complied with.</p>
      <h2 class="margin-top-20">4. LIABILITY</h2>
      <p>4.1 You acknowledge that, in your use of the Archive:</p>
      <p>4.1.1 You use your own skill and judgement;</p>
      <p>4.1.2 You accept all copyright and disclaimer provisions.</p>
      <p>4.2 Whilst we will endeavour to ensure that the Archive is	normally available 24 hours a day, due to the inherent nature of the Internet, errors, interruptions and delays may occur in the	service at any time. Accordingly, the Archive is provided on an &quot;AS	IS&quot; and &quot;AS AVAILABLE&quot; basis without any warranties	of any kind. Access to the Archive may be suspended temporarily	and without notice in the case of system failure, maintenance or repair or for any other reasonable cause. We do not accept any	liability arising from:</p>
      <p>4.2.1 any interruption in availability or problems	associated with transmission or access by/to the Archive;</p>
      <p>4.2.2 the failure of the Archive or the equipment or software;</p>
      <p>4.2.3 the unavailability of material or information or any	related software.</p>
      <p>4.3 You acknowledge that some of the content has originated with third parties and may not be accurate, comprehensive or current. We shall not accept any liability for	any inaccuracy or omission in the information provided on the	Archive. All implied warranties are excluded from these Terms and Conditions to the extent that they may be excluded as a matter of law.</p>
      <p>4.4 You acknowledge that the information on the Archive	and any related material is an archived resource, and does not	constitute any form of advice or recommendation by us. You	acknowledge that the information on the Archive does not reflect our views and opinions and that it should not be relied upon by you	in making (or refraining from making) business or personal	decisions.</p>
      <p>4.5 If you object to the publication of any material placed on the Archive please <a href="contact">contact us</a>.</p>
      <p>4.6 We will use reasonable endeavours to ensure that the Archive does not contain or promulgate any viruses or other malicious code. However, it is recommended that you should virus check all such materials and regularly check for the presence of	viruses and other malicious code. We exclude to the fullest extent permitted by applicable laws all liability in connection with any damage or loss caused by computer viruses or other malicious code originating or contracted from the Archive.</p>
      <p>4.7 We will not be liable for any damages (including, without limitation, damages for loss of the profits) arising in	contract, tort or otherwise from your use or inability to use the Archive or any content or from any action taken (or refrained from	being taken) as a result of using the Archive or any content on it,	including in respect of infringement of third party rights arising	from the your use of the content.</p>
      <h2 class="margin-top-20">5. INDEMNITY</h2>
      <p>5.1 You undertake to indemnify us and keep us indemnified	at all times against all actions, proceedings, costs, claims, demands, liabilities and expenses whatsoever (including legal and	other fees and disbursements) sustained, incurred or paid by us	directly or indirectly in respect of:</p>
      <p>5.1.1 access to and/or use of the Archive (other than as	permitted by the Terms and Conditions) by you;</p>
      <p>5.1.2 any information, data or material produced by you as	a result of your use of the Archive; and</p>
      <p>5.1.3 any breach by you of any of the Terms and Conditions.</p>
      <h2 class="margin-top-20">6.INTELLECTUAL PROPERTY RIGHTS</h2>
      <p>6.1 The Archive and the websites contained therein are	protected by copyright and other IPR. By entering the Archive, you acknowledge that those rights are the sole and exclusive property of	the copyright and/or other IPR holder.</p>
      <p>6.2 If you wish to use any information sourced from the	Archive for any purpose inconsistent with these Terms and Conditions, you must contact the copyright holder to seek permission.</p>
      <h2 class="margin-top-20">7. CONFIDENTIAL INFORMATION</h2>
      <p>7.1 You acknowledge and accept that, in order to perform our obligations under these Terms and Conditions, it may be necessary for us to hold information relating to you.</p>
      <p>7.2 In respect of such information, we undertake that we shall comply with the Data Protection Act 1998 (the &ldquo;Act&rdquo;) and specifically that such information:</p>
      <p>7.2.1 shall be obtained, held and processed only for the specified purposes of the Terms and Conditions;</p>
      <p>7.2.2 shall not be further processed in a manner	incompatible with those purposes;</p>
      <p>7.2.3 will be accurate and where necessary kept up to date;</p>
      <p>7.2.4 will not be kept for longer than is necessary for the	discharge of our functions under the Terms and Conditions;</p>
      <p>7.2.5 shall not be disclosed to any third party, other than	for a 'permitted disclosure' as defined by the Act.</p>
      <p>7.3 You acknowledge that we are	subject to the requirements of the Freedom of Information Act 2000	(&quot;the Act&quot;), and shall provide all necessary assistance as reasonably required by us to enable us to comply with the Act. You	agree to provide any such assistance to us within five working days	of any request made by us under this clause 7.3.</p>
      <h2 class="margin-top-20">8. ASSIGNMENT</h2>
      <p>8.1 You must not assign or otherwise dispose of your rights under these Terms and Conditions without our prior written	consent.</p>
      <h2 class="margin-top-20">9. APPLICABLE LAW</h2>
      <p>9.1 These Terms and Conditions shall be governed by and	construed in accordance with English law. You hereby submit to and	agree that the sole jurisdiction and venue for any actions that may	arise under or in relation to the subject matter hereof shall be the English courts.</p>
      <p>The British Library</p>
      <p>September 2010</p>
    </div>
  </div>
</section>
<footer>
  <%@include file="footer.jsp" %>
</footer>
</div>
</body>
</html>
