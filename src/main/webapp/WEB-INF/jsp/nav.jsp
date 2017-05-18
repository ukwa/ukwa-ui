<nav>
  <div class="main-menu-block"></div>
  <div class="main-menu">
    <div class="main-menu-close" title="<spring:message code="main.menu.close.title" />"></div>
    <div class="main-menu-cont">
      <!--<a href="index" title="<spring:message code="main.menu.home.title" />"><div tabindex="1" class="main-menu-item border-none"><img class="main-menu-img" alt="Home" src="img/icons/home-white.png"/><spring:message code="main.menu.home" text="Home" /></div></a>
      <a href="info/about" title="<spring:message code="main.menu.about.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="About" src="img/icons/about-white.png"/><spring:message code="main.menu.about" text="About" /></div></a>
      <a href="advancedsearch" title="<spring:message code="main.menu.advancedsearch.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="Advanced search" src="img/icons/search-white.png"/><spring:message code="main.menu.advancedsearch" text="Advanced search" /></div></a>
      <a href="visualisation" title="<spring:message code="main.menu.visualisations.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="Visualisations" src="img/icons/visualisation-white.png"/><spring:message code="main.menu.visualisations" text="Visualisations" /></div></a>
      <a href="info/mementos" title="<spring:message code="main.menu.mementos.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="Memento" src="img/icons/clock-white.png"/><spring:message code="main.menu.mementos" text="Mementos" /></div></a>
      <a href="info/nominate" title="<spring:message code="main.menu.nominate.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="Nominate a site" src="img/icons/plus-white.png"/><spring:message code="main.menu.nominate" text="Nominate a site" /></div></a>
      <a href="info/contact" title="<spring:message code="main.menu.contact.title" />"><div tabindex="1" class="main-menu-item"><img class="main-menu-img" alt="Contact" src="img/icons/contact-white.png"/><spring:message code="main.menu.contact" text="Contact" /></div></a>-->
      
      <a href="index" title="<spring:message code="main.menu.home.title" />"><div tabindex="1" class="main-menu-item border-none"><spring:message code="main.menu.home" text="Home" /></div></a>
      <a href="collections" title="<spring:message code="main.menu.collections.title" />"><div tabindex="1" class="main-menu-item border-none"><spring:message code="main.menu.collections" text="Special Collections" /></div></a> 
      <a href="nominate" title="<spring:message code="main.menu.nominate.title" />"><div tabindex="1" class="main-menu-item border-none"><spring:message code="main.menu.nominate" text="Nominate a site" /></div></a>
      <a href="contact" title="<spring:message code="main.menu.contact.title" />"><div tabindex="1" class="main-menu-item border-none"><spring:message code="main.menu.contact" text="Contact" /></div></a>

<c:if test="${!fn:startsWith(textUri, '/en/')}">
  <a href="/en<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.english.title" />"><div tabindex="1" class="main-menu-item border-none">English</div></a>
</c:if>

<c:if test="${!fn:startsWith(textUri, '/cy/')}">
  <a href="/cy<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.welsh.title" />"><div tabindex="1" class="main-menu-item border-none">Cymraeg</div></a>
</c:if>

<c:if test="${!fn:startsWith(textUri, '/gd/')}">
  <a href="/gd<c:out value="${textUriWithoutLang}"/>" title="<spring:message code="main.menu.scottish.title" />"><div tabindex="1" class="main-menu-item border-none">Alba</div></a>
</c:if>

    </div>
  </div>
</nav>