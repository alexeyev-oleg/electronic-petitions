function renderLogo(target, inverse = false) {
  const letters = ['G', 'E', 'S', 'H', 'E', 'R'];
  const className = inverse ? 'logo logo--inverse' : 'logo';
  target.setAttribute('dir', 'ltr');
  target.innerHTML = letters
    .map((letter) => `<span class="logo__letter">${letter}</span><span class="logo__dot"></span>`)
    .join('');
}

/** Numbers that must keep LTR order inside RTL text (e.g. "128 / 500", "26%"). */
function ltrNumber(html) {
  return `<bdi dir="ltr" class="num-ltr">${html}</bdi>`;
}

function formatNumber(value) {
  return new Intl.NumberFormat(getLocale()).format(value);
}

function currentPageName() {
  const path = window.location.pathname.split('/').pop() || 'index.html';
  return path;
}

function navLink(path, label, active = false) {
  const current = active ? ' aria-current="page"' : '';
  return `<a class="site-nav__link ${active ? 'is-active' : ''}" href="${pagePath(path)}"${current}>${label}</a>`;
}

function renderSiteHeader() {
  const header = document.getElementById('site-header');
  if (!header) {
    return;
  }

  const page = currentPageName();
  header.innerHTML = `
    <div class="site-header__inner">
      <a class="site-brand" href="${pagePath('/index.html')}" aria-label="G.E.S.H.E.R.">
        <div class="logo-mark" aria-hidden="true">G</div>
        <div class="logo" id="header-logo" aria-hidden="true"></div>
      </a>
      <nav class="site-nav" id="site-nav" aria-label="${t('navMenu')}">
        <div class="site-nav__links">
          ${navLink('/index.html', t('navHome'), page === 'index.html')}
          ${navLink('/initiatives.html', t('navInitiatives'), page === 'initiatives.html' || page === 'initiative.html')}
          ${navLink('/how-it-works.html', t('navHow'), page === 'how-it-works.html')}
          ${navLink('/faq.html', t('navFaq'), page === 'faq.html')}
          ${navLink('/about.html', t('navAbout'), page === 'about.html')}
        </div>
        <a class="btn btn--primary site-header__cta" data-testid="header-cta" href="${pagePath('/download.html')}">${t('ctaDownload')}</a>
      </nav>
      <div class="site-header__actions">
        <label class="sr-only" for="locale-select">${t('localeLabel')}</label>
        <select id="locale-select" class="locale-select">
          <option value="ru">RU</option>
          <option value="en">EN</option>
          <option value="he">HE</option>
          <option value="ar">AR</option>
        </select>
      </div>
      <button
        type="button"
        class="nav-toggle"
        id="nav-toggle"
        aria-expanded="false"
        aria-controls="site-nav"
        aria-label="${t('navMenu')}"
      >
        <span class="nav-toggle__bar" aria-hidden="true"></span>
        <span class="nav-toggle__bar" aria-hidden="true"></span>
        <span class="nav-toggle__bar" aria-hidden="true"></span>
      </button>
    </div>
  `;

  renderLogo(document.getElementById('header-logo'));
  bindLocaleSelect(document.getElementById('locale-select'));
  bindNavToggle(header);
}

/**
 * Compact menu (narrow screens): button toggles the panel; Escape, a link
 * click or a click outside closes it and focus returns to the button.
 * On wide screens CSS hides the button and always shows the nav.
 */
function bindNavToggle(header) {
  const toggle = header.querySelector('#nav-toggle');
  const nav = header.querySelector('#site-nav');
  if (!toggle || !nav) {
    return;
  }

  const isOpen = () => toggle.getAttribute('aria-expanded') === 'true';
  const setOpen = (open, { restoreFocus = false } = {}) => {
    toggle.setAttribute('aria-expanded', String(open));
    nav.classList.toggle('is-open', open);
    if (open) {
      // The panel precedes the button in DOM order: move focus into it so
      // Tab continues through the menu, not into the page.
      const first = nav.querySelector('a');
      if (first) {
        first.focus();
      }
    } else if (restoreFocus) {
      toggle.focus();
    }
  };

  toggle.addEventListener('click', () => setOpen(!isOpen()));

  header.addEventListener('keydown', (event) => {
    if (event.key === 'Escape' && isOpen()) {
      event.preventDefault();
      setOpen(false, { restoreFocus: true });
    }
  });

  nav.addEventListener('click', (event) => {
    if (event.target.closest('a') && isOpen()) {
      setOpen(false);
    }
  });

  document.addEventListener('click', (event) => {
    if (isOpen() && !header.contains(event.target)) {
      setOpen(false);
    }
  });
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
