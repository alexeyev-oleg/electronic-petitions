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

function formatStatus(status) {
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

