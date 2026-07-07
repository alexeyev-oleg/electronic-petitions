function renderPrivacySections() {
  return [1, 2, 3, 4]
    .map(
      (index) => `
    <section class="detail-panel">
      <h2>${t(`privacySection${index}Title`)}</h2>
      <p>${t(`privacySection${index}Text`)}</p>
    </section>`,
    )
    .join('');
}

function renderPrivacyPage() {
  const host = document.getElementById('privacy-content');
  if (!host) {
    return;
  }

  host.innerHTML = `
    <h1>${t('privacyTitle')}</h1>
    <p class="lead">${t('privacyIntro')}</p>
    ${renderPrivacySections()}
    <p class="info-note">${t('privacyMockNotice')}</p>
  `;

  setPageMeta({
    title: t('privacyMetaTitle'),
    description: t('privacyMetaDescription'),
    canonicalPath: '/privacy.html',
  });
}

window.onPublicLocaleChange = () => {
  renderPrivacyPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderPrivacyPage();
});
