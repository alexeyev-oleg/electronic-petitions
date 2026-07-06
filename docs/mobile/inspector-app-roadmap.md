# Inspector App Roadmap

## Purpose

Flutter mobile app for the `inspector` role:
- review enforcement trust score and evidence
- triage citizen reports
- dispatch field tasks
- record validated outcomes

First delivery is **mock-only** (no backend), aligned with the resident app beta approach.

## Stage Plan

### `I1` Scaffold and mock staff login (completed)
- new Flutter app at `apps/inspector_app`
- mock entrypoint `lib/main_mock.dart`
- civic inspector theme and app shell
- mock staff login with persisted session
- home workspace with navigation to triage
- localization baseline (`en`, `he`, `ru`, `ar`)

Exit criteria:
- inspector can sign in with mock credentials and reach a home shell
- session survives app restart until sign out

### `I2` Triage queue (completed)
- mock enforcement triage queue with seed reports (`e1`, `e2`, `e3`)
- status filters: all, triage, review required
- trust filters: all, standard, low geo confidence
- report detail with location, trust, geo mismatch banner, and evidence preview

Exit criteria:
- inspector can browse filtered queue and open report evidence locally

### `I3` Inspector actions (completed)
- triage actions: invalid, merge, dispatch field task
- validated outcomes: warning, fine, no action (after dispatch)
- staff OTP confirmation sheet (`123456` in mock mode)
- action notes persisted in mock store with updated status

Exit criteria:
- inspector can close or advance a report locally with auditable confirmation UX

### `I4` Docs and APK polish (completed)
- inspector triage user guide
- inspector APK build guide
- shared mock demo data doc aligned with resident enforcement seed (`e1`–`e3`)
- resident enforcement seed updated with `e3` for cross-app demo parity

Exit criteria:
- inspector mock workflow is documented end-to-end
- APK build path and credentials are documented

## Mock Credentials

| Field | Value |
|-------|-------|
| Email | `inspector@haifa.mock` |
| Password | `inspector123` |
| Action OTP | `123456` |

## Screen Inventory

- splash
- staff login
- inspector home
- triage queue
- triage report detail (actions + evidence)

## Related Docs

- `docs/mobile/user-guides/inspector-triage.md`
- `docs/mobile/build-inspector-apk.md`
- `docs/mobile/mock-demo-data.md`
