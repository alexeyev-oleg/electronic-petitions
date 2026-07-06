document.addEventListener('DOMContentLoaded', async () => {
  renderLogo(document.getElementById('hero-logo'));

  const existing = GesherMockStore.getSession();
  if (existing) {
    window.location.href = pagePath('/dashboard.html');
    return;
  }

  const form = document.getElementById('login-form');
  const errorEl = document.getElementById('login-error');

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    errorEl.textContent = '';

    const email = form.email.value;
    const password = form.password.value;
    const result = await signInStaff(email, password);

    if (!result.ok) {
      errorEl.textContent = 'Неверные учётные данные staff.';
      return;
    }

    window.location.href = pagePath('/dashboard.html');
  });
});
