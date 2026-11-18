// 1.2 — no horizontal scroll on narrow screens, every page × every locale.
import { expect, test } from '@playwright/test';
import { LOCALES, NARROW_WIDTHS, PAGES, measureOverflow, openPage } from './helpers';

for (const locale of LOCALES) {
  for (const width of NARROW_WIDTHS) {
    test.describe(`overflow ${locale} ${width}px`, () => {
      for (const path of PAGES) {
        test(`${path}`, async ({ browser }) => {
          const { context, page } = await openPage(browser, path, locale, width);
          const m = await measureOverflow(page);
          await context.close();
          expect(
            m.overflow,
            `scrollWidth ${m.scrollWidth} > clientWidth ${m.clientWidth} (+${m.overflow}px); widest offender: ${m.worst} (+${m.worstAmount}px)`,
          ).toBeLessThanOrEqual(0);
        });
      }
    });
  }
}
