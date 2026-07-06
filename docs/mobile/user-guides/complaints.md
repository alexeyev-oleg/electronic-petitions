# Complaints in the Resident App

## What You Can Do in This Stage
In the current mobile stage, the complaints section lets residents:
- browse complaints
- open complaint details
- create a complaint
- capture device geolocation
- attach photos and videos from camera or gallery
- confirm location on a map preview before submit
- enter a manual address when geodata may be inaccurate

## Beta Notes
- Complaint data still uses mock repositories in beta builds.
- Photos and videos are stored locally on the device during beta testing.
- If coordinates appear outside the expected Haifa service area, manual address entry is required.
- Camera captures attach simulated EXIF coordinates from the device location when available.

## Browse Complaints
1. Open the `Complaints` section.
2. Review the list of complaints.
3. Tap a complaint to open its detail screen.

## Create a Complaint
1. Open the complaints section.
2. Tap the create action.
3. Enter the complaint title.
4. Enter the complaint description.
5. Tap `Use current location` to attach device coordinates.
6. If prompted, enter a manual address.
7. Attach media using `Take photo`, `Choose from gallery`, `Record video`, or `Choose video from gallery`.
8. Tap submit and review the location confirmation screen.
9. Confirm the location to finish creating the complaint.

## What the Detail Screen Shows
- complaint title
- status chip
- complaint description
- map preview with location label and coordinates
- attached photo and video gallery when media is present

## What Will Change Later
In later stages, the complaint flow will be expanded with:
- backend media upload
- reverse geocoding on a real map provider
- real EXIF geodata extraction from photos
- real status updates from the municipality
