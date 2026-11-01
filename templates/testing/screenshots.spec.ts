import { expect, test, type Page } from '@playwright/test';

// Playbook template: capture each screen in each state the change touches, per project (mobile,
// desktop, dark), into screenshots/<TICKET>/ for the PR. `before` puts the page in a state before it
// loads (mock the API to fail or return nothing); `ready` is what must be visible before the capture.
// Run: TICKET=PROJ-12 npx playwright test screenshots.spec.ts
const TICKET = process.env.TICKET ?? 'local';

type Shot = { name: string; path: string; ready: string; before?: (page: Page) => Promise<unknown> };

const shots: Shot[] = [
  {
    name: 'items-default',
    path: '/',
    ready: 'text=Your items',
    before: (page) => page.route('**/api/items', (r) => r.fulfill({ json: [{ id: 1, name: 'First item' }] })),
  },
  {
    name: 'items-empty',
    path: '/',
    ready: 'text=Nothing here yet',
    before: (page) => page.route('**/api/items', (r) => r.fulfill({ json: [] })),
  },
  {
    name: 'items-error',
    path: '/',
    ready: 'text=Try again',
    before: (page) => page.route('**/api/items', (r) => r.fulfill({ status: 503 })),
  },
];

for (const shot of shots) {
  test(`screenshot ${shot.name}`, async ({ page }, testInfo) => {
    await shot.before?.(page);
    await page.goto(shot.path);
    await expect(page.locator(shot.ready).first()).toBeVisible();
    await page.screenshot({ path: `screenshots/${TICKET}/${shot.name}-${testInfo.project.name}.png`, fullPage: true });
  });
}
