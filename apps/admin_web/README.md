# Admin Web (G.E.S.H.E.R. Staff Portal)

Static staff portal for municipal operations (mock, no backend).

## Brand

- **G.E.S.H.E.R.** — terracotta `#C6643C`, graphite `#2B2B2B`
- Tagline: «Ваш голос. Ваш город.»

## Local run

```bash
cd apps/admin_web
chmod +x scripts/*.sh
./scripts/serve-local.sh
```

Open: http://127.0.0.1:4173

## Mock staff login

| Role | Email | Password |
|------|-------|----------|
| moderator | `moderator@gesher.mock` | `staff123` |
| operator | `operator@gesher.mock` | `staff123` |
| supervisor | `supervisor@gesher.mock` | `staff123` |
| municipality_staff | `staff@gesher.mock` | `staff123` |
| admin | `admin@gesher.mock` | `staff123` |

Protected actions OTP: `123456` (petition moderation, W1.1+)

## W1.1 — Petition moderation

- Filters and clickable petition list (moderator role)
- Detail page: `petition.html?id=p2`
- Actions: publish, reject, request changes, official response
- Guide: `docs/web/user-guides/petition-moderation.md`

## W1.2 — Complaint operator queue

- Filters and clickable complaint list (operator role)
- Detail page: `complaint.html?id=c1`
- Actions: assign department, resolve, return to triage (supervisor)
- Guide: `docs/web/user-guides/complaint-operator-queue.md`

## W1.3 — Enforcement oversight

- Filters and clickable enforcement list (supervisor role)
- Detail page: `enforcement.html?id=e2`
- Actions: dispatch, geo resolve, invalid, merge, validated outcomes
- Guide: `docs/web/user-guides/enforcement-oversight.md`

## W1.4 — Admin settings + audit

- Staff directory, portal settings, audit log UI (admin role)
- Guide: `docs/web/user-guides/admin-settings-audit.md`

## GitHub Pages

Combined deploy with public site. Staff portal path: `/staff/`.

Set in `js/config.js`:

```js
basePath: '/electronic-petitions/staff',
```

See `docs/web/deploy-github-pages.md`

## Shared mock

Source: `shared/mock/seed.json` (copied by `scripts/prepare-site.sh`)
