import { defineConfig, devices } from '@playwright/test';

const PORT = Number(process.env.PORT || 4317);
const SITE_OUT = process.env.SITE_OUT || '.site';

export default defineConfig({
  testDir: './specs',
  fullyParallel: true,
  // Bounded so the suite does not starve emulators/builds on a shared dev machine. Override: WORKERS=8.
  workers: Number(process.env.WORKERS || (process.env.CI ? 2 : 4)),
  forbidOnly: !!process.env.CI,
  retries: 0,
  reporter: process.env.CI ? [['list'], ['html', { open: 'never' }]] : [['list'], ['html', { open: 'never' }]],
  outputDir: process.env.SITE_OUT ? `test-results/${SITE_OUT}` : 'test-results',
  use: {
    baseURL: `http://127.0.0.1:${PORT}`,
    screenshot: 'only-on-failure',
    trace: 'retain-on-failure',
  },
  projects: [{ name: 'chromium', use: { ...devices['Desktop Chrome'] } }],
  webServer: {
    // Copies the apps into .site first, then serves it read-only.
    command: `node scripts/build-site.mjs && python3 -m http.server ${PORT} --bind 127.0.0.1 --directory ${SITE_OUT}`,
    url: `http://127.0.0.1:${PORT}/index.html`,
    reuseExistingServer: false,
    timeout: 60_000,
  },
});
