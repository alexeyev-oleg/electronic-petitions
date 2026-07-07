function renderMockBetaBanner(seed) {
  const host = document.getElementById('mock-beta-banner');
  if (!host) {
    return;
  }

  const version = seed?.version || '—';
  const staffUrl = pagePath(window.GESHER_PUBLIC_CONFIG.staffPortalPath);

  host.innerHTML = `
    <div class="mock-beta-banner__inner">
      <div>
        <strong>${t('mockBadge')}</strong>
        <span class="mock-beta-banner__version">${t('demoSeedVersion')}: <code>${version}</code></span>
      </div>
      <p class="mock-beta-banner__text">${t('demoBannerText')}</p>
      <a class="btn btn--secondary" href="${staffUrl}">${t('ctaStaff')}</a>
    </div>
  `;
}

function renderDemoSyncContent() {
  const title = document.getElementById('demo-sync-title');
  const intro = document.getElementById('demo-sync-intro');
  const exportTitle = document.getElementById('demo-export-title');
  const exportSteps = document.getElementById('demo-export-steps');
  const importTitle = document.getElementById('demo-import-title');
  const importList = document.getElementById('demo-import-list');
  const rehearsalTitle = document.getElementById('demo-rehearsal-title');
  const rehearsalText = document.getElementById('demo-rehearsal-text');
  const staffLink = document.getElementById('demo-staff-link');

  if (title) {
    title.textContent = t('demoSyncTitle');
  }
  if (intro) {
    intro.textContent = t('demoSyncIntro');
  }
  if (exportTitle) {
    exportTitle.textContent = t('demoExportTitle');
  }
  if (exportSteps) {
    exportSteps.innerHTML = t('demoExportSteps')
      .split('|')
      .map((step) => `<li>${step}</li>`)
      .join('');
  }
  if (importTitle) {
    importTitle.textContent = t('demoImportTitle');
  }
  if (importList) {
    importList.innerHTML = t('demoImportItems')
      .split('|')
      .map((item) => `<li>${item}</li>`)
      .join('');
  }
  if (rehearsalTitle) {
    rehearsalTitle.textContent = t('demoRehearsalTitle');
  }
  if (rehearsalText) {
    rehearsalText.textContent = t('demoRehearsalText');
  }
  if (staffLink) {
    staffLink.textContent = t('ctaStaff');
    staffLink.href = pagePath(window.GESHER_PUBLIC_CONFIG.staffPortalPath);
  }
}

async function renderDemoSyncPage() {
  renderDemoSyncContent();

  try {
    const seed = await loadPublicSeed();
    renderMockBetaBanner(seed);
  } catch {
    renderMockBetaBanner({ version: '—' });
  }
}

window.onPublicLocaleChange = () => {
  renderDemoSyncPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderDemoSyncPage();
});
