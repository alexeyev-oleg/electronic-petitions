# M0 Backend Foundation Plan

## Purpose

Define how G.E.S.H.E.R. moves from **mock-v0.2.0** (local clients, no API) to a **deployable backend foundation** ready for **M1** (identity + petitions MVP).

This document is the approved execution plan for milestone **M0**. Implementation happens in sub-stages; each sub-stage ends with a review gate unless the user explicitly asks to continue.

## Current baseline (completed)

| Track | Status | Reference |
|-------|--------|-----------|
| Mock clients | ✅ `mock-v0.2.0` | Resident, Inspector, Admin, Public web |
| Architecture | ✅ Stage 1 | `docs/backend/architecture.md` |
| Data model | ✅ Stage 2 | `docs/backend/data-model.md` |
| API contract | ✅ Stage 3 | `docs/api/openapi.yaml` |
| Infrastructure | ✅ Stage 4 | `docs/infra/digitalocean-architecture.md` |
| Delivery order | ✅ Stage 5 | `docs/delivery-roadmap.md` |
| CI (clients) | ✅ Q1 | `.github/workflows/quality.yml` |

**M0 does not replace mock clients.** Mock mode stays available via repository switches and environment flags until M1 endpoints are stable.

## M0 goal (exit criteria)

From `docs/delivery-roadmap.md`:

- [ ] Core backend repo structure exists inside the monorepo
- [ ] Migration framework runs locally and in CI
- [ ] Environment configuration is defined (`local`, `staging`, `production`)
- [ ] Health/readiness endpoints and API version surface exist
- [ ] Local stack boots with PostgreSQL+PostGIS, Redis, and S3-compatible storage
- [ ] Backend CI baseline (lint, test, migrate check) runs on PR
- [ ] Staging DOKS baseline is documented (manifests or IaC skeleton)

When all items above are checked, **M0 is complete** and **M1** (identity + petitions) may start.

## Recommended backend shape

### Pattern: modular monolith

Align with `docs/backend/architecture.md`:

> At the start, several logical services may ship as one deployable application, but the codebase and data boundaries should remain explicit.

One deployable **`services/api`** process with internal packages per bounded context:

```text
services/
  api/
    cmd/server/           # main entry
    internal/
      platform/           # config, logging, http, db, redis, storage
      identity/           # M1 — scaffold only in M0
      petition/           # M1 — scaffold only in M0
      complaint/          # package stub
      enforcement/        # package stub
      media/              # package stub
      notification/       # package stub
      ops/                # audit, health, version
    migrations/           # SQL migrations (goose)
    Dockerfile
  worker/                 # optional stub — async jobs in M2+
infra/
  docker/
    docker-compose.yml    # local postgres+postgis, redis, minio
  k8s/                    # staging/prod manifests (M0.7)
  terraform/              # DOKS baseline (M0.7, optional)
```

### Suggested runtime stack

| Layer | Recommendation | Rationale |
|-------|----------------|-----------|
| Language | **Go 1.22+** | Small images, strong K8s fit, good PostGIS drivers |
| HTTP | `chi` or `echo` | Lightweight routing, middleware |
| DB access | `pgx` + **sqlc** | Type-safe SQL, matches documented schemas |
| Migrations | **goose** | Simple SQL files, CI-friendly |
| Config | env + `config.yaml` per environment | Matches K8s secrets/config maps |
| Object storage | AWS SDK → DO Spaces (S3-compatible) | Already in architecture |
| Cache/queue | `go-redis` | OTP, rate limits, job queues later |

Alternative: TypeScript **NestJS** if the team optimizes for shared types with OpenAPI codegen. Decision should be locked in **M0.2** before skeleton code lands.

## Mock → API integration map

Demo entity IDs in `shared/mock/seed.json` become **seed fixtures** for staging, not production UUIDs.

| Mock prefix | Example IDs | OpenAPI domain | First real endpoints (M1+) |
|-------------|-------------|----------------|------------------------------|
| `p*` | p1–p4 | Petitions | `GET /petitions`, `GET /petitions/{id}`, `POST /petitions/{id}/signatures` |
| `c*` | c1–c3 | Complaints | `POST /complaints` (M2) |
| `e*` | e1–e4 | Enforcement | `POST /enforcement/reports` (M3) |
| `n*` | n1–n3 | Notifications | `GET /notifications` (M2) |
| `staff-*` | staff-moderator… | Admin | `POST /admin/auth/login` (M1) |

### Client switch strategy

| Client | Today | M0 | M1+ |
|--------|-------|-----|-----|
| Resident app | `MockLocalStore` + `main_mock.dart` | Add `AppEnvironment.apiBaseUrl`, no UI change | `ApiPetitionsRepository` behind `PetitionRepository` interface |
| Inspector app | same | same | `ApiEnforcementRepository` |
| Admin web | `GesherMockStore` | `config.js` API base URL stub | fetch admin API with bearer token |
| Public web | read-only `seed.json` | keep static; optional `PUBLIC_API_URL` later | published initiatives from API |

Flutter already uses repository interfaces (`petitions_repository.dart`, etc.). **M0 does not wire clients to the API** — only documents and prepares `core/api/` + environment flags.

## M0 sub-stages

### M0.1 Integration planning (this document)

**Progress:** `[██████████] 100%`

- [x] Mock → API mapping
- [x] Monorepo layout proposal
- [x] Stack recommendation
- [x] Sub-stage breakdown and exit gates
- [x] Client integration order

**Estimate:** done

---

### M0.2 Repository skeleton

**Progress:** `[░░░░░░░░░░] 0%` · ~2–3 days

- [ ] Create `services/api/` with `cmd/server`, `internal/platform`, package stubs
- [ ] `go.mod`, `Makefile` (`make run`, `make test`, `make migrate`)
- [ ] Root `.env.example` and `services/api/config.example.yaml`
- [ ] `README.md` in `services/api/`

**Exit:** `go build ./...` succeeds; empty HTTP server starts

---

### M0.3 Local development stack

**Progress:** `[░░░░░░░░░░] 0%` · ~1–2 days

- [ ] `infra/docker/docker-compose.yml`:
  - PostgreSQL 16 + PostGIS
  - Redis 7
  - MinIO (S3-compatible)
- [ ] `scripts/dev-up.sh` / `scripts/dev-down.sh`
- [ ] Document ports and credentials in `services/api/README.md`

**Exit:** `docker compose up` + API connects to all three services

---

### M0.4 Migration framework

**Progress:** `[░░░░░░░░░░] 0%` · ~2 days

- [ ] Initial migration: extensions (`postgis`), schemas (`identity`, `petition`, …) from `data-model.md`
- [ ] Seed migration optional: reference cities / demo municipality
- [ ] `make migrate-up` / `make migrate-down`
- [ ] Migration check in CI (against ephemeral Postgres)

**Exit:** clean migrate up/down on empty DB

---

### M0.5 Health, version, and OpenAPI stub

**Progress:** `[░░░░░░░░░░] 0%` · ~1 day

- [ ] `GET /health` — liveness
- [ ] `GET /ready` — DB + Redis ping
- [ ] `GET /version` — git sha, build time, API semver
- [ ] Serve `docs/api/openapi.yaml` at `/openapi.yaml` or embed redoc stub

**Exit:** endpoints return 200 in local stack

---

### M0.6 Backend CI

**Progress:** `[░░░░░░░░░░] 0%` · ~1 day

- [ ] `.github/workflows/backend.yml`:
  - `go test ./...`
  - `golangci-lint` (or `go vet` baseline)
  - migration smoke on service container
- [ ] Extend `docs/ci.md`

**Exit:** PR checks pass on skeleton-only PR

---

### M0.7 Staging DOKS baseline

**Progress:** `[░░░░░░░░░░] 0%` · ~3–5 days

- [ ] `infra/k8s/base/` — Deployment, Service, Ingress for API
- [ ] Secrets layout documented (DB URL, Redis, Spaces keys)
- [ ] Staging namespace per `digitalocean-architecture.md`
- [ ] Optional: Terraform module skeleton for DOKS + managed Postgres

**Exit:** documented path to deploy API to staging (manual apply acceptable for M0)

---

## Overall M0 progress

```text
[██░░░░░░░░] ~15%  (M0.1 planning complete)
```

| Sub-stage | Estimate | Depends on |
|-----------|----------|------------|
| M0.1 Planning | ✅ | — |
| M0.2 Skeleton | 2–3 d | M0.1 |
| M0.3 Local stack | 1–2 d | M0.2 |
| M0.4 Migrations | 2 d | M0.3 |
| M0.5 Health API | 1 d | M0.2 |
| M0.6 Backend CI | 1 d | M0.4, M0.5 |
| M0.7 DOKS baseline | 3–5 d | M0.6 |

**Total remaining:** ~10–14 days after M0.1 approval

## What not to build in M0

- Full identity/KYC flows (M1)
- Petition CRUD and signatures (M1)
- Media upload pipeline (M1/M2)
- Complaint or enforcement business logic (M2/M3)
- Replacing mock clients in production demos

## After M0: M1 preview

First vertical slice:

1. `POST /auth/register`, `POST /auth/login`, refresh tokens
2. KYC webhook stub + status on user
3. `GET /petitions` (published), `POST /petitions`, moderation admin routes
4. `POST /petitions/{id}/signatures` with step-up OTP
5. Resident app: flip `petitionsRepositoryProvider` to API in `main_staging.dart`

## Related documents

- `docs/delivery-roadmap.md` — milestone map
- `docs/backend/architecture.md` — service boundaries
- `docs/backend/data-model.md` — PostgreSQL schemas
- `docs/api/openapi.yaml` — contract to implement
- `docs/infra/digitalocean-architecture.md` — staging topology
- `docs/web/mock-platform.md` — mock client sync (unchanged until M1)

## Decision log

| Date | Decision |
|------|----------|
| 2026-07-07 | M0 starts with planning doc; mock clients remain default for demos |
| 2026-07-07 | Modular monolith in `services/api/` preferred over microservices day one |
| 2026-07-07 | Go recommended; confirm or override in M0.2 kickoff |
