const HOW_IT_WORKS_CONTENT = {
  ru: {
    title: 'Как это работает',
    intro:
      'G.E.S.H.E.R. объединяет три гражданских потока: инициативы, жалобы и сообщения о нарушениях. Публичный сайт показывает открытые инициативы; действия выполняются в мобильном приложении (mock beta).',
    flows: [
      {
        title: 'Инициативы',
        steps: [
          'Житель создаёт инициативу в приложении.',
          'Модератор проверяет и публикует её.',
          'Другие жители подписывают после верификации.',
          'Мэрия публикует официальный ответ.',
        ],
      },
      {
        title: 'Жалобы',
        steps: [
          'Житель отправляет жалобу с фото и геолокацией.',
          'Оператор мэрии назначает ответственный отдел.',
          'Служба устраняет проблему.',
          'Статус обновляется в приложении.',
        ],
      },
      {
        title: 'Нарушения',
        steps: [
          'Житель сообщает о возможном нарушении.',
          'Инспектор проводит триаж и выезд.',
          'Супервайзер контролирует итог.',
          'Результат фиксируется в системе.',
        ],
      },
    ],
  },
  en: {
    title: 'How it works',
    intro:
      'G.E.S.H.E.R. combines three civic flows: initiatives, complaints, and violation reports. The public site shows open initiatives; actions happen in the mobile app (mock beta).',
    flows: [
      {
        title: 'Initiatives',
        steps: [
          'A resident creates an initiative in the app.',
          'A moderator reviews and publishes it.',
          'Other residents sign after verification.',
          'The municipality publishes an official response.',
        ],
      },
      {
        title: 'Complaints',
        steps: [
          'A resident submits a complaint with photo and location.',
          'A municipal operator assigns a department.',
          'The service team resolves the issue.',
          'Status updates appear in the app.',
        ],
      },
      {
        title: 'Violations',
        steps: [
          'A resident reports a possible violation.',
          'An inspector triages and dispatches field work.',
          'A supervisor oversees the outcome.',
          'The result is recorded in the system.',
        ],
      },
    ],
  },
  he: {
    title: 'איך זה עובד',
    intro: 'G.E.S.H.E.R. מאחד שלושה תהליכים אזרחיים: יוזמות, תלונות ודיווחי הפרות.',
    flows: [
      { title: 'יוזמות', steps: ['יצירה באפליקציה', 'מודרציה ופרסום', 'חתימות תושבים', 'תגובת עירייה'] },
      { title: 'תלונות', steps: ['שליחת תלונה עם מדיה', 'שיוך למחלקה', 'טיפול בשטח', 'עדכון סטטוס'] },
      { title: 'הפרות', steps: ['דיווח על הפרה', 'טריאז\' אינספקטור', 'פיקוח סופרווייזר', 'תיעוד תוצאה'] },
    ],
  },
  ar: {
    title: 'كيف يعمل',
    intro: 'تجمع G.E.S.H.E.R. بين المبادرات والشكاوى وبلاغات المخالفات.',
    flows: [
      { title: 'المبادرات', steps: ['إنشاء في التطبيق', 'مراجعة ونشر', 'توقيعات السكان', 'رد البلدية'] },
      { title: 'الشكاوى', steps: ['إرسال مع صورة وموقع', 'تعيين قسم', 'معالجة ميدانية', 'تحديث الحالة'] },
      { title: 'المخالفات', steps: ['بلاغ مخالفة', 'فرز المفتش', 'إشراف المشرف', 'تسجيل النتيجة'] },
    ],
  },
};

const FAQ_CONTENT = {
  ru: [
    {
      q: 'Что такое G.E.S.H.E.R.?',
      a: 'Гражданская платформа для инициатив, жалоб и сообщений о нарушениях. Сейчас работает в mock beta без backend.',
    },
    {
      q: 'Можно ли подписать инициативу на сайте?',
      a: 'Нет. Подпись доступна только в мобильном приложении после верификации личности (в mock — упрощённый режим).',
    },
    {
      q: 'Где посмотреть опубликованные инициативы?',
      a: 'На странице «Инициативы» этого сайта. Показываются только опубликованные записи из shared mock seed.',
    },
    {
      q: 'Это уже production?',
      a: 'Нет. Текущая версия для демонстрации UX и согласования процессов. Данные хранятся локально в mock-режиме.',
    },
    {
      q: 'Где портал для сотрудников мэрии?',
      a: 'Staff Portal доступен по ссылке «Портал сотрудников» в шапке сайта или напрямую: /staff/index.html',
    },
  ],
  en: [
    {
      q: 'What is G.E.S.H.E.R.?',
      a: 'A civic platform for initiatives, complaints, and violation reports. Currently mock beta without backend.',
    },
    {
      q: 'Can I sign an initiative on the website?',
      a: 'No. Signing is available only in the mobile app after identity verification (simplified in mock).',
    },
    {
      q: 'Where can I browse published initiatives?',
      a: 'On the Initiatives page. Only published records from the shared mock seed are shown.',
    },
    {
      q: 'Is this production?',
      a: 'No. This build is for UX demo and process alignment. Data is stored locally in mock mode.',
    },
    {
      q: 'Where is the staff portal?',
      a: 'Use the Staff portal link in the header or go to /staff/index.html',
    },
  ],
  he: [
    { q: 'מה זה G.E.S.H.E.R.?', a: 'פלטפורמה אזרחית ליוזמות, תלונות ודיווחי הפרות. כרגע mock beta.' },
    { q: 'האם ניתן לחתום באתר?', a: 'לא. חתימה זמינה באפליקציית המובייל בלבד.' },
    { q: 'איפה רואים יוזמות?', a: 'בעמוד היוזמות באתר הציבורי.' },
    { q: 'האם זה production?', a: 'לא. זו גרסת mock להדגמת UX.' },
    { q: 'איפה פורטל הצוות?', a: 'בקישור פורטל צוות או ב-/staff/index.html' },
  ],
  ar: [
    { q: 'ما هي G.E.S.H.E.R.؟', a: 'منصة مدنية للمبادرات والشكاوى وبلاغات المخالفات. حاليًا mock beta.' },
    { q: 'هل يمكن التوقيع على الموقع؟', a: 'لا. التوقيع متاح في تطبيق الهاتف فقط.' },
    { q: 'أين أرى المبادرات؟', a: 'في صفحة المبادرات على الموقع العام.' },
    { q: 'هل هذا إنتاج؟', a: 'لا. هذا إصدار mock لعرض تجربة المستخدم.' },
    { q: 'أين بوابة الموظفين؟', a: 'عبر رابط بوابة الموظفين أو /staff/index.html' },
  ],
};

function getHowContent() {
  return HOW_IT_WORKS_CONTENT[getLocale()] || HOW_IT_WORKS_CONTENT.ru;
}

function getFaqContent() {
  return FAQ_CONTENT[getLocale()] || FAQ_CONTENT.ru;
}
