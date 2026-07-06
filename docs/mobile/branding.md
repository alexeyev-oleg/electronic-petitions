# Resident App Branding (Beta)

This is interim civic branding for UX review, not final municipality identity.

## Colors
| Token | Hex | Usage |
|-------|-----|--------|
| Primary | `#0057B8` | App bar, splash, civic accents |
| Primary dark | `#003D82` | Text on light info banners |
| Secondary | `#00897B` | Complaints tile accent |
| Surface muted | `#F4F7FB` | Screen background |

Defined in `apps/resident_app/lib/app/theme/app_colors.dart`.

## Typography
Material 3 text theme via `AppTheme.build()` — headline for screen titles, titleSmall for cards.

## Launch / Splash
- In-app splash: civic blue background + account balance icon (`SplashScreen`)
- Android native launch: `@color/launch_background` (`#0057B8`)

## App Label
- Android manifest label: `Resident App`
- iOS display name: `Resident App`

## Launcher Icon (TODO for municipality)
Replace default Flutter launcher icons before public release:
1. Prepare 1024×1024 master icon
2. Use `flutter_launcher_icons` or design tool export
3. Update Android `mipmap-*` and iOS `AppIcon.appiconset`

## Beta Banner
Mock/dev flavors show a corner banner with flavor name (`MOCK`, etc.).

## Design System Reference
See `docs/mobile/design-system.md` for component inventory.
