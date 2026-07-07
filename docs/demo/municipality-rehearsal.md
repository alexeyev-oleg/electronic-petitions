# Municipality Demo Rehearsal (15 min)

Live mock demo script for G.E.S.H.E.R. without backend.

**Audience:** municipality leadership, operations staff  
**Duration:** ~15 minutes  
**Prerequisites:** GitHub Pages deployed, Resident + Inspector APKs (mock), staff browser session

## URLs

| Surface | URL |
|---------|-----|
| Public site | https://alexeyev-oleg.github.io/electronic-petitions/ |
| Staff portal | https://alexeyev-oleg.github.io/electronic-petitions/staff/ |
| Demo sync guide | https://alexeyev-oleg.github.io/electronic-petitions/demo-sync.html |

## Credentials (mock)

| Role | Login | Password | OTP |
|------|-------|----------|-----|
| Moderator | `moderator@gesher.mock` | `staff123` | `123456` |
| Operator | `operator@gesher.mock` | `staff123` | `123456` |
| Supervisor | `supervisor@gesher.mock` | `staff123` | `123456` |
| Inspector | `inspector@haifa.mock` | `inspector123` | `123456` |
| Resident | any mock signup | — | `123456` |

## Timeline

### 0:00 — Public story (2 min)

1. Open **public site** → hero + stats from shared seed.
2. **Инициативы** → show `p1` (park lighting) and `p3` (promenade) with cover previews.
3. Open `p3` detail → signature progress + official municipality response.
4. Explain: signing and complaints happen in the **mobile app** (mock beta).

### 2:00 — Resident journey (3 min)

1. Resident app → browse **petitions** `p1`, **complaints** `c2`, **enforcement** `e1`.
2. Create a local complaint or enforcement report (stays on device).
3. **Profile → Mock beta** → show import/export snapshot controls.

### 5:00 — Staff operations (4 min)

1. Staff portal → login as **moderator**.
2. **Petitions** → open `p2` → publish or request changes (OTP).
3. Switch to **operator** → **Complaints** → assign `c1` to department.
4. **Supervisor** → **Enforcement** → dispatch `e4` (OTP).

### 9:00 — Cross-client sync (3 min)

1. Staff → **Settings → Mock sync → Export JSON**.
2. Resident → **Import admin mock snapshot** → lists refresh.
3. Inspector → **Import admin snapshot** → triage shows updated `e4`.
4. Mention: public web reads bundled seed; staff export does not change the public catalog live.

### 12:00 — Inspector triage (2 min)

1. Inspector app → **Triage queue** → open `e4` (if still in triage) or skip to dispatch.
2. **Field dispatch** → open `e4` → **Start field visit** (OTP `123456`).
3. Record validated outcome (warning / fine / no action).
4. Show trust label and geo mismatch on `e2` if time allows.

### 14:00 — Close (1 min)

- Multilingual: RU / EN / HE / AR on web and mobile.
- Next step: backend identity + real queues (M0).
- Q&A.

## Backup plan

| Issue | Fix |
|-------|-----|
| Import fails (version) | Rebuild APK after `./scripts/sync-mobile-seed.sh` |
| Staff session lost | Re-login `*@gesher.mock` / `staff123` |
| Empty public initiatives | Check seed `settings.publicPetitionsEnabled` |
| Mobile offline lists | Toggle simulate load error off in Profile |

## Related

- `docs/web/mock-demo-sync.md`
- `docs/web/mock-platform.md`
