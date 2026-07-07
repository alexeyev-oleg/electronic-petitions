# G.E.S.H.E.R. — Electronic Petitions

Unified civic platform for **petitions**, **complaints**, and **municipal enforcement reports**.

**Tagline:** Your voice. Your city. · Ваш голос. Ваш город.

| | |
|---|---|
| **Status** | Mock beta — no backend required for demos |
| **Languages** | English, Hebrew, Russian, Arabic (RTL on web + mobile) |
| **Live demo** | https://alexeyev-oleg.github.io/electronic-petitions/ |
| **Staff portal** | https://alexeyev-oleg.github.io/electronic-petitions/staff/ |

## Monorepo layout

```
electronic-petitions/
├── apps/
│   ├── public_web/      # Citizen site (HTML/CSS/JS) — GitHub Pages root
│   ├── admin_web/       # Staff portal — deployed under /staff/
│   ├── resident_app/    # Flutter — petitions, complaints, enforcement (Android/iOS)
│   └── inspector_app/   # Flutter — triage + field dispatch (Android/iOS)
├── shared/
│   ├── mock/            # Canonical seed.json + demo media
│   └── content/         # Shared copy (FAQ, etc.)
├── docs/                # Architecture, roadmaps, user guides, demo scripts
├── scripts/             # Build, deploy, seed sync
└── dist/                # Local build output (APKs, gh-pages bundle)
```

## Quick start (mock demo)

### Public + staff web (local)

```bash
cd apps/public_web
./scripts/serve-local.sh
# http://127.0.0.1:4174

cd apps/admin_web
./scripts/serve-local.sh
# http://127.0.0.1:4175
```

Combined GitHub Pages bundle:

```bash
./scripts/prepare-github-pages.sh
```

### Resident app (mock APK)

```bash
cd apps/resident_app
flutter pub get
./scripts/build-mock-apk.sh
# dist/resident-app-mock-*.apk
```

### Inspector app (mock APK)

```bash
cd apps/inspector_app
flutter pub get
./scripts/build-inspector-apk.sh
```

### Sync shared data after seed changes

```bash
./scripts/sync-mobile-seed.sh
./scripts/sync-shared-content.sh
```

## Mock credentials

| Context | Login | Password | OTP |
|---------|-------|----------|-----|
| Resident signup | any valid email | ≥8 chars | `123456` |
| Moderator | `moderator@gesher.mock` | `staff123` | `123456` |
| Operator | `operator@gesher.mock` | `staff123` | `123456` |
| Supervisor | `supervisor@gesher.mock` | `staff123` | `123456` |
| Municipality staff | `staff@gesher.mock` | `staff123` | `123456` |
| Inspector | `inspector@haifa.mock` | `inspector123` | `123456` |

Full reference: `shared/mock/README.md`

## Demo rehearsal (15 min)

Script for municipality presentations:

- `docs/demo/municipality-rehearsal.md` — step-by-step live demo
- `docs/demo/municipality-deck.md` — 10-slide narrative (text)
- https://alexeyev-oleg.github.io/electronic-petitions/demo-sync.html — snapshot import guide

## Documentation map

| Area | Entry point |
|------|-------------|
| Delivery plan | `docs/delivery-roadmap.md` |
| Mock platform | `docs/web/mock-platform.md` |
| Resident app | `docs/mobile/resident-app-roadmap.md` |
| Inspector app | `docs/mobile/inspector-app-roadmap.md` |
| Public web | `docs/web/public-web-roadmap.md` |
| User guides | `docs/mobile/user-guides/`, `docs/web/user-guides/` |
| Backend (planned) | `docs/backend/architecture.md` |
| Infrastructure | `docs/infra/digitalocean-architecture.md` |
| FAQ (canonical) | `shared/content/faq.json` |
| Changelog | `CHANGELOG.md` |

## Clients at a glance

| Client | Role | Mock data |
|--------|------|-----------|
| Public web | Browse published initiatives, info pages | Read-only `seed.json` |
| Admin web | Moderation, queues, enforcement oversight | `localStorage` + export/import |
| Resident app | Create/sign petitions, complaints, reports | `SharedPreferences` + import |
| Inspector app | Triage + field dispatch | `SharedPreferences` + import |

Cross-client alignment uses **shared seed version** (`1.6.2`) and optional **JSON snapshot** export from staff portal.

## Brand

- Primary terracotta `#C6643C`, graphite `#2B2B2B`
- Mobile launcher icons: run `dart run flutter_launcher_icons` in each Flutter app after clone
- Details: `docs/mobile/branding.md`, `docs/mobile/design-system.md`

## Deploy to GitHub Pages

Push to `main` triggers `.github/workflows/deploy-github-pages.yml`, or run locally:

```bash
./scripts/prepare-github-pages.sh
./scripts/publish-to-github.sh   # requires gh auth
```

## What is not in mock beta

- Real backend API, SMS OTP, cloud media upload
- Live sync between devices (use export/import)
- Legally binding petition signatures
- Production KYC providers

Next engineering milestone: **M0** backend foundation — see `docs/delivery-roadmap.md`.

## License

Private / pilot — see repository owner for distribution terms.
