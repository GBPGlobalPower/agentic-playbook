# Release checklist: <version> (YYYY-MM-DD)

Each line has evidence (a link, a number or a screenshot) or a ticket for what's missing.

## Product
- [ ] Every requirement in this milestone is done or explicitly deferred (owner-agreed)
- [ ] Release notes written from the merged PRs, in customer language

## Quality
- [ ] CI green on the release commit
- [ ] Offline and sync scenario passed (cold start offline, queued writes, a kill mid-write, reconnect)
- [ ] Layout QA matrix: 320 px, tablet and desktop widths, 200% zoom, 400% reflow, dark mode if supported
- [ ] Accessibility audit: no open critical or serious findings
- [ ] Performance on real mid-range hardware within budget (Web Vitals, API p95)

## Security and privacy
- [ ] Security audit since the last release: no open high or critical findings
- [ ] Dependency audit: no unaccepted high advisories
- [ ] Secrets rotated if anyone with access left; none in the repo (secret scan)
- [ ] Privacy notice and any required privacy disclosures match what the product collects
- [ ] Logs, analytics and crash reports scrubbed of content

## Data and infrastructure
- [ ] Migrations applied to prod by the pipeline; backward compatible with the live client
- [ ] Backups on, and a restore tested within the last quarter
- [ ] Jobs and functions deployed with prod configuration; alerts set

## Shipping
- [ ] Version and build numbers bumped
- [ ] Release notes published (changelog, in-product notice or status page)
- [ ] Rollback plan: previous build available; feature gates to switch off; forward-fix plan for data
- [ ] Watch crash-free rate and key flows for 24 h after release; log the result
