# Resident App Design System

## Purpose
This document defines the first UI/UX baseline for the resident mobile app.
It is intended for beta builds without backend dependency and can later be aligned with municipality branding.

## Design Principles
- civic and trustworthy, not playful
- high readability in 4 languages
- RTL-safe layouts for Hebrew and Arabic
- clear status communication for petitions, complaints, and enforcement reports
- mobile-first spacing and touch targets

## Brand Direction
### Product positioning
Electronic petitions and municipal services for residents: petitions, complaints, violation reporting, notifications.

### Visual tone
- professional municipal service
- clean surfaces
- strong hierarchy
- minimal decorative elements

### Logo mark (beta)
Until an official municipality logo is approved, the app uses a civic icon mark:
- icon: `account_balance_outlined`
- container: rounded square with primary tint background

## Color System
| Token | Hex | Usage |
|------|-----|-------|
| Primary | `#0057B8` | main actions, civic identity |
| Primary dark | `#003D82` | titles, app bar text |
| Secondary | `#00897B` | secondary actions, complaints accent |
| Surface muted | `#F4F7FB` | screen background |
| Outline | `#D7E0EA` | card borders, input borders |

### Status colors
| Meaning | Hex | Example statuses |
|--------|-----|------------------|
| Pending / review | `#F59E0B` | draft, moderation, triage |
| Active / submitted | `#2563EB` | published, submitted, in progress |
| Success | `#059669` | resolved, approved |
| Warning / rejected | `#DC2626` | rejected, failed |
| Neutral | `#64748B` | fallback |

## Typography
System fonts are used in beta:
- Android: Roboto
- iOS: SF Pro

Hierarchy:
- `headlineSmall` — screen hero / brand title
- `titleMedium` — section headers
- `titleSmall` — card titles
- `bodyLarge` — primary content
- `bodyMedium` — secondary content
- `labelLarge` — chips and compact labels

## Spacing
| Token | Value |
|------|-------|
| xxs | 4 |
| xs | 8 |
| sm | 12 |
| md | 16 |
| lg | 24 |
| xl | 32 |

Form max width: `420`

## Core Components
Implemented in `apps/resident_app/lib/core/widgets/`:
- `AppBrandHeader` — civic logo mark + title
- `AppSectionCard` — grouped settings/content card
- `AppFeatureTile` — home navigation tile with icon
- `AppListItemCard` — list item with status chip
- `AppStatusChip` — colored workflow status
- `AppInfoBanner` — beta/mock notices

Theme tokens live in:
- `lib/app/theme/app_colors.dart`
- `lib/app/theme/app_spacing.dart`
- `lib/app/theme/app_theme.dart`

## Screen Patterns
### Authentication
- centered form card
- brand header above form
- beta chip inside form card
- icon-prefixed inputs

### Home
- resident greeting / account context
- info banner for mock mode
- feature tiles with semantic icon colors

### Lists
- card-based list items
- status chip under subtitle
- floating actions via app bar icons

### Profile
- section cards for account, language, notifications

## RTL / LTR Rules
- use `AlignmentDirectional` instead of left/right alignment where possible
- chevrons flip in RTL on feature tiles
- Material localization delegates remain enabled for he/ar
- manual QA required for Hebrew and Arabic on:
  - auth form
  - home tiles
  - create/report forms

## Beta Environment Indicator
Mock flavor shows a diagonal banner via `MaterialApp.builder`.
Banner text comes from environment display name (`MOCK`, etc.).

## Out of Scope for D1
- official municipality logo asset
- Figma source files
- dark mode
- custom font family
- map UI styling
- motion/animation system

## Next Design Steps
1. replace beta icon mark with approved municipality logo
2. add splash and onboarding visual system
3. extend components for media blocks and map confirmation
4. run Hebrew/Arabic visual QA on all primary flows
