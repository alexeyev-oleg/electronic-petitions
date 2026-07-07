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
1. Master icon: `assets/brand/app_icon.png` (1024×1024)
2. Regenerate: `python3 scripts/generate-gesher-app-icon.py`
3. Apply to platforms: `dart run flutter_launcher_icons` in each app directory

## Beta Banner
Mock/dev flavors show a corner banner with flavor name (`MOCK`, etc.).

## Design System Reference
See `docs/mobile/design-system.md` for component inventory.
