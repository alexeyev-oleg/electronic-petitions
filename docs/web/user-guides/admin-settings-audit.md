# Admin Settings and Audit Log (Admin Web)

## Access

Sign in as `admin@gesher.mock` / `staff123` and open **Администрирование**.

## Sections

### Сотрудники

Read-only list of mock staff users from `shared/mock/seed.json`.

### Настройки

| Setting | Purpose |
|---------|---------|
| Режим обслуживания | Demo maintenance flag |
| Публичные инициативы | Gate for future public web (W2) |
| OTP для действий | Staff action confirmation |
| Подсказка mock OTP | Show `123456` in OTP dialog |
| Локаль по умолчанию | `ru`, `he`, `en`, `ar` |

Save and dangerous actions require OTP **`123456`**.

### Audit log

Shows sensitive staff actions from:
- W1.1 petitions moderation
- W1.2 complaints operator queue
- W1.3 enforcement oversight
- W1.4 settings and system actions

Filter by entity type: initiatives, complaints, enforcement, system.

## Danger zone

- **Сбросить mock-данные** — restores petitions, complaints, enforcement, settings, and audit log from seed (session kept).
- **Очистить audit log** — removes entries; a new system entry records the clear action.

## Persistence

Settings and audit log live in `gesher_mock_data` (`localStorage`). Bump seed version or use reset to return to defaults.
