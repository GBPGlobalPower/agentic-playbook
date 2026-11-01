
## Stack: React (web)

- **Check the docs for the installed major version** of React, the router and the framework (Next.js, Remix/React Router, Vite) before using an API: server components, data APIs and caching change between majors.
- **Server vs client**: secrets, service keys and privileged queries live only in server code (route handlers, server actions, API). Anything in the client bundle is public; only publishable keys reach it (`NEXT_PUBLIC_`, `VITE_` prefixes are public by definition).
- **Data**: one query library (TanStack Query, or the framework's loaders), keys scoped by tenant and by user for "me" queries, invalidation on mutation, and one retry layer. Forms validate on the client for UX and on the server for truth (one shared schema, e.g. zod).
- **States**: every route and data region renders loading (a skeleton), error (an error boundary with retry), empty and offline. Suspense boundaries sit where a skeleton makes sense, not at the root.
- **Styling**: design tokens as CSS variables or theme constants; components come from the kit (with Storybook or a `/dev/kit` page). No hard-coded colours or spacing.
- **Accessibility**: semantic HTML first, ARIA only to fill gaps. `eslint-plugin-jsx-a11y` on. Visible focus, focus management for dialogs and route changes, 24 × 24 CSS px targets minimum, 200% zoom and 320 px reflow. Automated checks with axe (in component tests and Playwright), plus a manual screen reader pass (VoiceOver or NVDA).
- **i18n**: ICU messages (react-i18next with ICU, or FormatJS), no inline copy, and `Intl` formatting with the person's locale and zone.
- **Security headers**: a CSP without `unsafe-inline` scripts where possible, `frame-ancestors`, HSTS, `Referrer-Policy`, `Permissions-Policy`. Cookies are `HttpOnly; Secure; SameSite` for sessions. CSRF protection for cookie-authenticated mutations. Never `dangerouslySetInnerHTML` unsanitised content.
- **Performance**: budgets in Web Vitals (LCP, INP, CLS) on a mid-range phone; code-split per route; next-gen images with sizes; no layout thrash in animations (transform and opacity only). Lighthouse CI or similar in CI for key pages.
- **Tests**: component tests with Testing Library (behaviour, not implementation); end-to-end with Playwright for key flows, against a local backend; visual or screenshot checks for the kit.
