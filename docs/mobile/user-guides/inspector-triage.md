# Inspector Triage in the Inspector App

## What You Can Do in This Stage
In the current inspector app mock build, staff can:
- sign in with mock staff credentials
- open the enforcement triage queue
- filter reports by status and trust level
- review report evidence and geo-trust warnings
- record inspector actions with OTP confirmation
- persist action results locally until backend integration

## Beta Notes
- This is a **mock staff app** — no backend, no legally binding outcomes.
- Staff OTP for protected actions: **`123456`**
- Demo report IDs (`e1`, `e2`, `e3`) align with resident violation reporting seed data.
- Evidence previews use mock file paths until real uploads are connected.

## Sign In
1. Open the Inspector App (`main_mock.dart` flavor).
2. Enter staff email: `inspector@haifa.mock`
3. Enter password: `inspector123`
4. Tap **Sign in**.

Session persists on device until **Sign out**.

## Open the Triage Queue
1. From the inspector home screen, tap **Open triage queue**.
2. Review the queue counter and report cards.
3. Tap a report to open its detail screen.

## Filter the Queue
### Status filters
- **All**
- **Triage**
- **Review required**

### Trust filters
- **All trust**
- **Standard trust**
- **Low geo confidence**

Combine filters to narrow the queue. Empty results mean no report matches both selected filters.

## Review a Report
The detail screen shows:
- title, status, and description
- location label and coordinates (when available)
- trust level and submission time
- geo mismatch banner when manual address review is required
- evidence gallery (photo/video placeholders in mock mode)
- inspector action buttons while the report is still open

## Record Inspector Actions
Protected actions require staff OTP **`123456`**.

### From triage or review status
- **Mark as invalid** — closes the report as invalid
- **Merge with existing case** — enter an existing case ID; action note is saved
- **Dispatch field task** — moves report to dispatch status

### After dispatch
- **Record warning**
- **Record fine**
- **Close with no action**

When a report reaches a closed status (`invalid`, `merged`, or any `validated_*` outcome), action buttons are hidden.

## Demo Report IDs (shared with Resident App)
| ID | Title | Typical use in demo |
|----|-------|---------------------|
| `e1` | Illegal parking across sidewalk | standard trust + media evidence |
| `e2` | Possible illegal dumping | low geo confidence + manual address |
| `e3` | Blocked fire lane | additional triage item |

## What Will Change Later
- backend-connected inspector authentication and device binding
- real media download from secure storage
- supervisor escalation and audit export
- shared live queue with resident submissions in real time
- separate dispatch task tracking screen

See also: `docs/mobile/build-inspector-apk.md`, `docs/mobile/mock-demo-data.md`
