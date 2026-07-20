# Public Web (G.E.S.H.E.R. Citizen Site)

Static public site for residents — mock, no backend.

## Brand

- **G.E.S.H.E.R.** — terracotta `#C6643C`, graphite `#2B2B2B`
- Tagline: «Ваш голос. Ваш город.»

## Local run

```bash
cd apps/public_web
chmod +x scripts/*.sh
./scripts/serve-local.sh
```

Open: http://127.0.0.1:4174

## Locales

`ru`, `en`, `he`, `ar` with RTL for `he` and `ar`.

## Mock data

Read-only copy of `shared/mock/seed.json` (via `scripts/prepare-site.sh`).

## W2.0 — Foundation

- Hero, locales, stats from seed
- `docs/web/public-web-roadmap.md`

## W2.1 — Public initiatives

- `initiatives.html`, `initiative.html?id=p1`
- Guide: `docs/web/user-guides/public-initiatives.md`

## W2.2 — Info + GitHub Pages deploy

- `how-it-works.html`, `faq.html`
- Combined deploy: `./scripts/prepare-github-pages.sh`
- Docs: `docs/web/deploy-github-pages.md`

## W2.5 — Share + app-only registration

- Initiative share (Email / WhatsApp / Telegram) + QR
- Banner: registration only via mobile app
- Store buttons (stubs) on home, download, initiative detail
- Helpers: `js/app-cta.js`

## Related
