import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'),
    Locale('he'),
    Locale('ru'),
    Locale('ar'),
  ];

  static const delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    final localizations = Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
    assert(localizations != null, 'AppLocalizations not found in context.');
    return localizations!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'appTitle': 'Resident App',
      'betaBanner': 'Beta mode',
      'signIn': 'Sign in',
      'signUp': 'Create account',
      'email': 'Email',
      'password': 'Password',
      'forgotPassword': 'Forgot password',
      'forgotPasswordHelp': 'Enter your email to continue the password reset beta flow.',
      'sendResetLink': 'Send reset link',
      'resetLinkSentNotice': 'If this were a connected backend, a reset link would be sent to your email.',
      'continueCta': 'Continue',
      'logout': 'Log out',
      'homeTitle': 'Resident Home',
      'petitions': 'Petitions',
      'myPetitions': 'My petitions',
      'createPetition': 'Create petition',
      'petitionDetail': 'Petition detail',
      'petitionTitle': 'Petition title',
      'petitionSummary': 'Petition summary',
      'petitionNotFound': 'Petition not found.',
      'noPetitionsYet': 'You have not created petitions yet.',
      'statusLabel': 'Status',
      'signatureCountLabel': 'Signatures',
      'betaSignaturePlaceholder': 'Petition signing will be enabled after secure verification.',
      'complaints': 'Complaints',
      'createComplaint': 'Create complaint',
      'complaintDetail': 'Complaint detail',
      'complaintTitle': 'Complaint title',
      'complaintDescription': 'Complaint description',
      'complaintNotFound': 'Complaint not found.',
      'locationLabel': 'Location',
      'manualAddress': 'Manual address',
      'attachMediaPlaceholder': 'Attach media placeholder',
      'useCurrentLocation': 'Use current location',
      'captureLocationFailed': 'Could not capture location. Enter address manually.',
      'attachPhoto': 'Attach photo',
      'attachMedia': 'Attach media',
      'takePhoto': 'Take photo',
      'takeVideo': 'Record video',
      'pickFromGallery': 'Choose from gallery',
      'pickVideoFromGallery': 'Choose video from gallery',
      'attachedMediaCount': 'Attached media',
      'videoLabel': 'Video',
      'confirmLocationTitle': 'Confirm location',
      'confirmLocationHelp': 'Review the map preview and address before submitting.',
      'confirmLocationAction': 'Confirm location',
      'editLocationAction': 'Edit location',
      'deviceCoordinates': 'Device coordinates',
      'geoMismatchDetected': 'Location appears outside the expected service area. Manual address is required.',
      'manualAddressRequired': 'Manual address is required.',
      'removePhoto': 'Remove',
      'enforcement': 'Report a Violation',
      'createEnforcementReport': 'Create violation report',
      'enforcementReportDetail': 'Violation report detail',
      'enforcementReportNotFound': 'Violation report not found.',
      'enforcementTitle': 'Violation title',
      'enforcementDescription': 'Violation description',
      'reviewEvidence': 'Review evidence',
      'submitReport': 'Submit report',
      'mediaEvidence': 'Media evidence',
      'yesLabel': 'Yes',
      'noLabel': 'No',
      'trustLevelLabel': 'Trust level',
      'standardTrust': 'Standard',
      'lowGeoConfidence': 'Low geo confidence',
      'locationMismatchToggle': 'Location may be inaccurate',
      'locationMismatchHelp': 'Use this if automatic geodata may be incorrect and manual address confirmation is required.',
      'manualAddressRequiredNotice': 'Manual address confirmation is required because the location may not match expected geodata.',
      'profile': 'Profile',
      'inbox': 'Inbox',
      'noNotificationsYet': 'No notifications yet.',
      'language': 'Language',
      'accountInformation': 'Account information',
      'notificationPreferences': 'Notification preferences',
      'emailNotifications': 'Email notifications',
      'pushNotifications': 'Push notifications',
      'mockModeNotice': 'This build uses mock data and simplified beta authentication.',
      'onboardingNext': 'Next',
      'onboardingGetStarted': 'Get started',
      'onboardingLanguagePrompt': 'Choose your language',
      'onboardingSlideWelcomeTitle': 'Welcome to Resident App',
      'onboardingSlideWelcomeBody': 'Connect with your municipality through petitions, complaints, and violation reports.',
      'onboardingSlidePetitionsTitle': 'Electronic petitions',
      'onboardingSlidePetitionsBody': 'Browse active petitions, follow progress, and prepare to support causes that matter to your community.',
      'onboardingSlideComplaintsTitle': 'City complaints',
      'onboardingSlideComplaintsBody': 'Report municipal issues with photos, location data, and clear status tracking.',
      'onboardingSlideViolationsTitle': 'Report violations',
      'onboardingSlideViolationsBody': 'Send evidence to municipal enforcement teams when you witness a probable violation.',
      'helpAndSupport': 'Help and support',
      'aboutApp': 'About the app',
      'helpFaq': 'FAQ',
      'aboutDescription': 'Resident App helps citizens interact with municipal services through petitions, complaints, and violation reporting.',
      'appVersionLabel': 'Version',
      'faqQuestionBeta': 'Why does the app show beta or mock mode?',
      'faqAnswerBeta': 'This build is for early testing. Data and authentication are simplified until design and functionality are approved.',
      'faqQuestionLanguage': 'How do I change the language?',
      'faqAnswerLanguage': 'Open Profile and choose a language. You can also set it during first launch onboarding.',
      'faqQuestionSecureAuth': 'When will secure registration be enabled?',
      'faqAnswerSecureAuth': 'Secure verification with document and identity checks will be added after beta UX approval.',
      'emailRequired': 'Email is required.',
      'emailInvalid': 'Enter a valid email address.',
      'passwordRequired': 'Password is required.',
      'passwordTooShort': 'Password must be at least 8 characters.',
      'emailVerificationPending': 'Email verification is pending. Some actions may stay limited in beta until verification is enabled.',
      'loadErrorMessage': 'Could not load data. Try again.',
      'retryAction': 'Retry',
      'emptyComplaints': 'No complaints yet.',
      'emptyEnforcementReports': 'No violation reports yet.',
      'mockDataPersistNotice': 'Mock data is saved on this device between app restarts.',
      'mockBetaSettings': 'Beta testing',
      'simulateLoadError': 'Simulate list load error',
      'simulateLoadErrorHelp': 'Use this toggle to test error and retry states on list screens.',
      'importMockSnapshot': 'Import admin mock snapshot',
      'importMockSnapshotHelp':
          'Pick gesher-mock-*.json exported from Admin Web to sync petitions, complaints, and enforcement.',
      'importMockSnapshotSuccess': 'Mock snapshot imported.',
      'importMockSnapshotFailed': 'Could not import snapshot. Check file version and format.',
      'phoneVerificationTitle': 'Phone verification',
      'phoneVerificationHelp': 'Verify your phone number to upgrade from beta to a secure session.',
      'phoneNumberLabel': 'Phone number',
      'phoneRequired': 'Phone number is required.',
      'phoneInvalid': 'Enter a valid phone number.',
      'sendOtpAction': 'Send code',
      'otpCodeLabel': 'Verification code',
      'otpRequired': 'Verification code is required.',
      'otpInvalid': 'Enter the 6-digit verification code.',
      'otpSentNotice': 'A mock verification code was sent for beta testing.',
      'verifyPhoneAction': 'Verify phone',
      'phoneVerifiedLabel': 'Verified phone',
      'phoneVerifiedNotice': 'Phone verified. Your session is now secure.',
      'phoneMismatchError': 'Phone number does not match the sent code request.',
      'mockOtpHint': 'Beta mock code: {code}',
      'secureVerificationTitle': 'Secure verification',
      'sessionTierLabel': 'Session tier',
      'sessionTierBeta': 'Beta session',
      'sessionTierSecure': 'Secure session',
      'verifyPhoneCta': 'Verify phone number',
      'kycVerificationTitle': 'Identity verification',
      'kycVerificationHelp': 'Complete mock KYC to unlock petition signing and higher-trust actions.',
      'kycStatusLabel': 'Verification status',
      'kycStatusNotStarted': 'Not started',
      'kycStatusPending': 'Pending review',
      'kycStatusApproved': 'Approved',
      'kycStatusManualReview': 'Manual review',
      'kycStatusRejected': 'Rejected',
      'phoneRequiredBeforeKyc': 'Verify your phone number before starting identity verification.',
      'kycDocumentStepTitle': 'Document and selfie capture',
      'documentNumberLabel': 'Government ID number',
      'documentNumberRequired': 'Document number is required.',
      'documentNumberInvalid': 'Enter a valid document number.',
      'simulateDocumentCapture': 'Simulate document capture',
      'simulateSelfieCapture': 'Simulate selfie capture',
      'submitKycAction': 'Submit verification',
      'kycApprovedNotice': 'Identity verification approved in mock mode.',
      'startKycAction': 'Start identity verification',
      'secureUpgradeNotice': 'Upgrade your account with phone verification and identity checks to unlock protected actions.',
      'phoneVerificationBanner': 'Verify your phone number to upgrade to a secure session.',
      'kycRequiredBanner': 'Complete identity verification to sign petitions.',
      'signPetitionAction': 'Sign petition',
      'petitionSignedNotice': 'Petition signed in mock mode.',
      'kycRequiredForAction': 'Identity verification is required for this action.',
      'secureSessionRequired': 'A secure phone-verified session is required.',
      'sensitiveActionTitle': 'Confirm sensitive action',
      'sensitiveActionMessage': 'Enter the verification code to confirm this protected action.',
      'confirmSensitiveAction': 'Confirm action',
      'cancelAction': 'Cancel',
      'searchPetitions': 'Search petitions',
      'filterAll': 'All',
      'filterPublished': 'Published',
      'filterInReview': 'In review',
      'filterDraft': 'Draft',
      'noPetitionsMatch': 'No petitions match your search or filter.',
      'pushScaffoldTitle': 'Push notifications (beta scaffold)',
      'pushScaffoldNotice': 'Push delivery is mocked locally until the backend and FCM are connected.',
      'pushDeviceTokenLabel': 'Mock device token',
      'pushStatusDisabled': 'Push disabled',
      'pushStatusPending': 'Push registration pending',
      'pushStatusRegistered': 'Push scaffold registered',
      'faqQuestionLocation': 'Why does the app ask for location permission?',
      'faqAnswerLocation': 'Location helps attach coordinates to complaints and reports. You can always enter an address manually if GPS is inaccurate.',
      'faqQuestionMedia': 'Why can the app use camera, gallery, or microphone?',
      'faqAnswerMedia': 'Media permissions are used only when you attach photo or video evidence to a complaint or violation report.',
      'faqQuestionPendingStatus': 'Why does my case show pending or review?',
      'faqAnswerPendingStatus': 'In beta mock mode, statuses simulate municipal processing. Real status updates will come from the backend later.',
      'faqQuestionMockOtp': 'What code should I use for phone or sensitive actions?',
      'faqAnswerMockOtp': 'In this beta build, use 123456 for mock OTP and sensitive-action confirmation.',
      'petitionAttachmentsTitle': 'Attachments',
      'petitionAttachmentsHelp':
          'Add photos or documents: PDF, Word, or Excel (up to 5 total).',
      'attachPetitionFile': 'Attach file',
      'petitionAttachmentLimitReached': 'You can attach up to 5 files in total.',
      'petitionAttachmentTypeNotAllowed':
          'Only photos, PDF, Word, and Excel files are supported.',
      'petitionAttachmentCountLabel': '{current} / {max} attachments',
      'petitionAttachmentPhotosLabel': 'Photos',
      'petitionAttachmentDocumentsLabel': 'Documents',
      'petitionAttachmentTypePdf': 'PDF',
      'petitionAttachmentTypeDoc': 'Word',
      'petitionAttachmentTypeExcel': 'Excel',
    },
    'he': {
      'appTitle': 'אפליקציית תושבים',
      'betaBanner': 'מצב בטא',
      'signIn': 'התחברות',
      'signUp': 'יצירת חשבון',
      'email': 'אימייל',
      'password': 'סיסמה',
      'forgotPassword': 'שכחתי סיסמה',
      'forgotPasswordHelp': 'הזינו את האימייל כדי להמשיך בתהליך איפוס סיסמה של גרסת הבטא.',
      'sendResetLink': 'שליחת קישור איפוס',
      'resetLinkSentNotice': 'אם זו היתה סביבת backend מחוברת, קישור איפוס היה נשלח לאימייל שלך.',
      'continueCta': 'המשך',
      'logout': 'התנתקות',
      'homeTitle': 'מסך הבית לתושב',
      'petitions': 'עצומות',
      'myPetitions': 'העצומות שלי',
      'createPetition': 'יצירת עצומה',
      'petitionDetail': 'פרטי עצומה',
      'petitionTitle': 'כותרת עצומה',
      'petitionSummary': 'סיכום העצומה',
      'petitionNotFound': 'העצומה לא נמצאה.',
      'noPetitionsYet': 'עדיין לא יצרת עצומות.',
      'statusLabel': 'סטטוס',
      'signatureCountLabel': 'חתימות',
      'betaSignaturePlaceholder': 'חתימה על עצומה תופעל לאחר אימות מאובטח.',
      'complaints': 'תלונות',
      'createComplaint': 'יצירת תלונה',
      'complaintDetail': 'פרטי תלונה',
      'complaintTitle': 'כותרת התלונה',
      'complaintDescription': 'תיאור התלונה',
      'complaintNotFound': 'התלונה לא נמצאה.',
      'locationLabel': 'מיקום',
      'manualAddress': 'כתובת ידנית',
      'attachMediaPlaceholder': 'סימון לצירוף מדיה',
      'useCurrentLocation': 'שימוש במיקום הנוכחי',
      'captureLocationFailed': 'לא ניתן לקבל מיקום. הזינו כתובת ידנית.',
      'attachPhoto': 'צירוף תמונה',
      'attachMedia': 'צירוף מדיה',
      'takePhoto': 'צילום תמונה',
      'takeVideo': 'צילום וידאו',
      'pickFromGallery': 'בחירה מהגלריה',
      'pickVideoFromGallery': 'בחירת וידאו מהגלריה',
      'attachedMediaCount': 'מדיה מצורפת',
      'videoLabel': 'וידאו',
      'confirmLocationTitle': 'אישור מיקום',
      'confirmLocationHelp': 'בדקו את תצוגת המפה והכתובת לפני השליחה.',
      'confirmLocationAction': 'אישור מיקום',
      'editLocationAction': 'עריכת מיקום',
      'deviceCoordinates': 'קואורדינטות המכשיר',
      'geoMismatchDetected': 'נראה שהמיקום מחוץ לאזור השירות הצפוי. נדרשת כתובת ידנית.',
      'manualAddressRequired': 'נדרשת כתובת ידנית.',
      'removePhoto': 'הסרה',
      'enforcement': 'דיווח על הפרה',
      'createEnforcementReport': 'יצירת דיווח על הפרה',
      'enforcementReportDetail': 'פרטי דיווח על הפרה',
      'enforcementReportNotFound': 'דיווח ההפרה לא נמצא.',
      'enforcementTitle': 'כותרת ההפרה',
      'enforcementDescription': 'תיאור ההפרה',
      'reviewEvidence': 'סקירת ראיות',
      'submitReport': 'שליחת דיווח',
      'mediaEvidence': 'ראיות מדיה',
      'yesLabel': 'כן',
      'noLabel': 'לא',
      'trustLevelLabel': 'רמת אמון',
      'standardTrust': 'רגילה',
      'lowGeoConfidence': 'אמינות מיקום נמוכה',
      'locationMismatchToggle': 'ייתכן שהמיקום אינו מדויק',
      'locationMismatchHelp': 'השתמשו בכך אם ייתכן שנתוני המיקום האוטומטיים שגויים ונדרש אישור כתובת ידני.',
      'manualAddressRequiredNotice': 'נדרש אישור כתובת ידני מפני שהמיקום עשוי לא להתאים לנתוני המיקום הצפויים.',
      'profile': 'פרופיל',
      'inbox': 'תיבת הודעות',
      'noNotificationsYet': 'עדיין אין התראות.',
      'language': 'שפה',
      'accountInformation': 'פרטי חשבון',
      'notificationPreferences': 'העדפות התראות',
      'emailNotifications': 'התראות אימייל',
      'pushNotifications': 'התראות פוש',
      'mockModeNotice': 'גרסה זו משתמשת בנתוני דמה ובאימות בטא פשוט.',
      'onboardingNext': 'הבא',
      'onboardingGetStarted': 'התחלה',
      'onboardingLanguagePrompt': 'בחרו שפה',
      'onboardingSlideWelcomeTitle': 'ברוכים הבאים לאפליקציית התושבים',
      'onboardingSlideWelcomeBody': 'התחברו לעירייה דרך עצומות, תלונות ודיווחי הפרות.',
      'onboardingSlidePetitionsTitle': 'עצומות אלקטרוניות',
      'onboardingSlidePetitionsBody': 'עיינו בעצומות פעילות, עקבו אחר התקדמות והיערכו לתמיכה בנושאים חשובים.',
      'onboardingSlideComplaintsTitle': 'תלונות עירוניות',
      'onboardingSlideComplaintsBody': 'דווחו על בעיות עירוניות עם תמונות, מיקום ומעקב סטטוס ברור.',
      'onboardingSlideViolationsTitle': 'דיווח על הפרות',
      'onboardingSlideViolationsBody': 'שלחו ראיות לצוותי האכיפה העירוניים כשאתם עדים להפרה.',
      'helpAndSupport': 'עזרה ותמיכה',
      'aboutApp': 'אודות האפליקציה',
      'helpFaq': 'שאלות נפוצות',
      'aboutDescription': 'אפליקציית התושבים מאפשרת לאזרחים לפנות לשירותים עירוניים דרך עצומות, תלונות ודיווחי הפרות.',
      'appVersionLabel': 'גרסה',
      'faqQuestionBeta': 'למה האפליקציה מציגה מצב בטא או דמה?',
      'faqAnswerBeta': 'גרסה זו מיועדת לבדיקות מוקדמות. הנתונים והאימות פשוטים עד לאישור העיצוב והפונקציונליות.',
      'faqQuestionLanguage': 'איך משנים שפה?',
      'faqAnswerLanguage': 'פתחו פרופיל ובחרו שפה. ניתן גם לבחור בשלב ההתחברות הראשון.',
      'faqQuestionSecureAuth': 'מתי יופעל אימות מאובטח?',
      'faqAnswerSecureAuth': 'אימות מאובטח עם בדיקת זהות ומסמכים יתווסף לאחר אישור חוויית הבטא.',
      'emailRequired': 'נדרש להזין אימייל.',
      'emailInvalid': 'הזינו כתובת אימייל תקינה.',
      'passwordRequired': 'נדרש להזין סיסמה.',
      'passwordTooShort': 'הסיסמה חייבת להכיל לפחות 8 תווים.',
      'emailVerificationPending': 'אימות האימייל ממתין. חלק מהפעולות עשויות להיות מוגבלות בגרסת הבטא.',
      'loadErrorMessage': 'לא ניתן לטעון נתונים. נסו שוב.',
      'retryAction': 'נסו שוב',
      'emptyComplaints': 'עדיין אין תלונות.',
      'emptyEnforcementReports': 'עדיין אין דיווחי הפרות.',
      'mockDataPersistNotice': 'נתוני הדמה נשמרים במכשיר זה בין הפעלות האפליקציה.',
      'mockBetaSettings': 'בדיקות בטא',
      'simulateLoadError': 'הדמיית שגיאת טעינה',
      'simulateLoadErrorHelp': 'השתמשו במתג זה כדי לבדוק מצבי שגיאה ונסיון חוזר במסכי רשימה.',
      'importMockSnapshot': 'ייבוא mock snapshot',
      'importMockSnapshotHelp': 'בחרו קובץ JSON שיוצא מ-Admin Web.',
      'importMockSnapshotSuccess': 'ה-snapshot יובא.',
      'importMockSnapshotFailed': 'לא ניתן לייבא snapshot.',
      'phoneVerificationTitle': 'אימות טלפון',
      'phoneVerificationHelp': 'אמתו את מספר הטלפון כדי לשדרג מבטא לסשן מאובטח.',
      'phoneNumberLabel': 'מספר טלפון',
      'phoneRequired': 'נדרש מספר טלפון.',
      'phoneInvalid': 'הזינו מספר טלפון תקין.',
      'sendOtpAction': 'שליחת קוד',
      'otpCodeLabel': 'קוד אימות',
      'otpRequired': 'נדרש קוד אימות.',
      'otpInvalid': 'הזינו קוד אימות בן 6 ספרות.',
      'otpSentNotice': 'קוד אימות דמה נשלח לבדיקות בטא.',
      'verifyPhoneAction': 'אימות טלפון',
      'phoneVerifiedLabel': 'טלפון מאומת',
      'phoneVerifiedNotice': 'הטלפון אומת. הסשן שלכם מאובטח כעת.',
      'phoneMismatchError': 'מספר הטלפון אינו תואם לבקשת הקוד.',
      'mockOtpHint': 'קוד דמה לבטא: {code}',
      'secureVerificationTitle': 'אימות מאובטח',
      'sessionTierLabel': 'רמת סשן',
      'sessionTierBeta': 'סשן בטא',
      'sessionTierSecure': 'סשן מאובטח',
      'verifyPhoneCta': 'אימות מספר טלפון',
      'kycVerificationTitle': 'אימות זהות',
      'kycVerificationHelp': 'השלימו KYC דמה כדי לפתוח חתימה על עצומות ופעולות בעלות אמון גבוה.',
      'kycStatusLabel': 'סטטוס אימות',
      'kycStatusNotStarted': 'לא התחיל',
      'kycStatusPending': 'ממתין לבדיקה',
      'kycStatusApproved': 'מאושר',
      'kycStatusManualReview': 'בדיקה ידנית',
      'kycStatusRejected': 'נדחה',
      'phoneRequiredBeforeKyc': 'יש לאמת טלפון לפני תחילת אימות זהות.',
      'kycDocumentStepTitle': 'צילום מסמך וסלפי',
      'documentNumberLabel': 'מספר תעודת זהות',
      'documentNumberRequired': 'נדרש מספר מסמך.',
      'documentNumberInvalid': 'הזינו מספר מסמך תקין.',
      'simulateDocumentCapture': 'הדמיית צילום מסמך',
      'simulateSelfieCapture': 'הדמיית צילום סלפי',
      'submitKycAction': 'שליחת אימות',
      'kycApprovedNotice': 'אימות זהות אושר במצב דמה.',
      'startKycAction': 'התחלת אימות זהות',
      'secureUpgradeNotice': 'שדרגו את החשבון עם אימות טלפון וזהות כדי לפתוח פעולות מוגנות.',
      'phoneVerificationBanner': 'אמתו את מספר הטלפון כדי לשדרג לסשן מאובטח.',
      'kycRequiredBanner': 'השלימו אימות זהות כדי לחתום על עצומות.',
      'signPetitionAction': 'חתימה על עצומה',
      'petitionSignedNotice': 'העצומה נחתמה במצב דמה.',
      'kycRequiredForAction': 'נדרש אימות זהות לפעולה זו.',
      'secureSessionRequired': 'נדרש סשן מאובטח עם טלפון מאומת.',
      'sensitiveActionTitle': 'אישור פעולה רגישה',
      'sensitiveActionMessage': 'הזינו קוד אימות כדי לאשר פעולה מוגנת זו.',
      'confirmSensitiveAction': 'אישור פעולה',
      'cancelAction': 'ביטול',
      'searchPetitions': 'חיפוש עצומות',
      'filterAll': 'הכל',
      'filterPublished': 'פורסמו',
      'filterInReview': 'בבדיקה',
      'filterDraft': 'טיוטה',
      'noPetitionsMatch': 'לא נמצאו עצומות לפי החיפוש או הסינון.',
      'pushScaffoldTitle': 'התראות push (שלד בטא)',
      'pushScaffoldNotice': 'משלוח push מדומה מקומית עד לחיבור backend ו-FCM.',
      'pushDeviceTokenLabel': 'Mock device token',
      'pushStatusDisabled': 'Push כבוי',
      'pushStatusPending': 'רישום push ממתין',
      'pushStatusRegistered': 'שלד push נרשם',
      'faqQuestionLocation': 'למה האפליקציה מבקשת הרשאת מיקום?',
      'faqAnswerLocation': 'מיקום עוזר לצרף קואורדינטות לתלונות ודיווחים. תמיד אפשר להזין כתובת ידנית.',
      'faqQuestionMedia': 'למה האפליקציה משתמשת במצלמה, בגלריה או במיקרופון?',
      'faqAnswerMedia': 'הרשאות מדיה משמשות רק כשאתם מצרפים תמונה או וידאו לתלונה או דיווח.',
      'faqQuestionPendingStatus': 'למה הסטטוס מציג pending או review?',
      'faqAnswerPendingStatus': 'במצב mock, הסטטוס מדמה עיבוד עירוני. עדכונים אמיתיים יגיעו מה-backend.',
      'faqQuestionMockOtp': 'איזה קוד להשתמש לטלפון או פעולות רגישות?',
      'faqAnswerMockOtp': 'בגרסת בטא זו השתמשו ב-123456 ל-OTP mock ולאישור פעולות רגישות.',
      'petitionAttachmentsTitle': 'קבצים מצורפים',
      'petitionAttachmentsHelp':
          'ניתן לצרף תמונות או מסמכים: PDF, Word או Excel (עד 5 בסך הכל).',
      'attachPetitionFile': 'צירוף קובץ',
      'petitionAttachmentLimitReached': 'ניתן לצרף עד 5 קבצים בסך הכל.',
      'petitionAttachmentTypeNotAllowed':
          'נתמכים רק תמונות, PDF, Word ו-Excel.',
      'petitionAttachmentCountLabel': '{current} / {max} קבצים מצורפים',
      'petitionAttachmentPhotosLabel': 'תמונות',
      'petitionAttachmentDocumentsLabel': 'מסמכים',
      'petitionAttachmentTypePdf': 'PDF',
      'petitionAttachmentTypeDoc': 'Word',
      'petitionAttachmentTypeExcel': 'Excel',
    },
    'ru': {
      'appTitle': 'Приложение жителя',
      'betaBanner': 'Бета-режим',
      'signIn': 'Войти',
      'signUp': 'Создать аккаунт',
      'email': 'Email',
      'password': 'Пароль',
      'forgotPassword': 'Забыли пароль',
      'forgotPasswordHelp': 'Введите email, чтобы продолжить beta-сценарий сброса пароля.',
      'sendResetLink': 'Отправить ссылку',
      'resetLinkSentNotice': 'Если бы backend был подключен, ссылка для сброса была бы отправлена на ваш email.',
      'continueCta': 'Продолжить',
      'logout': 'Выйти',
      'homeTitle': 'Главная жителя',
      'petitions': 'Петиции',
      'myPetitions': 'Мои петиции',
      'createPetition': 'Создать петицию',
      'petitionDetail': 'Карточка петиции',
      'petitionTitle': 'Название петиции',
      'petitionSummary': 'Краткое описание петиции',
      'petitionNotFound': 'Петиция не найдена.',
      'noPetitionsYet': 'Вы еще не создавали петиции.',
      'statusLabel': 'Статус',
      'signatureCountLabel': 'Подписи',
      'betaSignaturePlaceholder': 'Подписание петиции будет включено после безопасной верификации.',
      'complaints': 'Жалобы',
      'createComplaint': 'Создать жалобу',
      'complaintDetail': 'Карточка жалобы',
      'complaintTitle': 'Название жалобы',
      'complaintDescription': 'Описание жалобы',
      'complaintNotFound': 'Жалоба не найдена.',
      'locationLabel': 'Локация',
      'manualAddress': 'Ручной адрес',
      'attachMediaPlaceholder': 'Добавить медиа-заглушку',
      'useCurrentLocation': 'Использовать текущую геопозицию',
      'captureLocationFailed': 'Не удалось получить геопозицию. Введите адрес вручную.',
      'attachPhoto': 'Прикрепить фото',
      'attachMedia': 'Прикрепить медиа',
      'takePhoto': 'Сделать фото',
      'takeVideo': 'Записать видео',
      'pickFromGallery': 'Выбрать из галереи',
      'pickVideoFromGallery': 'Выбрать видео из галереи',
      'attachedMediaCount': 'Прикреплённые медиа',
      'videoLabel': 'Видео',
      'confirmLocationTitle': 'Подтверждение локации',
      'confirmLocationHelp': 'Проверьте карту и адрес перед отправкой.',
      'confirmLocationAction': 'Подтвердить локацию',
      'editLocationAction': 'Изменить локацию',
      'deviceCoordinates': 'Координаты устройства',
      'geoMismatchDetected': 'Местоположение вне ожидаемой зоны обслуживания. Нужен ручной адрес.',
      'manualAddressRequired': 'Требуется ручной адрес.',
      'removePhoto': 'Удалить',
      'enforcement': 'Сообщить о нарушении',
      'createEnforcementReport': 'Создать сообщение о нарушении',
      'enforcementReportDetail': 'Карточка сообщения о нарушении',
      'enforcementReportNotFound': 'Сообщение о нарушении не найдено.',
      'enforcementTitle': 'Название нарушения',
      'enforcementDescription': 'Описание нарушения',
      'reviewEvidence': 'Проверить материалы',
      'submitReport': 'Отправить сообщение',
      'mediaEvidence': 'Медиа-доказательства',
      'yesLabel': 'Да',
      'noLabel': 'Нет',
      'trustLevelLabel': 'Уровень доверия',
      'standardTrust': 'Стандартный',
      'lowGeoConfidence': 'Низкая гео-достоверность',
      'locationMismatchToggle': 'Геолокация может быть неточной',
      'locationMismatchHelp': 'Используйте это, если автоматические геоданные могут быть неверными и нужен ручной адрес.',
      'manualAddressRequiredNotice': 'Требуется ручное подтверждение адреса, потому что геоданные могут не совпадать с ожидаемыми.',
      'profile': 'Профиль',
      'inbox': 'Входящие',
      'noNotificationsYet': 'Уведомлений пока нет.',
      'language': 'Язык',
      'accountInformation': 'Информация об аккаунте',
      'notificationPreferences': 'Настройки уведомлений',
      'emailNotifications': 'Email-уведомления',
      'pushNotifications': 'Push-уведомления',
      'mockModeNotice': 'Эта сборка использует мок-данные и упрощенную beta-аутентификацию.',
      'onboardingNext': 'Далее',
      'onboardingGetStarted': 'Начать',
      'onboardingLanguagePrompt': 'Выберите язык',
      'onboardingSlideWelcomeTitle': 'Добро пожаловать в Resident App',
      'onboardingSlideWelcomeBody': 'Связь с муниципалитетом через петиции, жалобы и сообщения о нарушениях.',
      'onboardingSlidePetitionsTitle': 'Электронные петиции',
      'onboardingSlidePetitionsBody': 'Просматривайте активные петиции, следите за статусом и готовьтесь поддерживать важные инициативы.',
      'onboardingSlideComplaintsTitle': 'Городские жалобы',
      'onboardingSlideComplaintsBody': 'Сообщайте о городских проблемах с фото, геоданными и понятным статусом.',
      'onboardingSlideViolationsTitle': 'Сообщения о нарушениях',
      'onboardingSlideViolationsBody': 'Отправляйте доказательства муниципальной службе, если стали свидетелем нарушения.',
      'helpAndSupport': 'Помощь и поддержка',
      'aboutApp': 'О приложении',
      'helpFaq': 'FAQ',
      'aboutDescription': 'Resident App помогает жителям взаимодействовать с муниципалитетом через петиции, жалобы и сообщения о нарушениях.',
      'appVersionLabel': 'Версия',
      'faqQuestionBeta': 'Почему приложение показывает beta или mock режим?',
      'faqAnswerBeta': 'Эта сборка для раннего тестирования. Данные и авторизация упрощены до утверждения дизайна и функционала.',
      'faqQuestionLanguage': 'Как сменить язык?',
      'faqAnswerLanguage': 'Откройте Profile и выберите язык. Также можно выбрать при первом запуске.',
      'faqQuestionSecureAuth': 'Когда будет включена secure-регистрация?',
      'faqAnswerSecureAuth': 'Secure-верификация с документом и проверкой личности добавится после утверждения beta UX.',
      'emailRequired': 'Укажите email.',
      'emailInvalid': 'Введите корректный email.',
      'passwordRequired': 'Укажите пароль.',
      'passwordTooShort': 'Пароль должен содержать минимум 8 символов.',
      'emailVerificationPending': 'Подтверждение email ожидается. Некоторые действия могут быть ограничены в beta.',
      'loadErrorMessage': 'Не удалось загрузить данные. Попробуйте снова.',
      'retryAction': 'Повторить',
      'emptyComplaints': 'Жалоб пока нет.',
      'emptyEnforcementReports': 'Сообщений о нарушениях пока нет.',
      'mockDataPersistNotice': 'Mock-данные сохраняются на этом устройстве между перезапусками приложения.',
      'mockBetaSettings': 'Beta-тестирование',
      'simulateLoadError': 'Симулировать ошибку загрузки списка',
      'simulateLoadErrorHelp': 'Используйте переключатель, чтобы проверить error/retry на экранах списков.',
      'importMockSnapshot': 'Импорт mock-снимка',
      'importMockSnapshotHelp':
          'Выберите gesher-mock-*.json, экспортированный из Admin Web, для синхронизации данных.',
      'importMockSnapshotSuccess': 'Mock-снимок импортирован.',
      'importMockSnapshotFailed': 'Не удалось импортировать снимок.',
      'phoneVerificationTitle': 'Подтверждение телефона',
      'phoneVerificationHelp': 'Подтвердите телефон, чтобы перейти от beta к secure-сессии.',
      'phoneNumberLabel': 'Номер телефона',
      'phoneRequired': 'Укажите номер телефона.',
      'phoneInvalid': 'Введите корректный номер телефона.',
      'sendOtpAction': 'Отправить код',
      'otpCodeLabel': 'Код подтверждения',
      'otpRequired': 'Укажите код подтверждения.',
      'otpInvalid': 'Введите 6-значный код.',
      'otpSentNotice': 'Mock-код отправлен для beta-тестирования.',
      'verifyPhoneAction': 'Подтвердить телефон',
      'phoneVerifiedLabel': 'Подтверждённый телефон',
      'phoneVerifiedNotice': 'Телефон подтверждён. Сессия теперь secure.',
      'phoneMismatchError': 'Номер телефона не совпадает с запросом кода.',
      'mockOtpHint': 'Beta mock-код: {code}',
      'secureVerificationTitle': 'Secure-верификация',
      'sessionTierLabel': 'Уровень сессии',
      'sessionTierBeta': 'Beta-сессия',
      'sessionTierSecure': 'Secure-сессия',
      'verifyPhoneCta': 'Подтвердить телефон',
      'kycVerificationTitle': 'Верификация личности',
      'kycVerificationHelp': 'Пройдите mock KYC, чтобы подписывать петиции и выполнять защищённые действия.',
      'kycStatusLabel': 'Статус верификации',
      'kycStatusNotStarted': 'Не начата',
      'kycStatusPending': 'На проверке',
      'kycStatusApproved': 'Одобрена',
      'kycStatusManualReview': 'Ручная проверка',
      'kycStatusRejected': 'Отклонена',
      'phoneRequiredBeforeKyc': 'Сначала подтвердите телефон.',
      'kycDocumentStepTitle': 'Документ и селфи',
      'documentNumberLabel': 'Номер удостоверения',
      'documentNumberRequired': 'Укажите номер документа.',
      'documentNumberInvalid': 'Введите корректный номер документа.',
      'simulateDocumentCapture': 'Симулировать съёмку документа',
      'simulateSelfieCapture': 'Симулировать селфи',
      'submitKycAction': 'Отправить верификацию',
      'kycApprovedNotice': 'Верификация одобрена в mock-режиме.',
      'startKycAction': 'Начать верификацию личности',
      'secureUpgradeNotice': 'Пройдите phone + KYC, чтобы открыть защищённые действия.',
      'phoneVerificationBanner': 'Подтвердите телефон для secure-сессии.',
      'kycRequiredBanner': 'Пройдите KYC, чтобы подписывать петиции.',
      'signPetitionAction': 'Подписать петицию',
      'petitionSignedNotice': 'Петиция подписана в mock-режиме.',
      'kycRequiredForAction': 'Для этого действия нужна верификация личности.',
      'secureSessionRequired': 'Нужна secure-сессия с подтверждённым телефоном.',
      'sensitiveActionTitle': 'Подтверждение действия',
      'sensitiveActionMessage': 'Введите код, чтобы подтвердить защищённое действие.',
      'confirmSensitiveAction': 'Подтвердить',
      'cancelAction': 'Отмена',
      'searchPetitions': 'Поиск петиций',
      'filterAll': 'Все',
      'filterPublished': 'Опубликованные',
      'filterInReview': 'На проверке',
      'filterDraft': 'Черновики',
      'noPetitionsMatch': 'Нет петиций по вашему поиску или фильтру.',
      'pushScaffoldTitle': 'Push-уведомления (beta scaffold)',
      'pushScaffoldNotice': 'Push имитируется локально до подключения backend и FCM.',
      'pushDeviceTokenLabel': 'Mock device token',
      'pushStatusDisabled': 'Push выключен',
      'pushStatusPending': 'Регистрация push ожидается',
      'pushStatusRegistered': 'Push scaffold зарегистрирован',
      'faqQuestionLocation': 'Зачем приложению нужна геолокация?',
      'faqAnswerLocation': 'Координаты помогают прикрепить место к жалобе или донесению. Адрес можно ввести вручную.',
      'faqQuestionMedia': 'Зачем нужны камера, галерея или микрофон?',
      'faqAnswerMedia': 'Разрешения используются только когда вы прикрепляете фото или видео к жалобе или донесению.',
      'faqQuestionPendingStatus': 'Почему статус pending или review?',
      'faqAnswerPendingStatus': 'В mock-режиме статусы симулируют обработку муниципалитетом. Реальные обновления придут с backend.',
      'faqQuestionMockOtp': 'Какой код для телефона и sensitive actions?',
      'faqAnswerMockOtp': 'В этой beta-сборке используйте 123456 для mock OTP и подтверждения действий.',
      'petitionAttachmentsTitle': 'Вложения',
      'petitionAttachmentsHelp':
          'Фото или документы: PDF, Word или Excel (не более 5 всего).',
      'attachPetitionFile': 'Прикрепить файл',
      'petitionAttachmentLimitReached': 'Можно прикрепить не более 5 файлов.',
      'petitionAttachmentTypeNotAllowed':
          'Поддерживаются только фото, PDF, Word и Excel.',
      'petitionAttachmentCountLabel': '{current} / {max} вложений',
      'petitionAttachmentPhotosLabel': 'Фото',
      'petitionAttachmentDocumentsLabel': 'Документы',
      'petitionAttachmentTypePdf': 'PDF',
      'petitionAttachmentTypeDoc': 'Word',
      'petitionAttachmentTypeExcel': 'Excel',
    },
    'ar': {
      'appTitle': 'تطبيق السكان',
      'betaBanner': 'وضع تجريبي',
      'signIn': 'تسجيل الدخول',
      'signUp': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور',
      'forgotPasswordHelp': 'أدخل بريدك الإلكتروني لمتابعة مسار استعادة كلمة المرور في النسخة التجريبية.',
      'sendResetLink': 'إرسال رابط الاستعادة',
      'resetLinkSentNotice': 'إذا كان الخلفية متصلة فعلا، فسيتم إرسال رابط إعادة التعيين إلى بريدك الإلكتروني.',
      'continueCta': 'متابعة',
      'logout': 'تسجيل الخروج',
      'homeTitle': 'الصفحة الرئيسية للمقيم',
      'petitions': 'الالتماسات',
      'myPetitions': 'التماساتي',
      'createPetition': 'إنشاء التماس',
      'petitionDetail': 'تفاصيل الالتماس',
      'petitionTitle': 'عنوان الالتماس',
      'petitionSummary': 'ملخص الالتماس',
      'petitionNotFound': 'لم يتم العثور على الالتماس.',
      'noPetitionsYet': 'لم تقم بإنشاء أي التماسات بعد.',
      'statusLabel': 'الحالة',
      'signatureCountLabel': 'عدد التوقيعات',
      'betaSignaturePlaceholder': 'سيتم تفعيل توقيع الالتماسات بعد التحقق الآمن.',
      'complaints': 'الشكاوى',
      'createComplaint': 'إنشاء شكوى',
      'complaintDetail': 'تفاصيل الشكوى',
      'complaintTitle': 'عنوان الشكوى',
      'complaintDescription': 'وصف الشكوى',
      'complaintNotFound': 'لم يتم العثور على الشكوى.',
      'locationLabel': 'الموقع',
      'manualAddress': 'العنوان اليدوي',
      'attachMediaPlaceholder': 'إرفاق وسائط تجريبية',
      'useCurrentLocation': 'استخدام الموقع الحالي',
      'captureLocationFailed': 'تعذر الحصول على الموقع. أدخل العنوان يدوياً.',
      'attachPhoto': 'إرفاق صورة',
      'attachMedia': 'إرفاق وسائط',
      'takePhoto': 'التقاط صورة',
      'takeVideo': 'تسجيل فيديو',
      'pickFromGallery': 'اختيار من المعرض',
      'pickVideoFromGallery': 'اختيار فيديو من المعرض',
      'attachedMediaCount': 'الوسائط المرفقة',
      'videoLabel': 'فيديو',
      'confirmLocationTitle': 'تأكيد الموقع',
      'confirmLocationHelp': 'راجع معاينة الخريطة والعنوان قبل الإرسال.',
      'confirmLocationAction': 'تأكيد الموقع',
      'editLocationAction': 'تعديل الموقع',
      'deviceCoordinates': 'إحداثيات الجهاز',
      'geoMismatchDetected': 'يبدو أن الموقع خارج منطقة الخدمة المتوقعة. العنوان اليدوي مطلوب.',
      'manualAddressRequired': 'العنوان اليدوي مطلوب.',
      'removePhoto': 'إزالة',
      'enforcement': 'الإبلاغ عن مخالفة',
      'createEnforcementReport': 'إنشاء بلاغ مخالفة',
      'enforcementReportDetail': 'تفاصيل بلاغ المخالفة',
      'enforcementReportNotFound': 'لم يتم العثور على بلاغ المخالفة.',
      'enforcementTitle': 'عنوان المخالفة',
      'enforcementDescription': 'وصف المخالفة',
      'reviewEvidence': 'مراجعة الأدلة',
      'submitReport': 'إرسال البلاغ',
      'mediaEvidence': 'أدلة الوسائط',
      'yesLabel': 'نعم',
      'noLabel': 'لا',
      'trustLevelLabel': 'مستوى الثقة',
      'standardTrust': 'قياسي',
      'lowGeoConfidence': 'ثقة جغرافية منخفضة',
      'locationMismatchToggle': 'قد يكون الموقع غير دقيق',
      'locationMismatchHelp': 'استخدم هذا إذا كانت بيانات الموقع التلقائية قد تكون غير صحيحة ويلزم تأكيد العنوان يدويًا.',
      'manualAddressRequiredNotice': 'تأكيد العنوان اليدوي مطلوب لأن الموقع قد لا يطابق البيانات الجغرافية المتوقعة.',
      'profile': 'الملف الشخصي',
      'inbox': 'الوارد',
      'noNotificationsYet': 'لا توجد إشعارات بعد.',
      'language': 'اللغة',
      'accountInformation': 'معلومات الحساب',
      'notificationPreferences': 'تفضيلات الإشعارات',
      'emailNotifications': 'إشعارات البريد الإلكتروني',
      'pushNotifications': 'إشعارات الدفع',
      'mockModeNotice': 'يستخدم هذا الإصدار بيانات تجريبية ومصادقة بيتا مبسطة.',
      'onboardingNext': 'التالي',
      'onboardingGetStarted': 'ابدأ',
      'onboardingLanguagePrompt': 'اختر اللغة',
      'onboardingSlideWelcomeTitle': 'مرحباً بك في تطبيق السكان',
      'onboardingSlideWelcomeBody': 'تواصل مع البلدية عبر الالتماسات والشكاوى وتقارير المخالفات.',
      'onboardingSlidePetitionsTitle': 'الالتماسات الإلكترونية',
      'onboardingSlidePetitionsBody': 'تصفح الالتماسات النشطة وتابع التقدم واستعد لدعم القضايا المهمة.',
      'onboardingSlideComplaintsTitle': 'شكاوى البلدية',
      'onboardingSlideComplaintsBody': 'أبلغ عن مشكلات بلدية مع صور وموقع وتتبع واضح للحالة.',
      'onboardingSlideViolationsTitle': 'الإبلاغ عن مخالفات',
      'onboardingSlideViolationsBody': 'أرسل الأدلة إلى فرق الإنفاذ البلدي عند مشاهدة مخالفة محتملة.',
      'helpAndSupport': 'المساعدة والدعم',
      'aboutApp': 'حول التطبيق',
      'helpFaq': 'الأسئلة الشائعة',
      'aboutDescription': 'يساعد تطبيق السكان المواطنين على التفاعل مع خدمات البلدية عبر الالتماسات والشكاوى وتقارير المخالفات.',
      'appVersionLabel': 'الإصدار',
      'faqQuestionBeta': 'لماذا يظهر التطبيق وضع بيتا أو تجريبي؟',
      'faqAnswerBeta': 'هذا الإصدار للاختبار المبكر. البيانات والمصادقة مبسطة حتى اعتماد التصميم والوظائف.',
      'faqQuestionLanguage': 'كيف أغير اللغة؟',
      'faqAnswerLanguage': 'افتح الملف الشخصي واختر اللغة. يمكن أيضاً اختيارها عند أول تشغيل.',
      'faqQuestionSecureAuth': 'متى سيتم تفعيل التسجيل الآمن؟',
      'faqAnswerSecureAuth': 'سيتم إضافة التحقق الآمن بالهوية والمستندات بعد اعتماد تجربة البيتا.',
      'emailRequired': 'البريد الإلكتروني مطلوب.',
      'emailInvalid': 'أدخل بريداً إلكترونياً صالحاً.',
      'passwordRequired': 'كلمة المرور مطلوبة.',
      'passwordTooShort': 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل.',
      'emailVerificationPending': 'تأكيد البريد الإلكتروني قيد الانتظار. قد تبقى بعض الإجراءات محدودة في النسخة التجريبية.',
      'loadErrorMessage': 'تعذر تحميل البيانات. حاول مرة أخرى.',
      'retryAction': 'إعادة المحاولة',
      'emptyComplaints': 'لا توجد شكاوى بعد.',
      'emptyEnforcementReports': 'لا توجد بلاغات مخالفات بعد.',
      'mockDataPersistNotice': 'يتم حفظ البيانات التجريبية على هذا الجهاز بين إعادات تشغيل التطبيق.',
      'mockBetaSettings': 'اختبار بيتا',
      'simulateLoadError': 'محاكاة خطأ تحميل القائمة',
      'simulateLoadErrorHelp': 'استخدم هذا المفتاح لاختبار حالات الخطأ وإعادة المحاولة في شاشات القوائم.',
      'importMockSnapshot': 'استيراد mock snapshot',
      'importMockSnapshotHelp': 'اختر ملف JSON من Admin Web.',
      'importMockSnapshotSuccess': 'تم استيراد snapshot.',
      'importMockSnapshotFailed': 'تعذر استيراد snapshot.',
      'phoneVerificationTitle': 'تأكيد الهاتف',
      'phoneVerificationHelp': 'أكد رقم هاتفك للترقية من بيتا إلى جلسة آمنة.',
      'phoneNumberLabel': 'رقم الهاتف',
      'phoneRequired': 'رقم الهاتف مطلوب.',
      'phoneInvalid': 'أدخل رقم هاتف صالحاً.',
      'sendOtpAction': 'إرسال الرمز',
      'otpCodeLabel': 'رمز التحقق',
      'otpRequired': 'رمز التحقق مطلوب.',
      'otpInvalid': 'أدخل رمزاً مكوناً من 6 أرقام.',
      'otpSentNotice': 'تم إرسال رمز تجريبي لاختبار بيتا.',
      'verifyPhoneAction': 'تأكيد الهاتف',
      'phoneVerifiedLabel': 'الهاتف المؤكد',
      'phoneVerifiedNotice': 'تم تأكيد الهاتف. أصبحت جلستك الآن آمنة.',
      'phoneMismatchError': 'رقم الهاتف لا يطابق طلب الرمز.',
      'mockOtpHint': 'رمز بيتا التجريبي: {code}',
      'secureVerificationTitle': 'التحقق الآمن',
      'sessionTierLabel': 'مستوى الجلسة',
      'sessionTierBeta': 'جلسة بيتا',
      'sessionTierSecure': 'جلسة آمنة',
      'verifyPhoneCta': 'تأكيد رقم الهاتف',
      'kycVerificationTitle': 'التحقق من الهوية',
      'kycVerificationHelp': 'أكمل KYC التجريبي لفتح توقيع الالتماسات والإجراءات عالية الثقة.',
      'kycStatusLabel': 'حالة التحقق',
      'kycStatusNotStarted': 'لم يبدأ',
      'kycStatusPending': 'قيد المراجعة',
      'kycStatusApproved': 'موافق عليه',
      'kycStatusManualReview': 'مراجعة يدوية',
      'kycStatusRejected': 'مرفوض',
      'phoneRequiredBeforeKyc': 'يجب تأكيد الهاتف قبل بدء التحقق من الهوية.',
      'kycDocumentStepTitle': 'التقاط المستند والصورة الشخصية',
      'documentNumberLabel': 'رقم الهوية',
      'documentNumberRequired': 'رقم المستند مطلوب.',
      'documentNumberInvalid': 'أدخل رقم مستند صالحاً.',
      'simulateDocumentCapture': 'محاكاة التقاط المستند',
      'simulateSelfieCapture': 'محاكاة التقاط صورة شخصية',
      'submitKycAction': 'إرسال التحقق',
      'kycApprovedNotice': 'تمت الموافقة على التحقق في الوضع التجريبي.',
      'startKycAction': 'بدء التحقق من الهوية',
      'secureUpgradeNotice': 'قم بترقية حسابك عبر تأكيد الهاتف والهوية لفتح الإجراءات المحمية.',
      'phoneVerificationBanner': 'أكد هاتفك للترقية إلى جلسة آمنة.',
      'kycRequiredBanner': 'أكمل التحقق من الهوية لتوقيع الالتماسات.',
      'signPetitionAction': 'توقيع الالتماس',
      'petitionSignedNotice': 'تم توقيع الالتماس في الوضع التجريبي.',
      'kycRequiredForAction': 'التحقق من الهوية مطلوب لهذا الإجراء.',
      'secureSessionRequired': 'يلزم جلسة آمنة مع هاتف مؤكد.',
      'sensitiveActionTitle': 'تأكيد إجراء حساس',
      'sensitiveActionMessage': 'أدخل رمز التحقق لتأكيد هذا الإجراء المحمي.',
      'confirmSensitiveAction': 'تأكيد الإجراء',
      'cancelAction': 'إلغاء',
      'searchPetitions': 'البحث في الالتماسات',
      'filterAll': 'الكل',
      'filterPublished': 'منشورة',
      'filterInReview': 'قيد المراجعة',
      'filterDraft': 'مسودة',
      'noPetitionsMatch': 'لا توجد التماسات مطابقة للبحث أو التصفية.',
      'pushScaffoldTitle': 'إشعارات push (هيكل بيتا)',
      'pushScaffoldNotice': 'يتم محاكاة push محلياً حتى ربط الخلفية وFCM.',
      'pushDeviceTokenLabel': 'Mock device token',
      'pushStatusDisabled': 'الpush معطل',
      'pushStatusPending': 'تسجيل push قيد الانتظار',
      'pushStatusRegistered': 'تم تسجيل push scaffold',
      'faqQuestionLocation': 'لماذا يطلب التطبيق إذن الموقع؟',
      'faqAnswerLocation': 'يساعد الموقع على إرفاق الإحداثيات بالشكاوى والبلاغات. يمكنك إدخال العنوان يدوياً.',
      'faqQuestionMedia': 'لماذا يطلب التطبيق صلاحيات الكاميرا أو المعرض؟',
      'faqAnswerMedia': 'تُستخدم هذه الصلاحيات فقط عند إرفاق صورة أو فيديو.',
      'faqQuestionPendingStatus': 'لماذا تظهر حالة pending أو review؟',
      'faqAnswerPendingStatus': 'في وضع mock، تحاكي الحالات معالجة البلدية. التحديثات الحقيقية ستأتي من الخلفية.',
      'faqQuestionMockOtp': 'ما الرمز للهاتف أو الإجراءات الحساسة؟',
      'faqAnswerMockOtp': 'في نسخة البيتا هذه استخدم 123456 لOTP mock وتأكيد الإجراءات.',
      'petitionAttachmentsTitle': 'المرفقات',
      'petitionAttachmentsHelp':
          'أضف صوراً أو مستندات: PDF أو Word أو Excel (حتى 5 إجمالاً).',
      'attachPetitionFile': 'إرفاق ملف',
      'petitionAttachmentLimitReached': 'يمكنك إرفاق حتى 5 ملفات إجمالاً.',
      'petitionAttachmentTypeNotAllowed':
          'يتم دعم الصور وPDF وWord وExcel فقط.',
      'petitionAttachmentCountLabel': '{current} / {max} مرفقات',
      'petitionAttachmentPhotosLabel': 'صور',
      'petitionAttachmentDocumentsLabel': 'مستندات',
      'petitionAttachmentTypePdf': 'PDF',
      'petitionAttachmentTypeDoc': 'Word',
      'petitionAttachmentTypeExcel': 'Excel',
    },
  };

  String _text(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']![key]!;
  }

  String get appTitle => _text('appTitle');
  String get betaBanner => _text('betaBanner');
  String get signIn => _text('signIn');
  String get signUp => _text('signUp');
  String get email => _text('email');
  String get password => _text('password');
  String get forgotPassword => _text('forgotPassword');
  String get forgotPasswordHelp => _text('forgotPasswordHelp');
  String get sendResetLink => _text('sendResetLink');
  String get resetLinkSentNotice => _text('resetLinkSentNotice');
  String get continueCta => _text('continueCta');
  String get logout => _text('logout');
  String get homeTitle => _text('homeTitle');
  String get petitions => _text('petitions');
  String get myPetitions => _text('myPetitions');
  String get createPetition => _text('createPetition');
  String get petitionDetail => _text('petitionDetail');
  String get petitionTitle => _text('petitionTitle');
  String get petitionSummary => _text('petitionSummary');
  String get petitionNotFound => _text('petitionNotFound');
  String get noPetitionsYet => _text('noPetitionsYet');
  String get statusLabel => _text('statusLabel');
  String get signatureCountLabel => _text('signatureCountLabel');
  String get betaSignaturePlaceholder => _text('betaSignaturePlaceholder');
  String get complaints => _text('complaints');
  String get createComplaint => _text('createComplaint');
  String get complaintDetail => _text('complaintDetail');
  String get complaintTitle => _text('complaintTitle');
  String get complaintDescription => _text('complaintDescription');
  String get complaintNotFound => _text('complaintNotFound');
  String get locationLabel => _text('locationLabel');
  String get manualAddress => _text('manualAddress');
  String get attachMediaPlaceholder => _text('attachMediaPlaceholder');
  String get useCurrentLocation => _text('useCurrentLocation');
  String get captureLocationFailed => _text('captureLocationFailed');
  String get attachPhoto => _text('attachPhoto');
  String get attachMedia => _text('attachMedia');
  String get takePhoto => _text('takePhoto');
  String get takeVideo => _text('takeVideo');
  String get pickFromGallery => _text('pickFromGallery');
  String get pickVideoFromGallery => _text('pickVideoFromGallery');
  String get attachedMediaCount => _text('attachedMediaCount');
  String get videoLabel => _text('videoLabel');
  String get confirmLocationTitle => _text('confirmLocationTitle');
  String get confirmLocationHelp => _text('confirmLocationHelp');
  String get confirmLocationAction => _text('confirmLocationAction');
  String get editLocationAction => _text('editLocationAction');
  String get deviceCoordinates => _text('deviceCoordinates');
  String get geoMismatchDetected => _text('geoMismatchDetected');
  String get manualAddressRequired => _text('manualAddressRequired');
  String get removePhoto => _text('removePhoto');
  String get enforcement => _text('enforcement');
  String get createEnforcementReport => _text('createEnforcementReport');
  String get enforcementReportDetail => _text('enforcementReportDetail');
  String get enforcementReportNotFound => _text('enforcementReportNotFound');
  String get enforcementTitle => _text('enforcementTitle');
  String get enforcementDescription => _text('enforcementDescription');
  String get reviewEvidence => _text('reviewEvidence');
  String get submitReport => _text('submitReport');
  String get mediaEvidence => _text('mediaEvidence');
  String get yesLabel => _text('yesLabel');
  String get noLabel => _text('noLabel');
  String get trustLevelLabel => _text('trustLevelLabel');
  String get standardTrust => _text('standardTrust');
  String get lowGeoConfidence => _text('lowGeoConfidence');
  String get locationMismatchToggle => _text('locationMismatchToggle');
  String get locationMismatchHelp => _text('locationMismatchHelp');
  String get manualAddressRequiredNotice => _text('manualAddressRequiredNotice');
  String get profile => _text('profile');
  String get inbox => _text('inbox');
  String get noNotificationsYet => _text('noNotificationsYet');
  String get language => _text('language');
  String get accountInformation => _text('accountInformation');
  String get notificationPreferences => _text('notificationPreferences');
  String get emailNotifications => _text('emailNotifications');
  String get pushNotifications => _text('pushNotifications');
  String get mockModeNotice => _text('mockModeNotice');
  String get onboardingNext => _text('onboardingNext');
  String get onboardingGetStarted => _text('onboardingGetStarted');
  String get onboardingLanguagePrompt => _text('onboardingLanguagePrompt');
  String get onboardingSlideWelcomeTitle => _text('onboardingSlideWelcomeTitle');
  String get onboardingSlideWelcomeBody => _text('onboardingSlideWelcomeBody');
  String get onboardingSlidePetitionsTitle =>
      _text('onboardingSlidePetitionsTitle');
  String get onboardingSlidePetitionsBody =>
      _text('onboardingSlidePetitionsBody');
  String get onboardingSlideComplaintsTitle =>
      _text('onboardingSlideComplaintsTitle');
  String get onboardingSlideComplaintsBody =>
      _text('onboardingSlideComplaintsBody');
  String get onboardingSlideViolationsTitle =>
      _text('onboardingSlideViolationsTitle');
  String get onboardingSlideViolationsBody =>
      _text('onboardingSlideViolationsBody');
  String get helpAndSupport => _text('helpAndSupport');
  String get aboutApp => _text('aboutApp');
  String get helpFaq => _text('helpFaq');
  String get aboutDescription => _text('aboutDescription');
  String get appVersionLabel => _text('appVersionLabel');
  String get faqQuestionBeta => _text('faqQuestionBeta');
  String get faqAnswerBeta => _text('faqAnswerBeta');
  String get faqQuestionLanguage => _text('faqQuestionLanguage');
  String get faqAnswerLanguage => _text('faqAnswerLanguage');
  String get faqQuestionSecureAuth => _text('faqQuestionSecureAuth');
  String get faqAnswerSecureAuth => _text('faqAnswerSecureAuth');
  String get emailRequired => _text('emailRequired');
  String get emailInvalid => _text('emailInvalid');
  String get passwordRequired => _text('passwordRequired');
  String get passwordTooShort => _text('passwordTooShort');
  String get emailVerificationPending => _text('emailVerificationPending');
  String get loadErrorMessage => _text('loadErrorMessage');
  String get retryAction => _text('retryAction');
  String get emptyComplaints => _text('emptyComplaints');
  String get emptyEnforcementReports => _text('emptyEnforcementReports');
  String get mockDataPersistNotice => _text('mockDataPersistNotice');
  String get mockBetaSettings => _text('mockBetaSettings');
  String get simulateLoadError => _text('simulateLoadError');
  String get simulateLoadErrorHelp => _text('simulateLoadErrorHelp');
  String get importMockSnapshot => _text('importMockSnapshot');
  String get importMockSnapshotHelp => _text('importMockSnapshotHelp');
  String get importMockSnapshotSuccess => _text('importMockSnapshotSuccess');
  String get importMockSnapshotFailed => _text('importMockSnapshotFailed');
  String get phoneVerificationTitle => _text('phoneVerificationTitle');
  String get phoneVerificationHelp => _text('phoneVerificationHelp');
  String get phoneNumberLabel => _text('phoneNumberLabel');
  String get phoneRequired => _text('phoneRequired');
  String get phoneInvalid => _text('phoneInvalid');
  String get sendOtpAction => _text('sendOtpAction');
  String get otpCodeLabel => _text('otpCodeLabel');
  String get otpRequired => _text('otpRequired');
  String get otpInvalid => _text('otpInvalid');
  String get otpSentNotice => _text('otpSentNotice');
  String get verifyPhoneAction => _text('verifyPhoneAction');
  String get phoneVerifiedLabel => _text('phoneVerifiedLabel');
  String get phoneVerifiedNotice => _text('phoneVerifiedNotice');
  String get phoneMismatchError => _text('phoneMismatchError');
  String mockOtpHint(String code) =>
      _text('mockOtpHint').replaceAll('{code}', code);

  String petitionAttachmentCount(int current, int max) => _text(
        'petitionAttachmentCountLabel',
      )
          .replaceAll('{current}', '$current')
          .replaceAll('{max}', '$max');
  String get secureVerificationTitle => _text('secureVerificationTitle');
  String get sessionTierLabel => _text('sessionTierLabel');
  String get sessionTierBeta => _text('sessionTierBeta');
  String get sessionTierSecure => _text('sessionTierSecure');
  String get verifyPhoneCta => _text('verifyPhoneCta');
  String get kycVerificationTitle => _text('kycVerificationTitle');
  String get kycVerificationHelp => _text('kycVerificationHelp');
  String get kycStatusLabel => _text('kycStatusLabel');
  String get kycStatusNotStarted => _text('kycStatusNotStarted');
  String get kycStatusPending => _text('kycStatusPending');
  String get kycStatusApproved => _text('kycStatusApproved');
  String get kycStatusManualReview => _text('kycStatusManualReview');
  String get kycStatusRejected => _text('kycStatusRejected');
  String get phoneRequiredBeforeKyc => _text('phoneRequiredBeforeKyc');
  String get kycDocumentStepTitle => _text('kycDocumentStepTitle');
  String get documentNumberLabel => _text('documentNumberLabel');
  String get documentNumberRequired => _text('documentNumberRequired');
  String get documentNumberInvalid => _text('documentNumberInvalid');
  String get simulateDocumentCapture => _text('simulateDocumentCapture');
  String get simulateSelfieCapture => _text('simulateSelfieCapture');
  String get submitKycAction => _text('submitKycAction');
  String get kycApprovedNotice => _text('kycApprovedNotice');
  String get startKycAction => _text('startKycAction');
  String get secureUpgradeNotice => _text('secureUpgradeNotice');
  String get phoneVerificationBanner => _text('phoneVerificationBanner');
  String get kycRequiredBanner => _text('kycRequiredBanner');
  String get signPetitionAction => _text('signPetitionAction');
  String get petitionSignedNotice => _text('petitionSignedNotice');
  String get kycRequiredForAction => _text('kycRequiredForAction');
  String get secureSessionRequired => _text('secureSessionRequired');
  String get sensitiveActionTitle => _text('sensitiveActionTitle');
  String get sensitiveActionMessage => _text('sensitiveActionMessage');
  String get confirmSensitiveAction => _text('confirmSensitiveAction');
  String get cancelAction => _text('cancelAction');
  String get searchPetitions => _text('searchPetitions');
  String get filterAll => _text('filterAll');
  String get filterPublished => _text('filterPublished');
  String get filterInReview => _text('filterInReview');
  String get filterDraft => _text('filterDraft');
  String get noPetitionsMatch => _text('noPetitionsMatch');
  String get pushScaffoldTitle => _text('pushScaffoldTitle');
  String get pushScaffoldNotice => _text('pushScaffoldNotice');
  String get pushDeviceTokenLabel => _text('pushDeviceTokenLabel');
  String get pushStatusDisabled => _text('pushStatusDisabled');
  String get pushStatusPending => _text('pushStatusPending');
  String get pushStatusRegistered => _text('pushStatusRegistered');
  String get faqQuestionLocation => _text('faqQuestionLocation');
  String get faqAnswerLocation => _text('faqAnswerLocation');
  String get faqQuestionMedia => _text('faqQuestionMedia');
  String get faqAnswerMedia => _text('faqAnswerMedia');
  String get faqQuestionPendingStatus => _text('faqQuestionPendingStatus');
  String get faqAnswerPendingStatus => _text('faqAnswerPendingStatus');
  String get faqQuestionMockOtp => _text('faqQuestionMockOtp');
  String get faqAnswerMockOtp => _text('faqAnswerMockOtp');
  String get petitionAttachmentsTitle => _text('petitionAttachmentsTitle');
  String get petitionAttachmentsHelp => _text('petitionAttachmentsHelp');
  String get attachPetitionFile => _text('attachPetitionFile');
  String get petitionAttachmentLimitReached =>
      _text('petitionAttachmentLimitReached');
  String get petitionAttachmentTypeNotAllowed =>
      _text('petitionAttachmentTypeNotAllowed');
  String get petitionAttachmentPhotosLabel =>
      _text('petitionAttachmentPhotosLabel');
  String get petitionAttachmentDocumentsLabel =>
      _text('petitionAttachmentDocumentsLabel');
  String get petitionAttachmentTypePdf => _text('petitionAttachmentTypePdf');
  String get petitionAttachmentTypeDoc => _text('petitionAttachmentTypeDoc');
  String get petitionAttachmentTypeExcel => _text('petitionAttachmentTypeExcel');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales
        .map((item) => item.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
