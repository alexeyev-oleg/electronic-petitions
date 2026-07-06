# Data Model

## Purpose
This document defines the Stage 2 baseline for:
- transactional data in `PostgreSQL + PostGIS`
- ephemeral and queue data in `Redis / Valkey`
- binary media storage in `DO Spaces`
- multilingual content storage for English, Hebrew, Russian, and Arabic

## Storage Responsibilities
### `PostgreSQL + PostGIS`
Use PostgreSQL as the system of record for:
- users and identity status
- petitions and signatures
- complaints and operational routing
- municipal enforcement reports and cases
- media metadata and access policies
- moderation, notifications, and audit
- multilingual content and translations
- districts, city boundaries, and normalized geodata

### `Redis / Valkey`
Use Redis only for short-lived or derived state:
- OTP / auth challenges
- rate limiting
- short-lived session or step-up markers
- async processing queues
- notification fan-out buffers
- hot counters and cached dashboard fragments

Redis must not be the source of truth for:
- petition signatures
- complaint status
- enforcement outcomes
- KYC completion state

### `DO Spaces`
Use object storage for:
- KYC document images
- KYC selfie and liveness media
- petition attachments
- complaint photos and videos
- enforcement report evidence
- generated thumbnails, posters, previews, and transcoded video

Store only references and metadata in PostgreSQL.

## Modeling Conventions
- Primary keys: `uuid`
- Timestamps: `created_at`, `updated_at`
- Soft deletion where needed: `deleted_at`
- Status fields: explicit enums or constrained text columns
- JSON payloads only for flexible provider payloads, audit snapshots, or derived metadata
- Geo points: `geography(Point, 4326)` where distance matters
- Geo polygons: `geometry(MultiPolygon, 4326)` for districts and city boundaries

## Suggested PostgreSQL Schemas
- `identity`
- `petition`
- `complaint`
- `enforcement`
- `media`
- `ops`
- `i18n`
- `reference`

This is a logical split. Physical deployment can still be a single PostgreSQL database.

## Identity Domain
### `identity.users`
- `id`
- `phone_e164`
- `email`
- `status`
- `assurance_level`
- `default_locale`
- `preferred_city_id`
- `created_at`
- `updated_at`
- `last_login_at`

Notes:
- `status` examples: `draft`, `active`, `restricted`, `blocked`
- `assurance_level` examples: `none`, `phone_verified`, `basic_reporter`, `identity_verified`, `staff_verified`

### `identity.user_profiles`
- `user_id`
- `first_name`
- `last_name`
- `middle_name`
- `birth_date`
- `timezone`
- `primary_language`

### `identity.user_addresses`
- `id`
- `user_id`
- `country_code`
- `city_id`
- `address_line_1`
- `address_line_2`
- `postal_code`
- `geo_point`
- `is_primary`

### `identity.user_devices`
- `id`
- `user_id`
- `platform`
- `device_fingerprint`
- `push_token`
- `trusted_at`
- `last_seen_at`
- `risk_score`
- `app_version`

### `identity.user_sessions`
- `id`
- `user_id`
- `device_id`
- `refresh_token_hash`
- `ip_address`
- `user_agent`
- `expires_at`
- `revoked_at`
- `reauth_required_at`

### `identity.auth_challenges`
- `id`
- `user_id`
- `session_id`
- `challenge_type`
- `channel`
- `otp_hash`
- `attempts`
- `expires_at`
- `verified_at`

### `identity.passkeys`
- `id`
- `user_id`
- `credential_id`
- `public_key`
- `sign_count`
- `device_label`
- `created_at`
- `last_used_at`

## KYC Domain
### `identity.identity_verifications`
- `id`
- `user_id`
- `provider_code`
- `status`
- `assurance_level`
- `started_at`
- `completed_at`
- `failure_reason`
- `provider_reference`

### `identity.identity_documents`
- `id`
- `verification_id`
- `document_type`
- `country_code`
- `document_number_input`
- `document_number_normalized`
- `document_number_ocr`
- `ocr_confidence`
- `issued_at`
- `expires_at`
- `front_media_id`
- `back_media_id`

### `identity.selfie_checks`
- `id`
- `verification_id`
- `selfie_media_id`
- `liveness_score`
- `face_match_score`
- `result`
- `provider_payload_json`

### `identity.identity_review_queue`
- `id`
- `verification_id`
- `reason_code`
- `priority`
- `assigned_to_user_id`
- `status`
- `resolved_at`

### `identity.identity_risk_events`
- `id`
- `user_id`
- `event_type`
- `risk_score`
- `payload_json`
- `created_at`

### `identity.citizen_id_registry`
- `id`
- `country_code`
- `document_number_normalized`
- `user_id`
- `status`
- `linked_at`

Constraints:
- unique active government ID per active user
- duplicate linkage must require manual resolution

## Petition Domain
### `petition.petitions`
- `id`
- `author_user_id`
- `category_id`
- `district_id`
- `status`
- `signature_goal`
- `signature_count`
- `published_at`
- `deadline_at`
- `closed_at`

### `petition.petition_contents`
- `petition_id`
- `locale`
- `title`
- `body`
- `summary`
- `slug`
- `search_vector`

Why a separate content table:
- supports multilingual content without duplicating workflow fields
- allows missing translations while keeping one canonical petition record

### `petition.petition_attachments`
- `id`
- `petition_id`
- `media_id`
- `sort_order`

### `petition.petition_signatures`
- `id`
- `petition_id`
- `user_id`
- `signed_at`
- `ip_address`
- `device_id`
- `verification_snapshot`

Constraints:
- unique: `petition_id + user_id`

### `petition.petition_status_history`
- `id`
- `petition_id`
- `from_status`
- `to_status`
- `actor_user_id`
- `comment`
- `created_at`

### `petition.petition_assignments`
- `id`
- `petition_id`
- `department_id`
- `assigned_to_user_id`
- `assigned_at`

### `petition.petition_official_responses`
- `id`
- `petition_id`
- `author_user_id`
- `published_at`

### `petition.petition_official_response_contents`
- `response_id`
- `locale`
- `title`
- `body`

## Complaint Domain
### `complaint.complaints`
- `id`
- `author_user_id`
- `category_id`
- `status`
- `priority`
- `source_channel`
- `trust_level`
- `created_at`
- `resolved_at`

### `complaint.complaint_contents`
- `complaint_id`
- `locale`
- `title`
- `description`
- `search_vector`

### `complaint.complaint_locations`
- `id`
- `complaint_id`
- `device_geo_point`
- `device_accuracy_meters`
- `media_exif_geo_point`
- `manual_geo_point`
- `normalized_geo_point`
- `address_text_user`
- `address_text_normalized`
- `district_id`
- `city_id`
- `captured_at`
- `geo_confidence`
- `geo_mismatch_flag`

### `complaint.complaint_media_links`
- `id`
- `complaint_id`
- `media_id`
- `media_role`
- `captured_live`
- `uploaded_from_gallery`
- `is_primary`

### `complaint.complaint_assignments`
- `id`
- `complaint_id`
- `department_id`
- `assigned_to_user_id`
- `assigned_at`

### `complaint.complaint_status_history`
- `id`
- `complaint_id`
- `from_status`
- `to_status`
- `actor_user_id`
- `comment`
- `created_at`

### `complaint.complaint_resolution_notes`
- `id`
- `complaint_id`
- `author_user_id`
- `visibility`
- `body`
- `created_at`

### `complaint.complaint_sla_timers`
- `id`
- `complaint_id`
- `sla_policy_id`
- `due_at`
- `breached_at`
- `closed_at`

## Municipal Enforcement Domain
### `enforcement.enforcement_categories`
- `id`
- `code`
- `department_id`
- `priority_default`
- `requires_field_dispatch`

### `enforcement.enforcement_category_contents`
- `category_id`
- `locale`
- `name`
- `description`

### `enforcement.enforcement_reports`
- `id`
- `author_user_id`
- `category_id`
- `status`
- `severity_hint`
- `trust_level`
- `created_at`

### `enforcement.enforcement_report_contents`
- `report_id`
- `locale`
- `title`
- `description`

### `enforcement.enforcement_report_locations`
- `id`
- `report_id`
- `device_geo_point`
- `device_accuracy_meters`
- `exif_geo_point`
- `manual_geo_point`
- `normalized_geo_point`
- `manual_address_text`
- `normalized_address_text`
- `city_id`
- `district_id`
- `location_confidence`
- `geo_mismatch_flag`

### `enforcement.enforcement_report_media`
- `id`
- `report_id`
- `media_id`
- `media_role`
- `captured_live`
- `from_gallery`
- `is_primary`

### `enforcement.enforcement_geo_anomalies`
- `id`
- `report_id`
- `anomaly_type`
- `expected_city_id`
- `detected_city_id`
- `score`
- `decision`
- `created_at`

### `enforcement.enforcement_trust_scores`
- `id`
- `report_id`
- `geo_score`
- `media_score`
- `identity_score`
- `history_score`
- `final_score`
- `calculated_at`

### `enforcement.enforcement_cases`
- `id`
- `source_report_id`
- `assigned_unit_id`
- `assigned_to_user_id`
- `status`
- `priority`
- `opened_at`
- `closed_at`

### `enforcement.enforcement_dispatch_tasks`
- `id`
- `case_id`
- `dispatch_type`
- `scheduled_at`
- `accepted_at`
- `arrived_at`
- `completed_at`

### `enforcement.enforcement_case_actions`
- `id`
- `case_id`
- `actor_user_id`
- `action_type`
- `notes`
- `created_at`

### `enforcement.enforcement_case_evidence`
- `id`
- `case_id`
- `media_id`
- `evidence_source`
- `chain_of_custody_json`

### `enforcement.enforcement_outcomes`
- `id`
- `case_id`
- `outcome_type`
- `legal_result`
- `requires_followup`
- `created_at`

### `enforcement.enforcement_fines`
- `id`
- `case_id`
- `fine_code`
- `fine_amount`
- `issued_by_user_id`
- `issued_at`
- `external_reference`

Important rule:
- citizen-submitted media may create a report or case
- only staff validation may produce an official fine record

## Media Domain
### `media.media_objects`
- `id`
- `owner_user_id`
- `bucket`
- `object_key`
- `storage_class`
- `media_type`
- `mime_type`
- `size_bytes`
- `sha256`
- `created_at`

### `media.media_metadata`
- `media_id`
- `width`
- `height`
- `duration_sec`
- `codec`
- `captured_at`
- `device_model`
- `exif_json`
- `gps_exif_json`

### `media.media_processing_jobs`
- `id`
- `media_id`
- `job_type`
- `status`
- `attempts`
- `started_at`
- `finished_at`
- `error_text`

### `media.media_moderation_flags`
- `id`
- `media_id`
- `flag_type`
- `score`
- `review_status`

### `media.media_access_policies`
- `id`
- `media_id`
- `visibility`
- `retention_policy_code`
- `restricted_reason`

### `media.media_derivatives`
- `id`
- `source_media_id`
- `derivative_type`
- `media_id`
- `generated_at`

## Ops, Moderation, Notification, and Audit
### `ops.roles`
- `id`
- `code`
- `name`

### `ops.permissions`
- `id`
- `code`
- `name`

### `ops.role_permissions`
- `role_id`
- `permission_id`

### `ops.departments`
- `id`
- `city_id`
- `code`
- `name`
- `manager_user_id`

### `ops.city_service_units`
- `id`
- `city_id`
- `department_id`
- `name`
- `unit_type`

### `ops.moderation_cases`
- `id`
- `entity_type`
- `entity_id`
- `reason_code`
- `status`
- `assigned_to_user_id`
- `created_at`

### `ops.moderation_actions`
- `id`
- `case_id`
- `actor_user_id`
- `action_type`
- `comment`
- `created_at`

### `ops.notifications`
- `id`
- `user_id`
- `channel`
- `template_code`
- `payload_json`
- `status`
- `sent_at`

### `ops.notification_preferences`
- `user_id`
- `email_enabled`
- `sms_enabled`
- `push_enabled`
- `marketing_enabled`

### `ops.audit_events`
- `id`
- `actor_user_id`
- `actor_role`
- `entity_type`
- `entity_id`
- `action`
- `payload_json`
- `ip_address`
- `created_at`

### `ops.webhooks_outbox`
- `id`
- `event_type`
- `payload_json`
- `status`
- `next_retry_at`

## Reference and Geo Data
### `reference.cities`
- `id`
- `code`
- `country_code`
- `default_locale`

### `reference.city_contents`
- `city_id`
- `locale`
- `name`

### `reference.districts`
- `id`
- `city_id`
- `code`
- `geo_polygon`

### `reference.district_contents`
- `district_id`
- `locale`
- `name`

### `reference.sla_policies`
- `id`
- `code`
- `target_hours`
- `priority_rules_json`

### `reference.system_settings`
- `key`
- `value_json`

## Multilingual Data Strategy
Supported locales:
- `en`
- `he`
- `ru`
- `ar`

Recommended pattern:
- keep workflow and relational fields in the primary table
- keep translatable fields in parallel `*_contents` tables with `locale`

Examples of translatable entities:
- petition titles and bodies
- complaint category labels
- enforcement category labels
- canned replies
- official responses
- public pages and FAQ content

Benefits:
- avoids wide tables with one column per language
- allows partial translation rollout
- keeps business workflows language-neutral

## Indexing Baseline
### Unique and integrity indexes
- `identity.users(phone_e164)` unique
- `identity.users(email)` unique where not null
- `identity.citizen_id_registry(document_number_normalized)` unique for active records
- `petition.petition_signatures(petition_id, user_id)` unique

### Search indexes
- `GIN` on multilingual `search_vector` columns
- optional trigram indexes for names, slugs, and fuzzy search

### Spatial indexes
- `GIST` indexes on:
  - city polygons
  - district polygons
  - normalized complaint points
  - normalized enforcement report points

### Operational indexes
- status and priority indexes for complaint and enforcement queues
- due date indexes for SLA timers
- created_at indexes for audit and reporting

## Redis Keyspace Baseline
- `auth:otp:{challengeId}`
- `auth:rate_limit:{scope}:{subject}`
- `session:step_up:{sessionId}`
- `queue:media_processing`
- `queue:notifications`
- `queue:geo_normalization`
- `queue:reporting`
- `cache:petition:{petitionId}`
- `cache:dashboard:{cityId}:{role}`

## Spaces Object Prefix Baseline
- `kyc/documents/{userId}/{verificationId}/...`
- `kyc/selfies/{userId}/{verificationId}/...`
- `petitions/{petitionId}/attachments/...`
- `complaints/{complaintId}/media/...`
- `enforcement/{reportId}/media/...`
- `derived/{mediaId}/thumbnail/...`
- `derived/{mediaId}/poster/...`
- `derived/{mediaId}/transcoded/...`

## Retention Classes
- `kyc_sensitive`
  - document images
  - selfie and liveness media
- `civic_evidence_standard`
  - complaint media
  - enforcement media
- `public_attachment`
  - approved petition attachments
- `audit_long_term`
  - selected audit payload exports if needed

Detailed retention and access rules are defined in `docs/security/identity-and-auth.md`.
