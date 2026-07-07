async function loadFaqItems() {
  const locale = getLocale();
  const response = await fetch(pagePath('/content/faq.json'));
  if (!response.ok) {
    throw new Error(`FAQ load failed: ${response.status}`);
  }

  const data = await response.json();
  const items = Array.isArray(data.items) ? data.items : [];

  return items
    .filter((item) => Array.isArray(item.surfaces) && item.surfaces.includes('web'))
    .map((item) => {
      const text = item.text || {};
      const block = text[locale] || text.en || text.ru || {};
      return {
        q: block.question || '',
        a: block.answer || '',
      };
    })
    .filter((item) => item.q && item.a);
}

async function renderFaqPage() {
  const host = document.getElementById('faq-content');
  if (!host) {
    return;
  }

  const title =
    getLocale() === 'ru' ? 'Частые вопросы' : getLocale() === 'en' ? 'FAQ' : t('navFaq');
  document.title = `G.E.S.H.E.R. — ${title}`;

  host.innerHTML = `<p>${t('heroTagline')}</p>`;

  try {
    const items = await loadFaqItems();
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
      ${getLocale() === 'ru' ? 'Источник: ' : 'Source: '}
      <code>shared/content/faq.json</code>
      ·
      ${getLocale() === 'ru' ? 'Mobile-гайды: ' : 'Mobile guides: '}
      <code>docs/mobile/user-guides/</code>
    </p>
  `;
  } catch (error) {
    console.error(error);
    host.innerHTML = `
      <div class="section-heading">
        <h1>${title}</h1>
      </div>
      <p class="info-note">${getLocale() === 'ru' ? 'Не удалось загрузить FAQ.' : 'Could not load FAQ.'}</p>
    `;
  }
}

window.onPublicLocaleChange = () => {
  renderFaqPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderFaqPage();
});
