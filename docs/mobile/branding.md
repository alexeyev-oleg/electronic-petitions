# G.E.S.H.E.R. Mobile Branding

Unified brand identity for resident and inspector Flutter apps, aligned with the public web platform.

## Brand Name
**G.E.S.H.E.R.** — displayed on splash screens, auth headers, and home-screen labels.

Tagline (localized): **«Ваш голос. Ваш город.»** / *Your voice. Your city.*

## Colors
| Token | Hex | Usage |
|-------|-----|--------|
| Terracotta | `#C6643C` | Primary actions, accents, active status |
| Graphite | `#2B2B2B` | Titles, splash background, launcher adaptive bg |
| Secondary | `#00897B` | Complaints / secondary accents |
| Surface muted | `#F4F7FB` | Screen background |
| Text muted | `#64748B` | Secondary body text |

Defined in:
- `apps/resident_app/lib/app/theme/app_colors.dart`
- `apps/inspector_app/lib/app/theme/app_colors.dart`

## Logo Mark
`GesherBrandMark` widget (`lib/core/widgets/gesher_brand_mark.dart`):
- Stylized **G** with terracotta dot
- Wordmark **G.E.S.H.E.R.**
- Optional tagline and inspector badge

Used on splash screens and `AppBrandHeader` (resident auth/about).

## Typography
Material 3 text theme via `AppTheme.build()` — graphite headlines, terracotta primary buttons.

## Launch / Splash
- In-app splash: graphite background + `GesherBrandMark` (inverted)
- Android native launch: `@color/launch_background` (`#2B2B2B`)

## App Labels
| App | Android / iOS label |
|-----|---------------------|
| Resident | `G.E.S.H.E.R.` |
| Inspector | `G.E.S.H.E.R. Inspector` |

## Launcher Icons
1. **Official design:** `/Users/duck/Pictures/Projects/gesher/` (brand guide + mobile mockup)
2. Master PNG: `shared/brand/app_icon_master.png` (cropped **G.** mini-version from brand guide)
3. Sync: `python3 scripts/generate-gesher-app-icon.py`
4. Apply to Android: `python3 scripts/apply-android-launcher-icons.py`
5. Build scripts run sync automatically before `flutter build apk`

## Beta Banner
Mock/dev flavors show a corner banner with flavor name (`MOCK`, etc.).

## Design System Reference
See `docs/mobile/design-system.md` for component inventory.
