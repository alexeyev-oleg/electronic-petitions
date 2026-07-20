/**
 * Public site config — update basePath for GitHub Project Pages.
 */
window.GESHER_PUBLIC_CONFIG = {
  basePath: '/electronic-petitions',
  githubUser: 'alexeyev-oleg',
  githubRepo: 'electronic-petitions',
  staffPortalPath: '/staff/index.html',
  mockAppLinks: {
    // Store stubs until Play / App Store listings exist — both open download instructions.
    android: '/download.html#stores',
    ios: '/download.html#stores',
    browser: '/initiatives.html',
    googlePlayStub: true,
    appStoreStub: true,
  },
};

(function resolveLocalPublicBasePath() {
  const host = window.location.hostname;
  if (host !== 'localhost' && host !== '127.0.0.1') {
    return;
  }
  const path = window.location.pathname;
  const projectRoot = '/electronic-petitions';
  if (path.includes(projectRoot)) {
    window.GESHER_PUBLIC_CONFIG.basePath = projectRoot;
    return;
  }
  const dir = path.replace(/\/[^/]*$/, '');
  window.GESHER_PUBLIC_CONFIG.basePath = dir === '/' ? '' : dir;
})();

function assetPath(relativePath) {
  const base = window.GESHER_PUBLIC_CONFIG.basePath || '';
  const normalized = relativePath.startsWith('/') ? relativePath : `/${relativePath}`;
  return `${base}${normalized}`;
}

function pagePath(page) {
  return assetPath(page);
}
