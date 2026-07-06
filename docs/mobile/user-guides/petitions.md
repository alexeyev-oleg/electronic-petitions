# Petitions in the Resident App

## What You Can Do in This Stage
In the current resident app stage, the petitions section lets you:
- browse petitions
- search petitions by title or summary
- filter by status (all, published, in review, draft)
- open petition details
- create a petition draft
- attach photos and supporting documents to a petition
- review your own petitions
- sign a petition after mock KYC approval

## Beta Notes
- Petition signing uses mock identity verification and OTP `123456`.
- Some petition data comes from mock sources during testing.
- Signature count updates locally until the backend is connected.
- Attachment files are stored locally in mock mode until backend upload is connected.

## Browse and Filter Petitions
1. Open the `Petitions` section.
2. Use the search field to find petitions by title or summary.
3. Tap a filter chip: `All`, `Published`, `In review`, or `Draft`.
4. Tap a petition to open its details.

## View Petition Details
The detail screen shows:
- petition title
- summary
- status chip
- attached photos and documents (when present)
- current signature count
- sign action when KYC is approved

If identity verification is not complete, the app shows a link to start mock KYC.

Demo seed petitions may show placeholder previews for mock attachment paths.

## Create a Petition
1. Open the petitions screen.
2. Tap the create action.
3. Enter a petition title.
4. Enter a short summary.
5. Optionally attach up to **5 files total**:
   - photos from camera or gallery
   - documents: PDF, Word (`.doc`/`.docx`), Excel (`.xls`/`.xlsx`)
6. Video attachments are **not** supported in petitions.
7. Save the draft.

The attachment counter shows `current / 5`. When the limit is reached, add buttons are disabled.

## My Petitions
Use `My petitions` to review petitions created by the current user in the beta flow.

## What Will Change Later
In later stages, the petitions flow will be expanded with:
- backend-connected moderation and publication
- server-side file upload and virus scanning
- legally binding signature rules
- richer status history and official municipality responses
