# Live Demo Checklist

Pre-flight list before a municipality presentation.  
**Release:** `mock-v0.2.0` · **Seed:** `1.6.2` · **No backend required**

## 1 day before

- [ ] GitHub Pages deploy green (Actions: Deploy + Quality gates)
- [ ] Public site opens: https://alexeyev-oleg.github.io/electronic-petitions/
- [ ] Staff portal opens: https://alexeyev-oleg.github.io/electronic-petitions/staff/
- [ ] Demo sync page: …/demo-sync.html shows seed `1.6.2`
- [ ] Resident mock APK built (`apps/resident_app/scripts/build-mock-apk.sh`)
- [ ] Inspector mock APK built (`apps/inspector_app/scripts/build-inspector-apk.sh`)
- [ ] APKs installed on demo devices / emulators
- [ ] Browser: staff login tested (`moderator@gesher.mock` / `staff123`)

## 1 hour before

- [ ] Clear staff `localStorage` or **reset mock data** if you need a fresh seed state
- [ ] Resident app: Profile → **Simulate list load error** = OFF
- [ ] Resident app: language set (RU recommended for Haifa demo)
- [ ] Inspector app: import not required unless rehearsing cross-sync
- [ ] Laptop: disable sleep, notifications, auto-lock
- [ ] Second screen or projector resolution checked (1280×800 minimum)
- [ ] Print rehearsal script: `docs/demo/municipality-rehearsal.md`

## Staff portal (W1.5)

- [ ] Dashboard shows **Очереди (mock KPI)** for logged-in role
- [ ] Moderator: petition list — try `j` / `k` / `Enter` keyboard navigation
- [ ] **Mock sync** banner at bottom links to public demo-sync page
- [ ] Petition `p2` detail — **Печать** button works (print preview)

## Resident app (R7)

- [ ] Onboarding: 5 slides, G.E.S.H.E.R. brand on slide 1
- [ ] Petition `p3`: signature progress bar visible
- [ ] Inbox: tap notification → deep link opens petition/complaint/report
- [ ] Profile → **Simulate push** shows SnackBar with Open action
- [ ] Help → FAQ loads from shared `faq.json`
- [ ] Help → Contact / feedback form saves locally

## Inspector app (I6)

- [ ] Home shows **Queue overview** KPI chips
- [ ] Help → FAQ (OTP, triage, dispatch, sync)
- [ ] Triage queue shows `e1`–`e4`
- [ ] Dispatch queue: `e4` dispatch task with supervisor note
- [ ] OTP `123456` for field actions

## Cross-sync rehearsal (optional segment)

- [ ] Admin → Settings → Export JSON
- [ ] Resident → Import admin snapshot
- [ ] Inspector → Import admin snapshot
- [ ] Explain: public web catalog does **not** change from export

## Backup kit

| Problem | Fix |
|---------|-----|
| Import version error | Rebuild APK after `./scripts/sync-mobile-seed.sh` |
| Empty initiatives on web | Check `settings.publicPetitionsEnabled` in seed |
| Staff locked out | Re-login `*@gesher.mock` / `staff123` |
| Flutter crash on device | Use freshly built mock APK from `dist/` |

## After the demo

- [ ] Collect UX feedback (petitions vs complaints vs enforcement priority)
- [ ] Note branding / language / process questions
- [ ] Backend (M0) only when municipality approves pilot scope

## Related

- [15 min script](municipality-rehearsal.md)
- [10-slide narrative](municipality-deck.md)
- [Screenshot capture list](screenshots/README.md)
