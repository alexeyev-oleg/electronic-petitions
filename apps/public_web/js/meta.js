function gesherSiteUrl(relativePath = '/index.html') {
  const base = window.GESHER_PUBLIC_CONFIG?.basePath || '';
  const path = relativePath.startsWith('/') ? relativePath : `/${relativePath}`;
  return `${window.location.origin}${base}${path}`;
}

function defaultOgImageUrl() {
  return gesherSiteUrl('/media/p1-park-lighting.svg');
}

function upsertMeta(attr, name, content) {
  if (!content) {
    return;
  }

  let element = document.head.querySelector(`meta[${attr}="${name}"]`);
  if (!element) {
    element = document.createElement('meta');
    element.setAttribute(attr, name);
    document.head.appendChild(element);
  }
  element.content = content;
}

function setPageMeta({
  title,
  description,
  imageUrl,
  type = 'website',
  canonicalPath,
}) {
  if (title) {
    document.title = title;
  }

  const canonical = canonicalPath ? gesherSiteUrl(canonicalPath) : window.location.href;
  const image = imageUrl || defaultOgImageUrl();

  upsertMeta('name', 'description', description);
  upsertMeta('property', 'og:title', title);
  upsertMeta('property', 'og:description', description);
  upsertMeta('property', 'og:type', type);
  upsertMeta('property', 'og:url', canonical);
  upsertMeta('property', 'og:image', image);
  upsertMeta('property', 'og:site_name', 'G.E.S.H.E.R.');
  upsertMeta('name', 'twitter:card', 'summary_large_image');
  upsertMeta('name', 'twitter:title', title);
  upsertMeta('name', 'twitter:description', description);
  upsertMeta('name', 'twitter:image', image);

  let canonicalLink = document.head.querySelector('link[rel="canonical"]');
  if (!canonicalLink) {
    canonicalLink = document.createElement('link');
    canonicalLink.rel = 'canonical';
    document.head.appendChild(canonicalLink);
  }
  canonicalLink.href = canonical;
}
