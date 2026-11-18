// 1.1 — the G.E.S.H.E.R. wordmark always reads left-to-right, while RTL pages stay RTL.
import { expect, test } from '@playwright/test';
import { DESKTOP_WIDTH, PAGES, RTL_LOCALES, openPage } from './helpers';

const WIDTHS = [390, DESKTOP_WIDTH];

for (const locale of RTL_LOCALES) {
  for (const width of WIDTHS) {
    test.describe(`logo ${locale} ${width}px`, () => {
      for (const path of PAGES) {
        test(`${path}`, async ({ browser }) => {
          const { context, page } = await openPage(browser, path, locale, width);
          const info = await page.evaluate(() => {
            const logos = Array.from(document.querySelectorAll<HTMLElement>('.logo')).filter(
              (el) => el.getBoundingClientRect().width > 0,
            );
            return {
              htmlDir: document.documentElement.getAttribute('dir'),
              logos: logos.map((el) => ({
                id: el.id || el.className,
                direction: getComputedStyle(el).direction,
                // Visual order: letters sorted by their on-screen x position.
                visual: Array.from(el.querySelectorAll<HTMLElement>('.logo__letter'))
                  .map((s) => ({ t: (s.textContent || '').trim(), x: s.getBoundingClientRect().left }))
                  .sort((a, b) => a.x - b.x)
                  .map((s) => s.t)
                  .join(''),
              })),
            };
          });
          await context.close();

          expect(info.htmlDir, '<html dir> must stay rtl').toBe('rtl');
          expect(info.logos.length, 'at least the header logo is rendered').toBeGreaterThan(0);
          for (const logo of info.logos) {
            expect(logo.visual, `${logo.id}: letters read left-to-right`).toBe('GESHER');
            expect(logo.direction, `${logo.id}: computed direction`).toBe('ltr');
          }
        });
      }
    });
  }
}
