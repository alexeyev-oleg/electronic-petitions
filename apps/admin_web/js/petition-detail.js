function petitionIdFromQuery() {
  return new URLSearchParams(window.location.search).get('id');
}

function signaturePercent(petition) {
  if (!petition.signatureGoal) {
    return 0;
  }
  return Math.min(100, Math.round((petition.signatureCount / petition.signatureGoal) * 100));
}

function renderPetitionDetail(container, petition) {
  const percent = signaturePercent(petition);
  container.innerHTML = `
    <div style="display:flex;justify-content:space-between;gap:var(--space-md);align-items:flex-start;flex-wrap:wrap;">
      <div>
        <span class="${statusChipClass(petition.status)}">${formatStatus(petition.status)}</span>
        <span class="chip" style="margin-left:8px;">${categoryLabel(petition.category)}</span>
      </div>
      <span style="color:var(--color-text-muted);font-size:0.875rem;">${petition.submittedAtLabel}</span>
    </div>

    <p style="margin:var(--space-md) 0;">${petition.summary}</p>

    <div>
      <strong>${petition.signatureCount}</strong> / ${petition.signatureGoal} подписей (${percent}%)
      <div class="progress-track"><div class="progress-fill" style="width:${percent}%"></div></div>
    </div>

    <dl class="meta-grid">
      <div><dt>ID</dt><dd>${petition.id}</dd></div>
      ${petition.moderationNote ? `<div><dt>Замечание модерации</dt><dd>${petition.moderationNote}</dd></div>` : ''}
      ${petition.officialResponse ? `<div><dt>Официальный ответ мэрии</dt><dd>${petition.officialResponse}</dd></div>` : ''}
    </dl>
  `;
}

function renderPetitionActions(container, petition, session) {
  const parts = [];

  if (canModerate(session.role) && ['draft', 'moderation_review'].includes(petition.status)) {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Модерация</h2>
        <div class="field">
          <label for="moderation-note">Комментарий (для доработки обязателен)</label>
          <textarea id="moderation-note" rows="3" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">${petition.moderationNote || ''}</textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="approve">Опубликовать</button>
          <button class="btn btn--secondary" type="button" data-action="request_changes">Вернуть на доработку</button>
          <button class="btn btn--secondary" type="button" data-action="reject">Отклонить</button>
        </div>
      </div>
    `);
  }

  if (canPublishResponse(session.role) && petition.status === 'published') {
    parts.push(`
      <div>
        <h2 style="margin-top:0;">Официальный ответ мэрии</h2>
        <div class="field">
          <label for="official-response">Текст ответа</label>
          <textarea id="official-response" rows="4" style="width:100%;border-radius:var(--radius-md);padding:var(--space-sm);border:1px solid var(--color-border);">${petition.officialResponse || ''}</textarea>
        </div>
        <div class="action-bar">
          <button class="btn btn--primary" type="button" data-action="official_response">Сохранить ответ</button>
        </div>
      </div>
    `);
  }

  if (parts.length === 0) {
    container.innerHTML = `
      <div class="banner banner--muted">
        Для текущей роли и статуса инициативы действия недоступны.
      </div>
    `;
    return;
  }

  container.innerHTML = parts.join('<hr style="border:none;border-top:1px solid var(--color-border);margin:var(--space-lg) 0;" />');

  container.querySelectorAll('[data-action]').forEach((button) => {
    button.addEventListener('click', () =>
      handlePetitionAction(button.getAttribute('data-action'), petition.id, session),
    );
  });
}

async function handlePetitionAction(action, petitionId, session) {
  const messageEl = document.getElementById('action-message');
  messageEl.textContent = '';

  const moderationNote = document.getElementById('moderation-note')?.value || '';
  const officialResponse = document.getElementById('official-response')?.value || '';
  const note = action === 'official_response' ? officialResponse : moderationNote;

  if (action === 'request_changes' && !note.trim()) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Укажите комментарий для доработки.';
    return;
  }

  if (action === 'official_response' && !note.trim()) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Введите текст официального ответа.';
    return;
  }

  const actionLabels = {
    approve: 'опубликовать инициативу',
    reject: 'отклонить инициативу',
    request_changes: 'вернуть инициативу на доработку',
    official_response: 'сохранить официальный ответ',
  };

  const confirmed = await confirmStaffOtp(`Подтвердите действие: ${actionLabels[action]}.`);
  if (!confirmed) {
    return;
  }

  const result = applyPetitionAction({
    petitionId,
    session,
    action,
    note,
  });

  if (!result.ok) {
    messageEl.style.color = 'var(--color-danger)';
    messageEl.textContent = 'Не удалось выполнить действие.';
    return;
  }

  messageEl.style.color = 'var(--color-success)';
  messageEl.textContent = 'Действие записано в mock-режиме.';

  document.getElementById('petition-title').textContent = result.petition.title;
  renderPetitionDetail(document.getElementById('petition-detail'), result.petition);
  renderPetitionActions(document.getElementById('petition-actions'), result.petition, session);
}

document.addEventListener('DOMContentLoaded', async () => {
  const session = await requireStaffSession();
  if (!session) {
    return;
  }

  const petitionId = petitionIdFromQuery();
  if (!petitionId) {
    window.location.href = pagePath('/dashboard.html');
    return;
  }

  const petition = GesherMockStore.findPetitionById(petitionId);
  if (!petition) {
    document.getElementById('petition-detail').innerHTML = '<p>Инициатива не найдена.</p>';
    return;
  }

  renderLogo(document.getElementById('sidebar-logo'), true);
  document.getElementById('user-name').textContent = session.displayName;
  document.getElementById('role-chip').textContent = roleLabel(session.role);
  document.getElementById('petition-title').textContent = petition.title;
  document.getElementById('petition-subtitle').textContent = `ID ${petition.id}`;

  document.getElementById('back-dashboard').href = pagePath('/dashboard.html');
  document.getElementById('sign-out-btn').addEventListener('click', signOutStaff);

  renderPetitionDetail(document.getElementById('petition-detail'), petition);
  renderPetitionActions(document.getElementById('petition-actions'), petition, session);
});
