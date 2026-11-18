import { Browser, Page } from '@playwright/test';

export const PAGES = [
  'index.html',
  'initiatives.html',
  'initiative.html?id=p3',
  'how-it-works.html',
  'faq.html',
  'about.html',
  'contact.html',
  'download.html',
  'privacy.html',
  'demo-sync.html',
] as const;

export const LOCALES = ['ru', 'en', 'he', 'ar'] as const;
export const RTL_LOCALES = ['he', 'ar'] as const;
export type Locale = (typeof LOCALES)[number];

/** Widths that must never scroll horizontally (both sides of every layout switch). */
export const NARROW_WIDTHS = [320, 375, 390, 399, 400, 768, 1024, 1120, 1121, 1440] as const;

/**
 * Widest viewport at which the header collapses into the burger menu (stage 1.2: ≤1120px).
 * Override with NAV_BREAKPOINT=<px> without editing the specs.
 */
export const NAV_BREAKPOINT = Number(process.env.NAV_BREAKPOINT || 1120);

/** Below this width the wordmark is hidden and only the "G." mark stays. */
export const WORDMARK_MIN_WIDTH = 400;

export const MENU_LABELS: Record<Locale, string> = { ru: 'Меню', en: 'Menu', he: 'תפריט', ar: 'القائمة' };

/** WCAG relative-luminance contrast for two CSS rgb()/rgba() strings (alpha ignored). */
export function contrast(a: string, b: string): number {
  const lum = (c: string) => {
    const [r, g, bl] = (c.match(/[\d.]+/g) || ['0', '0', '0']).slice(0, 3).map((v) => {
      const x = Number(v) / 255;
      return x <= 0.03928 ? x / 12.92 : Math.pow((x + 0.055) / 1.055, 2.4);
    });
    return 0.2126 * r + 0.7152 * g + 0.0722 * bl;
  };
  const [hi, lo] = [lum(a), lum(b)].sort((x, y) => y - x);
  return (hi + 0.05) / (lo + 0.05);
}

export const DESKTOP_WIDTH = 1440;

const LOCALE_KEY = 'gesher_public_locale';

/** Opens a page in a fresh context with the locale preset in localStorage. */
export async function openPage(browser: Browser, path: string, locale: Locale, width: number, height = 900) {
  const context = await browser.newContext({ viewport: { width, height } });
  await context.addInitScript(
    ([key, value]) => {
      try {
        localStorage.setItem(key, value);
      } catch {
        /* storage may be unavailable */
      }
    },
    [LOCALE_KEY, locale],
  );
  const page = await context.newPage();
  const errors: string[] = [];
  page.on('console', (m) => {
    if (m.type() === 'error') errors.push(m.text());
  });
  page.on('pageerror', (e) => errors.push(String(e)));
  await page.goto(`/${path}`, { waitUntil: 'networkidle' });
  return { context, page, errors };
}

/** Horizontal overflow of the document plus the element that sticks out the most (for the report). */
export async function measureOverflow(page: Page) {
  return page.evaluate(() => {
    const de = document.documentElement;
    const cw = de.clientWidth;
    let worst = '';
    let worstAmount = 0;
    for (const el of Array.from(document.body.querySelectorAll<HTMLElement>('*'))) {
      if (el.closest('.sr-only')) continue; // visually hidden helpers are positioned off-screen on purpose
      const style = getComputedStyle(el);
      if (style.visibility === 'hidden' || style.display === 'none') continue;
      const r = el.getBoundingClientRect();
      if (!r.width || !r.height) continue;
      const amount = Math.max(r.right - cw, -r.left);
      if (amount > worstAmount + 0.5) {
        worstAmount = amount;
        const cls = typeof el.className === 'string' && el.className.trim() ? '.' + el.className.trim().split(/\s+/).join('.') : '';
        worst = el.tagName.toLowerCase() + (el.id ? '#' + el.id : '') + cls;
      }
    }
    return { overflow: de.scrollWidth - cw, scrollWidth: de.scrollWidth, clientWidth: cw, worst, worstAmount: Math.round(worstAmount) };
  });
}
