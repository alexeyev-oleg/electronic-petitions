# Municipality Demo Deck (text)

10-slide narrative for G.E.S.H.E.R. mock beta presentations.  
Pair with live demo: `municipality-rehearsal.md`.

**Duration:** ~10 minutes talk + 15 minutes live demo  
**Audience:** municipality leadership, operations, legal, IT

---

## Slide 1 — Title

**G.E.S.H.E.R.**  
*Your voice. Your city.*

Electronic petitions, complaints, and enforcement — one civic platform.

- Mock beta today · production path documented
- Languages: EN / HE / RU / AR

---

## Slide 2 — The problem

Citizens use fragmented channels: paper petitions, phone hotlines, social media, ad-hoc forms.

Municipal staff lack a single queue, audit trail, and field coordination.

**Goal:** one trusted channel for residents, one operational surface for staff.

---

## Slide 3 — Three civic flows

| Flow | Resident | Municipality |
|------|----------|--------------|
| **Initiatives** | Create, sign, track | Moderate, publish official response |
| **Complaints** | Photo + location | Assign department, resolve |
| **Enforcement** | Report violation | Triage, dispatch inspector, record outcome |

Public site shows **published initiatives only**. Actions happen in the **mobile app**.

---

## Slide 4 — What you see today (mock beta)

| Surface | URL / artifact |
|---------|----------------|
| Public web | alexeyev-oleg.github.io/electronic-petitions/ |
| Staff portal | …/staff/ |
| Resident app | Mock APK (Android) |
| Inspector app | Mock APK (Android) |

No backend required for this demo. Data is **local** with optional **JSON snapshot** sync.

---

## Slide 5 — Resident journey

1. Onboarding v2 — G.E.S.H.E.R. brand, 5 slides, public web CTA
2. Browse petitions `p1`–`p3`, sign after mock KYC (OTP `123456`)
3. Submit complaint with media and map confirmation
4. Report enforcement violation with evidence
5. Inbox notifications → **deep link** to petition / complaint / report
6. Mock push simulation from Profile
7. Shared FAQ + contact feedback (local mock)

---

## Slide 6 — Staff operations

| Role | Demo action |
|------|-------------|
| Moderator | Dashboard KPI queues → publish `p2` (OTP); hotkeys `j`/`k`/`Enter` |
| Operator | Assign complaint `c1` to department |
| Supervisor | Dispatch enforcement `e4` |
| Municipality staff | Official response on published `p3` |
| All | Mock sync banner → export JSON for mobile import |

All roles: `*@gesher.mock` / `staff123` · Print-friendly petition/complaint cards

---

## Slide 7 — Field inspector

Inspector app (`inspector@haifa.mock`):

1. **Triage queue** — review trust, geo mismatch, evidence
2. **Dispatch queue** — start field visit (OTP)
3. Record validated outcome (warning / fine / no action)

Shared demo IDs `e1`–`e4` align with resident and admin data.

---

## Slide 8 — Cross-client sync

1. Staff changes state in browser portal
2. **Export JSON** snapshot
3. Resident / Inspector **import** on device
4. Lists refresh with same entity IDs

Public catalog reads bundled seed; staff export does not change the live public site.

Seed version: **1.6.2** · FAQ: `shared/content/faq.json`

---

## Slide 9 — Security and compliance (planned)

Current mock:

- Simplified email/password, mock OTP `123456`
- Signatures and submissions are **not legally binding**

Production path (documented):

- Phone verification, secure sessions, external KYC
- Step-up auth for petition signing
- Audit log, retention, role-based access
- Infrastructure on DigitalOcean (K8s, PostGIS, object storage)

---

## Slide 10 — Next steps

| Step | Outcome |
|------|---------|
| **Pilot feedback** | UX, process fit, branding approval on mock-v0.2.0 |
| **Optional captures** | Screenshots per `docs/demo/screenshots/README.md` |
| **Backend (later)** | Identity + petitions API when pilot scope is signed |
| **Pilot (M4)** | Limited staff + resident group on real data |
| **Public launch (M5)** | Full operations, monitoring, support |

**Ask:** which flow matters most for your municipality — initiatives, complaints, or enforcement?

---

## Appendix — Quick links

- Rehearsal script: `docs/demo/municipality-rehearsal.md`
- Pre-flight checklist: `docs/demo/live-demo-checklist.md`
- Root README: mock credentials and repo map
- Changelog: `CHANGELOG.md` (mock-v0.2.0)
- Screenshot checklist: `docs/demo/screenshots/README.md`
