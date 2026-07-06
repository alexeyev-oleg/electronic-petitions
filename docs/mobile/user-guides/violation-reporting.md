# Reporting a Violation

## What This Flow Is For
The violation reporting flow is intended for cases where a resident wants to report a possible municipal violation, for example:
- blocked sidewalk
- illegal parking
- dumping or nuisance issues
- other reportable municipal violations

## What You Can Do in This Stage
In the current mobile stage, the flow lets the resident:
- create a violation report
- add a title and description
- capture device geolocation
- attach photo and video evidence from camera or gallery
- confirm location on a map preview before evidence review
- flag that automatic location may be inaccurate
- provide a manual address
- review the evidence summary before sending

## Why the App May Ask for a Manual Address
Sometimes device geodata may be inaccurate or mismatched, for example when coordinates are redirected outside the expected service area.

In this case, the app asks the user to confirm the location manually.
This helps preserve the quality of the report and prepare it for later review.

## Reporting Flow
1. Open `Report a Violation`.
2. Enter the report title.
3. Enter the report description.
4. Tap `Use current location`.
5. Attach photos or videos if available.
6. If location may be inaccurate, enable the mismatch option or follow the automatic mismatch warning.
7. Enter the manual address when required.
8. Tap review and confirm the location on the map preview.
9. Open the evidence review step.
10. Review the summary and submit the report.

## Evidence Review
Before final submission, the review screen shows:
- report title
- description
- map preview with location label and coordinates
- attached photo and video previews
- whether geo confidence is standard or low

## Beta Notes
- Reports still use mock repositories in beta builds.
- Media files remain on the device until backend upload is connected.
- iOS requires microphone permission when recording video evidence.
- Demo report IDs `e1`, `e2`, and `e3` also appear in the Inspector App triage queue for end-to-end mock review. See `docs/mobile/mock-demo-data.md`.
