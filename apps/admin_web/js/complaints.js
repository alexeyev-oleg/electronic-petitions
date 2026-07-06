const COMPLAINT_FILTERS = [
  { id: 'all', label: 'Все' },
  { id: 'triage', label: 'Триаж' },
  { id: 'in_progress', label: 'В работе' },
  { id: 'resolved', label: 'Решённые' },
];

const DEPARTMENT_OPTIONS = [
  { id: 'sanitation', label: 'Санитарная служба' },
  { id: 'lighting', label: 'Освещение и электросети' },
  { id: 'roads', label: 'Дорожная служба' },
  { id: 'parks', label: 'Парки и скверы' },
];

function departmentLabel(key) {
  if (!key) {
    return 'Не назначено';
  }
  const match = DEPARTMENT_OPTIONS.find((item) => item.id === key);
  return match ? match.label : key;
}

function filterComplaints(complaints, filterId) {
  if (filterId === 'all') {
    return complaints;
  }
  return complaints.filter((item) => item.status === filterId);
}

function canOperateComplaints(role) {
  return ['operator', 'admin', 'supervisor'].includes(role);
}

function canReopenComplaint(role) {
  return ['supervisor', 'admin'].includes(role);
}

function complaintDetailPath(id) {
  return pagePath(`/complaint.html?id=${encodeURIComponent(id)}`);
}

function renderComplaintFilters(container, activeFilter, onChange) {
  container.innerHTML = COMPLAINT_FILTERS.map(
    (filter) => `
      <button type="button" class="filter-chip ${filter.id === activeFilter ? 'is-active' : ''}" data-filter="${filter.id}">
        ${filter.label}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-filter]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-filter')));
  });
}

function renderComplaintsTable(container, complaints, options = {}) {
  const { clickable = true } = options;
  if (complaints.length === 0) {
    container.innerHTML = '<p>Нет жалоб по выбранному фильтру.</p>';
    return;
  }

  container.innerHTML = `
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Жалоба</th>
          <th>Статус</th>
          <th>Отдел</th>
          <th>Локация</th>
        </tr>
      </thead>
      <tbody>
        ${complaints
          .map((item) => {
            const rowClass = clickable ? 'table-row-link' : '';
            const attrs = clickable
              ? `class="${rowClass}" data-complaint-id="${item.id}"`
              : '';
            return `
          <tr ${attrs}>
            <td>${item.id}</td>
            <td>
              <strong>${item.title}</strong><br>
              <span style="color:var(--color-text-muted);font-size:0.875rem;">${item.submittedAtLabel}</span>
            </td>
            <td><span class="${statusChipClass(item.status)}">${formatStatus(item.status)}</span></td>
            <td>${departmentLabel(item.department)}</td>
            <td>${item.locationLabel}</td>
          </tr>`;
          })
          .join('')}
      </tbody>
    </table>
  `;

  if (clickable) {
    container.querySelectorAll('[data-complaint-id]').forEach((row) => {
      row.addEventListener('click', () => {
        const id = row.getAttribute('data-complaint-id');
        window.location.href = complaintDetailPath(id);
      });
    });
  }
}

function applyComplaintAction({ complaintId, session, action, department, note }) {
  const complaint = GesherMockStore.findComplaintById(complaintId);
  if (!complaint) {
    return { ok: false, error: 'not_found' };
  }

  let patch = {};

  switch (action) {
    case 'assign_department':
      if (!canOperateComplaints(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (complaint.status !== 'triage') {
        return { ok: false, error: 'invalid_status' };
      }
      if (!department) {
        return { ok: false, error: 'department_required' };
      }
      patch = {
        status: 'in_progress',
        department,
        assignedOperatorLabel: session.displayName,
        operatorNote: note?.trim() || `Назначено в ${departmentLabel(department)}.`,
      };
      break;
    case 'resolve':
      if (!canOperateComplaints(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (complaint.status !== 'in_progress') {
        return { ok: false, error: 'invalid_status' };
      }
      if (!note || !note.trim()) {
        return { ok: false, error: 'note_required' };
      }
      patch = {
        status: 'resolved',
        resolutionNote: note.trim(),
      };
      break;
    case 'return_to_triage':
      if (!canReopenComplaint(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (!['in_progress', 'resolved'].includes(complaint.status)) {
        return { ok: false, error: 'invalid_status' };
      }
      patch = {
        status: 'triage',
        department: null,
        assignedOperatorLabel: null,
        resolutionNote: null,
        operatorNote: note?.trim() || 'Возвращено на триаж супервайзером.',
      };
      break;
    default:
      return { ok: false, error: 'unknown_action' };
  }

  const updated = GesherMockStore.updateComplaint(complaintId, patch);
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'complaint',
    entityId: complaintId,
    action,
    note: note || department || null,
  });

  return { ok: true, complaint: updated };
}
