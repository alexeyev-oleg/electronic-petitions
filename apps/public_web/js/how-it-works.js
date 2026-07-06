function renderHowItWorksPage() {
  const content = getHowContent();
  const host = document.getElementById('how-content');
  if (!host) {
    return;
  }

  document.title = `G.E.S.H.E.R. — ${content.title}`;

  host.innerHTML = `
    <div class="section-heading">
      <h1>${content.title}</h1>
      <p>${content.intro}</p>
    </div>
    <div class="flow-grid">
      ${content.flows
        .map(
          (flow) => `
        <article class="flow-card">
          <h2>${flow.title}</h2>
          <ol class="flow-steps">
            ${flow.steps.map((step) => `<li>${step}</li>`).join('')}
          </ol>
        </article>`,
        )
        .join('')}
    </div>
    <div class="cta-band" style="margin-top:var(--space-xl);">
      <div>
        <h2 style="margin:0 0 8px;">${t('ctaBandTitle')}</h2>
        <p>${t('ctaBandText')}</p>
      </div>
      <a class="btn btn--primary" href="${window.GESHER_PUBLIC_CONFIG.mockAppLinks.android}">${t('ctaDownload')}</a>
    </div>
  `;
}

window.onPublicLocaleChange = () => {
  renderHowItWorksPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderHowItWorksPage();
});
