# Enforcement Oversight (Admin Web)

## Who can do what

| Role | Actions |
|------|---------|
| supervisor, admin | Dispatch field task, mark invalid, merge case, resolve geo, record validated outcome |
| admin | Reopen closed report to triage |

Protected actions require OTP **`123456`** in mock mode.

## Workflow

1. Sign in as `supervisor@gesher.mock` / `staff123`.
2. Open **Нарушения** on the dashboard.
3. Use filters: Триаж, Проверка гео, В поле, Закрытые.
4. Click a row to open enforcement detail.
5. Apply oversight action and confirm with OTP.

## Demo report IDs

| ID | Status | Use case |
|----|--------|----------|
| e1 | triage | dispatch field task |
| e2 | review_required | resolve geo mismatch with manual address |
| e3 | triage | merge or mark invalid |
| e4 | dispatch_task | validated outcome (warning / fine / no action) |

## Alignment with Inspector App

Mobile inspector (`inspector@haifa.mock`) performs field triage on the same IDs `e1`–`e4`. Admin web provides supervisor oversight layer in mock mode.

## Persistence

Changes save to browser `localStorage` via `gesher_mock_data`. Clear site data to reset to `shared/mock/seed.json` v1.3.0.
