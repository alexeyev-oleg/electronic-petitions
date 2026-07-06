function enforcementIdFromQuery() {
  return new URLSearchParams(window.location.search).get('id');
}

function renderEnforcementDetail(container, report) {
  const coords =
    report.latitude != null && report.longitude != null
      ? `${report.latitude.toFixed(4)}, ${report.longitude.toFixed(4)}`
      : '—';

  const geoBanner = report.geoMismatch
    ? `
      <div class="banner" style="margin-bottom:var(--space-md);border-color:var(--color-warning);">
        <strong>Несовпадение геолокации</strong>
        <p style="margin:8px 0 0;">Требуется ручная проверка адреса перед отправкой в поле.</p>
      </div>
    `
    : '';

  container.innerHTML = `
    ${geoBanner}
    <div style="display:flex;justify-content:space-between;gap:var(--space-md);align-items:flex-start;flex-wrap:wrap;">
      <div>
        <span class="${statusChipClass(report.status)}">${formatStatus(report.status)}</span>
        <span class="chip" style="margin-left:8px;">${trustLabel(report.trustLabel)}</span>
      </div>
      <span style="color:var(--color-text-muted);font-size:0.875rem;">${report.submittedAtLabel}</span>
    </div>

    <p style="margin:var(--space-md) 0;">${report.description}</p>

    <dl class="meta-grid">
      <div><dt>ID</dt><dd>${report.id}</dd></div>
      <div><dt>Локация</dt><dd>${report.locationLabel}</dd></div>
      <div><dt>Координаты</dt><dd>${coords}</dd></div>
      ${report.mergedCaseId ? `<div><dt>Объединено с делом</dt><dd>${report.mergedCaseId}</dd></div>` : ''}
      ${report.actionNote ? `<div><dt>Заметка по делу</dt><dd>${report.actionNote}</dd></div>` : ''}
      ${report.oversightNote ? `<div><dt>Заметка супервайзера</dt><dd>${report.oversightNote}</dd></div>` : ''}
    </dl>

    <div class="banner banner--muted" style="margin-top:var(--space-md);">
      Доказательства (фото/видео) доступны в Inspector App для того же ID отчёта.
    </div>
  `;
}

function renderEnforcementActions(container, report, session) {
  if (!canOverseeEnforcement(session.role)) {
    container.innerHTML = `
      <div class="banner banner--muted">
        Модуль надзора доступен только супервайзеру и администратору.
      </div>
    `;
    return;
  }

  const parts = [];
  const closed = isEnforcementClosed(report.status);

  if (!closed && ['triage', 'review_required'].includes(report.status)) {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Триаж и отправка</h2>
        ${
          report.status === 'review_required'
            ? `
        <div class="field">
          <label for="manual-address">Уточнённый адрес</label>
          <input id="manual-address" type="text" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);" placeholder="ул. Пример, 1" />
        </div>
        <div class="action-bar">
          <button class="btn btn--secondary" type="button" data-action="resolve_geo">Уточнить гео и вернуть в триаж</button>
        </div>
        <hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-lg) 0;" />
        `
            : ''
        }
        <div class="field">
          <label for="dispatch-note">Комментарий (необязательно)</label>
          <textarea id="dispatch-note" rows="2" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);"></textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="dispatch_task">Отправить полевую задачу</button>
          <button class="btn btn--secondary" type="button" data-action="mark_invalid">Недействительный отчёт</button>
        </div>
        <div class="field" style="margin-top:var(--space-md);">
          <label for="merge-case-id">ID существующего дела</label>
          <input id="merge-case-id" type="text" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);" placeholder="CASE-2024-001" />
        </div>
        <div class="action-bar">
          <button class="btn btn--secondary" type="button" data-action="merge_case">Объединить с делом</button>
        </div>
      </div>
    `);
  }

  if (!closed && report.status === 'dispatch_task') {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Подтверждённый итог</h2>
        <div class="field">
          <label for="outcome-note">Комментарий (необязательно)</label>
          <textarea id="outcome-note" rows="2" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);"></textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="validated_warning">Предупреждение</button>
          <button class="btn btn--primary" type="button" data-action="validated_fine">Штраф</button>
          <button class="btn btn--secondary" type="button" data-action="validated_no_action">Без мер</button>
        </div>
      </div>
    `);
  }

  if (closed && session.role === 'admin') {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Администрирование</h2>
        <div class="field">
          <label for="reopen-note">Причина возврата (необязательно)</label>
          <textarea id="reopen-note" rows="2" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);"></textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--secondary" type="button" data-action="reopen_to_triage">Вернуть на триаж</button>
        </div>
      </div>
    `);
  }

  if (parts.length === 0) {
    container.innerHTML = `
      <div class="banner banner--muted">
        Для текущего статуса отчёта действия недоступны.
      </div>
    `;
    return;
  }

  container.innerHTML = parts.join('<hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-lg) 0;" />');

  container.querySelectorAll('[data-action]').forEach((button) => {
    button.addEventListener('click', () =>
      handleEnforcementAction(button.getAttribute('data-action'), report.id, session),
    );
  });
}

async function handleEnforcementAction(action, reportId, session) {
  const messageEl = document.getElementById('action-message');
  messageEl.textContent = '';

  const dispatchNote = document.getElementById('dispatch-note')?.value || '';
  const manualAddress = document.getElementById('manual-address')?.value || '';
  const mergeCaseId = document.getElementById('merge-case-id')?.value || '';
  const outcomeNote = document.getElementById('outcome-note')?.value || '';
  const reopenNote = document.getElementById('reopen-note')?.value || '';

  if (action === 'resolve_geo' && !manualAddress.trim()) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Укажите уточнённый адрес.';
    return;
  }

  if (action === 'merge_case' && !mergeCaseId.trim()) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Укажите ID существующего дела.';
    return;
  }

  const actionLabels = {
    dispatch_task: 'отправить полевую задачу',
    resolve_geo: 'уточнить геолокацию и вернуть в триаж',
    mark_invalid: 'отметить отчёт недействительным',
    merge_case: 'объединить с существующим делом',
    validated_warning: 'зафиксировать итог: предупреждение',
    validated_fine: 'зафиксировать итог: штраф',
    validated_no_action: 'зафиксировать итог: без мер',
    reopen_to_triage: 'вернуть отчёт на триаж',
  };

  const confirmed = await confirmStaffOtp(`Подтвердите действие: ${actionLabels[action]}.`);
  if (!confirmed) {
    return;
  }

  const note =
    action === 'validated_warning' || action === 'validated_fine' || action === 'validated_no_action'
      ? outcomeNote
      : dispatchNote || reopenNote;

  const result = applyEnforcementAction({
    reportId,
    session,
    action,
    note,
    mergedCaseId: mergeCaseId || null,
    manualAddress: manualAddress || null,
  });

  if (!result.ok) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Не удалось выполнить действие.';
    return;
  }

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Действие записано в mock-режиме.';

  document.getElementById('enforcement-title').textContent = result.report.title;
  renderEnforcementDetail(document.getElementById('enforcement-detail'), result.report);
  renderEnforcementActions(document.getElementById('enforcement-actions'), result.report, session);
}

document.addEventListener('DOMContentLoaded', async () => {
  const session = await requireStaffSession();
  if (!session) {
    return;
  }

  const reportId = enforcementIdFromQuery();
  if (!reportId) {
    window.location.href = pagePath('/dashboard.html');
    return;
  }

  const report = GesherMockStore.findEnforcementById(reportId);
  if (!report) {
    document.getElementById('enforcement-detail').innerHTML = '<p>Отчёт не найден.</p>';
    return;
  }

  renderLogo(document.getElementById('sidebar-logo'), true);
  document.getElementById('user-name').textContent = session.displayName;
  document.getElementById('role-chip').textContent = roleLabel(session.role);
  document.getElementById('enforcement-title').textContent = report.title;
  document.getElementById('enforcement-subtitle').textContent = `ID ${report.id}`;

  document.getElementById('back-dashboard').href = pagePath('/dashboard.html');
  document.getElementById('sign-out-btn').addEventListener('click', signOutStaff);

  renderEnforcementDetail(document.getElementById('enforcement-detail'), report);
  renderEnforcementActions(document.getElementById('enforcement-actions'), report, session);
});
