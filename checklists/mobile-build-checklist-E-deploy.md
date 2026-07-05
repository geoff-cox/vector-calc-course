# Track E — GitHub Pages Deployment

**Goal:** every piece of work is reviewable as rendered HTML from a
phone. `.github/workflows/deploy-pages.yml` builds the PreTeXt targets
and publishes them: pushes to `main` deploy the real site; a PR labeled
`preview` deploys that branch instead (the repo has one Pages site, so a
preview temporarily replaces the main deployment — acceptable for a
single-instructor repo, and restored on merge).

## Task E1 — Align the deploy config with the repo (do this first)

1. Read `project.ptx`. The workflow runs `pretext build --deploys` then
   `pretext deploy --stage-only`, so what gets published is exactly what
   project.ptx marks for deployment — no workflow edit needed.
2. Verify the deploy configuration in `project.ptx` covers every HTML
   target worth publishing (homepage, book, notes student + instructor)
   and that a landing page ties them together. If a needed target is
   missing (e.g., no web notes target), add it, following the existing
   publication-file/stringparam pattern (`commentary` stringparam on
   instructor targets only) and mark it for deploy.
3. Confirm one-time settings in the PR body as reviewer to-dos:
   Settings → Pages → Source = "GitHub Actions"; create the `preview`
   label if it doesn't exist.
4. Trigger `workflow_dispatch` on the branch; the Actions run must go
   green end-to-end and the landing page must link every target.

**Acceptance:** dispatch run deploys; `https://<user>.github.io/<repo>/`
lists all targets with a correct ref/sha stamp.

## Task E2 — Preview hygiene (standing rule)

1. Every content PR gets the `preview` label (if the token can't add
   labels, say so in the PR body so the instructor taps it — one tap on
   mobile re-triggers the deploy via the `labeled` event).
2. In the PR body, link the Actions run and the pages that changed
   (deep links, e.g. `.../notes-student/ws-dot-product.html`), so review
   is one tap per page.
3. After merge, confirm the `main` push re-deploy went green; if the
   site is left showing a stale preview, dispatch the workflow on
   `main`.
