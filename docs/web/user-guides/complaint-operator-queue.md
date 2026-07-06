# Complaint Operator Queue (Admin Web)

## Who can do what

| Role | Actions |
|------|---------|
| operator, supervisor, admin | Assign department, mark resolved |
| supervisor, admin | Return complaint to triage |

Protected actions require OTP **`123456`** in mock mode.

## Workflow

1. Sign in as `operator@gesher.mock` / `staff123`.
2. Open **Жалобы** on the dashboard.
3. Use filters: Триаж, В работе, Решённые.
4. Click a row to open complaint detail.
5. Assign to a department or close with resolution note.
6. Confirm with OTP.

## Demo complaint IDs

| ID | Status | Use case |
|----|--------|----------|
| c1 | triage | assign to department (e.g. lighting) |
| c2 | in_progress | mark resolved |
| c3 | resolved | view closed case; supervisor can reopen |

## Departments (mock)

- Санитарная служба (`sanitation`)
- Освещение и электросети (`lighting`)
- Дорожная служба (`roads`)
- Парки и скверы (`parks`)

## Persistence

Changes save to browser `localStorage` via `gesher_mock_data`. Clear site data to reset to `shared/mock/seed.json` v1.2.0.
