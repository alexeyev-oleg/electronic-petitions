# User Documentation Plan for Resident App

## Purpose
This document defines how user-facing documentation should be written in parallel with the resident mobile app.

## Documentation Principles
- Write documentation at the same time as feature implementation.
- Use simple language suitable for non-technical residents.
- Keep documentation aligned with real app screens.
- Maintain documentation in all supported product languages later:
  - English
  - Hebrew
  - Russian
  - Arabic

## Documentation Tracks
### `U1` Getting started
- what the app is for
- who it is for
- supported devices
- how to install and open the app

### `U2` Account and sign-in
- how to create an account in beta
- how to log in
- how to reset password
- how account verification will change in secure release

### `U3` Petitions guide
- how to browse petitions
- how to create a petition
- how petition status works
- note about signature rules in beta vs secure release

### `U4` Complaints guide
- how to create a complaint
- how to attach photos and videos
- how geolocation and manual address work
- how to track complaint status

### `U5` Violation reporting guide
- how to report a violation
- how photo/video evidence is used
- why the app may ask for a manual address
- what happens after submission

### `U6` Notifications and settings
- how to manage language
- how to manage notification preferences
- how to view your own history

### `U7` FAQ and troubleshooting
- common login problems
- location permission issues
- media upload issues
- language switching
- why a report may show pending or review status

### `U8` Inspector triage guide
- staff mock login
- triage queue filters
- evidence review
- inspector actions and OTP confirmation
- shared demo report IDs with resident app

## Documentation by Milestone
### After `R0`
- quick project overview
- supported languages
- app navigation overview

### After `R1`
- registration and login guide
- password reset guide
- profile guide

### After `R2`
- petition browsing guide
- petition creation guide

### After `R3`
- complaint submission guide
- media attach guide
- location confirmation guide

### After `R4`
- violation reporting guide
- manual address fallback explanation

### After `R5`
- notifications guide
- FAQ baseline

### After `R6`
- secure registration and KYC guide
- updated petition signing rules

### After `I4` (Inspector App mock)
- inspector triage guide
- inspector APK build guide
- shared mock demo data reference

## Documentation Formats
Recommended outputs:
- `docs/mobile/user-guides/*.md`
- in-app help content later
- FAQ page content reusable for web help center later

## Writing Style Rules
- short steps
- one action per bullet when procedural
- screenshots or annotated mockups where useful
- avoid legal or technical jargon unless required
- clearly label `beta/test behavior` vs `production behavior`

## Beta-Specific Notes
Documentation must clearly explain:
- beta uses simplified `email + password`
- some features may be non-binding or test-only
- secure verification will be added later

## Priority Order for Writing
1. onboarding and login
2. petition guide
3. complaint guide
4. violation reporting guide
5. notifications/settings
6. FAQ

## Ownership Recommendation
- product or UX writer drafts first version
- feature implementer validates accuracy
- QA verifies steps against real app behavior
- translation/localization review happens before broad release

## Exit Criteria
- each major resident feature has a usage guide
- beta-specific behavior is clearly documented
- documentation can later be localized without structural rewrite
