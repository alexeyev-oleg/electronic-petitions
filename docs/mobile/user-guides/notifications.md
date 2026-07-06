# Notifications and Inbox

## What the Inbox Is For
The inbox shows important updates such as:
- petition status changes
- complaint updates
- enforcement report updates

## What You Can Do in This Stage
In the current stage, you can:
- open the inbox
- review notification items
- mark items as read by opening them

## Push Notifications (Beta Scaffold)
Push is prepared but not fully connected yet:
- enabling push in Profile generates a **mock device token**
- no real FCM/APNs delivery until backend integration
- the toggle validates UX and future wiring

## Where to Find It
1. Open the home screen.
2. Tap `Inbox` for in-app messages.
3. Open `Profile` → notification preferences for push toggle and mock token status.

## Beta Notes
- Notification list data may come from mock sources.
- Created items persist on the device between app restarts in mock mode.
- Real push delivery requires backend + Firebase/APNs setup.

## What Will Change Later
In later stages, notifications will be extended with:
- backend-connected inbox events
- real push notifications with deep links
- operator-generated status updates from the municipality
