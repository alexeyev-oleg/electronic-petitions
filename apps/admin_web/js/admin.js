const ADMIN_SECTIONS = [
  { id: 'staff', label: 'Сотрудники' },
  { id: 'settings', label: 'Настройки' },
  { id: 'audit', label: 'Audit log' },
];

const AUDIT_ENTITY_FILTERS = [
  { id: 'all', label: 'Все' },
  { id: 'petition', label: 'Инициативы' },
  { id: 'complaint', label: 'Жалобы' },
  { id: 'enforcement', label: 'Нарушения' },
  { id: 'system', label: 'Система' },
];

const AUDIT_ACTION_LABELS = {
  approve: 'Опубликовано',
  reject: 'Отклонено',
  request_changes: 'Возврат на доработку',
  official_response: 'Официальный ответ',
  assign_department: 'Назначен отдел',
  resolve: 'Решено',
  return_to_triage: 'Возврат на триаж',
  dispatch_task: 'Полевая задача',
  resolve_geo: 'Гео уточнено',
  mark_invalid: 'Недействительно',
  merge_case: 'Объединение дел',
  validated_warning: 'Итог: предупреждение',
  validated_fine: 'Итог: штраф',
  validated_no_action: 'Итог: без мер',
  reopen_to_triage: 'Повторный триаж',
  settings_update: 'Обновление настроек',
  reset_mock_data: 'Сброс mock-данных',
    import_snapshot: 'Импорт mock-снимка',
    clear_audit_log: 'Очистка audit log',
};

const ENTITY_TYPE_LABELS = {
  petition: 'Инициатива',
  complaint: 'Жалоба',
  enforcement: 'Нарушение',
  system: 'Система',
};

function canAdmin(role) {
  return role === 'admin';
}

function auditActionLabel(action) {
  return AUDIT_ACTION_LABELS[action] || formatStatus(action);
}

function entityTypeLabel(entityType) {
  return ENTITY_TYPE_LABELS[entityType] || entityType;
}

function formatAuditTimestamp(iso) {
  try {
    return new Date(iso).toLocaleString('ru-RU', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  } catch {
    return iso;
  }
}

function filterAuditEntries(entries, filterId) {
  if (filterId === 'all') {
    return entries;
  }
  return entries.filter((item) => item.entityType === filterId);
}

function renderAdminSectionNav(container, activeSection, onChange) {
  container.innerHTML = ADMIN_SECTIONS.map(
    (section) => `
      <button type="button" class="filter-chip ${section.id === activeSection ? 'is-active' : ''}" data-admin-section="${section.id}">
        ${section.label}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-admin-section]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-admin-section')));
  });
}

function renderStaffTable(container) {
  const users = GesherMockStore.getStaffUsers();
  container.innerHTML = `
    <h2 style="margin-top:0;">Сотрудники портала (mock)</h2>
    <p style="color:var(--color-text-muted);margin:0 0 var(--space-md);">
      Управление учётными записями — в production через backend IAM. Здесь только просмотр seed-данных.
    </p>
    <table class="table">
      <thead>
        <tr>
          <th>Имя</th>
          <th>Email</th>
          <th>Роль</th>
          <th>Badge</th>
        </tr>
      </thead>
      <tbody>
        ${users
          .map(
            (user) => `
          <tr>
            <td><strong>${user.displayName}</strong></td>
            <td>${user.email}</td>
            <td><span class="chip">${roleLabel(user.role)}</span></td>
            <td>${user.badgeId}</td>
          </tr>`,
          )
          .join('')}
      </tbody>
    </table>
  `;
}

function settingsToggleRow(id, label, description, checked) {
  return `
    <label class="settings-toggle" for="${id}">
      <div>
        <strong>${label}</strong>
        <p style="margin:4px 0 0;color:var(--color-text-muted);font-size:0.875rem;">${description}</p>
      </div>
      <input id="${id}" type="checkbox" ${checked ? 'checked' : ''} />
    </label>
  `;
}

function renderSettingsPanel(container, session) {
  const settings = GesherMockStore.getSettings();

  container.innerHTML = `
    <h2 style="margin-top:0;">Настройки портала (mock)</h2>
    <form id="settings-form" class="settings-form">
      ${settingsToggleRow(
        'setting-maintenance',
        'Режим обслуживания',
        'Скрывает публичные действия для демо-обслуживания.',
        settings.maintenanceMode,
      )}
      ${settingsToggleRow(
        'setting-public-petitions',
        'Публичные инициативы',
        'Разрешает отображение опубликованных инициатив на citizen site (W2).',
        settings.publicPetitionsEnabled,
      )}
      ${settingsToggleRow(
        'setting-require-otp',
        'OTP для действий сотрудников',
        'Требует код подтверждения для модерации, жалоб и нарушений.',
        settings.requireOtpForStaffActions,
      )}
      ${settingsToggleRow(
        'setting-otp-hint',
        'Подсказка mock OTP',
        'Показывает код 123456 в диалоге подтверждения.',
        settings.mockOtpHintVisible,
      )}
      <div class="field">
        <label for="setting-locale">Локаль по умолчанию</label>
        <select id="setting-locale" style="width:100%;max-width:240px;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">
          <option value="ru" ${settings.defaultLocale === 'ru' ? 'selected' : ''}>Русский</option>
          <option value="he" ${settings.defaultLocale === 'he' ? 'selected' : ''}>עברית</option>
          <option value="en" ${settings.defaultLocale === 'en' ? 'selected' : ''}>English</option>
          <option value="ar" ${settings.defaultLocale === 'ar' ? 'selected' : ''}>العربية</option>
        </select>
      </div>
      <div class="action-bar">
        <button class="btn btn--primary" type="submit">Сохранить настройки</button>
      </div>
      <p id="settings-message" style="min-height:1.25rem;font-weight:600;"></p>
    </form>

    <hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-xl) 0;" />

    <h2>Mock sync (W3.2)</h2>
    <p style="color:var(--color-text-muted);margin:0 0 var(--space-md);">
      Экспорт / импорт снимка <code>gesher_mock_data</code> для демо между браузерами и мобильными приложениями.
      Экспортированный JSON можно импортировать в Resident / Inspector (Профиль → Mock beta).
    </p>
    <div class="action-bar">
      <button class="btn btn--secondary" type="button" id="export-mock-btn">Экспорт JSON</button>
      <label class="btn btn--secondary" style="cursor:pointer;">
        Импорт JSON
        <input id="import-mock-file" type="file" accept="application/json,.json" hidden />
      </label>
    </div>
    <p id="sync-message" style="min-height:1.25rem;font-weight:600;"></p>

    <hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-xl) 0;" />

    <h2>Опасная зона (mock)</h2>
    <p style="color:var(--color-text-muted);margin:0 0 var(--space-md);">
      Сброс вернёт petitions, complaints, enforcement и audit log к seed v${GesherMockStore.readData().version || '1.4.0'}.
      Сессия входа сохранится.
    </p>
    <div class="action-bar">
      <button class="btn btn--secondary" type="button" id="reset-mock-btn">Сбросить mock-данные</button>
      <button class="btn btn--secondary" type="button" id="clear-audit-btn">Очистить audit log</button>
    </div>
    <p id="danger-message" style="min-height:1.25rem;font-weight:600;"></p>
  `;

  container.querySelector('#settings-form').addEventListener('submit', (event) => {
    event.preventDefault();
    handleSaveSettings(session, container);
  });

  container.querySelector('#reset-mock-btn').addEventListener('click', () => {
    handleResetMockData(session, container);
  });

  container.querySelector('#clear-audit-btn').addEventListener('click', () => {
    handleClearAuditLog(session, container);
  });

  container.querySelector('#export-mock-btn').addEventListener('click', () => {
    handleExportMock(container);
  });

  container.querySelector('#import-mock-file').addEventListener('change', (event) => {
    handleImportMock(event, session, container);
  });
}

function handleExportMock(root) {
  const messageEl = root.querySelector('#sync-message');
  messageEl.textContent = '';

  const blob = new Blob([GesherMockStore.exportSnapshot()], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = `gesher-mock-${GesherMockStore.readData().version || 'snapshot'}.json`;
  link.click();
  URL.revokeObjectURL(url);

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Снимок mock-данных скачан.';
}

async function handleImportMock(event, session, root) {
  const messageEl = root.querySelector('#sync-message');
  messageEl.textContent = '';

  const input = event.target;
  const file = input.files && input.files[0];
  if (!file) {
    return;
  }

  const confirmed = await confirmStaffOtp('Подтвердите импорт mock-снимка. Текущие данные будут заменены.');
  if (!confirmed) {
    input.value = '';
    return;
  }

  try {
    const text = await file.text();
    const result = GesherMockStore.importSnapshot(text);
    if (!result.ok) {
      messageEl.style.color = 'var(--color-danger)';
      messageEl.textContent =
        result.error === 'version_mismatch'
          ? 'Версия снимка не совпадает с текущим seed.'
          : 'Не удалось импортировать снимок.';
      input.value = '';
      return;
    }

    GesherMockStore.appendAuditEntry({
      actorId: session.id,
      actorName: session.displayName,
      role: session.role,
      entityType: 'system',
      entityId: 'mock-store',
      action: 'import_snapshot',
      note: file.name,
    });

    messageEl.style.color = 'var(--color-success)';
    messageEl.textContent = 'Mock-снимок импортирован.';
  } catch {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Ошибка чтения файла.';
  }

  input.value = '';
}

async function handleSaveSettings(session, root) {
  const messageEl = root.querySelector('#settings-message');
  messageEl.textContent = '';

  const confirmed = await confirmStaffOtp('Подтвердите сохранение настроек портала.');
  if (!confirmed) {
    return;
  }

  const patch = {
    maintenanceMode: root.querySelector('#setting-maintenance').checked,
    publicPetitionsEnabled: root.querySelector('#setting-public-petitions').checked,
    requireOtpForStaffActions: root.querySelector('#setting-require-otp').checked,
    mockOtpHintVisible: root.querySelector('#setting-otp-hint').checked,
    defaultLocale: root.querySelector('#setting-locale').value,
  };

  GesherMockStore.updateSettings(patch);
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'system',
    entityId: 'portal-settings',
    action: 'settings_update',
    note: JSON.stringify(patch),
  });

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Настройки сохранены в localStorage.';
}

async function handleResetMockData(session, root) {
  const messageEl = root.querySelector('#danger-message');
  messageEl.textContent = '';

  const confirmed = await confirmStaffOtp('Подтвердите полный сброс mock-данных к seed.');
  if (!confirmed) {
    return;
  }

  GesherMockStore.resetData();
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'system',
    entityId: 'mock-store',
    action: 'reset_mock_data',
    note: 'Данные восстановлены из seed.json',
  });

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Mock-данные сброшены. Обновите другие модули при необходимости.';
}

async function handleClearAuditLog(session, root) {
  const messageEl = root.querySelector('#danger-message');
  messageEl.textContent = '';

  const confirmed = await confirmStaffOtp('Подтвердите очистку audit log.');
  if (!confirmed) {
    return;
  }

  GesherMockStore.clearAuditLog();
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'system',
    entityId: 'audit-log',
    action: 'clear_audit_log',
    note: null,
  });

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Audit log очищен (осталась запись об очистке).';

  const auditHost = root.closest('[data-admin-root]')?.querySelector('[data-admin-audit-host]');
  if (auditHost && auditHost._refreshAudit) {
    auditHost._refreshAudit();
  }
}

function renderAuditFilters(container, activeFilter, onChange) {
  container.innerHTML = AUDIT_ENTITY_FILTERS.map(
    (filter) => `
      <button type="button" class="filter-chip ${filter.id === activeFilter ? 'is-active' : ''}" data-audit-filter="${filter.id}">
        ${filter.label}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-audit-filter]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-audit-filter')));
  });
}

function renderAuditTable(container, entries) {
  if (entries.length === 0) {
    container.innerHTML = '<p>Записей audit log пока нет. Выполните действия в модулях W1.1–W1.3.</p>';
    return;
  }

  container.innerHTML = `
    <table class="table table--compact">
      <thead>
        <tr>
          <th>Время</th>
          <th>Сотрудник</th>
          <th>Объект</th>
          <th>Действие</th>
          <th>Комментарий</th>
        </tr>
      </thead>
      <tbody>
        ${entries
          .map(
            (entry) => `
          <tr>
            <td style="white-space:nowrap;">${formatAuditTimestamp(entry.at)}</td>
            <td>
              <strong>${entry.actorName}</strong><br>
              <span style="color:var(--color-text-muted);font-size:0.8rem;">${roleLabel(entry.role)}</span>
            </td>
            <td>
              ${entityTypeLabel(entry.entityType)}<br>
              <span style="color:var(--color-text-muted);font-size:0.8rem;">${entry.entityId}</span>
            </td>
            <td>${auditActionLabel(entry.action)}</td>
            <td style="max-width:220px;word-break:break-word;">${entry.note || '—'}</td>
          </tr>`,
          )
          .join('')}
      </tbody>
    </table>
  `;
}

function renderAuditPanel(container) {
  let activeFilter = 'all';
  const filtersHost = document.createElement('div');
  filtersHost.className = 'filter-row';
  const tableHost = document.createElement('div');
  tableHost.setAttribute('data-admin-audit-host', '');

  container.innerHTML = `
    <h2 style="margin-top:0;">Audit log</h2>
    <p style="color:var(--color-text-muted);margin:0 0 var(--space-md);">
      Журнал чувствительных действий сотрудников. Новые записи появляются после модерации, жалоб и нарушений.
    </p>
  `;
  container.appendChild(filtersHost);
  container.appendChild(tableHost);

  function refreshAudit() {
    const items = filterAuditEntries(GesherMockStore.getAuditLog(), activeFilter);
    renderAuditFilters(filtersHost, activeFilter, (filterId) => {
      activeFilter = filterId;
      refreshAudit();
    });
    renderAuditTable(tableHost, items);
  }

  tableHost._refreshAudit = refreshAudit;
  refreshAudit();
}

function renderAdminModule(container, session) {
  if (!canAdmin(session.role)) {
    container.innerHTML = '<p>Модуль администрирования доступен только роли admin.</p>';
    return;
  }

  let activeSection = 'staff';
  const navHost = document.createElement('div');
  navHost.className = 'filter-row';
  navHost.style.marginBottom = 'var(--space-md)';

  const contentHost = document.createElement('div');
  contentHost.setAttribute('data-admin-root', '');

  container.innerHTML = '';
  container.appendChild(navHost);
  container.appendChild(contentHost);

  function renderSection() {
    renderAdminSectionNav(navHost, activeSection, (sectionId) => {
      activeSection = sectionId;
      renderSection();
    });

    if (activeSection === 'staff') {
      renderStaffTable(contentHost);
      return;
    }

    if (activeSection === 'settings') {
      renderSettingsPanel(contentHost, session);
      return;
    }

    renderAuditPanel(contentHost);
  }

  renderSection();
}
