function renderSidebarNav(modules, activeId) {
  const nav = document.getElementById('sidebar-nav');
  nav.innerHTML = modules
    .map(
      (item) => `
      <a href="#" class="sidebar__link ${item.id === activeId ? 'is-active' : ''}" data-module="${item.id}">
        ${item.label}
      </a>`,
    )
    .join('');

  nav.querySelectorAll('[data-module]').forEach((link) => {
    link.addEventListener('click', (event) => {
      event.preventDefault();
      const moduleId = link.getAttribute('data-module');
      showModule(moduleId);
    });
  });
}

let _session = null;
let _modules = [];

function showModule(moduleId) {
  const module = _modules.find((item) => item.id === moduleId) || _modules[0];
  if (!module) {
    return;
  }

  document.getElementById('page-title').textContent = module.label;
  document.getElementById('page-subtitle').textContent = `Роль: ${roleLabel(_session.role)}`;

  const table = document.getElementById('module-table');
  if (module.id === 'petitions') {
    const filtersHost = document.getElementById('module-filters');
    let activeFilter = 'all';

    function renderList() {
      const items = filterPetitions(GesherMockStore.getPetitions(), activeFilter);
      renderPetitionFilters(filtersHost, activeFilter, (filterId) => {
        activeFilter = filterId;
        renderList();
      });
      renderPetitionsTable(table, items);
    }

    filtersHost.style.display = 'flex';
    renderList();
  } else if (module.id === 'complaints') {
    const filtersHost = document.getElementById('module-filters');
    let activeFilter = 'all';

    function renderList() {
      const items = filterComplaints(GesherMockStore.getComplaints(), activeFilter);
      renderComplaintFilters(filtersHost, activeFilter, (filterId) => {
        activeFilter = filterId;
        renderList();
      });
      renderComplaintsTable(table, items);
    }

    filtersHost.style.display = 'flex';
    renderList();
  } else if (module.id === 'enforcement') {
    const filtersHost = document.getElementById('module-filters');
    let activeFilter = 'all';

    function renderList() {
      const items = filterEnforcement(GesherMockStore.getEnforcement(), activeFilter);
      renderEnforcementFilters(filtersHost, activeFilter, (filterId) => {
        activeFilter = filterId;
        renderList();
      });
      renderEnforcementTable(table, items);
    }

    filtersHost.style.display = 'flex';
    renderList();
  } else if (module.id === 'admin') {
    document.getElementById('module-filters').style.display = 'none';
    renderAdminModule(table, _session);
  } else {
    document.getElementById('module-filters').style.display = 'none';
    table.innerHTML = '<p>Модуль не найден.</p>';
  }

  renderSidebarNav(_modules, module.id);
}

document.addEventListener('DOMContentLoaded', async () => {
  _session = await requireStaffSession();
  if (!_session) {
    return;
  }

  renderLogo(document.getElementById('sidebar-logo'), true);

  document.getElementById('user-name').textContent = _session.displayName;
  document.getElementById('role-chip').textContent = roleLabel(_session.role);

  const banner = document.getElementById('role-banner');
  banner.innerHTML = `
    <strong>Добро пожаловать, ${_session.displayName}</strong>
    <p style="margin:8px 0 0;">
      Badge ${_session.badgeId}. Портал G.E.S.H.E.R. в mock-режиме — данные общие с mobile seed (W3).
    </p>
  `;

  renderStats(document.getElementById('stats-panel'), GesherMockStore.getStats());

  _modules = modulesForRole(_session.role);
  if (_modules.length === 0) {
    document.getElementById('module-table').innerHTML =
      '<p>Для этой роли модули пока не назначены.</p>';
    return;
  }

  showModule(_modules[0].id);

  document.getElementById('sign-out-btn').addEventListener('click', signOutStaff);
});
