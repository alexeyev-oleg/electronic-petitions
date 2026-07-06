# Resident App Architecture

## Purpose
This document defines the recommended Flutter architecture for the first mobile app:
- one codebase
- Android and iOS
- resident role first
- beta auth now, secure auth later

## Technical Goals
- fast UI iteration before backend is fully ready
- strict separation between UI and data sources
- easy switch from mock API to real backend
- strong support for multilingual and RTL/LTR behavior
- easy future migration to secure auth and KYC

## Recommended Stack
- `Flutter`
- state management: `Riverpod`
- routing: `go_router`
- networking: `Dio`
- immutable models: `freezed` + `json_serializable`
- localization: Flutter `intl` + generated localization files
- local storage:
  - `flutter_secure_storage` for tokens
  - lightweight local store for settings and cached drafts
- media/camera:
  - camera plugin
  - image/video picker fallback
- maps/geolocation:
  - geolocator
  - map package chosen later by product/region constraints
- crash reporting:
  - Sentry or Firebase Crashlytics later

## Architecture Style
Recommended pattern:
- `feature-first modular structure`
- `presentation -> application -> domain -> data`

Why:
- easier to scale by feature
- keeps petitions, complaints, and enforcement independent
- mock vs real data can be swapped without rewriting UI

## Project Structure
```text
lib/
  app/
    app.dart
    router/
    theme/
    localization/
    environment/
  core/
    constants/
    error/
    utils/
    widgets/
    services/
  features/
    auth/
      presentation/
      application/
      domain/
      data/
    profile/
    petitions/
    complaints/
    enforcement/
    notifications/
    settings/
  shared/
    models/
    repositories/
    api/
    storage/
```

## Layer Responsibilities
### `presentation`
- screens
- widgets
- forms
- user interaction state

### `application`
- use cases
- controllers/notifiers
- orchestration between repositories and UI

### `domain`
- entities
- business rules
- status enums
- pure models not tied to transport

### `data`
- DTOs
- repository implementations
- mock sources
- remote sources
- local persistence

## Feature Modules
### `auth`
- beta registration and login
- forgot password
- later secure onboarding entry
- auth state

### `profile`
- account details
- locale preference
- notification preferences
- help/about

### `petitions`
- list, detail, create, status
- later signature flow

### `complaints`
- create complaint
- attach media
- confirm location
- track complaint statuses

### `enforcement`
- report violation
- evidence capture
- manual address fallback
- trust-related messaging

### `notifications`
- inbox
- later push handling

### `settings`
- language
- appearance if needed
- app preferences

## Repository Strategy
Define interfaces first:
- `AuthRepository`
- `PetitionRepository`
- `ComplaintRepository`
- `EnforcementRepository`
- `MediaRepository`
- `NotificationRepository`

For each repository:
- `Mock...Repository`
- `Api...Repository`

Rule:
- UI depends only on repository interfaces or use cases
- implementation is selected by environment configuration

## Environment Strategy
Recommended environments:
- `mock`
- `dev`
- `staging`
- `prod`

### `mock`
- no backend dependency
- local fixtures and fake delays

### `dev`
- early backend integration

### `staging`
- pre-release validation

### `prod`
- production endpoints and secure policies

## Localization Strategy
Supported locales:
- `en`
- `he`
- `ru`
- `ar`

Requirements:
- locale-aware text resources
- pluralization support
- number/date formatting per locale
- RTL/LTR-aware layout and icons where needed
- text expansion tolerance in layouts

Rule:
- never hardcode visible strings in widgets

## Navigation Strategy
Use typed route definitions grouped by feature.

Example top-level navigation groups:
- auth
- home
- petitions
- complaints
- enforcement
- inbox
- profile/settings

Recommended navigation behavior:
- protected routes behind auth state
- deep-link readiness for later
- role changes handled centrally in routing guards

## Auth Strategy in App
### Beta mode
- email + password
- secure token storage
- minimal account profile

### Later secure mode
- secure onboarding entry point
- phone verification screens
- KYC document capture
- selfie or liveness entry point
- step-up prompts for sensitive actions

Design rule:
- build auth module so secure auth is an extension, not a rewrite

## Draft and Offline Behavior
Recommended support:
- save draft petitions
- save draft complaints
- save draft enforcement reports
- retain unsent media references until submission completes

Do not over-engineer full offline sync in the first stage.
Focus on:
- draft persistence
- retry behavior
- clear user feedback on network failure

## Media and Geodata UX Architecture
### Media flow
- request upload intent from repository
- capture or pick media
- show local preview
- upload through repository abstraction
- update entity draft with uploaded media reference

### Geodata flow
- get device location
- allow manual correction
- persist both raw and manual location in draft model
- show warning state for mismatch scenario

Important:
- geodata mismatch must be a first-class UI state, not an afterthought

## Error Handling Strategy
Use normalized app errors:
- validation errors
- auth errors
- network errors
- upload errors
- permission errors
- unknown errors

UI rule:
- each important screen should define:
  - loading state
  - empty state
  - validation state
  - recoverable error state

## Analytics and Observability Hooks
Add event points early, even if providers are connected later:
- screen viewed
- sign up started
- sign up completed
- petition created
- complaint submitted
- enforcement report submitted
- media upload failed
- location mismatch shown

This makes later instrumentation easier.

## Testing Strategy
### Early stage
- widget tests for critical forms
- unit tests for controllers and use cases
- golden or screenshot tests for multilingual UI if feasible

### Later stage
- integration tests for key journeys
- mock vs API environment smoke tests

Priority test journeys:
- beta login
- petition creation
- complaint creation
- enforcement report with manual address fallback

## Security Preparation in Mobile
Even in beta mode:
- secure token storage
- avoid logging sensitive values
- separate debug and release config
- keep auth and upload configuration environment-driven

Later secure rollout:
- stronger session management
- KYC capture and consent screens
- sensitive action confirmation

## Recommended First Implementation Sequence
1. app shell
2. localization and theme
3. router and auth guard
4. mock repositories
5. auth screens
6. petitions screens
7. complaint screens
8. enforcement screens
9. notifications and settings

## Architecture Exit Criteria
- modules are feature-based, not screen-chaotic
- mock and API repositories are swappable
- localization foundation works in all supported locales
- secure auth can be added without restructuring the whole app
