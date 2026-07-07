import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('he'),
    Locale('ru'),
    Locale('ar'),
  ];

  static const _strings = {
    'en': {
      'appTitle': 'G.E.S.H.E.R.',
      'brandTagline': 'Your voice. Your city.',
      'inspectorAppBadge': 'Inspector',
      'signIn': 'Staff sign in',
      'emailLabel': 'Work email',
      'passwordLabel': 'Password',
      'signInAction': 'Sign in',
      'signOutAction': 'Sign out',
      'invalidCredentials': 'Invalid inspector credentials.',
      'unknownError': 'Unable to sign in right now.',
      'inspectorHomeTitle': 'Inspector workspace',
      'inspectorHomeSubtitle':
          'Review enforcement reports and record validated outcomes.',
      'inspectorRoleLabel': 'Role',
      'badgeIdLabel': 'Badge ID',
      'openTriageQueueAction': 'Open triage queue',
      'openDispatchQueueAction': 'Open field dispatch queue',
      'dispatchQueueTitle': 'Field dispatch',
      'dispatchTaskDetail': 'Field task detail',
      'dispatchTaskNotFound': 'Field task not found.',
      'emptyDispatchQueue': 'No field tasks match the selected filters.',
      'filterDispatchAssigned': 'Assigned',
      'filterDispatchInField': 'In field',
      'filterDispatchCompleted': 'Completed',
      'startFieldVisitAction': 'Start field visit',
      'dispatchActionsTitle': 'Field actions',
      'oversightNoteLabel': 'Supervisor note',
      'mockCredentialsHint':
          'Mock login: inspector@haifa.mock / inspector123',
      'triageQueueTitle': 'Triage queue',
      'triageReportDetail': 'Report detail',
      'triageReportNotFound': 'Report not found.',
      'emptyTriageQueue': 'No reports match the selected filters.',
      'loadErrorMessage': 'Unable to load reports.',
      'retryAction': 'Retry',
      'filterAll': 'All',
      'filterTriage': 'Triage',
      'filterReviewRequired': 'Review required',
      'filterTrustAll': 'All trust',
      'filterTrustStandard': 'Standard trust',
      'filterTrustLowGeo': 'Low geo confidence',
      'trustLevelLabel': 'Trust level',
      'locationLabel': 'Location',
      'coordinatesLabel': 'Coordinates',
      'submittedAtLabel': 'Submitted',
      'geoMismatchNotice':
          'Resident geodata did not match the city boundary. Manual address review is required.',
      'evidenceSectionTitle': 'Evidence',
      'videoLabel': 'Video',
      'queueCountLabel': '{count} reports in queue',
      'inspectorActionsTitle': 'Inspector actions',
      'markInvalidAction': 'Mark as invalid',
      'mergeCaseAction': 'Merge with existing case',
      'dispatchTaskAction': 'Dispatch field task',
      'validatedOutcomeTitle': 'Validated outcome',
      'validateWarningAction': 'Record warning',
      'validateFineAction': 'Record fine',
      'validateNoActionAction': 'Close with no action',
      'sensitiveActionTitle': 'Confirm inspector action',
      'sensitiveActionMessage':
          'Enter the staff verification code to confirm this action.',
      'confirmSensitiveAction': 'Confirm action',
      'cancelAction': 'Cancel',
      'otpCodeLabel': 'Verification code',
      'otpInvalid': 'Invalid verification code.',
      'mockOtpHint': 'Mock code: {code}',
      'actionAppliedNotice': 'Inspector action recorded in mock mode.',
      'mockSyncTitle': 'Mock sync (W3.2)',
      'importMockSnapshot': 'Import admin snapshot',
      'importMockSnapshotHelp':
          'Import gesher-mock-*.json from Admin Web to refresh enforcement queue.',
      'importMockSnapshotSuccess': 'Mock snapshot imported.',
      'importMockSnapshotFailed': 'Could not import snapshot.',
      'actionFailedMessage': 'Unable to apply this action.',
      'reportClosedNotice': 'This report is closed and no further actions apply.',
      'actionNoteLabel': 'Action note',
      'mergeCaseDialogTitle': 'Merge with existing case',
      'mergeCaseIdLabel': 'Existing case ID',
      'mergeCaseNote': 'Merged into case {caseId}',
    },
    'he': {
      'appTitle': 'G.E.S.H.E.R.',
      'brandTagline': 'הקול שלך. העיר שלך.',
      'inspectorAppBadge': 'פיקוח',
      'signIn': 'כניסת צוות',
      'emailLabel': 'דוא"ל עבודה',
      'passwordLabel': 'סיסמה',
      'signInAction': 'התחברות',
      'signOutAction': 'יציאה',
      'invalidCredentials': 'פרטי התחברות של inspector לא תקינים.',
      'unknownError': 'לא ניתן להתחבר כעת.',
      'inspectorHomeTitle': 'סביבת פיקוח',
      'inspectorHomeSubtitle': 'סקירת דיווחי אכיפה ותיעוד תוצאות מאומתות.',
      'inspectorRoleLabel': 'תפקיד',
      'badgeIdLabel': 'מספר תג',
      'openTriageQueueAction': 'פתיחת תור triage',
      'openDispatchQueueAction': 'פתיחת תור שטח',
      'dispatchQueueTitle': 'משימות שטח',
      'dispatchTaskDetail': 'פרטי משימת שטח',
      'dispatchTaskNotFound': 'משימת שטח לא נמצאה.',
      'emptyDispatchQueue': 'אין משימות שטח לפי המסנן.',
      'filterDispatchAssigned': 'הוקצה',
      'filterDispatchInField': 'בשטח',
      'filterDispatchCompleted': 'הושלם',
      'startFieldVisitAction': 'התחלת ביקור שטח',
      'dispatchActionsTitle': 'פעולות שטח',
      'oversightNoteLabel': 'הערת מפקח',
      'mockCredentialsHint': 'Mock: inspector@haifa.mock / inspector123',
      'triageQueueTitle': 'תור triage',
      'triageReportDetail': 'פרטי דיווח',
      'triageReportNotFound': 'הדיווח לא נמצא.',
      'emptyTriageQueue': 'אין דיווחים לפי הסינון שנבחר.',
      'loadErrorMessage': 'לא ניתן לטעון דיווחים.',
      'retryAction': 'נסו שוב',
      'filterAll': 'הכל',
      'filterTriage': 'Triage',
      'filterReviewRequired': 'נדרש review',
      'filterTrustAll': 'כל רמת trust',
      'filterTrustStandard': 'Trust רגיל',
      'filterTrustLowGeo': 'Geo confidence נמוך',
      'trustLevelLabel': 'רמת trust',
      'locationLabel': 'מיקום',
      'coordinatesLabel': 'קואורdinates',
      'submittedAtLabel': 'הוגש',
      'geoMismatchNotice':
          'נתוני המיקום של התושב לא תואמים לגבול העיר. נדרש review של כתובת ידנית.',
      'evidenceSectionTitle': 'ראיות',
      'videoLabel': 'וידאו',
      'queueCountLabel': '{count} דיווחים בתור',
      'inspectorActionsTitle': 'פעולות inspector',
      'markInvalidAction': 'סימון כלא תקין',
      'mergeCaseAction': 'מיזוג עם תיק קיים',
      'dispatchTaskAction': 'שליחת משימת שטח',
      'validatedOutcomeTitle': 'תוצאה מאומתת',
      'validateWarningAction': 'תיעוד אזהרה',
      'validateFineAction': 'תיעוד קנס',
      'validateNoActionAction': 'סגירה ללא פעולה',
      'sensitiveActionTitle': 'אישור פעולת inspector',
      'sensitiveActionMessage': 'הזינו קוד אימות staff כדי לאשר פעולה זו.',
      'confirmSensitiveAction': 'אישור פעולה',
      'cancelAction': 'ביטול',
      'otpCodeLabel': 'קוד אימות',
      'otpInvalid': 'קוד אימות לא תקין.',
      'mockOtpHint': 'Mock code: {code}',
      'actionAppliedNotice': 'פעולת inspector נרשמה במצב mock.',
      'mockSyncTitle': 'Mock sync (W3.2)',
      'importMockSnapshot': 'ייבוא snapshot',
      'importMockSnapshotHelp': 'ייבוא JSON מ-Admin Web.',
      'importMockSnapshotSuccess': 'snapshot יובא.',
      'importMockSnapshotFailed': 'ייבוא snapshot נכשל.',
      'actionFailedMessage': 'לא ניתן לבצע פעולה זו.',
      'reportClosedNotice': 'דיווח זה סגור ולא ניתן לבצע פעולות נוספות.',
      'actionNoteLabel': 'הערת פעולה',
      'mergeCaseDialogTitle': 'מיזוג עם תיק קיים',
      'mergeCaseIdLabel': 'מזהה תיק קיים',
      'mergeCaseNote': 'מוזג לתיק {caseId}',
    },
    'ru': {
      'appTitle': 'G.E.S.H.E.R.',
      'brandTagline': 'Ваш голос. Ваш город.',
      'inspectorAppBadge': 'Инспектор',
      'signIn': 'Вход для staff',
      'emailLabel': 'Рабочий email',
      'passwordLabel': 'Пароль',
      'signInAction': 'Войти',
      'signOutAction': 'Выйти',
      'invalidCredentials': 'Неверные учётные данные инспектора.',
      'unknownError': 'Сейчас войти не удалось.',
      'inspectorHomeTitle': 'Рабочее место инспектора',
      'inspectorHomeSubtitle':
          'Проверка enforcement-репортов и фиксация итогов.',
      'inspectorRoleLabel': 'Роль',
      'badgeIdLabel': 'Badge ID',
      'openTriageQueueAction': 'Открыть очередь triage',
      'openDispatchQueueAction': 'Открыть полевую очередь',
      'dispatchQueueTitle': 'Полевые задачи',
      'dispatchTaskDetail': 'Детали полевой задачи',
      'dispatchTaskNotFound': 'Полевая задача не найдена.',
      'emptyDispatchQueue': 'Нет задач по выбранному фильтру.',
      'filterDispatchAssigned': 'Назначено',
      'filterDispatchInField': 'В поле',
      'filterDispatchCompleted': 'Завершено',
      'startFieldVisitAction': 'Начать обход',
      'dispatchActionsTitle': 'Полевые действия',
      'oversightNoteLabel': 'Заметка супервайзера',
      'mockCredentialsHint': 'Mock: inspector@haifa.mock / inspector123',
      'triageQueueTitle': 'Очередь triage',
      'triageReportDetail': 'Детали репорта',
      'triageReportNotFound': 'Репорт не найден.',
      'emptyTriageQueue': 'Нет репортов по выбранным фильтрам.',
      'loadErrorMessage': 'Не удалось загрузить репорты.',
      'retryAction': 'Повторить',
      'filterAll': 'Все',
      'filterTriage': 'Triage',
      'filterReviewRequired': 'Нужен review',
      'filterTrustAll': 'Любой trust',
      'filterTrustStandard': 'Standard trust',
      'filterTrustLowGeo': 'Low geo confidence',
      'trustLevelLabel': 'Trust level',
      'locationLabel': 'Локация',
      'coordinatesLabel': 'Координаты',
      'submittedAtLabel': 'Подано',
      'geoMismatchNotice':
          'Геоданные жителя не совпали с границей города. Нужна проверка адреса вручную.',
      'evidenceSectionTitle': 'Доказательства',
      'videoLabel': 'Видео',
      'queueCountLabel': '{count} репортов в очереди',
      'inspectorActionsTitle': 'Действия инспектора',
      'markInvalidAction': 'Отметить как недействительный',
      'mergeCaseAction': 'Объединить с существующим делом',
      'dispatchTaskAction': 'Отправить полевую задачу',
      'validatedOutcomeTitle': 'Подтверждённый итог',
      'validateWarningAction': 'Зафиксировать предупреждение',
      'validateFineAction': 'Зафиксировать штраф',
      'validateNoActionAction': 'Закрыть без действия',
      'sensitiveActionTitle': 'Подтверждение действия',
      'sensitiveActionMessage':
          'Введите staff-код для подтверждения действия.',
      'confirmSensitiveAction': 'Подтвердить',
      'cancelAction': 'Отмена',
      'otpCodeLabel': 'Код подтверждения',
      'otpInvalid': 'Неверный код подтверждения.',
      'mockOtpHint': 'Mock-код: {code}',
      'actionAppliedNotice': 'Действие инспектора записано в mock-режиме.',
      'mockSyncTitle': 'Mock sync (W3.2)',
      'importMockSnapshot': 'Импорт mock-снимка',
      'importMockSnapshotHelp': 'Импорт gesher-mock-*.json из Admin Web для очереди нарушений.',
      'importMockSnapshotSuccess': 'Mock-снимок импортирован.',
      'importMockSnapshotFailed': 'Не удалось импортировать снимок.',
      'actionFailedMessage': 'Не удалось выполнить действие.',
      'reportClosedNotice': 'Репорт закрыт, дальнейшие действия недоступны.',
      'actionNoteLabel': 'Примечание к действию',
      'mergeCaseDialogTitle': 'Объединить с существующим делом',
      'mergeCaseIdLabel': 'ID существующего дела',
      'mergeCaseNote': 'Объединено с делом {caseId}',
    },
    'ar': {
      'appTitle': 'G.E.S.H.E.R.',
      'brandTagline': 'صوتك. مدينتك.',
      'inspectorAppBadge': 'مفتش',
      'signIn': 'دخول الموظفين',
      'emailLabel': 'البريد الوظيفي',
      'passwordLabel': 'كلمة المرور',
      'signInAction': 'تسجيل الدخول',
      'signOutAction': 'تسجيل الخروج',
      'invalidCredentials': 'بيانات اعتماد المفتش غير صالحة.',
      'unknownError': 'تعذر تسجيل الدخول الآن.',
      'inspectorHomeTitle': 'مساحة عمل المفتش',
      'inspectorHomeSubtitle':
          'مراجعة بلاغات الإنفاذ وتسجيل النتائج المعتمدة.',
      'inspectorRoleLabel': 'الدور',
      'badgeIdLabel': 'رقم الشارة',
      'openTriageQueueAction': 'فتح طابور triage',
      'openDispatchQueueAction': 'فتح قائمة المهام الميدانية',
      'dispatchQueueTitle': 'المهام الميدانية',
      'dispatchTaskDetail': 'تفاصيل المهمة الميدانية',
      'dispatchTaskNotFound': 'المهمة الميدانية غير موجودة.',
      'emptyDispatchQueue': 'لا توجد مهام مطابقة للفلتر.',
      'filterDispatchAssigned': 'معيّنة',
      'filterDispatchInField': 'في الميدان',
      'filterDispatchCompleted': 'مكتملة',
      'startFieldVisitAction': 'بدء الزيارة الميدانية',
      'dispatchActionsTitle': 'إجراءات ميدانية',
      'oversightNoteLabel': 'ملاحظة المشرف',
      'mockCredentialsHint': 'Mock: inspector@haifa.mock / inspector123',
      'triageQueueTitle': 'طابور triage',
      'triageReportDetail': 'تفاصيل البلاغ',
      'triageReportNotFound': 'لم يتم العثور على البلاغ.',
      'emptyTriageQueue': 'لا توجد بلاغات مطابقة للتصفية.',
      'loadErrorMessage': 'تعذر تحميل البلاغات.',
      'retryAction': 'إعادة المحاولة',
      'filterAll': 'الكل',
      'filterTriage': 'Triage',
      'filterReviewRequired': 'مراجعة مطلوبة',
      'filterTrustAll': 'كل مستويات trust',
      'filterTrustStandard': 'Standard trust',
      'filterTrustLowGeo': 'Low geo confidence',
      'trustLevelLabel': 'مستوى trust',
      'locationLabel': 'الموقع',
      'coordinatesLabel': 'الإحداثيات',
      'submittedAtLabel': 'تاريخ الإرسال',
      'geoMismatchNotice':
          'بيانات موقع الساكن لا تطابق حدود المدينة. يلزم مراجعة العنوان يدوياً.',
      'evidenceSectionTitle': 'الأدلة',
      'videoLabel': 'فيديو',
      'queueCountLabel': '{count} بلاغات في الطابور',
      'inspectorActionsTitle': 'إجراءات المفتش',
      'markInvalidAction': 'وضع علامة غير صالح',
      'mergeCaseAction': 'دمج مع حالة موجودة',
      'dispatchTaskAction': 'إرسال مهمة ميدانية',
      'validatedOutcomeTitle': 'نتيجة معتمدة',
      'validateWarningAction': 'تسجيل تحذير',
      'validateFineAction': 'تسجيل غرامة',
      'validateNoActionAction': 'إغلاق بدون إجراء',
      'sensitiveActionTitle': 'تأكيد إجراء المفتش',
      'sensitiveActionMessage': 'أدخل رمز staff لتأكيد هذا الإجراء.',
      'confirmSensitiveAction': 'تأكيد الإجراء',
      'cancelAction': 'إلغاء',
      'otpCodeLabel': 'رمز التحقق',
      'otpInvalid': 'رمز التحقق غير صالح.',
      'mockOtpHint': 'Mock code: {code}',
      'actionAppliedNotice': 'تم تسجيل إجراء المفتش في الوضع التجريبي.',
      'mockSyncTitle': 'Mock sync (W3.2)',
      'importMockSnapshot': 'استيراد snapshot',
      'importMockSnapshotHelp': 'استيراد JSON من Admin Web.',
      'importMockSnapshotSuccess': 'تم الاستيراد.',
      'importMockSnapshotFailed': 'فشل الاستيراد.',
      'actionFailedMessage': 'تعذر تنفيذ هذا الإجراء.',
      'reportClosedNotice': 'هذا البلاغ مغلق ولا يمكن تنفيذ إجراءات إضافية.',
      'actionNoteLabel': 'ملاحظة الإجراء',
      'mergeCaseDialogTitle': 'دمج مع حالة موجودة',
      'mergeCaseIdLabel': 'معرف الحالة الموجودة',
      'mergeCaseNote': 'تم الدمج مع الحالة {caseId}',
    },
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const delegate = _AppLocalizationsDelegate();

  String _text(String key) {
    final languageCode = locale.languageCode;
    final values = _strings[languageCode] ?? _strings['en']!;
    return values[key] ?? _strings['en']![key] ?? key;
  }

  String get appTitle => _text('appTitle');
  String get brandTagline => _text('brandTagline');
  String get inspectorAppBadge => _text('inspectorAppBadge');
  String get signIn => _text('signIn');
  String get emailLabel => _text('emailLabel');
  String get passwordLabel => _text('passwordLabel');
  String get signInAction => _text('signInAction');
  String get signOutAction => _text('signOutAction');
  String get invalidCredentials => _text('invalidCredentials');
  String get unknownError => _text('unknownError');
  String get inspectorHomeTitle => _text('inspectorHomeTitle');
  String get inspectorHomeSubtitle => _text('inspectorHomeSubtitle');
  String get inspectorRoleLabel => _text('inspectorRoleLabel');
  String get badgeIdLabel => _text('badgeIdLabel');
  String get openTriageQueueAction => _text('openTriageQueueAction');
  String get openDispatchQueueAction => _text('openDispatchQueueAction');
  String get dispatchQueueTitle => _text('dispatchQueueTitle');
  String get dispatchTaskDetail => _text('dispatchTaskDetail');
  String get dispatchTaskNotFound => _text('dispatchTaskNotFound');
  String get emptyDispatchQueue => _text('emptyDispatchQueue');
  String get filterDispatchAssigned => _text('filterDispatchAssigned');
  String get filterDispatchInField => _text('filterDispatchInField');
  String get filterDispatchCompleted => _text('filterDispatchCompleted');
  String get startFieldVisitAction => _text('startFieldVisitAction');
  String get dispatchActionsTitle => _text('dispatchActionsTitle');
  String get oversightNoteLabel => _text('oversightNoteLabel');
  String get mockCredentialsHint => _text('mockCredentialsHint');
  String get triageQueueTitle => _text('triageQueueTitle');
  String get triageReportDetail => _text('triageReportDetail');
  String get triageReportNotFound => _text('triageReportNotFound');
  String get emptyTriageQueue => _text('emptyTriageQueue');
  String get loadErrorMessage => _text('loadErrorMessage');
  String get retryAction => _text('retryAction');
  String get filterAll => _text('filterAll');
  String get filterTriage => _text('filterTriage');
  String get filterReviewRequired => _text('filterReviewRequired');
  String get filterTrustAll => _text('filterTrustAll');
  String get filterTrustStandard => _text('filterTrustStandard');
  String get filterTrustLowGeo => _text('filterTrustLowGeo');
  String get trustLevelLabel => _text('trustLevelLabel');
  String get locationLabel => _text('locationLabel');
  String get coordinatesLabel => _text('coordinatesLabel');
  String get submittedAtLabel => _text('submittedAtLabel');
  String get geoMismatchNotice => _text('geoMismatchNotice');
  String get evidenceSectionTitle => _text('evidenceSectionTitle');
  String get videoLabel => _text('videoLabel');

  String queueCountLabel(int count) =>
      _text('queueCountLabel').replaceAll('{count}', '$count');

  String mockOtpHint(String code) =>
      _text('mockOtpHint').replaceAll('{code}', code);

  String mergeCaseNote(String caseId) =>
      _text('mergeCaseNote').replaceAll('{caseId}', caseId);

  String get inspectorActionsTitle => _text('inspectorActionsTitle');
  String get markInvalidAction => _text('markInvalidAction');
  String get mergeCaseAction => _text('mergeCaseAction');
  String get dispatchTaskAction => _text('dispatchTaskAction');
  String get validatedOutcomeTitle => _text('validatedOutcomeTitle');
  String get validateWarningAction => _text('validateWarningAction');
  String get validateFineAction => _text('validateFineAction');
  String get validateNoActionAction => _text('validateNoActionAction');
  String get sensitiveActionTitle => _text('sensitiveActionTitle');
  String get sensitiveActionMessage => _text('sensitiveActionMessage');
  String get confirmSensitiveAction => _text('confirmSensitiveAction');
  String get cancelAction => _text('cancelAction');
  String get otpCodeLabel => _text('otpCodeLabel');
  String get otpInvalid => _text('otpInvalid');
  String get actionAppliedNotice => _text('actionAppliedNotice');
  String get mockSyncTitle => _text('mockSyncTitle');
  String get importMockSnapshot => _text('importMockSnapshot');
  String get importMockSnapshotHelp => _text('importMockSnapshotHelp');
  String get importMockSnapshotSuccess => _text('importMockSnapshotSuccess');
  String get importMockSnapshotFailed => _text('importMockSnapshotFailed');
  String get actionFailedMessage => _text('actionFailedMessage');
  String get reportClosedNotice => _text('reportClosedNotice');
  String get actionNoteLabel => _text('actionNoteLabel');
  String get mergeCaseDialogTitle => _text('mergeCaseDialogTitle');
  String get mergeCaseIdLabel => _text('mergeCaseIdLabel');
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
