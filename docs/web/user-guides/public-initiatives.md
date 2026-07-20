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

## Signing and registration

- Web is **read-only** for signatures and accounts.
- Banner on initiative + download pages: registration and actions happen **only in the mobile app**.
- CTA: **Подписать в приложении** / Download → Resident App mock beta.
- Google Play / App Store buttons are **stubs** until store listings exist (open `download.html#stores`).

## Sharing

On `initiative.html?id=…`:
- Email / WhatsApp / Telegram
- Copy link
- Show / hide QR (points at the same public URL)

Mobile Resident app has the same share + QR on petition detail.

## Admin gate

If `settings.publicPetitionsEnabled` is `false` in seed (or admin disables it in portal), the catalog shows a disabled message.
