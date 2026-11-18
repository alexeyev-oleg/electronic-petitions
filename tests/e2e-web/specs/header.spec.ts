// 1.2 — desktop header (> NAV_BREAKPOINT): one row "brand | 5 links | CTA | language",
// visual order = Tab order (mirrored in RTL), no burger, active link readable.
// Staff portal and Demo sync live in the footer, not in the header.
import { expect, test } from '@playwright/test';
import { DESKTOP_WIDTH, LOCALES, NAV_BREAKPOINT, PAGES, RTL_LOCALES, contrast, openPage } from './helpers';

const NAV_HREFS = ['index.html', 'initiatives.html', 'how-it-works.html', 'faq.html', 'about.html'];
const ACTIVE_HREF: Record<string, string> = {
  'index.html': 'index.html',
  'initiatives.html': 'initiatives.html',
  'initiative.html?id=p3': 'initiatives.html',
  'how-it-works.html': 'how-it-works.html',
  'faq.html': 'faq.html',
  'about.html': 'about.html',
};
const WIDE = [NAV_BREAKPOINT + 1, DESKTOP_WIDTH];

for (const locale of LOCALES) {
  for (const width of WIDE) {
    test.describe(`header ${locale} ${width}px`, () => {
      for (const path of PAGES) {
        test(`${path}`, async ({ browser }) => {
          const { context, page } = await openPage(browser, path, locale, width);
          const h = await page.evaluate(() => {
            const header = document.getElementById('site-header')!;
            const footer = document.getElementById('site-footer');
            const visible = (el: Element | null): el is HTMLElement => {
              if (!el) return false;
              const r = el.getBoundingClientRect();
              const cs = getComputedStyle(el);
              return r.width > 0 && r.height > 0 && cs.visibility !== 'hidden' && cs.display !== 'none';
            };
            const links = Array.from(header.querySelectorAll<HTMLAnchorElement>('.site-nav__link')).filter(visible);
            const cta = header.querySelector<HTMLAnchorElement>('[data-testid="header-cta"]');
            const select = header.querySelector<HTMLSelectElement>('#locale-select');
            const brand = header.querySelector<HTMLAnchorElement>('.site-brand');
            const row = [brand, ...links, cta, select].filter(visible);
            const rects = row.map((e) => e.getBoundingClientRect());
            const oneRow = rects.length > 0 && Math.max(...rects.map((r) => r.top)) < Math.min(...rects.map((r) => r.bottom));

            // Tab order of focusable, visible header controls vs their on-screen x order.
            const focusables = Array.from(header.querySelectorAll<HTMLElement>('a[href], button, select, [tabindex]'))
              .filter((e) => visible(e) && e.tabIndex >= 0);
            const centers = focusables.map((e) => {
              const r = e.getBoundingClientRect();
              return Math.round(r.left + r.width / 2);
            });

            // Active link: aria-current, weight, contrast against the first opaque background.
            const active = links.filter((a) => a.getAttribute('aria-current') === 'page');
            const bgOf = (el: Element | null): string => {
              for (let n = el; n; n = n.parentElement) {
                const bg = getComputedStyle(n).backgroundColor;
                if (bg && !/rgba\(.*,\s*0\)$/.test(bg) && bg !== 'transparent') return bg;
              }
              return 'rgb(255, 255, 255)';
            };
            const a0 = active[0];
            const hrefs = (root: Element | null) => (root ? Array.from(root.querySelectorAll('a')).map((a) => a.getAttribute('href') || '') : []);
            return {
              navHrefs: links.map((a) => a.getAttribute('href') || ''),
              ctaVisible: visible(cta),
              ctaHref: cta?.getAttribute('href') || '',
              selectVisible: visible(select),
              toggleVisible: visible(document.getElementById('nav-toggle')),
              oneRow,
              rowTops: rects.map((r) => Math.round(r.top)),
              focusOrder: focusables.map((e) => e.id || e.className.split(' ')[0] || e.tagName),
              centers,
              activeHrefs: active.map((a) => a.getAttribute('href') || ''),
              activeColor: a0 ? getComputedStyle(a0).color : '',
              activeBg: a0 ? bgOf(a0) : '',
              activeWeight: a0 ? Number(getComputedStyle(a0).fontWeight) : 0,
              headerHrefs: hrefs(header),
              footerHrefs: hrefs(footer),
              dir: document.documentElement.getAttribute('dir') || 'ltr',
            };
          });
          await context.close();

          expect(h.navHrefs.length, `visible .site-nav__link: ${h.navHrefs.join(', ')}`).toBe(5);
          NAV_HREFS.forEach((target, i) => expect(h.navHrefs[i], `nav link #${i + 1}`).toContain(target));
          expect(h.selectVisible, 'language select visible').toBe(true);
          expect(h.ctaVisible, 'header CTA visible').toBe(true);
          expect(h.ctaHref, 'header CTA goes to download.html').toContain('download.html');
          expect(h.toggleVisible, 'no burger above the breakpoint').toBe(false);
          expect(h.oneRow, `header on one row; tops: ${h.rowTops.join(', ')}`).toBe(true);

          // Visual order follows Tab order: x ascending in LTR, descending in RTL.
          const sorted = [...h.centers].sort((a, b) => (h.dir === 'rtl' ? b - a : a - b));
          expect(h.centers, `Tab order ${h.focusOrder.join(' → ')} matches visual order (${h.dir})`).toEqual(sorted);
          expect(h.focusOrder.at(-1), 'language select is last in the row').toBe('locale-select');

          expect(h.headerHrefs.filter((x) => x.includes('staff')), 'staff portal not in header').toEqual([]);
          expect(h.headerHrefs.filter((x) => x.includes('demo-sync')), 'Demo sync not in header').toEqual([]);
          expect(h.footerHrefs.some((x) => x.includes('staff')), 'staff portal link in footer').toBe(true);
          expect(h.footerHrefs.some((x) => x.includes('demo-sync')), 'Demo sync link in footer').toBe(true);

          const expectedActive = ACTIVE_HREF[path];
          if (expectedActive) {
            expect(h.activeHrefs.length, 'exactly one aria-current="page"').toBe(1);
            expect(h.activeHrefs[0]).toContain(expectedActive);
            expect(h.activeWeight, 'active link weight').toBeGreaterThanOrEqual(600);
            const ratio = contrast(h.activeColor, h.activeBg);
            expect(ratio, `active link ${h.activeColor} on ${h.activeBg} = ${ratio.toFixed(2)}:1`).toBeGreaterThanOrEqual(4.5);
          } else {
            expect(h.activeHrefs, 'no nav item is current on pages outside the menu').toEqual([]);
          }
        });
      }
    });
  }
}

test.describe('hero: primary button comes first in reading order', () => {
  for (const locale of [...RTL_LOCALES, 'ru'] as const) {
    test(`index ${locale}`, async ({ browser }) => {
      const { context, page } = await openPage(browser, 'index.html', locale, DESKTOP_WIDTH);
      const xs = await page.evaluate(() => {
        const r = (id: string) => document.getElementById(id)!.getBoundingClientRect();
        return { primary: r('cta-download').left, secondary: r('cta-browser').left, dir: document.documentElement.dir };
      });
      await context.close();
      if (xs.dir === 'rtl') expect(xs.primary, 'RTL: primary button on the right').toBeGreaterThan(xs.secondary);
      else expect(xs.primary, 'LTR: primary button on the left').toBeLessThan(xs.secondary);
    });
  }
});
