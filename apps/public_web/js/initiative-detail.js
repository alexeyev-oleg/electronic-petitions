function initiativeIdFromQuery() {
  return new URLSearchParams(window.location.search).get('id');
}

function renderInitiativeDetail(petition) {
  const percent = signaturePercent(petition);
  const host = document.getElementById('initiative-detail');
  if (!host) {
    return;
  }

  host.innerHTML = `
    <div class="initiative-detail__meta">
      <span class="chip chip--success">${t('statusPublished')}</span>
      <span class="chip">${categoryLabel(petition.category)}</span>
      <span class="initiative-detail__date">${petition.submittedAtLabel}</span>
    </div>

    <h1 class="initiative-detail__title">${petition.title}</h1>
    ${petition.coverImage ? `<img class="initiative-card__cover" src="${mediaPath(petition.coverImage)}" alt="" />` : ''}
    <p class="initiative-detail__summary">${petition.summary}</p>

    <section class="detail-panel">
      <h2>${t('trackingTitle')}</h2>
      ${renderTrackingStepper(petition)}
    </section>

    <section class="detail-panel">
      <h2>${t('stepSignatures')}</h2>
      <p><strong>${petition.signatureCount}</strong> / ${petition.signatureGoal} ${t('signaturesLabel')} (${percent}%)</p>
      <div class="progress-track progress-track--lg"><div class="progress-fill" style="width:${percent}%"></div></div>
    </section>

    ${
      petition.officialResponse
        ? `
    <section class="detail-panel detail-panel--highlight">
      <h2>${t('officialResponseTitle')}</h2>
      <p>${petition.officialResponse}</p>
    </section>`
        : ''
    }

    <section class="detail-panel detail-panel--cta">
      <h2>${t('signInApp')}</h2>
      <p>${t('signInAppHint')}</p>
      <a class="btn btn--primary" href="${window.GESHER_PUBLIC_CONFIG.mockAppLinks.android}">${t('signInApp')}</a>
    </section>
  `;
}

async function refreshInitiativeDetailPage() {
  const backLink = document.getElementById('back-to-list');
  if (backLink) {
    backLink.textContent = t('backToList');
    backLink.href = pagePath('/initiatives.html');
  }

  const id = initiativeIdFromQuery();
  const host = document.getElementById('initiative-detail');

  if (!id || !host) {
    if (host) {
      host.innerHTML = `<p>${t('initiativeNotFound')}</p>`;
    }
    return;
  }

  try {
    const seed = await loadPublicSeed();
    if (!arePublicInitiativesEnabled(seed.settings)) {
      host.innerHTML = `<p>${t('initiativesDisabled')}</p>`;
      return;
    }

    const petition = findInitiativeById(seed.petitions, id);
    if (!petition || petition.status !== 'published') {
      host.innerHTML = `<p>${t('initiativeNotFound')}</p>`;
      document.title = `G.E.S.H.E.R. — ${t('initiativeNotFound')}`;
      return;
    }

    document.title = `G.E.S.H.E.R. — ${petition.title}`;
    renderInitiativeDetail(petition);
  } catch {
    host.innerHTML = '<p>Не удалось загрузить mock-данные.</p>';
  }
}

window.onPublicLocaleChange = () => {
  refreshInitiativeDetailPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  refreshInitiativeDetailPage();
});
