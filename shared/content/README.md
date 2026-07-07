# Shared Content

Canonical copy shared across web and mobile clients.

## Files

| File | Consumers | Surfaces |
|------|-----------|----------|
| `faq.json` | Public web `faq.html`, Resident app FAQ screen | `web`, `mobile` tags per item |

## Sync

After editing `faq.json`:

```bash
./scripts/sync-shared-content.sh
```

This copies into:

- `apps/public_web/content/faq.json`
- `apps/resident_app/assets/content/faq.json`

Public web `prepare-site.sh` also runs the sync script.

## Schema (`faq.json`)

```json
{
  "version": "1.0.0",
  "items": [
    {
      "id": "unique-id",
      "surfaces": ["web", "mobile"],
      "text": {
        "en": { "question": "...", "answer": "..." },
        "ru": { "question": "...", "answer": "..." }
      }
    }
  ]
}
```

Bump `version` when structure or meaning changes materially.
