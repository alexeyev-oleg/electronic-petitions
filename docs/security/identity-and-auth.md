# Identity, Authentication, and Security

## Purpose
This document defines the Stage 2 security baseline for:
- registration and login
- identity verification and KYC
- session protection
- role-based access control
- media access restrictions
- retention and audit requirements

## Security Principles
- Minimize sensitive data stored locally.
- Use external KYC for document OCR, liveness, and face match.
- Require stronger verification only when needed.
- Keep staff and inspector access fully auditable.
- Separate public civic content from restricted identity data.
- Never allow citizen-submitted evidence to directly create a legal fine without staff validation.

## Identity Levels
### `anonymous`
- Can browse public content.
- Cannot submit protected actions.

### `phone_verified`
- Verified phone number.
- Can create an account and start limited flows.

### `basic_reporter`
- Phone verified and session trusted.
- Can submit general complaints and low-risk reports.

### `identity_verified`
- External KYC completed successfully.
- Can sign petitions and gets higher trust for complaints and enforcement reports.

### `staff_verified`
- Internal municipality or operator account.
- Requires stronger login policy, restricted devices, and audit.

## Registration Baseline
1. User enters phone number.
2. System sends OTP.
3. OTP is validated.
4. User adds email.
5. Email is verified by OTP or magic link.
6. System creates a draft user account.
7. User selects login method:
   - passwordless OTP
   - password + MFA
   - passkey where supported

## KYC Baseline
1. User enters government ID number.
2. User captures document images through guided capture.
3. Provider performs OCR.
4. System compares:
   - input document number
   - normalized document number
   - OCR result
   - format and checksum rules where available
5. User captures a selfie or guided live image.
6. Provider performs:
   - liveness detection
   - face match
   - fraud and risk checks
7. Result is stored as:
   - approved
   - manual review
   - rejected

## Authentication Baseline
### Recommended primary methods
- Passkeys for supported devices and staff
- OTP passwordless for residents
- Password + MFA only if required by business or compatibility needs

### Session design
- Short-lived access token
- Rotating refresh token
- Refresh token hash stored server-side
- Refresh bound to a device record where possible
- Session revocation supported per device

### Session risk checks
- unusual IP change
- impossible travel
- device change
- too many failed OTP attempts
- abnormal frequency of sensitive actions

## Step-Up Authentication
Require re-authentication for:
- signing a petition
- changing phone number
- changing verified identity data
- accessing KYC media
- staff login
- inspector legal actions
- publishing official municipality responses if policy requires
- converting an enforcement case into a validated official outcome

Allowed step-up methods:
- passkey re-auth
- OTP challenge
- MFA verification

## Role-Based Access Control
### Core roles
- `resident`
- `moderator`
- `operator`
- `inspector`
- `supervisor`
- `municipality_staff`
- `admin`

### RBAC rules
- permissions are assigned to roles
- roles are scoped by city and optionally department or service unit
- staff accounts must not access data outside their city scope unless explicitly allowed
- KYC media access must be more restricted than normal profile access

### Example permission groups
- `petition.create`
- `petition.publish`
- `petition.respond`
- `complaint.assign`
- `complaint.resolve`
- `enforcement.triage`
- `enforcement.dispatch`
- `enforcement.validate_outcome`
- `identity.review`
- `media.restricted.read`
- `audit.read`

## Media Security Model
### Media classes
- `public_attachment`
  - approved petition attachments
- `internal_case_media`
  - complaint and enforcement evidence
- `kyc_restricted`
  - document and selfie media

### Access rules
- `public_attachment`
  - readable by public if attached to a published public record
- `internal_case_media`
  - readable by authorized operators, inspectors, supervisors, and admins
- `kyc_restricted`
  - readable only by highly privileged identity review staff and admins with audit logging

### Delivery rules
- Do not expose raw DO Spaces object URLs publicly.
- Serve protected media through signed URLs or a proxy layer.
- Expire signed URLs quickly.
- Log every access to `kyc_restricted` media.

## Retention Policy Baseline
### `kyc_sensitive`
- Contents:
  - document front/back images
  - selfie
  - liveness capture
- Recommendation:
  - keep only as long as compliance and dispute requirements demand
  - prefer provider-side storage when legally acceptable
  - if stored locally, use restricted retention and deletion workflow

### `civic_evidence_standard`
- Contents:
  - complaint media
  - enforcement report media
- Recommendation:
  - retain while the case is active
  - extend retention for disputes, appeals, or legal review

### `public_attachment`
- Contents:
  - approved public petition files
- Recommendation:
  - retain while the petition remains public, subject to moderation and policy

### `audit_long_term`
- Contents:
  - audit event records and critical security trails
- Recommendation:
  - longer retention than business data, according to legal and municipal policy

## Audit Requirements
Audit every sensitive action:
- login success and failure
- KYC submission and result
- KYC media access
- role changes
- moderation decisions
- complaint assignment and closure
- enforcement triage, dispatch, validation, and fine issuance
- official response publication
- policy overrides and manual trust-score overrides

Audit event payload should include:
- actor
- role
- entity type and entity id
- action
- timestamp
- IP address
- target city or department scope
- selected diff or reason snapshot where relevant

## Geodata Trust and Anti-Fraud
Store and compare:
- device geodata
- EXIF geodata
- manual address
- normalized geodata

Suspicion triggers:
- city mismatch
- weak GPS accuracy
- EXIF missing while claiming live capture
- EXIF and device geodata diverge sharply
- capture time far from submission time
- repeated reports from suspicious device patterns

Response rules:
- do not automatically reject solely on mismatch
- require manual address when mismatch occurs
- lower trust score
- route through careful triage
- allow supervisor override with audit

## Citizen Report Trust Model
### Complaint flow
- `phone_verified` can be enough for standard complaints
- trust score affects routing priority and review depth

### Petition flow
- only `identity_verified` should be allowed to sign a petition

### Enforcement flow
- `basic_reporter` may submit a report
- `identity_verified` gets higher trust weighting
- legal action still requires staff validation

## Staff Security Baseline
- Staff accounts must use MFA or passkeys.
- Device binding is recommended for inspectors and supervisors.
- Admin actions should require step-up auth even within an active session.
- Privileged sessions should have shorter idle timeouts.
- Break-glass access must be rare, logged, and reviewed.

## Notification Security
- Never include full government ID numbers in notifications.
- Never include direct links to raw restricted media.
- Redact sensitive fields in email and push content.
- Localized templates must preserve the same security rules across all languages.

## Multilingual Security Considerations
- Store locale preference on the user profile.
- Security-critical notifications must be localizable into:
  - English
  - Hebrew
  - Russian
  - Arabic
- Admin templates for official actions should also support localization where required.
- RTL rendering must not break secure confirmation or warning flows.

## Operational Recommendations
- Use dedicated secrets management for provider keys.
- Separate production and non-production credentials.
- Restrict direct database access.
- Monitor failed login bursts, OTP abuse, and abnormal KYC failure spikes.
- Periodically review privileged access to KYC-restricted media.

## Stage 2 Output
This document defines the approved baseline for:
- identity assurance levels
- resident and staff authentication
- KYC orchestration
- session and step-up policy
- media access restrictions
- retention and audit expectations
