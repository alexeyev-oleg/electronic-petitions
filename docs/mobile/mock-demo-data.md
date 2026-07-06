# Shared Mock Demo Data

Demo entities shared across Resident, Inspector, Admin, and Public web clients.

## Canonical file

`shared/mock/seed.json` — bump `version` when content changes, then run:

```bash
./scripts/sync-mobile-seed.sh
```

## Entity map

| ID | Domain | Resident | Inspector | Admin | Public |
|----|--------|----------|-----------|-------|--------|
| p1–p4 | Petitions | yes | — | yes | p1, p3 published |
| c1–c3 | Complaints | yes | — | yes | — |
| e1–e4 | Enforcement | yes | yes | yes | — |
| n1–n3 | Notifications | yes | — | — | — |

## Enforcement demo path

1. Resident — browse `e1`–`e4` in violation reports.
2. Inspector — triage queue shows same IDs (after W3.1 seed sync).
3. Admin — supervisor oversight on `e2`, `e4`.
4. Inspector OTP for actions: `123456`.

## Storage keys

| Client | Key / mechanism |
|--------|-----------------|
| Resident | `gesher_mock_seed_version` + entity keys |
| Inspector | `gesher_mock_seed_version` + `mock_inspector_triage_v1` |
| Admin Web | `gesher_mock_data` via `mock-store.js` |
| Public Web | read-only `mock/seed.json` fetch |

Full reference: `docs/web/mock-platform.md`

## Cross-client sync (W3.2)

Admin Web can export `gesher_mock_snapshot` JSON. Import on mobile:

- **Resident** — Profile → Mock beta settings
- **Inspector** — Home → Mock sync

See `docs/web/mock-demo-sync.md`.

## Not in scope
