function renderStepList(text) {
  return `<ol class="info-steps">${text
    .split('|')
    .map((step) => `<li>${step.trim()}</li>`)
    .join('')}</ol>`;
}

function renderQrBlock(label) {
  const pageUrl = gesherSiteUrl('/download.html');
  const qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=220x220&data=${encodeURIComponent(pageUrl)}`;

  return `
    <div class="download-qr">
      <img src="${qrUrl}" width="220" height="220" alt="${label}" loading="lazy" />
      <p>${t('downloadQrHint')}</p>
      <code class="download-url">${pageUrl}</code>
    </div>`;
}

function renderDownloadPage() {
  const host = document.getElementById('download-content');
  if (!host) {
    return;
  }

  const repoUrl = `https://github.com/${window.GESHER_PUBLIC_CONFIG.githubUser}/${window.GESHER_PUBLIC_CONFIG.githubRepo}`;

  host.innerHTML = `
    <h1>${t('downloadTitle')}</h1>
    <p class="lead">${t('downloadIntro')}</p>

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

      ${renderQrBlock(t('downloadQrLabel'))}
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
