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

function getHowContent() {
  return HOW_IT_WORKS_CONTENT[getLocale()] || HOW_IT_WORKS_CONTENT.ru;
}
