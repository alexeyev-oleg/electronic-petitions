function renderAboutPage() {
  document.getElementById('about-title').textContent = t('aboutTitle');
  document.getElementById('about-text').textContent = t('aboutText');
}

window.onPublicLocaleChange = () => {
  renderAboutPage();
};

document.addEventListener('DOMContentLoaded', () => {
  initPublicShell();
  renderAboutPage();
});
