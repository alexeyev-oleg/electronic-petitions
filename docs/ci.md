# CI Quality Gates (Q1)

Automated checks for the mock-beta monorepo without backend or APK builds.

## Workflow

GitHub Actions: `.github/workflows/quality.yml`

| Job | What it runs |
|-----|----------------|
| **JS syntax** | `node --check` on public web, admin web, and `shared/mock/mock-store.js` |
| **Pages smoke** | `scripts/prepare-github-pages.sh` + required artifact checks |
| **Flutter analyze** | `flutter analyze` for `resident_app` and `inspector_app` |

Triggers: pull requests and pushes to `main` / `master`.

Deploy workflow (separate): `.github/workflows/deploy-github-pages.yml` — publishes `dist/gh-pages` to GitHub Pages on push when web/shared paths change.

## Local commands

```bash
./scripts/ci-check-js.sh
./scripts/ci-smoke-pages.sh

cd apps/resident_app && flutter pub get && flutter analyze
cd apps/inspector_app && flutter pub get && flutter analyze
```

## Mock release tags

After a major mock milestone, tag the repository:

```bash
git tag -a mock-v0.2.0 -m "Mock beta: R7 resident polish, U9 docs, Q1 CI"
git push origin mock-v0.2.0
```

See `CHANGELOG.md` for version notes.
