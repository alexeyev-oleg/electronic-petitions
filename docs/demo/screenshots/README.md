# Demo Screenshots & UI Notes

Capture checklist for municipality decks, README, and user guides.  
**Canonical FAQ:** `shared/content/faq.json` (not duplicated here).

## How to capture

| Platform | Command / tool |
|----------|----------------|
| Android emulator | `flutter run --target lib/main_mock.dart`, then device screenshot |
| Android device | Power + Volume down |
| Public web | Browser DevTools → device toolbar (375×812) |
| Staff portal | Desktop 1280×800, login as `moderator@gesher.mock` |

Store files under `docs/demo/screenshots/<client>/` using the naming below.  
Prefer **PNG**, light theme, locale **RU** or **EN** unless the guide specifies otherwise.

---

## Public web (`public/`)

| File | Screen | Notes |
|------|--------|-------|
| `public-home-ru.png` | `index.html` | Hero, stats from seed, terracotta brand |
| `public-initiatives-ru.png` | `initiatives.html` | Cards `p1`, `p3` with cover previews |
| `public-initiative-detail-p3.png` | `initiative.html?id=p3` | Signature bar + municipality response |
| `public-about-en.png` | `about.html` | Mission + mock beta disclaimer |
| `public-download-ru.png` | `download.html` | App-only registration banner + store stubs + APK QR |

---

## Staff portal (`staff/`)

| File | Screen | Notes |
|------|--------|-------|
| `staff-login.png` | `/staff/index.html` | G.E.S.H.E.R. staff branding |
| `staff-petitions-queue.png` | Petitions list | Filter tabs, `p2` in review |
| `staff-petition-detail-p2.png` | Petition detail | Moderation actions |
| `staff-complaints-assign.png` | Complaints | Operator assign on `c1` |
| `staff-enforcement-dispatch.png` | Enforcement | Supervisor dispatch `e4` |
| `staff-mock-sync.png` | Settings → Mock sync | Export JSON button visible |

---

## Resident app (`resident/`)

| File | Screen | Route / path |
|------|--------|--------------|
| `resident-splash.png` | Splash | `GesherBrandMark` + tagline |
| `resident-onboarding-brand.png` | Onboarding slide 1 | Brand mark + language picker |
| `resident-home.png` | Home | Feature tiles |
| `resident-petition-detail-p3.png` | Petition detail | Progress bar, **Share + QR**, signed state |
| `resident-petition-share.png` | Share sheet | Email / WhatsApp / Telegram |
| `resident-petition-qr.png` | QR sheet | Public initiative link QR |
| `resident-petition-signed.png` | Petition detail | «Вы подписали эту петицию» |
| `resident-complaint-create.png` | Create complaint | Media + map step |
| `resident-enforcement-create.png` | Create violation report | `/enforcement/create` |
| `resident-inbox-deeplink.png` | Inbox | Notification with link icon |
| `resident-profile-mock-sync.png` | Profile | Push scaffold + simulate push |
| `resident-faq.png` | Help → FAQ | Loaded from `faq.json` |
| `resident-contact-feedback.png` | Help → Contact | Mock feedback form |
| `resident-about.png` | About | Brand mark + version |

Build: `./apps/resident_app/scripts/build-mock-apk.sh`

---

## Inspector app (`inspector/`)

| File | Screen | Notes |
|------|--------|-------|
| `inspector-home-kpi.png` | Home | Queue KPI chips + brand header |
| `inspector-help-faq.png` | Help / FAQ | Inspector FAQ screen |
| `inspector-home.png` | Home | Triage + dispatch entry points |
| `inspector-triage-e4.png` | Triage detail | Trust label, evidence |
| `inspector-dispatch-queue.png` | Dispatch list | Filters assigned / in field |
| `inspector-dispatch-outcome.png` | Dispatch detail | Outcome action sheet |

Build: `./apps/inspector_app/scripts/build-inspector-apk.sh`

---

## Status

### Resident (captured from device, RU/EN) — 25 files

| File | Screen / этап |
|------|----------------|
| `resident-splash.png` | Сплэш — этап 1 |
| `resident-onboarding-brand.png` | Онбординг слайд 1 + язык — этап 1 |
| `resident-auth-login.png` | Вход (пусто) — этап 2 |
| `resident-auth-login-filled.png` | Вход с email — этап 2 |
| `resident-home.png` | Главная — этап 3 |
| `resident-petitions-list.png` | Список петиций |
| `resident-petition-detail-p1.png` | Карточка `p1` |
| `resident-petition-detail-p3.png` | Карточка `p3` + Share/QR |
| `resident-petition-share.png` | Шторка Share |
| `resident-petition-qr.png` | Шторка QR |
| `resident-phone-verify.png` | Подтверждение телефона — этап 4 |
| `resident-phone-verify-otp.png` | Телефон + OTP `123456` — этап 4 |
| `resident-kyc-after-phone.png` | KYC после телефона — этап 4 |
| `resident-kyc.png` | KYC документ + симуляции — этап 4 |
| `resident-petition-detail-sign.png` | Петиция, кнопка «Подписать» — этап 4 |
| `resident-petition-sign-otp.png` | OTP при подписи — этап 4 |
| `resident-petition-signed.png` | «Вы подписали» — этап 4 |
| `resident-complaint-create.png` | Создать жалобу — этап 5 |
| `resident-location-confirm.png` | Подтверждение локации — этап 5 |
| `resident-enforcement-create.png` | Создать сообщение о нарушении — этап 5 |
| `resident-inbox-deeplink.png` | Входящие — этап 5 |
| `resident-profile-mock-sync.png` | Профиль / simulate push — этап 6 |
| `resident-faq.png` | FAQ — этап 6 |
| `resident-contact-feedback.png` | Контакты — этап 6 |
| `resident-about.png` | О приложении — этап 6 |

Still useful to capture: _(none for resident — checklist complete)._

### Public / Staff / Inspector

**Public captured:** `public-home-ru.png`, `public-initiatives-ru.png`, `public-initiative-detail-p3.png`, `public-about-en.png`, `public-download-ru.png`.

Staff / Inspector folders still empty. Before the next municipality meeting, run through `docs/demo/live-demo-checklist.md`.

## Related

- `docs/demo/README.md` — demo materials index
- `docs/demo/live-demo-checklist.md` — pre-flight
- `docs/demo/municipality-deck.md` — slide narrative
- `docs/demo/municipality-rehearsal.md` — 15 min live script (v2)
- `docs/mobile/branding.md` — colors and launcher icons
