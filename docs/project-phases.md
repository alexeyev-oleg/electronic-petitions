# Project Phases

## Execution Rules
- Work only by approved stages.
- Before each new stage: agree the plan and expected outcome.
- After each completed stage: stop and wait for approval unless the user explicitly asks to continue.
- For substantial tasks, report progress with:
  - `- [x]` completed items
  - `- [ ]` pending items
  - a text progress bar
  - an approximate remaining time estimate

## Current Delivery Scope
- Product: unified civic platform for petitions, complaints, and municipal enforcement reports.
- Deployment target: DigitalOcean.
- Backend platform: Kubernetes, PostgreSQL with PostGIS, Redis/Valkey, DO Spaces.
- Web stack: `HTML + CSS + JavaScript`.
- Mobile scope: dedicated mobile flows for complaints and enforcement reports with photo/video and geodata capture.
- Platform languages:
  - English (default)
  - Hebrew
  - Russian
  - Arabic

## Delivery Stages
- [x] Stage 1. Product rules and architecture baseline
  - persist the stage-based execution rule
  - create the local project
  - define architecture baseline
  - lock multilingual and web stack requirements
- [x] Stage 2. Data model and security design
  - finalize PostgreSQL/PostGIS model
  - define Redis and object storage responsibilities
  - document KYC, session security, retention, audit, and access control
- [x] Stage 3. API contract and workflows
  - describe public API, admin API, media upload, KYC callbacks
  - define citizen, operator, inspector, and municipality workflows
- [x] Stage 4. Infrastructure design
  - describe DigitalOcean topology, namespaces, ingress, secrets, monitoring, backups
- [x] Stage 5. Delivery roadmap
  - define implementation order, acceptance criteria, and release milestones

## Stage 1 Acceptance Criteria
- [x] Persistent work rules are saved for future projects.
- [x] Local project directory exists.
- [x] Local Git repository is initialized.
- [x] `docs/project-phases.md` is created.
- [x] `docs/backend/architecture.md` is created.
- [x] Architecture baseline includes multilingual requirements.
- [x] Architecture baseline includes `HTML + CSS + JavaScript` for the web client.
- [x] Architecture baseline includes petitions, complaints, and municipal enforcement.

## Stage 2 Acceptance Criteria
- [x] `docs/backend/data-model.md` is created.
- [x] `docs/security/identity-and-auth.md` is created.
- [x] PostgreSQL/PostGIS domains are defined for identity, petition, complaint, enforcement, media, ops, and reference data.
- [x] Redis responsibilities are constrained to ephemeral, queue, and cache workloads.
- [x] DO Spaces responsibilities are defined for KYC, complaint, enforcement, and public attachments.
- [x] Language-aware content storage is defined for `en`, `he`, `ru`, and `ar`.
- [x] KYC retention and restricted media access baseline is documented.
- [x] Geodata trust and mismatch handling is documented for complaint and enforcement flows.

## Stage 3 Acceptance Criteria
- [x] `docs/backend/workflows.md` is created.
- [x] `docs/api/openapi.yaml` is created.
- [x] Public API and admin API boundaries are documented.
- [x] Role workflows are documented for resident, moderator, operator, inspector, supervisor, municipality staff, and admin.
- [x] Petition, complaint, and enforcement lifecycles are documented.
- [x] Media upload flow is documented.
- [x] KYC callback handling and verification state transitions are documented.

## Stage 4 Acceptance Criteria
- [x] `docs/infra/digitalocean-architecture.md` is created.
- [x] DigitalOcean deployment topology is documented.
- [x] Kubernetes namespace and workload placement strategy is documented.
- [x] Ingress, TLS, secrets, and service exposure rules are documented.
- [x] Managed PostgreSQL, Redis/Valkey, and Spaces responsibilities are documented.
- [x] Backup and restore expectations are documented.
- [x] Monitoring, logging, alerting, and operational access model are documented.

## Stage 5 Acceptance Criteria
- [x] `docs/delivery-roadmap.md` is created.
- [x] Backend implementation order is documented.
- [x] MVP, pilot, and public launch milestones are documented.
- [x] Acceptance criteria are documented by module and environment.
- [x] Rollout sequencing is documented for backend, web, mobile, and operations.

## Delivery Status
- [x] Stage 1 complete
- [x] Stage 2 complete
- [x] Stage 3 complete
- [x] Stage 4 complete
- [x] Stage 5 complete
