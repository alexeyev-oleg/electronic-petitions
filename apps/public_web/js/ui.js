function renderLogo(target, inverse = false) {
  const letters = ['G', 'E', 'S', 'H', 'E', 'R'];
  const className = inverse ? 'logo logo--inverse' : 'logo';
  target.innerHTML = letters
    .map((letter) => `<span class="logo__letter">${letter}</span><span class="logo__dot"></span>`)
    .join('');
}

function formatNumber(value) {
  return new Intl.NumberFormat(getLocale()).format(value);
}

function currentPageName() {
  const path = window.location.pathname.split('/').pop() || 'index.html';
  return path;
}

function navLink(path, label, active = false) {
  return `<a class="site-nav__link ${active ? 'is-active' : ''}" href="${pagePath(path)}">${label}</a>`;
}

function renderSiteHeader() {
  const header = document.getElementById('site-header');
  if (!header) {
    return;
  }

  const page = currentPageName();
  header.innerHTML = `
    <div class="site-header__inner">
      <a class="site-brand" href="${pagePath('/index.html')}">
        <div class="logo-mark" aria-hidden="true">G</div>
        <div class="logo" id="header-logo" aria-label="G.E.S.H.E.R."></div>
      </a>
      <nav class="site-nav" aria-label="Main">
        ${navLink('/index.html', t('navHome'), page === 'index.html')}
        ${navLink('/initiatives.html', t('navInitiatives'), page === 'initiatives.html' || page === 'initiative.html')}
        ${navLink('/how-it-works.html', t('navHow'), page === 'how-it-works.html')}
        ${navLink('/faq.html', t('navFaq'), page === 'faq.html')}
        ${navLink('/about.html', t('navAbout'), page === 'about.html')}
        ${navLink('/download.html', t('navDownload'), page === 'download.html')}
        ${navLink('/demo-sync.html', t('navDemoSync'), page === 'demo-sync.html')}
      </nav>
      <div class="site-header__actions">
        <label class="sr-only" for="locale-select">${t('localeLabel')}</label>
        <select id="locale-select" class="locale-select" aria-label="${t('localeLabel')}">
          <option value="ru">RU</option>
          <option value="en">EN</option>
          <option value="he">HE</option>
          <option value="ar">AR</option>
        </select>
        <a class="btn btn--secondary" href="${pagePath(window.GESHER_PUBLIC_CONFIG.staffPortalPath)}">${t('ctaStaff')}</a>
      </div>
    </div>
  `;

  renderLogo(document.getElementById('header-logo'));
  bindLocaleSelect(document.getElementById('locale-select'));
}

function renderSiteFooter() {
  const footer = document.getElementById('site-footer');
  if (!footer) {
    return;
  }

  footer.innerHTML = `
    <div class="site-footer__inner">
      <div class="site-footer__grid">
        <div>
          <div class="logo logo--inverse" id="footer-logo" aria-label="G.E.S.H.E.R."></div>
          <p style="margin:var(--space-sm) 0 0;">${t('heroTagline')}</p>
          <span class="chip" style="margin-top:var(--space-sm);background:rgba(255,255,255,0.1);color:#fff;">${t('mockBadge')}</span>
        </div>
        <div>
          <h3>${t('footerCitizen')}</h3>
          <ul>
            <li><a href="${pagePath('/initiatives.html')}">${t('navInitiatives')}</a></li>
            <li><a href="${pagePath('/how-it-works.html')}">${t('navHow')}</a></li>
            <li><a href="${pagePath('/faq.html')}">${t('navFaq')}</a></li>
          </ul>
        </div>
        <div>
          <h3>${t('footerLegal')}</h3>
          <ul>
            <li><a href="${pagePath('/contact.html')}">${t('navContact')}</a></li>
            <li><a href="${pagePath('/privacy.html')}">${t('navPrivacy')}</a></li>
            <li><a href="${pagePath('/download.html')}">${t('navDownload')}</a></li>
          </ul>
        </div>
        <div>
          <h3>${t('footerStaff')}</h3>
          <ul>
            <li><a href="${pagePath(window.GESHER_PUBLIC_CONFIG.staffPortalPath)}">${t('ctaStaff')}</a></li>
            <li><a href="${pagePath('/demo-sync.html')}">${t('navDemoSync')}</a></li>
            <li><a href="${pagePath('/about.html')}">${t('navAbout')}</a></li>
          </ul>
        </div>
      </div>
      <div class="site-footer__bottom">${t('footerNote')}</div>
    </div>
  `;

  renderLogo(document.getElementById('footer-logo'), true);
}

function initPublicShell() {
  initLocale();
  renderSiteHeader();
  renderSiteFooter();

  window.addEventListener('gesher:localechange', () => {
    renderSiteHeader();
    renderSiteFooter();
    if (typeof window.onPublicLocaleChange === 'function') {
      window.onPublicLocaleChange();
    }
  });
}
