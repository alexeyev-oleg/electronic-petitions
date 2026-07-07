const CONTACT_STORAGE_KEY = 'gesher_contact_mock_submissions';

function renderContactLabels() {
  document.getElementById('contact-title').textContent = t('contactTitle');
  document.getElementById('contact-intro').textContent = t('contactIntro');
  document.getElementById('contact-name-label').textContent = t('contactNameLabel');
  document.getElementById('contact-email-label').textContent = t('contactEmailLabel');
  document.getElementById('contact-message-label').textContent = t('contactMessageLabel');
  document.getElementById('contact-submit').textContent = t('contactSubmit');
  document.getElementById('contact-notice').textContent = t('contactMockNotice');

  setPageMeta({
    title: t('contactMetaTitle'),
    description: t('contactMetaDescription'),
    canonicalPath: '/contact.html',
  });
}

function bindContactForm() {
  const form = document.getElementById('contact-form');
  const success = document.getElementById('contact-success');
  if (!form) {
    return;
  }

  form.addEventListener('submit', (event) => {
    event.preventDefault();
    const data = new FormData(form);
    const payload = {
      name: String(data.get('name') || '').trim(),
      email: String(data.get('email') || '').trim(),
      message: String(data.get('message') || '').trim(),
      submittedAt: new Date().toISOString(),
    };

    const existing = JSON.parse(localStorage.getItem(CONTACT_STORAGE_KEY) || '[]');
    existing.push(payload);
    localStorage.setItem(CONTACT_STORAGE_KEY, JSON.stringify(existing));

    form.reset();
    success.hidden = false;
    success.textContent = t('contactSuccess');
  });
}

window.onPublicLocaleChange = () => {
  renderContactLabels();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderContactLabels();
  bindContactForm();
});
