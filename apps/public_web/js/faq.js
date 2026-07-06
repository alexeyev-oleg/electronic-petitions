function renderFaqPage() {
  const items = getFaqContent();
  const host = document.getElementById('faq-content');
  if (!host) {
    return;
  }

  const title = getLocale() === 'ru' ? 'Частые вопросы' : getLocale() === 'en' ? 'FAQ' : t('navFaq');
  document.title = `G.E.S.H.E.R. — ${title}`;

  host.innerHTML = `
    <div class="section-heading">
      <h1>${title}</h1>
      <p>${t('heroTagline')}</p>
    </div>
    <div class="faq-list">
      ${items
        .map(
          (item, index) => `
        <details class="faq-item" ${index === 0 ? 'open' : ''}>
          <summary>${item.q}</summary>
          <p>${item.a}</p>
        </details>`,
        )
        .join('')}
    </div>
    <p class="info-note">
      ${getLocale() === 'ru' ? 'Подробные mobile-гайды: ' : 'Mobile guides: '}
      <code>docs/mobile/user-guides/</code>
    </p>
  `;
}

window.onPublicLocaleChange = () => {
  renderFaqPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderFaqPage();
});
