# Mock Platform (W3)

Cross-client mock data strategy for G.E.S.H.E.R. demo without backend.

## Canonical source

| File | Role |
|------|------|
| `shared/mock/seed.json` | Single schema + demo entities |
| `shared/mock/mock-store.js` | Web mutable store (`localStorage`) |

Current seed version: see `version` field in `seed.json` (e.g. `1.6.0`).

## Client adapters (W3.1)

| Client | Adapter | Storage |
|--------|---------|---------|
| Admin Web | `GesherMockStore` | `gesher_mock_data`, `gesher_mock_seed_version` |
| Public Web | `loadPublicSeed()` read-only fetch | none (stateless) |
| Resident App | `SharedSeedBridge` + `MockLocalStore` | `SharedPreferences` + `gesher_mock_seed_version` |
| Inspector App | `SharedSeedBridge` + `MockLocalStore` | `SharedPreferences` + `gesher_mock_seed_version` |

## Version sync

When `seed.json` `version` changes:

1. **Web** — `GesherMockStore.readData()` resets `gesher_mock_data` from bundled seed.
2. **Mobile** — on next read, `MockLocalStore` compares `gesher_mock_seed_version` with asset bundle and re-hydrates entity lists from `assets/mock/seed.json`.

Run after every seed bump:

```bash
./scripts/sync-mobile-seed.sh
```

This copies `shared/mock/seed.json` into:

- `apps/resident_app/assets/mock/seed.json`
- `apps/inspector_app/assets/mock/seed.json`

## Entity parity

| Prefix | IDs (demo) | Resident | Inspector | Admin | Public |
|--------|------------|----------|-----------|-------|--------|
| `p*` | p1–p4 | yes | — | yes | published only |
| `c*` | c1–c3 | yes | — | yes | — |
| `e*` | e1–e4 | yes | yes | yes | — |
| `n*` | n1–n3 | yes | — | — | — |

## Admin export / import (demo bridge)

In **Администрирование → Настройки → Mock sync**:

1. **Экспорт JSON** — downloads `gesher_mock_snapshot` file with full `gesher_mock_data`.
2. **Импорт JSON** — replaces browser store (OTP required). Version must match current seed.

Use case: copy staff portal state from one machine/browser to another for demo rehearsals.

## Mobile import (W3.2)

Export from Admin Web, then import on device:

| App | Location |
|-----|----------|
| Resident | Profile → Mock beta settings → Import / **Export** admin mock snapshot |
| Inspector | Home → Mock sync → Import admin snapshot |

See `docs/web/mock-demo-sync.md` for format and demo script.

## End-to-end demo script

1. Resident app — browse `p1`, create complaint (local).
2. Admin web — moderate petition, assign complaint `c1`.
3. Inspector app — triage `e4`.
4. Public web — verify published initiatives `p1`, `p3`.
5. Admin — export JSON snapshot.
6. Resident / Inspector — import snapshot to align with staff portal changes.

Live auto-sync between clients on one device is **not** implemented. Clients align on **seed version**, **entity IDs**, and optional **file import**.

## W3.2 (completed)

- [x] Unified notification seed (`n1`–`n3`)
- [x] `MockSnapshotImporter` on Resident + Inspector
- [x] Admin export → mobile import UI
- [x] `docs/web/mock-demo-sync.md`

## W3.3 (completed)

- [x] `docs/demo/municipality-rehearsal.md` — 15 min demo script
- [x] Public `demo-sync.html` + home mock beta banner (seed version)
- [x] Resident `MockSnapshotExporter` (export JSON)
- [x] Demo media previews in `shared/mock/media/` (seed `coverImage`)
- [x] Seed v1.6.0

## Related

- `shared/mock/README.md`
- `docs/mobile/mock-demo-data.md`
- `docs/web/deploy-github-pages.md`
