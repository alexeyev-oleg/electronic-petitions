# Admin Web Roadmap (G.E.S.H.E.R. Staff Portal)

## Purpose

HTML/CSS/JS staff portal for municipal roles:
- moderator, operator, supervisor, municipality_staff, admin

Brand: **G.E.S.H.E.R.** — terracotta `#C6643C`, graphite `#2B2B2B`.

## Stage Plan

### `W3.0` Shared mock schema (completed)
- `shared/mock/seed.json` canonical demo data
- `shared/mock/mock-store.js` browser adapter
- staff users, petitions, complaints, enforcement, stats

### `W1.0` Admin foundation (completed)
- `apps/admin_web/` static scaffold
- G.E.S.H.E.R. design tokens and logo treatment
- staff login with role-based dashboard modules
- GitHub Pages workflow and deploy docs

Exit criteria:
- staff can sign in and see role-appropriate queues from shared seed
- site deploys to GitHub Pages

### `W1.1` Petitions module (completed)
- petition list filters: all, draft, moderation, published, rejected
- petition detail page with signature progress
- moderator actions: publish, reject, request changes (OTP `123456`)
- municipality staff: official response on published petitions
- audit log entries in shared mock store
- seed extended with `p4` draft and `officialResponse` fields

### `W1.2` Complaints module (completed)
- complaint list filters: all, triage, in progress, resolved
- complaint detail page with location and operator notes
- operator actions: assign department, resolve (OTP `123456`)
- supervisor: return complaint to triage
- seed extended with `c3` resolved and operator fields

### `W1.3` Enforcement oversight (completed)
- enforcement list filters: all, triage, geo review, dispatch, closed
- detail page with trust score, geo mismatch banner
- supervisor actions: dispatch, invalid, merge, geo resolve, validated outcomes (OTP `123456`)
- admin: reopen closed reports to triage
- seed extended with `e4` dispatch_task and oversight fields

### `W1.4` Admin settings + audit (completed)
- staff users directory (read-only mock view)
- portal settings toggles persisted in localStorage
- audit log UI with entity filters
- admin actions: save settings, reset mock data, clear audit log (OTP `123456`)
- seed v1.4.0 with `settings` and sample audit entries

## Related

- `docs/web/deploy-github-pages.md`
- `shared/mock/README.md`
- `apps/admin_web/README.md`
