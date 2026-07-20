document.addEventListener('DOMContentLoaded', async () => {
  renderLogo(document.getElementById('hero-logo'));

  const form = document.getElementById('login-form');
  const errorEl = document.getElementById('login-error');

  try {
    await initMockStore();
  } catch (error) {
    console.error(error);
    errorEl.textContent =
      'Не удалось загрузить mock-данные. Откройте staff через /electronic-petitions/staff/ или локальный serve-local.';
    return;
  }

  let existing = null;
  try {
    existing = GesherMockStore.getSession();
  } catch (error) {
    console.error(error);
    GesherMockStore.clearSession();
  }

  if (existing) {
    window.location.href = pagePath('/dashboard.html');
    return;
  }

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    errorEl.textContent = '';

    const email = form.email.value;
    const password = form.password.value;

    try {
      const result = await signInStaff(email, password);

      if (!result.ok) {
        errorEl.textContent = 'Неверные учётные данные staff.';
        return;
      }

      window.location.href = pagePath('/dashboard.html');
    } catch (error) {
      console.error(error);
      errorEl.textContent =
        'Ошибка входа: mock-данные недоступны. Проверьте URL и перезагрузите страницу.';
    }
  });
});
