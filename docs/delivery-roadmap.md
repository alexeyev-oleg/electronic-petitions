# Delivery Roadmap

## Purpose
This document defines the Stage 5 delivery plan:
- implementation order
- milestone structure
- acceptance criteria
- rollout sequence for backend, web, mobile, and operations

## Delivery Strategy
Build the platform in layers, not by building every client and service in parallel from day one.

Recommended order:
1. platform foundation
2. identity and security
3. petitions MVP
4. complaints MVP
5. municipal enforcement MVP
6. admin and reporting operations
7. pilot hardening
8. public launch

This order reduces risk because:
- identity and audit rules affect all domains
- media and geodata handling affect complaints and enforcement
- admin workflows must be ready before public launch
- infrastructure and observability must be stable before municipality onboarding

## Recommended Track Structure
### Track A. Platform and backend
- backend domain services
- API gateway
- workers and async jobs
- data model and migrations

### Track B. Web
- public site on `HTML + CSS + JavaScript`
- admin web interfaces

### Track C. Mobile
- resident complaint and enforcement flows
- KYC capture
- push notifications

### Track D. Operations
- infrastructure
- CI/CD
- observability
- security and support processes

## Milestone Map
### `M0` Foundation
Goal:
- prepare a working backend foundation and deployment baseline

Includes:
- repository structure
- backend skeleton
- migration framework
- environment configuration
- CI baseline
- DOKS baseline

### `M1` Identity and petitions MVP
Goal:
- allow secure signup, KYC, petition publishing, and signatures

Includes:
- registration and login
- KYC orchestration
- petition creation and moderation
- signature flow
- official response workflow

### `M2` Complaints MVP
Goal:
- allow residents to submit city complaints with media and geodata

Includes:
- complaint creation
- media upload and processing
- geodata normalization
- operator assignment
- resident notifications

### `M3` Municipal enforcement MVP
Goal:
- allow residents to report probable violations and route them into inspector triage

Includes:
- enforcement reports
- trust scoring
- triage queue
- dispatch workflow
- validated outcomes

### `M4` Operational pilot
Goal:
- run the platform with selected municipality staff and a limited user group

Includes:
- supervisor workflows
- reporting dashboards
- alerting
- backup restore validation
- support runbooks

### `M5` Public launch
Goal:
- open the platform to the public with full operational readiness

Includes:
- production hardening
- launch communications support
- post-launch monitoring
- incident escalation paths

## Detailed Implementation Order
### Phase 1. Repository and skeleton
- initialize backend workspace
- define module boundaries
- add migration tooling
- add environment configuration structure
- add base CI workflow

Dependencies:
- none

### Phase 2. Identity and auth
- implement registration
- implement OTP verification
- implement sessions and refresh flow
- implement passkey or MFA baseline
- integrate external KYC provider
- implement identity review queue

Dependencies:
- Phase 1

### Phase 3. Shared platform capabilities
- implement media upload intent flow
- implement media processing workers
- implement notification service baseline
- implement audit event pipeline
- implement localization and locale resolution

Dependencies:
- Phase 2 for protected flows

### Phase 4. Petition domain
- petition drafts
- moderation workflow
- publication flow
- signature flow with identity checks
- official response publication

Dependencies:
- Phases 2 and 3

### Phase 5. Complaint domain
- complaint submission
- location normalization
- assignment and SLA workflow
- resolution notes and closure

Dependencies:
- Phases 2 and 3

### Phase 6. Enforcement domain
- enforcement report submission
- trust scoring
- geo mismatch handling
- inspector triage
- dispatch tasks
- validated outcome recording

Dependencies:
- Phases 2, 3, and 5

### Phase 7. Admin and analytics
- moderation dashboard
- operator queues
- inspector queues
- supervisor tools
- reporting dashboard

Dependencies:
- Phases 4, 5, and 6

### Phase 8. Pilot hardening
- load and failure testing
- alert tuning
- backup restore drill
- security review
- municipality staff onboarding

Dependencies:
- Phases 1 through 7

### Phase 9. Public launch hardening
- production access review
- rate limiting review
- final legal and policy review
- launch checklist execution

Dependencies:
- Phase 8

## MVP Scope Recommendation
### Include in MVP
- secure registration
- KYC verification
- petition lifecycle
- complaint lifecycle
- enforcement report lifecycle
- admin triage and assignment
- multilingual support for `en`, `he`, `ru`, `ar`
- static public website
- audit and monitoring baseline

### Defer from MVP if needed
- advanced AI moderation
- sophisticated duplicate clustering
- advanced heatmaps
- public forum discussions
- appeal workflows for fines
- deep analytics warehouse

## Acceptance Criteria by Module
### Identity and auth
- user can register with phone and email
- user can log in and refresh session
- KYC verification reaches `approved`, `manual_review`, or `rejected`
- identity-verified user can sign petitions
- staff login requires stronger auth

### Media
- client can request upload intent
- media upload completes successfully
- metadata and EXIF are extracted
- video transcode and preview generation work where applicable
- restricted media is not publicly accessible

### Petitions
- resident can create a petition draft
- moderator can approve or reject it
- published petition is visible publicly
- identity-verified resident can sign once
- municipality staff can publish official response

### Complaints
- resident can submit complaint with media and geodata
- geodata is normalized
- complaint is routed to operator queue
- operator can assign and resolve
- resident receives status updates

### Enforcement
- resident can submit enforcement report
- geo mismatch triggers manual address requirement
- trust score is calculated
- inspector can triage and dispatch
- validated outcome requires authorized staff action

### Reporting and ops
- dashboards show queue depth and basic KPIs
- alerts trigger on outage and queue backlog
- audit log exists for sensitive operations
- backup restore process is documented and tested

## Acceptance Criteria by Environment
### `dev`
- developers can run the stack and test flows end to end
- migrations apply cleanly
- test media processing works

### `staging`
- mirrors production behavior closely
- full smoke test passes
- KYC sandbox integration works
- notifications use non-production providers or safe channels

### `production`
- production secrets and domains configured
- monitoring and alerts enabled
- backup strategy active
- privileged access reviewed
- launch checklist approved

## Rollout Sequence by Track
### Backend rollout
1. identity
2. shared media and notifications
3. petitions
4. complaints
5. enforcement
6. admin dashboards and reporting

### Web rollout
1. public informational pages
2. petition browsing and petition submission UI
3. resident account views
4. admin portal flows

### Mobile rollout
1. auth and KYC capture
2. complaint submission with media and geodata
3. enforcement reporting
4. status tracking and notifications

### Ops rollout
1. non-production cluster and managed services
2. CI/CD and migrations
3. observability stack
4. production readiness and restore drills

## Parallelization Guidance
### Safe to do in parallel
- backend skeleton and infrastructure baseline
- public site markup and API contract preparation
- admin UX planning and backend queue design
- mobile capture UX and backend media contracts

### Should remain sequential
- KYC integration before petition signing launch
- media pipeline before complaint and enforcement public submission
- queue dashboards before pilot onboarding
- backup validation before production launch

## Suggested Milestone Exit Gates
### Exit gate for `M0`
- core repo structure exists
- CI baseline works
- environments are defined

### Exit gate for `M1`
- KYC and petition flow work end to end
- audit trail covers sensitive actions

### Exit gate for `M2`
- complaint flow works end to end
- operator queue works

### Exit gate for `M3`
- enforcement report flow works end to end
- inspector triage and validated outcomes work

### Exit gate for `M4`
- pilot users are onboarded
- alerts and restore checks pass

### Exit gate for `M5`
- launch checklist signed off
- support model active
- monitoring stable after soft launch

## Recommended Team Focus by Stage
### Foundation
- backend lead
- DevOps

### Identity and shared platform
- backend
- security-minded backend
- mobile for KYC capture alignment

### Petitions and complaints
- backend
- web
- admin UX

### Enforcement and pilot
- backend
- mobile
- admin/ops
- municipality stakeholders

## Immediate Next Execution Recommendation
When moving from planning/docs into implementation, start with:
1. backend repository skeleton
2. migration setup
3. identity-service baseline
4. media upload pipeline
5. petition MVP endpoints

Do not begin with enforcement-specific fine logic before:
- identity
- media
- geo normalization
- admin queue controls

## Stage 5 Output
This document defines the approved roadmap for:
- implementation order
- release milestones
- module acceptance criteria
- environment readiness
- cross-track rollout sequence
