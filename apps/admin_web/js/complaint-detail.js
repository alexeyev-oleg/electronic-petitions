function complaintIdFromQuery() {
  return new URLSearchParams(window.location.search).get('id');
}

function renderComplaintDetail(container, complaint) {
  const coords =
    complaint.latitude != null && complaint.longitude != null
      ? `${complaint.latitude.toFixed(4)}, ${complaint.longitude.toFixed(4)}`
      : '—';

  container.innerHTML = `
    <div style="display:flex;justify-content:space-between;gap:var(--space-md);align-items:flex-start;flex-wrap:wrap;">
      <div>
        <span class="${statusChipClass(complaint.status)}">${formatStatus(complaint.status)}</span>
        <span class="chip" style="margin-left:8px;">${departmentLabel(complaint.department)}</span>
      </div>
      <span style="color:var(--color-text-muted);font-size:0.875rem;">${complaint.submittedAtLabel}</span>
    </div>

    <p style="margin:var(--space-md) 0;">${complaint.description}</p>

    <dl class="meta-grid">
      <div><dt>ID</dt><dd>${complaint.id}</dd></div>
      <div><dt>Локация</dt><dd>${complaint.locationLabel}</dd></div>
      <div><dt>Координаты</dt><dd>${coords}</dd></div>
      ${complaint.assignedOperatorLabel ? `<div><dt>Оператор</dt><dd>${complaint.assignedOperatorLabel}</dd></div>` : ''}
      ${complaint.operatorNote ? `<div><dt>Заметка оператора</dt><dd>${complaint.operatorNote}</dd></div>` : ''}
      ${complaint.resolutionNote ? `<div><dt>Решение</dt><dd>${complaint.resolutionNote}</dd></div>` : ''}
    </dl>
  `;
}

function departmentSelectHtml(selectedId) {
  const options = DEPARTMENT_OPTIONS.map(
    (item) =>
      `<option value="${item.id}" ${item.id === selectedId ? 'selected' : ''}>${item.label}</option>`,
  ).join('');
  return `
    <select id="complaint-department" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">
      <option value="">Выберите отдел</option>
      ${options}
    </select>
  `;
}

function renderComplaintActions(container, complaint, session) {
  const parts = [];

  if (canOperateComplaints(session.role) && complaint.status === 'triage') {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Назначение в отдел</h2>
        <div class="field">
          <label for="complaint-department">Ответственный отдел</label>
          ${departmentSelectHtml(complaint.department)}
        </div>
        <div class="field">
          <label for="operator-note">Комментарий (необязательно)</label>
          <textarea id="operator-note" rows="2" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">${complaint.operatorNote || ''}</textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="assign_department">Назначить и взять в работу</button>
        </div>
      </div>
    `);
  }

  if (canOperateComplaints(session.role) && complaint.status === 'in_progress') {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Закрытие жалобы</h2>
        <div class="field">
          <label for="resolution-note">Описание решения</label>
          <textarea id="resolution-note" rows="3" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">${complaint.resolutionNote || ''}</textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="resolve">Отметить решённой</button>
        </div>
      </div>
    `);
  }

  if (canReopenComplaint(session.role) && ['in_progress', 'resolved'].includes(complaint.status)) {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Супервизия</h2>
        <div class="field">
          <label for="reopen-note">Причина возврата (необязательно)</label>
          <textarea id="reopen-note" rows="2" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);"></textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--secondary" type="button" data-action="return_to_triage">Вернуть на триаж</button>
        </div>
      </div>
    `);
  }

  if (parts.length === 0) {
    container.innerHTML = `
      <div class="banner banner--muted">
        Для текущей роли и статуса жалобы действия недоступны.
      </div>
    `;
    return;
  }

  container.innerHTML = parts.join('<hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-lg) 0;" />');

  container.querySelectorAll('[data-action]').forEach((button) => {
    button.addEventListener('click', () =>
      handleComplaintAction(button.getAttribute('data-action'), complaint.id, session),
    );
  });
}

async function handleComplaintAction(action, complaintId, session) {
  const messageEl = document.getElementById('action-message');
  messageEl.textContent = '';

  const department = document.getElementById('complaint-department')?.value || '';
  const operatorNote = document.getElementById('operator-note')?.value || '';
  const resolutionNote = document.getElementById('resolution-note')?.value || '';
  const reopenNote = document.getElementById('reopen-note')?.value || '';

  if (action === 'assign_department' && !department) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Выберите отдел для назначения.';
    return;
  }

  if (action === 'resolve' && !resolutionNote.trim()) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Укажите описание решения.';
    return;
  }

  const actionLabels = {
    assign_department: 'назначить жалобу в отдел и взять в работу',
    resolve: 'отметить жалобу решённой',
    return_to_triage: 'вернуть жалобу на триаж',
  };

  const confirmed = await confirmStaffOtp(`Подтвердите действие: ${actionLabels[action]}.`);
  if (!confirmed) {
    return;
  }

  const result = applyComplaintAction({
    complaintId,
    session,
    action,
    department: department || null,
    note: action === 'resolve' ? resolutionNote : action === 'return_to_triage' ? reopenNote : operatorNote,
  });

  if (!result.ok) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Не удалось выполнить действие.';
    return;
  }

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Действие записано в mock-режиме.';

  document.getElementById('complaint-title').textContent = result.complaint.title;
  renderComplaintDetail(document.getElementById('complaint-detail'), result.complaint);
  renderComplaintActions(document.getElementById('complaint-actions'), result.complaint, session);
}

document.addEventListener('DOMContentLoaded', async () => {
  const session = await requireStaffSession();
  if (!session) {
    return;
  }

  const complaintId = complaintIdFromQuery();
  if (!complaintId) {
    window.location.href = pagePath('/dashboard.html');
    return;
  }

  const complaint = GesherMockStore.findComplaintById(complaintId);
  if (!complaint) {
    document.getElementById('complaint-detail').innerHTML = '<p>Жалоба не найдена.</p>';
    return;
  }

  renderLogo(document.getElementById('sidebar-logo'), true);
  document.getElementById('user-name').textContent = session.displayName;
  document.getElementById('role-chip').textContent = roleLabel(session.role);
  document.getElementById('complaint-title').textContent = complaint.title;
  document.getElementById('complaint-subtitle').textContent = `ID ${complaint.id}`;

  document.getElementById('back-dashboard').href = pagePath('/dashboard.html');
  document.getElementById('sign-out-btn').addEventListener('click', signOutStaff);

  renderComplaintDetail(document.getElementById('complaint-detail'), complaint);
  renderComplaintActions(document.getElementById('complaint-actions'), complaint, session);
});
