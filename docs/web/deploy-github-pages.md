# Deploy G.E.S.H.E.R. Web to GitHub Pages

## Overview

Combined static site deployed from `dist/gh-pages/`:

| Path | App |
|------|-----|
| `/` | Public citizen site (`apps/public_web/`) |
| `/staff/` | Staff portal (`apps/admin_web/`) |

Workflow: `.github/workflows/deploy-github-pages.yml`

## One-time GitHub setup

1. Push the repository to GitHub (`alexeyev-oleg/electronic-petitions`).
2. Open **Settings → Pages**.
3. Set **Source** to **GitHub Actions**.
4. Verify `basePath` in config files for project site:

```javascript
// apps/public_web/js/config.js
basePath: '/electronic-petitions',

// apps/admin_web/js/config.js
basePath: '/electronic-petitions/staff',
```

5. Push to `main`. The deploy workflow runs automatically.

## Live URLs (after deploy)

```text
https://alexeyev-oleg.github.io/electronic-petitions/
https://alexeyev-oleg.github.io/electronic-petitions/staff/
```

Staff login: `moderator@gesher.mock` / `staff123`

## Manual build (same as CI)

```bash
chmod +x scripts/prepare-github-pages.sh
./scripts/prepare-github-pages.sh
```

Output: `dist/gh-pages/`

## Local preview (combined)

```bash
chmod +x scripts/serve-github-pages-local.sh
./scripts/serve-github-pages-local.sh
```

- Public: http://127.0.0.1:4173/index.html
- Staff: http://127.0.0.1:4173/staff/index.html

## Per-app local preview

```bash
# Public only
cd apps/public_web && ./scripts/serve-local.sh

# Staff only
cd apps/admin_web && ./scripts/serve-local.sh
```

## Notes

- Mock `seed.json` is copied into both apps at build time from `shared/mock/`.
- Mobile APKs are separate artifacts; not hosted on GitHub Pages.
- Old workflow `deploy-admin-web.yml` replaced by combined deploy.
