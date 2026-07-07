/**
 * Public site config — update basePath for GitHub Project Pages.
 */
window.GESHER_PUBLIC_CONFIG = {
  basePath: '/electronic-petitions',
  githubUser: 'alexeyev-oleg',
  githubRepo: 'electronic-petitions',
  staffPortalPath: '/staff/index.html',
  mockAppLinks: {
    android: '/download.html',
    ios: '/download.html',
    browser: '/initiatives.html',
  },
};

function assetPath(relativePath) {
  const base = window.GESHER_PUBLIC_CONFIG.basePath || '';
  const normalized = relativePath.startsWith('/') ? relativePath : `/${relativePath}`;
  return `${base}${normalized}`;
}

function pagePath(page) {
  return assetPath(page);
}
