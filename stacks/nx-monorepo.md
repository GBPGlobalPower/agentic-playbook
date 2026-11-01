
## Stack: Nx monorepo (TypeScript)

- **Check the Nx docs for the installed version** before using generators, executors or plugin options; they change between majors. Add plugins with `nx add <plugin>` and upgrade with `nx migrate latest` then `nx migrate --run-migrations`, never by hand-editing versions.
- **Run things through Nx** so caching and the project graph apply: `nx run <project>:<target>`, `nx affected -t lint test build typecheck` for "what my change touched", and `nx run-many -t <target>` for everything. CI uses `affected` against the base branch.
- **Generate, don't copy**: new apps and libraries come from generators (`nx g @nx/<plugin>:lib …`) so config, tsconfig paths and targets are consistent.
- **Library types and tags**: every project has tags in `project.json`:
  - `type:app | feature | ui | data-access | util`, and `scope:<domain> | shared`.
  - Rules (enforced by `@nx/enforce-module-boundaries`): apps → feature; feature → ui, data-access, util; ui → util; data-access → util; util → util. A `scope:x` project may import only `scope:x` or `scope:shared`.
- **Public APIs**: import a library only through its entry point (`@org/<lib>`), never via deep paths. What isn't exported from `index.ts` is private.
- **One version policy**: dependencies sit in the root `package.json`, one version across the workspace. Vet new ones (`07-dependencies-supply-chain.md`).
- **Shared rules live in libraries**: tokens, i18n catalogues, API schemas (zod) and generated types are libraries used by both client and server, so a rule has one home.
- **`nx graph`** before big refactors: check the dependency direction, and that no cycles were introduced.
- **Caching**: targets declare their `inputs` and `outputs` correctly so the cache is safe; never cache targets with side effects (deploys).
- **Per-project `AGENTS.md`** is allowed for apps with their own rules (for example `apps/web/AGENTS.md` with the React overlay); the root file holds workspace rules.
