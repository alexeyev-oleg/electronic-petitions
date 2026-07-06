const ENFORCEMENT_FILTERS = [
  { id: 'all', label: 'Все' },
  { id: 'triage', label: 'Триаж' },
  { id: 'review_required', label: 'Проверка гео' },
  { id: 'dispatch_task', label: 'В поле' },
  { id: 'closed', label: 'Закрытые' },
];

const TRUST_LABELS = {
  standard: 'Стандартный',
  low_geo_confidence: 'Низкая гео-точность',
};

function trustLabel(key) {
  return TRUST_LABELS[key] || formatStatus(key);
}

function isEnforcementClosed(status) {
  const value = (status || '').toLowerCase();
  return (
    value.includes('invalid') ||
    value.includes('merged') ||
    value.includes('validated')
  );
}

function filterEnforcement(reports, filterId) {
  if (filterId === 'all') {
    return reports;
  }
  if (filterId === 'closed') {
    return reports.filter((item) => isEnforcementClosed(item.status));
  }
  return reports.filter((item) => item.status === filterId);
}

function canOverseeEnforcement(role) {
  return ['supervisor', 'admin'].includes(role);
}

function enforcementDetailPath(id) {
  return pagePath(`/enforcement.html?id=${encodeURIComponent(id)}`);
}

function renderEnforcementFilters(container, activeFilter, onChange) {
  container.innerHTML = ENFORCEMENT_FILTERS.map(
    (filter) => `
      <button type="button" class="filter-chip ${filter.id === activeFilter ? 'is-active' : ''}" data-filter="${filter.id}">
        ${filter.label}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-filter]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-filter')));
  });
}

function renderEnforcementTable(container, reports, options = {}) {
  const { clickable = true } = options;
  if (reports.length === 0) {
    container.innerHTML = '<p>Нет отчётов по выбранному фильтру.</p>';
    return;
  }

  container.innerHTML = `
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Отчёт</th>
          <th>Статус</th>
          <th>Trust</th>
          <th>Локация</th>
        </tr>
      </thead>
      <tbody>
        ${reports
          .map((item) => {
            const rowClass = clickable ? 'table-row-link' : '';
            const attrs = clickable
              ? `class="${rowClass}" data-enforcement-id="${item.id}"`
              : '';
            return `
          <tr ${attrs}>
            <td>${item.id}</td>
            <td>
              <strong>${item.title}</strong><br>
              <span style="color:var(--color-text-muted);font-size:0.875rem;">${item.submittedAtLabel}</span>
            </td>
            <td><span class="${statusChipClass(item.status)}">${formatStatus(item.status)}</span></td>
            <td>${trustLabel(item.trustLabel)}</td>
            <td>${item.locationLabel}</td>
          </tr>`;
          })
          .join('')}
      </tbody>
    </table>
  `;

  if (clickable) {
    container.querySelectorAll('[data-enforcement-id]').forEach((row) => {
      row.addEventListener('click', () => {
        const id = row.getAttribute('data-enforcement-id');
        window.location.href = enforcementDetailPath(id);
      });
    });
  }
}

function applyEnforcementAction({ reportId, session, action, note, mergedCaseId, manualAddress }) {
  const report = GesherMockStore.findEnforcementById(reportId);
  if (!report) {
    return { ok: false, error: 'not_found' };
  }

  if (!canOverseeEnforcement(session.role)) {
    return { ok: false, error: 'forbidden' };
  }

  if (isEnforcementClosed(report.status) && action !== 'reopen_to_triage') {
    return { ok: false, error: 'already_closed' };
  }

  let patch = {};

  switch (action) {
    case 'dispatch_task':
      if (!['triage', 'review_required'].includes(report.status)) {
        return { ok: false, error: 'invalid_status' };
      }
      patch = {
        status: 'dispatch_task',
        actionNote: note?.trim() || 'Супервайзер подтвердил отправку полевой бригады.',
      };
      break;
    case 'resolve_geo':
      if (report.status !== 'review_required') {
        return { ok: false, error: 'invalid_status' };
      }
      if (!manualAddress || !manualAddress.trim()) {
        return { ok: false, error: 'address_required' };
      }
      patch = {
        status: 'triage',
        geoMismatch: false,
        locationLabel: manualAddress.trim(),
        oversightNote: note?.trim() || 'Геолокация уточнена супервайзером.',
      };
      break;
    case 'mark_invalid':
      patch = {
        status: 'invalid',
        actionNote: note?.trim() || 'Отмечено как недействительное.',
      };
      break;
    case 'merge_case':
      if (!mergedCaseId || !mergedCaseId.trim()) {
        return { ok: false, error: 'case_id_required' };
      }
      patch = {
        status: 'merged_with_existing_case',
        mergedCaseId: mergedCaseId.trim(),
        actionNote: note?.trim() || `Объединено с делом ${mergedCaseId.trim()}.`,
      };
      break;
    case 'validated_warning':
    case 'validated_fine':
    case 'validated_no_action':
      if (report.status !== 'dispatch_task') {
        return { ok: false, error: 'invalid_status' };
      }
      patch = {
        status: action,
        actionNote: note?.trim() || 'Подтверждённый итог зафиксирован супервайзером.',
      };
      break;
    case 'reopen_to_triage':
      if (!isEnforcementClosed(report.status)) {
        return { ok: false, error: 'invalid_status' };
      }
      patch = {
        status: 'triage',
        geoMismatch: false,
        actionNote: null,
        oversightNote: note?.trim() || 'Возвращено на триаж администратором.',
        mergedCaseId: null,
      };
      break;
    default:
      return { ok: false, error: 'unknown_action' };
  }

  const updated = GesherMockStore.updateEnforcement(reportId, patch);
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'enforcement',
    entityId: reportId,
    action,
    note: note || mergedCaseId || manualAddress || null,
  });

  return { ok: true, report: updated };
}
