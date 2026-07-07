const PETITION_FILTERS = [
  { id: 'all', label: 'Все' },
  { id: 'draft', label: 'Черновики' },
  { id: 'moderation_review', label: 'На модерации' },
  { id: 'published', label: 'Опубликованные' },
  { id: 'rejected', label: 'Отклонённые' },
];

const CATEGORY_LABELS = {
  blagoustroystvo: 'Благоустройство',
  transport: 'Транспорт',
  ecology: 'Экология',
};

function categoryLabel(key) {
  return CATEGORY_LABELS[key] || key;
}

function filterPetitions(petitions, filterId) {
  if (filterId === 'all') {
    return petitions;
  }
  return petitions.filter((item) => item.status === filterId);
}

function canModerate(role) {
  return ['moderator', 'admin', 'supervisor'].includes(role);
}

function canPublishResponse(role) {
  return ['municipality_staff', 'admin'].includes(role);
}

function petitionDetailPath(id) {
  return pagePath(`/petition.html?id=${encodeURIComponent(id)}`);
}

function renderPetitionFilters(container, activeFilter, onChange) {
  container.innerHTML = PETITION_FILTERS.map(
    (filter) => `
      <button type="button" class="filter-chip ${filter.id === activeFilter ? 'is-active' : ''}" data-filter="${filter.id}">
        ${filter.label}
      </button>`,
  ).join('');

  container.querySelectorAll('[data-filter]').forEach((button) => {
    button.addEventListener('click', () => onChange(button.getAttribute('data-filter')));
  });
}

function renderPetitionsTable(container, petitions, options = {}) {
  const { clickable = true, selectedIndex = -1 } = options;
  if (petitions.length === 0) {
    container.innerHTML = '<p>Нет инициатив по выбранному фильтру.</p>';
    return;
  }

  container.innerHTML = `
    <table class="table" data-keyboard-table="petitions">
      <thead>
        <tr>
          <th>ID</th>
          <th>Инициатива</th>
          <th>Категория</th>
          <th>Статус</th>
          <th>Подписи</th>
        </tr>
      </thead>
      <tbody>
        ${petitions
          .map((item, index) => {
            const rowClass = [
              clickable ? 'table-row-link' : '',
              index === selectedIndex ? 'is-focused' : '',
            ]
              .filter(Boolean)
              .join(' ');
            const attrs = clickable
              ? `class="${rowClass}" data-petition-id="${item.id}" data-row-index="${index}" tabindex="0"`
              : '';
            return `
          <tr ${attrs}>
            <td>${item.id}</td>
            <td>
              <strong>${item.title}</strong><br>
              <span style="color:var(--color-text-muted);font-size:0.875rem;">${item.summary}</span>
            </td>
            <td>${categoryLabel(item.category)}</td>
            <td><span class="${statusChipClass(item.status)}">${formatStatus(item.status)}</span></td>
            <td>${item.signatureCount} / ${item.signatureGoal}</td>
          </tr>`;
          })
          .join('')}
      </tbody>
    </table>
  `;

  if (clickable) {
    container.querySelectorAll('[data-petition-id]').forEach((row) => {
      row.addEventListener('click', () => {
        const id = row.getAttribute('data-petition-id');
        window.location.href = petitionDetailPath(id);
      });
    });
  }
}

function applyPetitionAction({ petitionId, session, action, note }) {
  const petition = GesherMockStore.findPetitionById(petitionId);
  if (!petition) {
    return { ok: false, error: 'not_found' };
  }

  let patch = {};
  switch (action) {
    case 'approve':
      if (!canModerate(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (!['draft', 'moderation_review'].includes(petition.status)) {
        return { ok: false, error: 'invalid_status' };
      }
      patch = { status: 'published', moderationNote: note || null };
      break;
    case 'reject':
      if (!canModerate(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      patch = { status: 'rejected', moderationNote: note || 'Отклонено модератором.' };
      break;
    case 'request_changes':
      if (!canModerate(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (!note || !note.trim()) {
        return { ok: false, error: 'note_required' };
      }
      patch = { status: 'draft', moderationNote: note.trim() };
      break;
    case 'official_response':
      if (!canPublishResponse(session.role)) {
        return { ok: false, error: 'forbidden' };
      }
      if (petition.status !== 'published') {
        return { ok: false, error: 'invalid_status' };
      }
      if (!note || !note.trim()) {
        return { ok: false, error: 'note_required' };
      }
      patch = { officialResponse: note.trim() };
      break;
    default:
      return { ok: false, error: 'unknown_action' };
  }

  const updated = GesherMockStore.updatePetition(petitionId, patch);
  GesherMockStore.appendAuditEntry({
    actorId: session.id,
    actorName: session.displayName,
    role: session.role,
    entityType: 'petition',
    entityId: petitionId,
    action,
    note: note || null,
  });

  return { ok: true, petition: updated };
}
