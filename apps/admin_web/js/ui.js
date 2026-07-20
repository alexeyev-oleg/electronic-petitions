function renderLogo(target, inverse = false) {
  const letters = ['G', 'E', 'S', 'H', 'E', 'R'];
  const className = inverse ? 'logo logo--inverse' : 'logo';
  target.innerHTML = letters
    .map((letter) => `<span class="logo__letter">${letter}</span><span class="logo__dot"></span>`)
    .join('');
}

function statusChipClass(status) {
  const value = (status || '').toLowerCase();
  if (value.includes('rejected') || value.includes('invalid')) {
    return 'chip chip--danger';
  }
  if (
    value.includes('published') ||
    value.includes('resolved') ||
    value.includes('validated')
  ) {
    return 'chip chip--success';
  }
  if (
    value.includes('review') ||
    value.includes('triage') ||
    value.includes('progress') ||
    value.includes('draft') ||
    value.includes('dispatch')
  ) {
    return 'chip chip--warning';
  }
  if (value.includes('merged')) {
    return 'chip';
  }
  return 'chip';
}

const STATUS_LABELS = {
  en: {
    published: 'Published',
    moderation_review: 'Moderation review',
    draft: 'Draft',
    triage: 'Triage',
    in_progress: 'In progress',
    resolved: 'Resolved',
    review_required: 'Review required',
    dispatch_task: 'Dispatch task',
    rejected: 'Rejected',
    field_in_progress: 'Field in progress',
    validated: 'Validated',
    merged: 'Merged',
  },
  ru: {
    published: 'Опубликована',
    moderation_review: 'На модерации',
    draft: 'Черновик',
    triage: 'Сортировка',
    in_progress: 'В работе',
    resolved: 'Решена',
    review_required: 'Требует проверки',
    dispatch_task: 'Выезд',
    rejected: 'Отклонена',
    field_in_progress: 'В поле',
    validated: 'Подтверждена',
    merged: 'Объединена',
  },
  he: {
    published: 'פורסם',
    moderation_review: 'בבדיקת מודרציה',
    draft: 'טיוטה',
    triage: 'מיון',
    in_progress: 'בטיפול',
    resolved: 'טופל',
    review_required: 'דורש בדיקה',
    dispatch_task: 'משימת שטח',
    rejected: 'נדחה',
    field_in_progress: 'בשטח',
    validated: 'אומת',
    merged: 'מוזג',
  },
  ar: {
    published: 'منشورة',
    moderation_review: 'قيد المراجعة',
    draft: 'مسودة',
    triage: 'فرز',
    in_progress: 'قيد التنفيذ',
    resolved: 'تم الحل',
    review_required: 'يتطلب مراجعة',
    dispatch_task: 'مهمة ميدانية',
    rejected: 'مرفوضة',
    field_in_progress: 'في الميدان',
    validated: 'تم التحقق',
    merged: 'مدمجة',
  },
};

function staffStatusLocale() {
  try {
    if (typeof GesherMockStore !== 'undefined' && GesherMockStore.getSettings) {
      const locale = GesherMockStore.getSettings()?.defaultLocale;
      if (locale && STATUS_LABELS[locale]) {
        return locale;
      }
    }
  } catch (_) {
    // Seed may not be loaded yet.
  }
  return 'ru';
}

function formatStatus(status) {
  const key = (status || '').toLowerCase().trim();
  const locale = staffStatusLocale();
  const labels = STATUS_LABELS[locale] || STATUS_LABELS.ru;
  if (labels[key]) {
    return labels[key];
  }
  return (status || '').replaceAll('_', ' ');
}

function renderStats(container, stats) {
  container.innerHTML = `
    <div class="stat-grid">
      <div class="stat-card"><strong>${stats.initiativesSubmitted}</strong><span>Инициатив подано</span></div>
      <div class="stat-card"><strong>${stats.underReview}</strong><span>На рассмотрении</span></div>
      <div class="stat-card"><strong>${stats.implemented}</strong><span>Реализовано</span></div>
      <div class="stat-card"><strong>${stats.citizenVotes}</strong><span>Голосов жителей</span></div>
    </div>
  `;
}

function renderQueueKpis(container, kpis, role) {
  const cards = [];

  if (['moderator', 'admin', 'supervisor', 'municipality_staff'].includes(role)) {
    cards.push(
      { value: kpis.petitionsModeration, label: 'Инициатив на модерации' },
      { value: kpis.petitionsDraft, label: 'Черновиков' },
    );
  }
  if (['operator', 'admin', 'supervisor'].includes(role)) {
    cards.push(
      { value: kpis.complaintsTriage, label: 'Жалоб в triage' },
      { value: kpis.complaintsInProgress, label: 'Жалоб в работе' },
    );
  }
  if (['supervisor', 'admin'].includes(role)) {
    cards.push(
      { value: kpis.enforcementTriage, label: 'Донесений в triage' },
      { value: kpis.enforcementDispatch, label: 'Выездов / review' },
    );
  }

  cards.push({ value: kpis.slaAttention, label: 'Требуют внимания (mock SLA)' });

  container.innerHTML = `
    <div class="kpi-grid">
      ${cards
        .map(
          (card) => `
        <div class="kpi-card">
          <strong>${card.value}</strong>
          <span>${card.label}</span>
        </div>`,
        )
        .join('')}
    </div>
    <p class="kpi-meta">Seed <code>${kpis.seedVersion}</code> · очереди из текущего mock store</p>
  `;
}

function attachPrintButton(buttonId) {
  const button = document.getElementById(buttonId);
  if (!button) {
    return;
  }
  button.addEventListener('click', () => window.print());
}

