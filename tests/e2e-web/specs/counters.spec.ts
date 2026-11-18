// 1.1b — signature counters keep their numeric order in RTL.
// "128 / 500" must read 128 → 500 left-to-right on screen in he/ar, and "16%" must stay "16%".
// Checked by on-screen character coordinates (Range rects), not by markup, because mixed
// RTL text is easy to misread on a screenshot and the fix may change markup later.
import { expect, test } from '@playwright/test';
import { DESKTOP_WIDTH, openPage } from './helpers';

const PAGES = ['index.html', 'initiatives.html', 'initiative.html?id=p3'];
const LOCALES = ['he', 'ar', 'ru'] as const; // ru = LTR control
const WIDTHS = [390, DESKTOP_WIDTH];

type Counter = { logical: string; visual: string; context: string };

for (const locale of LOCALES) {
  for (const width of WIDTHS) {
    test.describe(`counters ${locale} ${width}px`, () => {
      for (const path of PAGES) {
        test(`${path}`, async ({ browser }) => {
          const { context, page } = await openPage(browser, path, locale, width);
          const counters: Counter[] = await page.evaluate(() => {
            const PAIR = /\d[\d,.  ]*\s*\/\s*\d[\d,.  ]*/g;
            const PCT = /\d+(?:[.,]\d+)?\s?%/g;
            // Smallest block-ish ancestor that holds a whole counter line.
            const holders = new Set<Element>();
            const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
            for (let n = walker.nextNode(); n; n = walker.nextNode()) {
              const el = n.parentElement;
              if (!el || !/\d/.test(n.textContent || '')) continue;
              let holder: Element = el;
              while (holder.parentElement && !PAIR.test(holder.textContent || '') && holder !== document.body) {
                PAIR.lastIndex = 0;
                holder = holder.parentElement;
              }
              PAIR.lastIndex = 0;
              if (PAIR.test(holder.textContent || '')) holders.add(holder);
              PAIR.lastIndex = 0;
            }
            // Keep only innermost holders.
            const inner = [...holders].filter((h) => ![...holders].some((o) => o !== h && h.contains(o)));
            const out: { logical: string; visual: string; context: string }[] = [];
            for (const h of inner) {
              const r = h.getBoundingClientRect();
              if (!r.width || !r.height) continue;
              const chars: { c: string; x: number; y: number }[] = [];
              const range = document.createRange();
              const tw = document.createTreeWalker(h, NodeFilter.SHOW_TEXT);
              for (let t = tw.nextNode() as Text | null; t; t = tw.nextNode() as Text | null) {
                for (let i = 0; i < t.length; i++) {
                  const ch = t.data[i];
                  range.setStart(t, i);
                  range.setEnd(t, i + 1);
                  const b = range.getBoundingClientRect();
                  if (!b.width) continue;
                  chars.push({ c: ch.trim() ? ch : ' ', x: b.left, y: Math.round((b.top + b.bottom) / 2) });
                }
              }
              // Visual order: by line (y within 4px), then left-to-right.
              chars.sort((a, b) => (Math.abs(a.y - b.y) > 4 ? a.y - b.y : a.x - b.x));
              const visual = chars.map((c) => c.c).join('').replace(/\s+/g, ' ');
              const logical = (h.textContent || '').replace(/\s+/g, ' ');
              const tokens = (s: string) => [...(s.match(PAIR) || []), ...(s.match(PCT) || [])].map((x) => x.replace(/\s+/g, ''));
              out.push({
                logical: tokens(logical).join(' | '),
                visual: tokens(visual).join(' | '),
                context: logical.trim().slice(0, 80),
              });
            }
            return out;
          });
          await context.close();

          expect(counters.length, 'at least one "count / goal" counter on the page').toBeGreaterThan(0);
          for (const c of counters) {
            expect(c.visual, `on-screen order of "${c.context}"`).toBe(c.logical);
          }
        });
      }
    });
  }
}
