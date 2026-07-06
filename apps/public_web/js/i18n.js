const LOCALE_STORAGE_KEY = 'gesher_public_locale';
const RTL_LOCALES = new Set(['he', 'ar']);

const I18N_STRINGS = {
  ru: {
    navHome: 'Главная',
    navInitiatives: 'Инициативы',
    navHow: 'Как это работает',
    navFaq: 'FAQ',
    navAbout: 'О платформе',
    heroTagline: 'Ваш голос. Ваш город.',
    heroTitle: 'Участвуйте в жизни города через G.E.S.H.E.R.',
    heroSubtitle:
      'Подписывайте инициативы, отправляйте жалобы и сообщайте о нарушениях — в одном гражданском приложении.',
    ctaDownload: 'Скачать приложение',
    ctaBrowser: 'Открыть в браузере',
    ctaStaff: 'Портал сотрудников',
    statsTitle: 'Влияние вместе',
    statsSubtitle: 'Агрегированные показатели mock-режима из общего seed.',
    statInitiatives: 'Инициатив подано',
    statReview: 'На рассмотрении',
    statImplemented: 'Реализовано',
    statVotes: 'Голосов жителей',
    ctaBandTitle: 'Готовы начать?',
    ctaBandText:
      'Полный цикл — подпись инициатив, жалобы с геолокацией и отчёты о нарушениях — доступен в мобильном приложении (mock beta).',
    footerProduct: 'Продукт',
    footerCitizen: 'Для жителей',
    footerStaff: 'Для мэрии',
    footerNote: 'G.E.S.H.E.R. · mock beta без backend',
    aboutTitle: 'О платформе G.E.S.H.E.R.',
    aboutText:
      'G.E.S.H.E.R. объединяет инициативы жителей, жалобы на городские проблемы и сообщения о нарушениях. Публичный сайт показывает открытые инициативы; действия выполняются в мобильном приложении.',
    mockBadge: 'MOCK BETA',
    localeLabel: 'Язык',
    initiativesTitle: 'Инициативы жителей',
    initiativesSubtitle: 'Опубликованные инициативы, открытые для подписи в приложении.',
    filterAll: 'Все',
    categoryBlag: 'Благоустройство',
    categoryTransport: 'Транспорт',
    categoryEcology: 'Экология',
    statusPublished: 'Опубликована',
    signaturesLabel: 'подписей',
    emptyInitiatives: 'Нет опубликованных инициатив по выбранному фильтру.',
    initiativesDisabled: 'Публичный каталог инициатив временно отключён в настройках портала.',
    backToList: '← К списку инициатив',
    signInApp: 'Подписать в приложении',
    signInAppHint: 'Подпись инициатив доступна в мобильном приложении после верификации (mock beta).',
    officialResponseTitle: 'Официальный ответ мэрии',
    trackingTitle: 'Статус рассмотрения',
    stepSubmitted: 'Подана',
    stepModeration: 'Модерация',
    stepPublished: 'Опубликована',
    stepSignatures: 'Сбор подписей',
    stepResponse: 'Ответ мэрии',
    stepImplemented: 'Реализована',
    initiativeNotFound: 'Инициатива не найдена или не опубликована.',
    viewDetails: 'Подробнее',
  },
  en: {
    navHome: 'Home',
    navInitiatives: 'Initiatives',
    navHow: 'How it works',
    navFaq: 'FAQ',
    navAbout: 'About',
    heroTagline: 'Your voice. Your city.',
    heroTitle: 'Shape your city with G.E.S.H.E.R.',
    heroSubtitle:
      'Sign initiatives, submit complaints, and report violations in one civic app.',
    ctaDownload: 'Download app',
    ctaBrowser: 'Open in browser',
    ctaStaff: 'Staff portal',
    statsTitle: 'Impact together',
    statsSubtitle: 'Aggregated mock metrics from the shared seed.',
    statInitiatives: 'Initiatives submitted',
    statReview: 'Under review',
    statImplemented: 'Implemented',
    statVotes: 'Citizen votes',
    ctaBandTitle: 'Ready to start?',
    ctaBandText:
      'The full flow — signing initiatives, geo complaints, and violation reports — is available in the mobile app (mock beta).',
    footerProduct: 'Product',
    footerCitizen: 'For residents',
    footerStaff: 'For municipality',
    footerNote: 'G.E.S.H.E.R. · mock beta without backend',
    aboutTitle: 'About G.E.S.H.E.R.',
    aboutText:
      'G.E.S.H.E.R. brings together resident initiatives, city complaints, and violation reports. The public site shows open initiatives; actions happen in the mobile app.',
    mockBadge: 'MOCK BETA',
    localeLabel: 'Language',
    initiativesTitle: 'Resident initiatives',
    initiativesSubtitle: 'Published initiatives open for signing in the app.',
    filterAll: 'All',
    categoryBlag: 'Urban improvement',
    categoryTransport: 'Transport',
    categoryEcology: 'Ecology',
    statusPublished: 'Published',
    signaturesLabel: 'signatures',
    emptyInitiatives: 'No published initiatives for this filter.',
    initiativesDisabled: 'The public initiative catalog is temporarily disabled.',
    backToList: '← Back to initiatives',
    signInApp: 'Sign in app',
    signInAppHint: 'Initiative signing is available in the mobile app after verification (mock beta).',
    officialResponseTitle: 'Official municipality response',
    trackingTitle: 'Review status',
    stepSubmitted: 'Submitted',
    stepModeration: 'Moderation',
    stepPublished: 'Published',
    stepSignatures: 'Collecting signatures',
    stepResponse: 'Municipality response',
    stepImplemented: 'Implemented',
    initiativeNotFound: 'Initiative not found or not published.',
    viewDetails: 'View details',
  },
  he: {
    navHome: 'בית',
    navInitiatives: 'יוזמות',
    navHow: 'איך זה עובד',
    navFaq: 'שאלות נפוצות',
    navAbout: 'אודות',
    heroTagline: 'הקול שלך. העיר שלך.',
    heroTitle: 'השפיעו על העיר עם G.E.S.H.E.R.',
    heroSubtitle: 'חתמו על יוזמות, שלחו תלונות ודווחו על הפרות באפליקציה אזרחית אחת.',
    ctaDownload: 'הורדת אפליקציה',
    ctaBrowser: 'פתיחה בדפדפן',
    ctaStaff: 'פורטל צוות',
    statsTitle: 'השפעה ביחד',
    statsSubtitle: 'מדדים מצטברים ממצב mock משותף.',
    statInitiatives: 'יוזמות שהוגשו',
    statReview: 'בבדיקה',
    statImplemented: 'יושמו',
    statVotes: 'קולות תושבים',
    ctaBandTitle: 'מוכנים להתחיל?',
    ctaBandText: 'הזרימה המלאה זמינה באפליקציית המובייל (mock beta).',
    footerProduct: 'מוצר',
    footerCitizen: 'לתושבים',
    footerStaff: 'לעירייה',
    footerNote: 'G.E.S.H.E.R. · mock beta ללא backend',
    aboutTitle: 'אודות G.E.S.H.E.R.',
    aboutText: 'G.E.S.H.E.R. מאחד יוזמות, תלונות ודיווחי הפרות. האתר הציבורי מציג יוזמות פתוחות; פעולות מתבצעות באפליקציה.',
    mockBadge: 'MOCK BETA',
    localeLabel: 'שפה',
    initiativesTitle: 'יוזמות תושבים',
    initiativesSubtitle: 'יוזמות שפורסמו ופתוחות לחתימה באפליקציה.',
    filterAll: 'הכל',
    categoryBlag: 'שיפור עירוני',
    categoryTransport: 'תחבורה',
    categoryEcology: 'אקולוגיה',
    statusPublished: 'פורסם',
    signaturesLabel: 'חתימות',
    emptyInitiatives: 'אין יוזמות שפורסמו לפי המסנן.',
    initiativesDisabled: 'קטלוג היוזמות הציבורי מושבת זמנית.',
    backToList: '← חזרה ליוזמות',
    signInApp: 'חתימה באפליקציה',
    signInAppHint: 'חתימה על יוזמות זמינה באפליקציה לאחר אימות (mock beta).',
    officialResponseTitle: 'תגובה רשמית מהעירייה',
    trackingTitle: 'סטטוס טיפול',
    stepSubmitted: 'הוגש',
    stepModeration: 'מודרציה',
    stepPublished: 'פורסם',
    stepSignatures: 'איסוף חתימות',
    stepResponse: 'תגובת עירייה',
    stepImplemented: 'יושם',
    initiativeNotFound: 'היוזמה לא נמצאה או לא פורסמה.',
    viewDetails: 'פרטים',
  },
  ar: {
    navHome: 'الرئيسية',
    navInitiatives: 'المبادرات',
    navHow: 'كيف يعمل',
    navFaq: 'الأسئلة الشائعة',
    navAbout: 'حول المنصة',
    heroTagline: 'صوتك. مدينتك.',
    heroTitle: 'شارك في حياة مدينتك عبر G.E.S.H.E.R.',
    heroSubtitle: 'وقّع على المبادرات، أرسل الشكاوى، وأبلغ عن المخالفات في تطبيق موحد.',
    ctaDownload: 'تنزيل التطبيق',
    ctaBrowser: 'فتح في المتصفح',
    ctaStaff: 'بوابة الموظفين',
    statsTitle: 'تأثير مشترك',
    statsSubtitle: 'مؤشرات mock مجمعة من البيانات المشتركة.',
    statInitiatives: 'مبادرات مقدمة',
    statReview: 'قيد المراجعة',
    statImplemented: 'منفذة',
    statVotes: 'أصوات السكان',
    ctaBandTitle: 'هل أنت مستعد للبدء؟',
    ctaBandText: 'التدفق الكامل متاح في تطبيق الهاتف (mock beta).',
    footerProduct: 'المنتج',
    footerCitizen: 'للسكان',
    footerStaff: 'للبلدية',
    footerNote: 'G.E.S.H.E.R. · mock beta بدون backend',
    aboutTitle: 'حول G.E.S.H.E.R.',
    aboutText: 'تجمع G.E.S.H.E.R. بين مبادرات السكان والشكاوى وبلاغات المخالفات. يعرض الموقع المبادرات المفتوحة؛ الإجراءات في التطبيق.',
    mockBadge: 'MOCK BETA',
    localeLabel: 'اللغة',
    initiativesTitle: 'مبادرات السكان',
    initiativesSubtitle: 'المبادرات المنشورة المتاحة للتوقيع في التطبيق.',
    filterAll: 'الكل',
    categoryBlag: 'تحسين المدينة',
    categoryTransport: 'النقل',
    categoryEcology: 'البيئة',
    statusPublished: 'منشورة',
    signaturesLabel: 'توقيعات',
    emptyInitiatives: 'لا توجد مبادرات منشورة لهذا الفلتر.',
    initiativesDisabled: 'كتالوج المبادرات العام معطل مؤقتًا.',
    backToList: '← العودة إلى المبادرات',
    signInApp: 'التوقيع في التطبيق',
    signInAppHint: 'التوقيع على المبادرات متاح في تطبيق الهاتف بعد التحقق (mock beta).',
    officialResponseTitle: 'الرد الرسمي للبلدية',
    trackingTitle: 'حالة المراجعة',
    stepSubmitted: 'مقدمة',
    stepModeration: 'المراجعة',
    stepPublished: 'منشورة',
    stepSignatures: 'جمع التوقيعات',
    stepResponse: 'رد البلدية',
    stepImplemented: 'منفذة',
    initiativeNotFound: 'المبادرة غير موجودة أو غير منشورة.',
    viewDetails: 'التفاصيل',
  },
};

let _locale = 'ru';

function getLocale() {
  return _locale;
}

function isRtlLocale(locale = _locale) {
  return RTL_LOCALES.has(locale);
}

function t(key) {
  const pack = I18N_STRINGS[_locale] || I18N_STRINGS.ru;
  return pack[key] || I18N_STRINGS.ru[key] || key;
}

function setLocale(locale) {
  const next = I18N_STRINGS[locale] ? locale : 'ru';
  _locale = next;
  localStorage.setItem(LOCALE_STORAGE_KEY, next);
  document.documentElement.lang = next;
  document.documentElement.dir = isRtlLocale(next) ? 'rtl' : 'ltr';
}

function initLocale() {
  const saved = localStorage.getItem(LOCALE_STORAGE_KEY);
  const fallback = document.documentElement.lang || 'ru';
  setLocale(I18N_STRINGS[saved] ? saved : fallback);
}

function bindLocaleSelect(select) {
  select.value = _locale;
  select.addEventListener('change', () => {
    setLocale(select.value);
    window.dispatchEvent(new CustomEvent('gesher:localechange'));
  });
}
