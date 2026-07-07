# Resident App Roadmap

## Purpose
This document defines the delivery roadmap for the first mobile product:
- one Flutter app for `Android + iOS`
- first target role: `resident`
- beta authentication with `email + password`
- later transition to secure registration and KYC

## Product Strategy
### Current priority
- build the `Resident App` first
- postpone dedicated role apps for:
  - inspector
  - supervisor
  - municipality staff
  - admin

### Why this order
- resident flows are the highest-volume product surface
- the resident app validates UX for:
  - onboarding
  - petitions
  - complaints
  - enforcement reports
- camera, media, geodata, localization, and notifications can be validated early

## Role Roadmap
### Phase 1
- `Resident App`

### Phase 2
- `Inspector App` as a separate operational mobile product if field workflows require it

### Phase 3
- internal municipality roles stay primarily in web/admin unless later mobile use cases prove necessary

## Release Model
### `B0` Prototype
- no real backend dependency required
- mock data only
- validate navigation and basic UI states

### `B1` Test/Beta
- `email + password`
- optional email verification
- no secure KYC yet
- core resident features under mock API or partial backend

### `B2` Functional Beta
- connect to selected real backend endpoints
- keep authentication simplified
- validate real media and geodata flows

### `R1` Secure Release Preparation
- enable secure registration path
- add phone verification and/or KYC
- tighten session and evidence handling

### `R2` Public Release
- resident app connected to production backend
- secure auth live
- monitoring and support processes active

## Beta Authentication Strategy
### For test/beta
- `email + password`
- recommended addition: email verification before allowing content submission

### Secure auth later
- phone verification
- secure sessions
- external KYC
- step-up auth for petition signing and sensitive actions

### Important product rule
- in beta, petition signature should be considered `test-only` or disabled as legally binding
- complaint and enforcement flows may be tested without KYC, but should be clearly marked as test environment behavior

## Resident App Scope
### Included in first mobile product
- app shell
- onboarding
- login and registration
- profile and preferences
- petitions
- complaints
- municipal enforcement reports
- notifications and history

### Deferred if needed
- advanced offline sync
- community discussion/forum
- deep analytics views
- appeal workflows

## Major Implementation Milestones
### `R0` Foundation
- Flutter project setup
- environment flavors
- routing
- theme system
- localization
- RTL/LTR support
- mock API layer

Exit criteria:
- app boots on Android and iOS
- locale switching works for `en/he/ru/ar`
- navigation shell is stable

### `R1` Authentication and profile
- beta auth with `email + password`
- forgot password
- session persistence
- profile basics
- notification preferences

Exit criteria:
- user can register, log in, log out
- auth state persists correctly
- profile and settings are reachable

### `R2` Petitions
- petition list
- filters and search
- petition detail
- create petition draft
- signature CTA placeholder or beta flow
- petition status/history view

Exit criteria:
- user can browse and create petition content
- localized petition UI works in all supported languages

### `R3` Complaints
- create complaint flow
- photo/video attach
- geolocation capture
- manual address input
- complaint history and detail
- status tracking

Exit criteria:
- user can submit complaint with mock or real media references
- geo capture and manual correction UX works

### `R4` Enforcement reports
- report violation flow
- media capture
- geodata mismatch UX
- evidence review before submit
- report history and statuses

Exit criteria:
- user can create enforcement report
- mismatch address logic is represented in UX

### `R5` Notifications and polish
- inbox
- push notification scaffolding
- empty, loading, and error states
- accessibility review
- basic analytics and crash reporting hooks

Exit criteria:
- end-to-end resident journeys feel coherent
- major UX gaps are closed

### `B2` Device capabilities (current)
- real camera and gallery attachment on complaints and enforcement flows
- device geolocation capture with Haifa-region mismatch heuristic
- manual address required when geo confidence is low
- beta docs updated for media and location behavior

Exit criteria:
- user can attach photos and capture location on Android/iOS
- geo mismatch UX is testable without backend

### `D1` UI/UX design baseline (completed)
- civic color system and typography hierarchy
- reusable UI components for auth, home, lists, and profile
- RTL-safe navigation tiles
- design system documentation in `docs/mobile/design-system.md`

Exit criteria:
- app no longer uses raw default Material list screens for primary journeys
- design tokens and components are documented and implemented in Flutter

### `D2` App shell and onboarding (completed)
- splash screen with bootstrap routing
- first-launch onboarding carousel
- language selection during onboarding
- help, FAQ, and about screens
- persistent onboarding state via shared preferences

Exit criteria:
- first launch shows onboarding once
- returning users go directly to auth
- help content is reachable from profile

### `D3` Beta auth polish (completed)
- secure session persistence with flutter_secure_storage
- email and password form validation
- mock email verification state after sign-up
- splash restores session before auth screen

Exit criteria:
- user stays signed in after app restart
- invalid auth input is blocked with localized messages
- sign-up shows pending email verification notice

### `D4` Media and geo polish (completed)
- shared `MediaAttachment` model for photos and videos
- reusable media editor, gallery, and map preview components
- location confirmation screen before complaint submit and enforcement review
- video capture from camera and gallery on complaints and enforcement flows
- detail screens show status chips, map preview, and media gallery
- iOS microphone permission for video recording
- localized strings for media and location confirmation in en/he/ru/ar

Exit criteria:
- user can attach photos and videos on Android/iOS
- location is confirmed on a map preview before submit
- detail screens show media and geo context

### `D5` Mock maturity (completed)
- persist mock data across app restarts via SharedPreferences JSON store
- consistent loading, empty, and error states on main list screens
- richer mock fixtures for petitions and notifications
- beta profile toggle to simulate list load errors and test retry UX

Exit criteria:
- created complaints and reports survive app restart in mock mode
- empty, loading, and error states are visible on main lists

### `R6` Secure auth migration (completed)
- extended resident identity model with phone, KYC, and session tier fields
- phone verification flow with mock OTP and secure session upgrade
- KYC entry screen with mock document/selfie capture and approval path
- sensitive action confirmation sheet for protected actions
- gated petition signing behind KYC approval and step-up OTP
- profile and home surfaces for secure verification status

Exit criteria:
- beta auth migration path exists
- secure onboarding is testable without rewriting app structure

### `R7` Resident polish v2 (completed)
- petition detail shows signature progress, goal, and signed state with accessibility semantics
- richer in-app FAQ (petition signing, notifications, contact, public web)
- contact and feedback screen with email and public web links (`url_launcher`)
- notification inbox deep links to petition, complaint, and enforcement detail routes
- mock push simulation from profile (SnackBar with open action)
- onboarding v2: G.E.S.H.E.R. brand mark on welcome slide, fifth slide with public web CTA
- shared seed `1.6.2` with notification `deepLink` fields

Exit criteria:
- demo path covers signing UX, help/contact, and notification navigation without backend
- onboarding introduces brand and public web companion site

### `U9` Documentation and demo assets (completed)
- root `README.md` with monorepo map, credentials, and quick start
- `CHANGELOG.md` for mock release milestones (v0.1.x–v0.2.0)
- canonical `shared/content/faq.json` synced to public web and resident FAQ
- `docs/demo/municipality-deck.md` — 10-slide presentation narrative
- `docs/demo/screenshots/README.md` — capture checklist per client

Exit criteria:
- new contributors onboard from README in under 30 minutes
- FAQ has a single source for web and mobile surfaces

### `P1` Resident polish without backend (completed)
- push notification scaffold with mock device token in profile
- analytics and crash reporting hooks (mock/no-op via environment flags)
- accessibility semantics on primary navigation cards
- petitions search and status filters
- civic Android launch splash color
- expanded FAQ and user guides (petitions, notifications, troubleshooting)
- iOS build and branding documentation

Exit criteria:
- resident app demo path is complete without backend dependencies
- remaining gaps are documented for inspector/staff clients or backend integration

### `PF` Petition attachments without backend (completed)
- petition model stores up to 5 attachments (photos + PDF/Word/Excel)
- create petition flow with camera, gallery, and file picker (no video)
- petition detail shows photo previews and document list
- mock seed includes sample attachments on demo petitions
- user guide updated for attachment rules and limits

Exit criteria:
- residents can attach and review petition evidence locally without backend
- attachment limits and supported formats are documented

### Mobile companion: Inspector App mock (completed — see `docs/mobile/inspector-app-roadmap.md`)
- separate Flutter app for staff triage (`apps/inspector_app`)
- shared demo enforcement IDs `e1`–`e3` with resident seed
- documented in `docs/mobile/user-guides/inspector-triage.md`

## Screen Inventory
### Core app shell
- splash
- locale selection
- onboarding carousel
- auth landing
- sign up
- login
- forgot password

### Resident account
- profile
- preferences
- notification settings
- language selection
- about/help

### Petitions
- petitions list
- petition detail
- create petition
- my petitions

### Complaints
- complaints list
- complaint detail
- create complaint
- camera/media picker
- location confirmation

### Enforcement
- enforcement list
- report violation
- evidence review
- map/address confirmation

### Support screens
- inbox
- FAQ
- contact/help

## Technical Sequencing
### Build first
- app shell
- localization
- auth scaffolding
- mock repository layer

### Then
- petitions
- complaints
- enforcement

### Then
- notifications
- settings
- documentation and polish

### Then
- secure auth migration

## Mock API Strategy
### Before backend is ready
- use repository interfaces
- provide mock implementations from local JSON or in-memory fixtures
- simulate statuses, errors, loading states, and delayed responses

### Benefits
- UI can progress independently
- UX can be tested before backend completion
- app can be demoed early

### Rule
- the app must never couple screens directly to transport or hardcoded HTTP logic
- all data must flow through repositories or service abstractions

## Data and State Strategy
Recommended approach:
- one source of truth per feature
- feature state isolated by module
- optimistic UI only where safe
- clear separation between:
  - presentation state
  - domain models
  - remote/mock sources

## Quality Gates
### Before beta demo
- all key resident screens exist
- locale switching works
- no broken navigation
- no critical crash in main journeys

### Before functional beta
- real or semi-real media flow works
- geodata flow works
- status persistence is consistent

### Before secure rollout
- KYC migration path approved
- petition signature rules aligned with backend security model

## Parallel Documentation Rule
User-facing documentation must be written in parallel with the app, not after it.

For each major milestone:
- update feature usage guide
- update screenshots or UI notes
- update FAQ

### `Q1` CI quality gates (completed)
- GitHub Actions workflow `.github/workflows/quality.yml`
- `scripts/ci-check-js.sh` — `node --check` for web + shared JS
- `scripts/ci-smoke-pages.sh` — `prepare-github-pages.sh` artifact smoke test
- `flutter analyze` matrix for resident and inspector apps (no APK build in CI)
- deploy workflow paths include `shared/content/**`

Exit criteria:
- PRs and pushes to main run automated lint/smoke without manual steps
- local developers can reproduce checks with documented scripts

## Next Recommended Execution Stage
If we move from planning to execution, start with:
1. **M0.2** — `services/api/` Go skeleton (`docs/backend/m0-foundation-plan.md`)

### `M0` Backend foundation (in progress)
- **M0.1** integration plan — `docs/backend/m0-foundation-plan.md` (completed)
- **M0.2–M0.7** skeleton, local stack, migrations, health API, backend CI, DOKS baseline (pending)

Exit criteria (full M0): see `docs/backend/m0-foundation-plan.md`
