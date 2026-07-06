# Public Initiatives (Citizen Site)

## What is shown

Only initiatives with status **`published`** from `shared/mock/seed.json`.

Draft, moderation, and rejected initiatives are hidden from the public catalog.

## Pages

| Page | URL |
|------|-----|
| List | `initiatives.html` |
| Detail | `initiative.html?id=p1` |

## Demo IDs

| ID | Notes |
|----|-------|
| p1 | published, collecting signatures |
| p3 | published, with official municipality response |

## Signing

Web is read-only for signatures. Use **Подписать в приложении** CTA → Resident App mock beta.

## Admin gate

If `settings.publicPetitionsEnabled` is `false` in seed (or admin disables it in portal), the catalog shows a disabled message.
