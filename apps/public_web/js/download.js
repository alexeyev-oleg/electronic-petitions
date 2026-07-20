function renderStepList(text) {
  return `<ol class="info-steps">${text
    .split('|')
    .map((step) => `<li>${step.trim()}</li>`)
    .join('')}</ol>`;
}

function renderDownloadPage() {
  const host = document.getElementById('download-content');
  if (!host) {
    return;
  }

  const repoUrl = `https://github.com/${window.GESHER_PUBLIC_CONFIG.githubUser}/${window.GESHER_PUBLIC_CONFIG.githubRepo}`;
  const pageUrl = gesherSiteUrl('/download.html');

  host.innerHTML = `
    <h1>${t('downloadTitle')}</h1>
    <p class="lead">${t('downloadIntro')}</p>

    ${renderAppOnlyRegistrationBanner()}

    <div id="stores"></div>
    ${renderStoreButtonsPanel()}

    <div class="download-layout">
      <div>
        <section class="detail-panel">
          <h2>${t('downloadResidentTitle')}</h2>
          ${renderStepList(t('downloadResidentSteps'))}
        </section>

        <section class="detail-panel">
          <h2>${t('downloadInspectorTitle')}</h2>
          ${renderStepList(t('downloadInspectorSteps'))}
        </section>

        <p class="info-note">${t('downloadMockNotice')}</p>
        <a class="btn btn--secondary" href="${repoUrl}" target="_blank" rel="noopener noreferrer">${t('downloadRepoLink')}</a>
      </div>

      ${renderQrForUrl(pageUrl, t('downloadQrLabel'), t('downloadQrHint'))}
    </div>
  `;

  setPageMeta({
    title: t('downloadMetaTitle'),
    description: t('downloadMetaDescription'),
    canonicalPath: '/download.html',
  });
}

window.onPublicLocaleChange = () => {
  renderDownloadPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderDownloadPage();
});
