/**
 * Site config — update basePath for GitHub Project Pages.
 * Example: '/electronic-petitions' when repo is username.github.io/electronic-petitions
 */
window.GESHER_CONFIG = {
  basePath: '/electronic-petitions/staff',
  mockOtp: '123456',
  brandName: 'G.E.S.H.E.R.',
  brandTagline: 'Ваш голос. Ваш город.',
  githubUser: 'alexeyev-oleg',
  githubRepo: 'electronic-petitions',
};

function assetPath(relativePath) {
  const base = window.GESHER_CONFIG.basePath || '';
  const normalized = relativePath.startsWith('/') ? relativePath : `/${relativePath}`;
  return `${base}${normalized}`;
}

function pagePath(page) {
  return assetPath(page);
}

function publicSitePath(page) {
  const base = window.GESHER_CONFIG.basePath || '';
  const root = base.replace(/\/staff\/?$/, '');
  const normalized = page.startsWith('/') ? page : `/${page}`;
  return `${root}${normalized}`;
}
