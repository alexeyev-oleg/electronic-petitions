/**
 * Shared CTA helpers: app-only registration banner, store stubs, share + QR.
 */

function storeLink(platform) {
  const links = window.GESHER_PUBLIC_CONFIG.mockAppLinks || {};
  const path = platform === 'ios' ? links.ios : links.android;
  return pagePath(path || '/download.html');
}

function renderAppOnlyRegistrationBanner() {
  return `
    <aside class="app-only-banner" role="note">
      <strong>${t('appOnlyRegistrationTitle')}</strong>
      <p>${t('appOnlyRegistrationText')}</p>
      <div class="store-buttons">
        <a class="btn btn--primary store-btn" href="${storeLink('android')}">${t('storeGooglePlay')}</a>
        <a class="btn btn--secondary store-btn" href="${storeLink('ios')}">${t('storeAppStore')}</a>
      </div>
      <p class="info-note">${t('storeLinksStubNotice')}</p>
    </aside>`;
}

function renderStoreButtonsPanel() {
  return `
    <section class="detail-panel">
      <h2>${t('storeLinksTitle')}</h2>
      <p>${t('storeLinksIntro')}</p>
      <div class="store-buttons">
        <a class="btn btn--primary store-btn" href="${storeLink('android')}">${t('storeGooglePlay')}</a>
        <a class="btn btn--secondary store-btn" href="${storeLink('ios')}">${t('storeAppStore')}</a>
      </div>
      <p class="info-note">${t('storeLinksStubNotice')}</p>
    </section>`;
}

function renderQrForUrl(pageUrl, label, hint) {
  const qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=220x220&data=${encodeURIComponent(pageUrl)}`;
  return `
    <div class="download-qr">
      <img src="${qrUrl}" width="220" height="220" alt="${label}" loading="lazy" />
      <p>${hint}</p>
      <code class="download-url">${pageUrl}</code>
    </div>`;
}

function renderShareActions(pageUrl, title) {
  const text = `${title}\n\n${pageUrl}`;
  const emailHref = `mailto:?subject=${encodeURIComponent(title)}&body=${encodeURIComponent(text)}`;
  const waHref = `https://wa.me/?text=${encodeURIComponent(text)}`;
  const tgHref = `https://t.me/share/url?url=${encodeURIComponent(pageUrl)}&text=${encodeURIComponent(title)}`;

  return `
    <section class="detail-panel">
      <h2>${t('shareInitiativeTitle')}</h2>
      <p>${t('shareInitiativeHint')}</p>
      <div class="share-actions">
        <a class="btn btn--secondary" href="${emailHref}">${t('shareViaEmail')}</a>
        <a class="btn btn--secondary" href="${waHref}" target="_blank" rel="noopener noreferrer">${t('shareViaWhatsApp')}</a>
        <a class="btn btn--secondary" href="${tgHref}" target="_blank" rel="noopener noreferrer">${t('shareViaTelegram')}</a>
        <button type="button" class="btn btn--secondary" id="copy-initiative-link">${t('copyInitiativeLink')}</button>
      </div>
      <div class="initiative-qr-wrap" id="initiative-qr-panel" hidden>
        ${renderQrForUrl(pageUrl, t('initiativeQrLabel'), t('initiativeQrHint'))}
      </div>
      <button type="button" class="btn btn--primary" id="toggle-initiative-qr" style="margin-top:var(--space-md);">
        ${t('showInitiativeQr')}
      </button>
    </section>`;
}

function bindInitiativeShareControls(pageUrl) {
  const copyBtn = document.getElementById('copy-initiative-link');
  const toggleBtn = document.getElementById('toggle-initiative-qr');
  const qrPanel = document.getElementById('initiative-qr-panel');

  if (copyBtn) {
    copyBtn.addEventListener('click', async () => {
      try {
        await navigator.clipboard.writeText(pageUrl);
        copyBtn.textContent = t('initiativeLinkCopied');
        setTimeout(() => {
          copyBtn.textContent = t('copyInitiativeLink');
        }, 1600);
      } catch {
        window.prompt(t('copyInitiativeLink'), pageUrl);
      }
    });
  }

  if (toggleBtn && qrPanel) {
    toggleBtn.addEventListener('click', () => {
      const willShow = qrPanel.hidden;
      qrPanel.hidden = !willShow;
      toggleBtn.textContent = willShow ? t('hideInitiativeQr') : t('showInitiativeQr');
    });
  }
}
