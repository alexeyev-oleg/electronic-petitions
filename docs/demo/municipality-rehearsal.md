# Municipality Demo Rehearsal (15 min) — v2

Live mock demo script for G.E.S.H.E.R. without backend.  
Aligned with **mock-v0.2.0**, seed **1.6.2**, Admin **W1.5**, Resident **R7**.

**Audience:** municipality leadership, operations staff  
**Duration:** ~15 minutes  
**Prerequisites:** GitHub Pages deployed, Resident + Inspector APKs (mock), staff browser session

## URLs

| Surface | URL |
|---------|-----|
| Public site | https://alexeyev-oleg.github.io/electronic-petitions/ |
| About / Contact / Download | …/about.html · …/contact.html · …/download.html |
| Staff portal | https://alexeyev-oleg.github.io/electronic-petitions/staff/ |
| Demo sync guide | https://alexeyev-oleg.github.io/electronic-petitions/demo-sync.html |

## Credentials (mock)

| Role | Login | Password | OTP |
|------|-------|----------|-----|
| Moderator | `moderator@gesher.mock` | `staff123` | `123456` |
| Operator | `operator@gesher.mock` | `staff123` | `123456` |
| Supervisor | `supervisor@gesher.mock` | `staff123` | `123456` |
| Municipality staff | `staff@gesher.mock` | `staff123` | `123456` |
| Inspector | `inspector@haifa.mock` | `inspector123` | `123456` |
| Resident | any mock signup | — | `123456` |

## Timeline

### 0:00 — Public story (2 min)

1. Open **public site** → hero + platform stats.
2. **Инициативы** → `p1` (park lighting) and `p3` (promenade) with cover previews.
3. Open `p3` → signature progress + **official municipality response** (OG meta if sharing link).
4. Mention **About**, **Contact**, **Download APK** in footer — citizen site is shareable externally.
5. Signing and complaints happen in the **mobile app** (mock beta).

### 2:00 — Resident journey (3 min)

1. **Onboarding** — G.E.S.H.E.R. brand, 5 slides, last slide links to public website.
2. Browse **petitions** `p1`, **complaints** `c2`, **enforcement** `e1`.
3. Open `p3` → signature progress → sign after mock KYC (OTP `123456`).
4. **Inbox** → tap notification → deep link to related item.
5. **Profile** → **Simulate push** → SnackBar **Open** action.
6. **Help → FAQ** (shared with public site) and **Contact / feedback**.

### 5:00 — Staff operations (4 min)

1. Staff portal → login as **moderator**.
2. Dashboard **Очереди (mock KPI)** — live counts from current mock store.
3. **Petitions** list — keyboard `j` / `k`, `Enter` to open row (optional wow moment).
4. Open `p2` → publish or request changes (OTP `123456`).
5. **Печать** on petition detail — print-friendly card for meeting notes.
6. Switch to **operator** → assign complaint `c1`.
7. **Supervisor** → dispatch enforcement `e4` (OTP).
8. **Municipality staff** → official response on published `p3` if time allows.

### 9:00 — Cross-client sync (3 min)

1. Point to dashboard **Mock sync** banner → public demo-sync instructions.
2. Staff → **Admin → Settings → Mock sync → Export JSON**.
3. Resident → **Profile → Import admin mock snapshot**.
4. Inspector → **Import admin snapshot** → dispatch/triage reflects `e4`.
5. Clarify: public web reads **bundled seed**; staff export does not change the public catalog live.

### 12:00 — Inspector field (2 min)

1. **Home** → queue KPI overview (triage / dispatch counts).
2. **Triage queue** → `e4` or geo mismatch on `e2`.
3. **Help → FAQ** if asked about OTP or mock sync.
4. **Field dispatch** → `e4` → **Start field visit** (OTP).
5. Record validated outcome (warning / fine / no action).

### 14:00 — Close (1 min)

- Multilingual: RU / EN / HE / AR on web and mobile.
- **mock-v0.2.0** complete for UX pilot — backend when municipality approves scope.
- Q&A.

## Backup plan

| Issue | Fix |
|-------|-----|
| Import fails (version) | Rebuild APK after `./scripts/sync-mobile-seed.sh` |
| Staff session lost | Re-login `*@gesher.mock` / `staff123` |
| Empty public initiatives | Check seed `settings.publicPetitionsEnabled` |
| Mobile list error | Profile → turn off **Simulate list load error** |
| KPI shows zeros | Reset mock data or refresh after seed import |

## Pre-flight

Use `docs/demo/live-demo-checklist.md` the day before the meeting.

## Related

- `docs/demo/municipality-deck.md`
- `docs/demo/live-demo-checklist.md`
- `docs/web/mock-demo-sync.md`
- `docs/web/mock-platform.md`
