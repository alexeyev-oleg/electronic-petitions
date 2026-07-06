# Petition Moderation (Admin Web)

## Who can do what

| Role | Actions |
|------|---------|
| moderator, supervisor, admin | Publish, reject, request changes |
| municipality_staff, admin | Save official municipality response (published only) |

Protected actions require OTP **`123456`** in mock mode.

## Workflow

1. Sign in as `moderator@gesher.mock` / `staff123`.
2. Open **Инициативы** on the dashboard.
3. Use filters: Черновики, На модерации, Опубликованные, Отклонённые.
4. Click a row to open petition detail.
5. Apply moderation or official response action.
6. Confirm with OTP.

## Demo petition IDs

| ID | Status | Use case |
|----|--------|----------|
| p2 | moderation_review | publish / reject / request changes |
| p4 | draft | send to moderation path |
| p1, p3 | published | official response (staff@gesher.mock) |

## Persistence

Changes save to browser `localStorage` via `gesher_mock_data`. Clear site data to reset to `shared/mock/seed.json` v1.1.0.
