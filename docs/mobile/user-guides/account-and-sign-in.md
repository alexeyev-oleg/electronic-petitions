# Account and Sign-In

## Beta Account Model
In the current beta version, account access supports:
- sign up with `email + password`
- sign in with the same credentials
- session persistence between app restarts in secure storage
- optional upgrade to a secure session through phone verification
- optional mock identity verification (KYC) for protected actions

## Validation Rules
- Email must be a valid email format.
- Password is required for sign-in.
- For sign-up, password must be at least 8 characters.
- Phone numbers must contain enough digits for beta validation.
- Mock OTP and sensitive-action codes use `123456` in beta builds.

## How to Create an Account
1. Open the app.
2. Complete onboarding if this is your first launch.
3. Switch to `Create account`.
4. Enter a valid email.
5. Enter a password with at least 8 characters.
6. Tap `Create account`.

After sign-up, the app stores a beta session and shows an email verification pending notice. This is a mock state until real verification is connected.

## How to Sign In
1. Open the app.
2. If you already completed onboarding, the app restores your session automatically when possible.
3. Otherwise enter your email and password.
4. Tap `Sign in`.

## Secure Session Upgrade
After sign-in, you can upgrade from a beta session to a secure session:

1. Open `Profile` or follow the home banner.
2. Open `Verify phone number`.
3. Enter a phone number and tap `Send code`.
4. Enter the beta mock code `123456`.
5. Your session tier changes to `Secure session`.

## Identity Verification (Mock KYC)
Petition signing and other protected actions require mock KYC approval:

1. Complete phone verification first.
2. Open `Profile` and tap `Start identity verification`.
3. Enter a document number.
4. Tap `Simulate document capture` and `Simulate selfie capture`.
5. Submit verification.

When approved, petition signing becomes available.

## Sensitive Action Confirmation
When signing a petition, the app asks for a step-up confirmation code.
In beta mock mode, enter `123456` to confirm the action.

## Session Persistence
- Successful sign-in, sign-up, and secure upgrades are saved locally in secure storage.
- After closing and reopening the app, you should remain signed in with your latest verification state.
- `Log out` clears the saved session.

## Forgot Password
- Use `Forgot password` on the sign-in screen.
- Enter a valid email address.
- In the current beta stage, this flow is a placeholder reset simulation.
- In a later connected backend phase, this flow will send a real reset link or secure recovery action.

## Important Beta Notice
- Phone verification and KYC flows are mock simulations for UX testing.
- Real OTP, document OCR, liveness, and provider callbacks will be connected later.
- Legal or sensitive actions remain limited until backend secure registration is enabled.

## If Sign-In Does Not Work
- Check that your email format is valid.
- For sign-up, use at least 8 characters in the password.
- Try signing in again after a moment.
- Use `Log out` and sign in again if the session looks stale.
