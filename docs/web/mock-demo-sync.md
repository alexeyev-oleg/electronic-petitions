# Mock Demo Sync (W3.2)

File-based bridge between Admin Web and mobile apps for demo rehearsals.

## Snapshot format

```json
{
  "format": "gesher_mock_snapshot",
  "seedVersion": "1.5.0",
  "exportedAt": "2026-07-06T12:00:00.000Z",
  "data": { }
}
```

- `format` must be `gesher_mock_snapshot`
- `seedVersion` must match the mobile asset bundle (`assets/mock/seed.json`) and Admin Web bundled seed
- `data` is the full `gesher_mock_data` object (petitions, complaints, enforcement, notifications, settings, auditLog)

## Export (Admin Web)

1. Sign in as staff (`*@gesher.mock` / `staff123`).
2. Open **Администрирование → Настройки → Mock sync**.
3. Click **Экспорт JSON** — saves `gesher-mock-*.json`.

## Import (Admin Web)

Same section → **Импорт JSON**. OTP `123456` required. Replaces browser `localStorage` store.

## Import (Resident App)

1. Profile → **Mock beta settings**.
2. **Import admin mock snapshot** — pick exported JSON.
3. Petitions, complaints, enforcement, and notifications reload from snapshot.

## Import (Inspector App)

1. Home → **Mock sync (W3.2)** card.
2. **Import admin snapshot** — pick exported JSON.
3. Triage queue reloads from enforcement rows in snapshot.

## Version mismatch

If import fails, run `./scripts/sync-mobile-seed.sh` after seed bump and rebuild mobile apps so `seedVersion` matches the exported file.

## Demo script (cross-client)

1. Admin — moderate `p2`, assign `c1`, update `e4`.
2. Admin — export JSON.
3. Resident — import snapshot → see updated petition/complaint/enforcement.
4. Inspector — import same file → triage queue reflects `e4` changes.
5. Public web — still reads bundled seed (published initiatives only); not affected by admin export.

## Related

- `docs/web/mock-platform.md`
- `shared/mock/README.md`
