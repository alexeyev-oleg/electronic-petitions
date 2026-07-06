const INITIATIVE_FILTERS = [
  { id: 'all', labelKey: 'filterAll' },
  { id: 'blagoustroystvo', labelKey: 'categoryBlag' },
  { id: 'transport', labelKey: 'categoryTransport' },
  { id: 'ecology', labelKey: 'categoryEcology' },
];

const TRACKING_STEPS = [
  'stepSubmitted',
  'stepModeration',
  'stepPublished',
  'stepSignatures',
  'stepResponse',
  'stepImplemented',
];

function getTrackingStepState(petition) {
  const states = TRACKING_STEPS.map((key) => ({ key, status: 'upcoming' }));

  states[0].status = 'done';
  states[1].status = 'done';
  states[2].status = 'done';

  const signaturesComplete = petition.signatureCount >= petition.signatureGoal;
  const hasResponse = Boolean(petition.officialResponse);

  if (hasResponse) {
    states[3].status = 'done';
    states[4].status = 'done';
    states[5].status = 'upcoming';
  } else if (signaturesComplete) {
    states[3].status = 'done';
    states[4].status = 'current';
  } else {
    states[3].status = 'current';
  }

  return states;
}

function renderTrackingStepper(petition) {
  const steps = getTrackingStepState(petition);
  return `
    <div class="stepper" aria-label="${t('trackingTitle')}">
      ${steps
        .map(
          (step) => `
        <div class="stepper__item stepper__item--${step.status}">
          <div class="stepper__dot" aria-hidden="true"></div>
          <span class="stepper__label">${t(step.key)}</span>
        </div>`,
        )
        .join('')}
    </div>
  `;
}

function renderInitiativeFilters(container, activeFilter, onChange) {
  container.innerHTML = INITIATIVE_FILTERS.map(
    (filter) => `
      <button type="button" class="filter-chip ${filter.id === activeFilter ? 'is-active' : ''}" data-filter="${filter.id}">
        ${t(filter.labelKey)}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-filter]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-filter')));
  });
}

function renderInitiativeCard(item) {
  const percent = signaturePercent(item);
  return `
    <article class="initiative-card">
      <div class="initiative-card__meta">
        <span class="chip chip--success">${t('statusPublished')}</span>
        <span class="chip">${categoryLabel(item.category)}</span>
      </div>
      <h2 class="initiative-card__title">${item.title}</h2>
      <p class="initiative-card__summary">${item.summary}</p>
      <div class="initiative-card__progress">
        <div class="progress-track"><div class="progress-fill" style="width:${percent}%"></div></div>
        <span>${item.signatureCount} / ${item.signatureGoal} ${t('signaturesLabel')}</span>
      </div>
      <div class="initiative-card__footer">
        <span class="initiative-card__date">${item.submittedAtLabel}</span>
        <a class="btn btn--secondary" href="${initiativeDetailPath(item.id)}">${t('viewDetails')}</a>
      </div>
    </article>
  `;
}

function renderInitiativeGrid(container, initiatives) {
  if (initiatives.length === 0) {
    container.innerHTML = `<p class="empty-state">${t('emptyInitiatives')}</p>`;
    return;
  }

  container.innerHTML = `
    <div class="initiative-grid">
      ${initiatives.map((item) => renderInitiativeCard(item)).join('')}
    </div>
  `;
}

function renderInitiativesPageHeading() {
  const title = document.getElementById('initiatives-title');
  const subtitle = document.getElementById('initiatives-subtitle');
  if (title) {
    title.textContent = t('initiativesTitle');
  }
  if (subtitle) {
    subtitle.textContent = t('initiativesSubtitle');
  }
}

let _activeFilter = 'all';
let _publishedInitiatives = [];

async function refreshInitiativesPage() {
  renderInitiativesPageHeading();

  const filtersHost = document.getElementById('initiative-filters');
  const listHost = document.getElementById('initiative-list');
  const disabledHost = document.getElementById('initiatives-disabled');

  if (!filtersHost || !listHost) {
    return;
  }

  try {
    const seed = await loadPublicSeed();
    if (!arePublicInitiativesEnabled(seed.settings)) {
      filtersHost.style.display = 'none';
      listHost.innerHTML = '';
      if (disabledHost) {
        disabledHost.hidden = false;
        disabledHost.textContent = t('initiativesDisabled');
      }
      return;
    }

    if (disabledHost) {
      disabledHost.hidden = true;
    }

    _publishedInitiatives = getPublishedInitiatives(seed.petitions);
    filtersHost.style.display = 'flex';

    function renderList() {
      const items = filterInitiativesByCategory(_publishedInitiatives, _activeFilter);
      renderInitiativeFilters(filtersHost, _activeFilter, (filterId) => {
        _activeFilter = filterId;
        renderList();
      });
      renderInitiativeGrid(listHost, items);
    }

    renderList();
  } catch {
    listHost.innerHTML = '<p>Не удалось загрузить mock-данные.</p>';
  }
}

window.onPublicLocaleChange = () => {
  refreshInitiativesPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  refreshInitiativesPage();
});
