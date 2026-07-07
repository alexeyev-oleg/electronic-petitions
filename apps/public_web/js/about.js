function renderRoleCards() {
  const roles = [
    { titleKey: 'aboutRoleResidentTitle', textKey: 'aboutRoleResidentText' },
    { titleKey: 'aboutRoleInspectorTitle', textKey: 'aboutRoleInspectorText' },
    { titleKey: 'aboutRoleStaffTitle', textKey: 'aboutRoleStaffText' },
  ];

  return `
    <div class="info-grid">
      ${roles
        .map(
          (role) => `
        <article class="info-card">
          <h3>${t(role.titleKey)}</h3>
          <p>${t(role.textKey)}</p>
        </article>`,
        )
        .join('')}
    </div>`;
}

function renderSurfaceList() {
  return t('aboutSurfacesList')
    .split('|')
    .map((item) => `<li>${item.trim()}</li>`)
    .join('');
}

function renderAboutPage() {
  const host = document.getElementById('about-content');
  if (!host) {
    return;
  }

  host.innerHTML = `
    <h1>${t('aboutTitle')}</h1>
    <p class="lead">${t('aboutLead')}</p>

    <section class="detail-panel">
      <h2>${t('aboutMissionTitle')}</h2>
      <p>${t('aboutMissionText')}</p>
    </section>

    <section class="detail-panel">
      <h2>${t('aboutRolesTitle')}</h2>
      ${renderRoleCards()}
    </section>

    <section class="detail-panel">
      <h2>${t('aboutSurfacesTitle')}</h2>
      <ul class="info-list">${renderSurfaceList()}</ul>
    </section>

    <section class="detail-panel detail-panel--highlight">
      <h2>${t('aboutMockTitle')}</h2>
      <p>${t('aboutMockText')}</p>
      <span class="chip">${t('mockBadge')}</span>
    </section>
  `;

  setPageMeta({
    title: t('aboutMetaTitle'),
    description: t('aboutMetaDescription'),
    canonicalPath: '/about.html',
  });
}

window.onPublicLocaleChange = () => {
  renderAboutPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderAboutPage();
});
