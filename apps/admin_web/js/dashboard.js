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
let _activeModuleId = null;
let _petitionNav = {
  items: [],
  selectedIndex: 0,
  keyHandler: null,
};

function teardownPetitionKeyboardNav() {
  if (_petitionNav.keyHandler) {
    document.removeEventListener('keydown', _petitionNav.keyHandler);
    _petitionNav.keyHandler = null;
  }
  _petitionNav.items = [];
  _petitionNav.selectedIndex = 0;
}

function openPetitionAtIndex(index) {
  const petition = _petitionNav.items[index];
  if (!petition) {
    return;
  }
  window.location.href = petitionDetailPath(petition.id);
}

function setupPetitionKeyboardNav(table, petitions) {
  teardownPetitionKeyboardNav();
  if (!petitions.length || !['moderator', 'admin', 'supervisor'].includes(_session.role)) {
    return;
  }

  _petitionNav.items = petitions;
  _petitionNav.selectedIndex = 0;

  function focusRow() {
    table.querySelectorAll('[data-row-index]').forEach((row) => {
      const index = Number(row.getAttribute('data-row-index'));
      row.classList.toggle('is-focused', index === _petitionNav.selectedIndex);
    });
    const activeRow = table.querySelector(`[data-row-index="${_petitionNav.selectedIndex}"]`);
    if (activeRow) {
      activeRow.focus();
    }
  }

  _petitionNav.keyHandler = (event) => {
    if (_activeModuleId !== 'petitions') {
      return;
    }
    const tag = (event.target && event.target.tagName) || '';
    if (['INPUT', 'TEXTAREA', 'SELECT'].includes(tag)) {
      return;
    }

    if (event.key === 'j') {
      event.preventDefault();
      _petitionNav.selectedIndex = Math.min(
        _petitionNav.items.length - 1,
        _petitionNav.selectedIndex + 1,
      );
      focusRow();
      return;
    }

    if (event.key === 'k') {
      event.preventDefault();
      _petitionNav.selectedIndex = Math.max(0, _petitionNav.selectedIndex - 1);
      focusRow();
      return;
    }

    if (event.key === 'Enter') {
      event.preventDefault();
      openPetitionAtIndex(_petitionNav.selectedIndex);
    }
  };

  document.addEventListener('keydown', _petitionNav.keyHandler);
  focusRow();
}

function showModule(moduleId) {
  const module = _modules.find((item) => item.id === moduleId) || _modules[0];
  if (!module) {
    return;
  }

  _activeModuleId = module.id;
  teardownPetitionKeyboardNav();

  document.getElementById('page-title').textContent = module.label;
  document.getElementById('page-subtitle').textContent = `Роль: ${roleLabel(_session.role)}`;

  const keyboardHint = document.getElementById('keyboard-hint');
  if (keyboardHint) {
    const showKeys =
      module.id === 'petitions' && ['moderator', 'admin', 'supervisor'].includes(_session.role);
    keyboardHint.hidden = !showKeys;
  }

  const table = document.getElementById('module-table');
  if (module.id === 'petitions') {
    const filtersHost = document.getElementById('module-filters');
    let activeFilter = 'all';

    function renderList() {
      const items = filterPetitions(GesherMockStore.getPetitions(), activeFilter);
      renderPetitionFilters(filtersHost, activeFilter, (filterId) => {
        activeFilter = filterId;
        _petitionNav.selectedIndex = 0;
        renderList();
      });
      renderPetitionsTable(table, items, { selectedIndex: _petitionNav.selectedIndex });
      setupPetitionKeyboardNav(table, items);
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

  renderQueueKpis(
    document.getElementById('kpi-panel'),
    GesherMockStore.getQueueKpis(),
    _session.role,
  );
  renderStats(document.getElementById('stats-panel'), GesherMockStore.getStats());

  _modules = modulesForRole(_session.role);
  if (_modules.length === 0) {
    document.getElementById('module-table').innerHTML =
      '<p>Для этой роли модули пока не назначены.</p>';
    return;
  }

  showModule(_modules[0].id);

  const demoSyncLink = document.getElementById('demo-sync-link');
  if (demoSyncLink) {
    demoSyncLink.href = publicSitePath('/demo-sync.html');
  }

  document.getElementById('sign-out-btn').addEventListener('click', signOutStaff);
});
