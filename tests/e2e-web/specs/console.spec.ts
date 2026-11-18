// Guard: no JavaScript errors on any page in any locale.
import { expect, test } from '@playwright/test';
import { DESKTOP_WIDTH, LOCALES, PAGES, openPage } from './helpers';

for (const locale of LOCALES) {
  test.describe(`console ${locale}`, () => {
    for (const path of PAGES) {
      test(`${path}`, async ({ browser }) => {
        const { context, errors } = await openPage(browser, path, locale, DESKTOP_WIDTH);
        await context.close();
        expect(errors, 'console errors').toEqual([]);
      });
    }
  });
}
