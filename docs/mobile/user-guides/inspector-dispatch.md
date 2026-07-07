# Inspector Field Dispatch (I5)

Guide for the **Field dispatch** queue in the Inspector app (mock beta).

## Purpose

After supervisor dispatches a report (`dispatch_task`), inspectors use this queue to:

1. Start a field visit (`field_in_progress`)
2. Record a validated outcome (warning, fine, or no action)

Demo report: **`e4`** — illegal sidewalk trading.

## Sign in

| Field | Value |
|-------|-------|
| Email | `inspector@haifa.mock` |
| Password | `inspector123` |
| Action OTP | `123456` |

## Open dispatch queue

1. Home → **Open field dispatch queue** (or **Полевые задачи**).
2. Use filters:
   - **Assigned** — `dispatch_task` (e.g. `e4`)
   - **In field** — `field_in_progress`
   - **Completed** — `validated_*`

## Field task detail

Shows location, trust level, action note, and **supervisor note** (`oversightNote` from seed).

### Actions (OTP required)

| Action | Result status |
|--------|----------------|
| Start field visit | `field_in_progress` |
| Record warning | `validated_warning` |
| Record fine | `validated_fine` |
| Close with no action | `validated_no_action` |

## Sync with Admin Web

1. Supervisor dispatches `e4` in staff portal (Enforcement).
2. Export mock snapshot from **Settings → Mock sync**.
3. Inspector → Home → **Import admin snapshot**.
4. Dispatch queue shows updated `e4`.

## Related

- `docs/mobile/user-guides/inspector-triage.md`
- `docs/demo/municipality-rehearsal.md`
- `docs/web/mock-demo-sync.md`
