function renderHeroCopy() {
  const heroTitle = document.getElementById('hero-title');
  const heroSubtitle = document.getElementById('hero-subtitle');
  const heroTagline = document.getElementById('hero-tagline');
  const ctaDownload = document.getElementById('cta-download');
  const ctaBrowser = document.getElementById('cta-browser');

  if (heroTagline) {
    heroTagline.textContent = t('heroTagline');
  }
  if (heroTitle) {
    heroTitle.innerHTML = t('heroTitle').replace(
      'G.E.S.H.E.R.',
      'G.E.S.H.E.R<span class="accent-dot">.</span>',
    );
  }
  if (heroSubtitle) {
    heroSubtitle.textContent = t('heroSubtitle');
  }
  if (ctaDownload) {
    ctaDownload.textContent = t('ctaDownload');
    ctaDownload.href = window.GESHER_PUBLIC_CONFIG.mockAppLinks.android;
  }
  if (ctaBrowser) {
    ctaBrowser.textContent = t('ctaBrowser');
    ctaBrowser.href = window.GESHER_PUBLIC_CONFIG.mockAppLinks.browser;
  }
}

function renderStats(stats) {
  const host = document.getElementById('stats-panel');
  if (!host) {
    return;
  }

  host.innerHTML = `
    <div class="section-heading">
      <h2>${t('statsTitle')}</h2>
      <p>${t('statsSubtitle')}</p>
    </div>
    <div class="stat-grid">
      <div class="stat-card"><strong>${formatNumber(stats.initiativesSubmitted)}</strong><span>${t('statInitiatives')}</span></div>
      <div class="stat-card"><strong>${formatNumber(stats.underReview)}</strong><span>${t('statReview')}</span></div>
      <div class="stat-card"><strong>${formatNumber(stats.implemented)}</strong><span>${t('statImplemented')}</span></div>
      <div class="stat-card"><strong>${formatNumber(stats.citizenVotes)}</strong><span>${t('statVotes')}</span></div>
    </div>
  `;
}

function renderCtaBand() {
  const host = document.getElementById('cta-band');
  if (!host) {
    return;
  }

  host.innerHTML = `
    <div>
      <h2 style="margin:0 0 8px;">${t('ctaBandTitle')}</h2>
      <p>${t('ctaBandText')}</p>
    </div>
    <div class="hero__actions" style="margin:0;">
      <a class="btn btn--primary" id="cta-band-download" href="${window.GESHER_PUBLIC_CONFIG.mockAppLinks.android}">${t('ctaDownload')}</a>
      <a class="btn btn--secondary" id="cta-band-browser" href="${window.GESHER_PUBLIC_CONFIG.mockAppLinks.browser}">${t('ctaBrowser')}</a>
    </div>
  `;
}

function renderHeroMockCards(petitions) {
  const host = document.getElementById('hero-mock-cards');
  if (!host) {
    return;
  }

  const published = getPublishedInitiatives(petitions).slice(0, 2);
  host.innerHTML = published
    .map(
      (item) => `
      <a class="hero__mock-card" href="${initiativeDetailPath(item.id)}">
        <strong>${item.title}</strong>
        <span>${item.signatureCount} / ${item.signatureGoal}</span>
      </a>`,
    )
    .join('');
}

async function renderHomePage() {
  renderHeroCopy();
  renderCtaBand();

  try {
    const seed = await loadPublicSeed();
    renderStats(seed.stats);
    renderHeroMockCards(seed.petitions || []);
  } catch {
    const statsHost = document.getElementById('stats-panel');
    if (statsHost) {
      statsHost.innerHTML = '<p>Не удалось загрузить mock-данные.</p>';
    }
  }
}

window.onPublicLocaleChange = () => {
  renderHomePage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderHomePage();
});
