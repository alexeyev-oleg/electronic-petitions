# Public Web Roadmap (G.E.S.H.E.R. Citizen Site)

## Purpose

Static public site for residents and guests:
- browse published initiatives
- learn how petitions, complaints, and enforcement work
- CTA to mobile app (mock beta)

Brand: **G.E.S.H.E.R.** — terracotta `#C6643C`, graphite `#2B2B2B`.

## Stage Plan

### `W2.0` Foundation (completed)
- `apps/public_web/` scaffold
- G.E.S.H.E.R. hero, header/footer, locale switcher, RTL
- Home stats from shared seed (read-only)
- CTA: download app / open in browser (mock links)
- `about.html` stub, nav placeholders for W2.1–W2.2

### `W2.1` Public initiatives (completed)
- published initiatives list with category filters
- initiative detail: signature progress, official response, status stepper
- «Sign in app» CTA (no web signing in mock beta)
- respects `settings.publicPetitionsEnabled` from seed

### `W2.2` Info pages + deploy (completed)
- how it works (petitions / complaints / violations flows)
- FAQ with mock beta guidance
- combined GitHub Pages deploy: public `/`, staff `/staff/`
- `scripts/prepare-github-pages.sh`, `deploy-github-pages.yml`

### `W2.3` Demo platform (completed)
- `demo-sync.html` — import/export guide for mock rehearsals
- Home mock beta banner with seed version + staff link
- Initiative cover previews from `shared/mock/media/`
- `docs/demo/municipality-rehearsal.md`

### `W2.4` Public polish (completed)
- expanded `about.html` — mission, roles, mock beta disclaimer
- `contact.html` + `privacy.html` stubs (4 languages)
- `download.html` — APK build instructions + QR code
- Open Graph / Twitter meta via `js/meta.js`
- `robots.txt`, `sitemap.xml` for GitHub Pages
- footer legal links; CTA → `download.html`
- removed unused `js/placeholder.js`

## Related

- `apps/public_web/README.md`
- `shared/mock/README.md`
- `docs/web/deploy-github-pages.md`
