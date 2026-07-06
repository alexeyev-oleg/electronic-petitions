const PLACEHOLDER_COPY = {
  ru: {
    initiatives: {
      title: 'Инициативы',
      text: 'Публичный каталог инициатив — этап W2.1.',
    },
    how: {
      title: 'Как это работает',
      text: 'Информационные страницы — этап W2.2.',
    },
    faq: {
      title: 'FAQ',
      text: 'Частые вопросы — этап W2.2.',
    },
  },
  en: {
    initiatives: { title: 'Initiatives', text: 'Public initiative catalog — W2.1 stage.' },
    how: { title: 'How it works', text: 'Info pages — W2.2 stage.' },
    faq: { title: 'FAQ', text: 'Frequently asked questions — W2.2 stage.' },
  },
  he: {
    initiatives: { title: 'יוזמות', text: 'קטלוג יוזמות ציבורי — שלב W2.1.' },
    how: { title: 'איך זה עובד', text: 'דפי מידע — שלב W2.2.' },
    faq: { title: 'שאלות נפוצות', text: 'שאלות נפוצות — שלב W2.2.' },
  },
  ar: {
    initiatives: { title: 'المبادرات', text: 'كتالوج المبادرات العام — مرحلة W2.1.' },
    how: { title: 'كيف يعمل', text: 'صفحات معلومات — مرحلة W2.2.' },
    faq: { title: 'الأسئلة الشائعة', text: 'الأسئلة الشائعة — مرحلة W2.2.' },
  },
};

function placeholderCopy(pageKey) {
  const pack = PLACEHOLDER_COPY[getLocale()] || PLACEHOLDER_COPY.ru;
  return pack[pageKey];
}

function renderPlaceholder(pageKey) {
  const copy = placeholderCopy(pageKey);
  document.getElementById('placeholder-title').textContent = copy.title;
  document.getElementById('placeholder-text').textContent = copy.text;
}

function initPlaceholderPage(pageKey) {
  window.onPublicLocaleChange = () => renderPlaceholder(pageKey);
  document.addEventListener('DOMContentLoaded', () => {
    initPublicShell();
    renderPlaceholder(pageKey);
  });
}
