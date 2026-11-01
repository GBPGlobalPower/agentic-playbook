import { defineConfig, devices } from '@playwright/test';

// Playbook template: end-to-end tests and PR screenshots for a web app. Point BASE_URL at a running
// app, or let `webServer` start it. Install with the project's package manager:
// `npm i -D @playwright/test`, then `npx playwright install chromium` (once per machine).
const baseURL = process.env.BASE_URL ?? 'http://localhost:3000';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  reporter: process.env.CI ? 'github' : 'list',
  use: {
    baseURL,
    trace: 'retain-on-failure',
    screenshot: 'only-on-failure',
    // Screenshots never catch a half-finished animation; it also tests the reduced-motion path.
    contextOptions: { reducedMotion: 'reduce' },
  },
  projects: [
    { name: 'mobile', use: { ...devices['Pixel 7'] } },
    { name: 'desktop', use: { ...devices['Desktop Chrome'] } },
    { name: 'desktop-dark', use: { ...devices['Desktop Chrome'], colorScheme: 'dark' } },
  ],
  webServer: process.env.BASE_URL
    ? undefined
    : { command: 'npm run dev', url: baseURL, reuseExistingServer: !process.env.CI },
});
