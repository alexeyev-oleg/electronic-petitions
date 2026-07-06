function confirmStaffOtp(message) {
  return new Promise((resolve) => {
    const backdrop = document.createElement('div');
    backdrop.className = 'modal-backdrop';
    backdrop.innerHTML = `
      <form class="modal-card" id="otp-form">
        <h3>Подтверждение действия</h3>
        <p style="margin:0 0 var(--space-sm);color:var(--color-text-muted);">${message}</p>
        <p style="margin:0 0 var(--space-md);font-size:0.85rem;">Mock OTP: <strong>${window.GESHER_CONFIG.mockOtp}</strong></p>
        <div class="field">
          <label for="otp-input">Код подтверждения</label>
          <input id="otp-input" inputmode="numeric" maxlength="6" required />
        </div>
        <p id="otp-error" style="color:var(--color-danger);min-height:1.25rem;font-size:0.875rem;"></p>
        <div class="action-bar">
          <button class="btn btn--primary" type="submit">Подтвердить</button>
          <button class="btn btn--secondary" type="button" id="otp-cancel">Отмена</button>
        </div>
      </form>
    `;

    document.body.appendChild(backdrop);

    const form = backdrop.querySelector('#otp-form');
    const input = backdrop.querySelector('#otp-input');
    const errorEl = backdrop.querySelector('#otp-error');

    function close(result) {
      backdrop.remove();
      resolve(result);
    }

    backdrop.querySelector('#otp-cancel').addEventListener('click', () => close(false));
    backdrop.addEventListener('click', (event) => {
      if (event.target === backdrop) {
        close(false);
      }
    });

    form.addEventListener('submit', (event) => {
      event.preventDefault();
      if (input.value.trim() !== window.GESHER_CONFIG.mockOtp) {
        errorEl.textContent = 'Неверный код подтверждения.';
        return;
      }
      close(true);
    });

    input.focus();
  });
}
