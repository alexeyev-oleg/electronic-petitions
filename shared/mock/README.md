# Shared Mock Data (W3.0 + W3.1)

Single source of truth for demo data across web and mobile clients.

## Files

| File | Purpose |
|------|---------|
| `seed.json` | Canonical mock entities and staff users |
| `mock-store.js` | Browser `localStorage` adapter for web clients |
| `media/` | Demo SVG previews for initiatives and entities |

## Entity IDs

| Prefix | Domain |
|--------|--------|
| `p*` | Petitions / initiatives |
| `c*` | Complaints |
| `e*` | Enforcement reports |
| `n*` | Resident notifications (seed) |
| `staff-*` | Admin portal users |

## Staff mock login

| Role | Email | Password |
|------|-------|----------|
| moderator | `moderator@gesher.mock` | `staff123` |
| operator | `operator@gesher.mock` | `staff123` |
| supervisor | `supervisor@gesher.mock` | `staff123` |
| municipality_staff | `staff@gesher.mock` | `staff123` |
| admin | `admin@gesher.mock` | `staff123` |

Protected staff actions OTP (mock): **`123456`**

## Storage keys

### Web

- `gesher_mock_seed_version` — loaded seed version
- `gesher_mock_data` — mutable copy of seed collections (includes `settings`, `auditLog`)
- `gesher_staff_session` — current staff session JSON

### Mobile (W3.1)

- `gesher_mock_seed_version` — last applied asset seed version
- `mock_petitions_v2`, `mock_complaints_v1`, `mock_enforcement_v2` — resident entities
- `mock_notifications_v1` — resident notifications
- `mock_inspector_triage_v1` — inspector triage queue

## Versioning

Bump `version` in `seed.json` when schema or seed content changes.

After bump:

```bash
./scripts/sync-mobile-seed.sh
```

Web clients reset local overrides when version mismatches. Mobile apps re-hydrate from `assets/mock/seed.json` on next read.

## Mobile asset sync

```bash
chmod +x scripts/sync-mobile-seed.sh
./scripts/sync-mobile-seed.sh
```

## Client adapters

See `docs/web/mock-platform.md` for export/import and cross-client demo flow.

Mobile import/export UI: `docs/web/mock-demo-sync.md`.

Demo rehearsal: `docs/demo/municipality-rehearsal.md`.

Shared FAQ: `shared/content/faq.json` — run `./scripts/sync-shared-content.sh` after edits.
