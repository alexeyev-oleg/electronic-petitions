# Changelog

All notable mock-beta releases for the G.E.S.H.E.R. monorepo.

Format follows [Keep a Changelog](https://keepachangelog.com/). Versions track **demo milestones**, not production semver.

## [Unreleased]

### Added
- **Resident app:** share petition via Email / WhatsApp / Telegram; QR code sheet with public initiative link (`qr_flutter`)
- **Public web (W2.5):** share + QR on initiative detail; «registration only in mobile app» banner; Google Play / App Store **stub** buttons → `download.html#stores`
- Shared public helpers: `apps/public_web/js/app-cta.js`

### Changed
- Public nav includes Download; download page leads with app-only registration + store stubs
- Android package visibility queries for `mailto` / HTTPS share targets
- Launcher icon synced from official design folder `/Users/duck/Pictures/Projects/gesher/` (brand guide mini **G.**)

## [mock-v0.2.0] — 2026-07-07

### Added
- **R7** Resident app polish v2: petition signature progress, inbox deep links, mock push simulation, onboarding v2 with public web CTA, contact/feedback screen
- **P4 / W2.4** Public web: `about`, `contact`, `privacy`, `download` pages; Open Graph meta; `robots.txt`, `sitemap.xml`
- **B1** G.E.S.H.E.R. mobile branding (terracotta palette, splash, launcher icon scaffold)
- **I5** Inspector field dispatch queue with OTP outcomes
- **W3.3** Municipality demo rehearsal script, demo-sync page, resident export snapshot
- Shared seed **1.6.2** with notification `deepLink` fields
- Root `README.md`, `CHANGELOG.md`, shared `faq.json`, municipality deck

### Changed
- Resident onboarding expanded to 5 slides with brand mark
- Public web footer links to legal and download pages
- Mobile seed sync script copies canonical `shared/mock/seed.json`

## [mock-v0.1.2] — 2026-07-06

### Added
- Inspector triage mock app (`apps/inspector_app`)
- Admin web enforcement oversight and complaint operator queues
- Public initiatives catalog with cover previews
- Resident petition attachments (photos + documents, max 5)
- Secure auth migration scaffold (KYC, phone OTP, step-up signing)
- GitHub Pages deploy workflow and publish scripts

### Changed
- Shared mock seed versioning and cross-client entity IDs (`p*`, `c*`, `e*`, `n*`)
- Resident app persists mock data across restarts

## [mock-v0.1.1] — 2026-07-05

### Added
- Resident app complaints and enforcement modules with media + geolocation
- Notifications inbox and profile mock beta settings
- Public web hero, locales, and how-it-works / FAQ pages
- Admin web petition moderation shell

## [mock-v0.1.0] — 2026-07-04

### Added
- Monorepo skeleton: Flutter resident app, public web, documentation baseline
- Mock repositories and localization (en/he/ru/ar)
- Architecture, data model, and delivery roadmap docs

[mock-v0.2.0]: https://github.com/alexeyev-oleg/electronic-petitions/compare/mock-v0.1.2...main
[mock-v0.1.2]: https://github.com/alexeyev-oleg/electronic-petitions/compare/mock-v0.1.1...mock-v0.1.2
[mock-v0.1.1]: https://github.com/alexeyev-oleg/electronic-petitions/compare/mock-v0.1.0...mock-v0.1.1
[mock-v0.1.0]: https://github.com/alexeyev-oleg/electronic-petitions/commit/f0ce425
