// 1.2 — compact header at ≤ NAV_BREAKPOINT: brand · language select · burger; the panel holds
// the 5 links + CTA. Mouse and keyboard, focus management, outside click, RTL, narrow brand.
import { Page, expect, test } from '@playwright/test';
import { LOCALES, MENU_LABELS, NAV_BREAKPOINT, WORDMARK_MIN_WIDTH, measureOverflow, openPage } from './helpers';

const WIDTHS = [320, 390, WORDMARK_MIN_WIDTH, NAV_BREAKPOINT];

async function state(page: Page) {
  return page.evaluate(() => {
    const visible = (el: Element | null) => {
      if (!el) return false;
      const r = el.getBoundingClientRect();
      const cs = getComputedStyle(el);
      return r.width > 0 && r.height > 0 && cs.visibility !== 'hidden' && cs.display !== 'none';
    };
    const t = document.getElementById('nav-toggle');
    const nav = document.getElementById('site-nav');
    const panelLinks = nav ? Array.from(nav.querySelectorAll<HTMLAnchorElement>('.site-nav__link')) : [];
    const cta = nav?.querySelector<HTMLAnchorElement>('[data-testid="header-cta"]') || null;
    const shown = [...panelLinks, cta].filter((e): e is HTMLAnchorElement => visible(e));
    return {
      toggleVisible: visible(t),
      selectVisible: visible(document.getElementById('locale-select')),
      selectInPanel: !!nav?.querySelector('#locale-select'),
      wordmarkVisible: visible(document.getElementById('header-logo')),
      brandLabel: document.querySelector('.site-brand')?.getAttribute('aria-label') || '',
      expanded: t?.getAttribute('aria-expanded') ?? null,
      controls: t?.getAttribute('aria-controls') ?? null,
      label: t?.getAttribute('aria-label') ?? '',
      linkCount: panelLinks.length,
      ctaInPanel: !!cta,
      ctaHref: cta?.getAttribute('href') || '',
      shown: shown.length,
      rects: shown.map((a) => {
        const r = a.getBoundingClientRect();
        return { left: Math.round(r.left), right: Math.round(r.right) };
      }),
      viewport: document.documentElement.clientWidth,
      activeId: document.activeElement?.id || '',
      activeIsFirstLink: document.activeElement === panelLinks[0],
    };
  });
}

for (const locale of LOCALES) {
  for (const width of WIDTHS) {
    test.describe(`compact header ${locale} ${width}px`, () => {
      test('layout: brand · select · burger; panel = 5 links + CTA', async ({ browser }) => {
        const { context, page } = await openPage(browser, 'index.html', locale, width);
        const s = await state(page);
        expect(s.toggleVisible, 'burger visible').toBe(true);
        expect(s.selectVisible, 'language select visible outside the panel').toBe(true);
        expect(s.selectInPanel, 'language select is not inside the panel').toBe(false);
        expect(s.expanded).toBe('false');
        expect(s.controls).toBe('site-nav');
        expect(s.label, 'burger aria-label').toBe(MENU_LABELS[locale]);
        expect(s.linkCount, '.site-nav__link in panel').toBe(5);
        expect(s.ctaInPanel, 'CTA in panel').toBe(true);
        expect(s.ctaHref).toContain('download.html');
        expect(s.shown, 'panel content hidden while closed').toBe(0);
        expect(s.brandLabel, 'brand link accessible name').toBe('G.E.S.H.E.R.');
        expect(s.wordmarkVisible, `wordmark ${width < WORDMARK_MIN_WIDTH ? 'hidden' : 'shown'}`).toBe(width >= WORDMARK_MIN_WIDTH);
        await context.close();
      });

      test('mouse: open moves focus in, link/outside click and toggle close', async ({ browser }) => {
        const { context, page } = await openPage(browser, 'index.html', locale, width);
        await page.locator('#nav-toggle').click();
        let s = await state(page);
        expect(s.expanded).toBe('true');
        expect(s.shown, '5 links + CTA visible').toBe(6);
        expect(s.activeIsFirstLink, 'focus moves to the first panel link').toBe(true);
        for (const r of s.rects) {
          expect(r.left, 'panel inside viewport (left)').toBeGreaterThanOrEqual(0);
          expect(r.right, 'panel inside viewport (right)').toBeLessThanOrEqual(s.viewport);
        }
        const m = await measureOverflow(page);
        expect(m.overflow, `no horizontal scroll with menu open; offender ${m.worst}`).toBeLessThanOrEqual(0);

        await page.locator('#nav-toggle').click();
        expect((await state(page)).expanded, 'toggle closes').toBe('false');

        await page.locator('#nav-toggle').click();
        await page.mouse.click(5, 880); // outside the header
        expect((await state(page)).expanded, 'outside click closes').toBe('false');
        await context.close();
      });

      test('keyboard: Tab to burger, Enter opens, Escape closes and returns focus, Space opens', async ({ browser }) => {
        const { context, page } = await openPage(browser, 'index.html', locale, width);
        let reached = false;
        for (let i = 0; i < 25 && !reached; i++) {
          await page.keyboard.press('Tab');
          reached = (await state(page)).activeId === 'nav-toggle';
        }
        expect(reached, 'burger reachable with Tab').toBe(true);
        await page.keyboard.press('Enter');
        let s = await state(page);
        expect(s.expanded, 'Enter opens').toBe('true');
        expect(s.activeIsFirstLink, 'focus on first panel link').toBe(true);
        await page.keyboard.press('Escape');
        s = await state(page);
        expect(s.expanded, 'Escape closes').toBe('false');
        expect(s.activeId, 'focus returns to the burger').toBe('nav-toggle');
        await page.keyboard.press('Space');
        expect((await state(page)).expanded, 'Space opens').toBe('true');
        await context.close();
      });
    });
  }
}

test('clicking a panel link closes the menu and navigates', async ({ browser }) => {
  const { context, page } = await openPage(browser, 'index.html', 'ru', 390);
  await page.locator('#nav-toggle').click();
  await Promise.all([page.waitForURL(/faq\.html/), page.locator('#site-nav .site-nav__link[href*="faq"]').click()]);
  await page.waitForLoadState('networkidle');
  expect((await state(page)).expanded).toBe('false');
  await context.close();
});
