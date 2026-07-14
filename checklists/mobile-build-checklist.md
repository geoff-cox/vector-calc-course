# Mobile Build Checklist — Master Index

This is the task catalog for converting the MA 301 course materials into
PreTeXt. Each task has an ID (`A1`, `B2`, ...). From the GitHub mobile
app, open an issue or comment and write, for example:

> @claude Do Task B1. Details are in checklists/mobile-build-checklist-B-coursebook.md.

Claude Code reads `CLAUDE.md` (conventions, verification gates, PR rules)
automatically; the per-track files below hold the step-by-step details.

| Track | File | Scope |
|---|---|---|
| A | `mobile-build-checklist-A-syllabus.md` | MA 301 syllabus from the 2015 docx |
| B | `mobile-build-checklist-B-coursebook.md` | Prune/reroute/enhance the coursebook |
| C | `mobile-build-checklist-C-guided-notes.md` | Guided Lecture Notes worksheets |
| D | `mobile-build-checklist-D-macros.md` | LaTeX macro management |
| E | `mobile-build-checklist-E-deploy.md` | GitHub Pages deployment |
| M | `mobile-build-checklist-M-maintenance.md` | Ad hoc: answer keys, figures, QA, build fixes, visibility, legacy migration |

## Recommended work order

The tasks are scaffolded — later tracks depend on earlier ones:

1. **E1** (verify the deploy-target config in `project.ptx` — the
   workflow builds via `pretext build --deploys`) — do first so every
   subsequent PR can be reviewed as rendered HTML on Pages.
2. **A1 → A2** (syllabus) — small, and it fixes the authoritative topic
   list that Track B and C decisions hang on.
3. **B1 → B2 → B3 → B4** (coursebook) — strictly in order; B1 is a
   read-only audit whose report drives B2–B4. **B5** (spherical-convention
   alignment) is an independent coursebook enhancement, done when
   scheduled.
4. **C1**, then **C2 repeated per section** (worksheets) — the long tail;
   one worksheet per PR, ordered by the course schedule.
5. **D1/D2** — D1 is a standing rule enforced inside every task; D2 is an
   occasional audit.

## Current status

Snapshot of where the build stands; per-worksheet detail for Track C
lives in `docs/gln-roadmap.md`.

| Task | State | Landed |
|---|---|---|
| E1 — verify deploy-target config | todo | — |
| A1, A2 — MA 301 syllabus | ✅ done | #5 |
| B1 — cross-boundary xref audit | ✅ done | #6 |
| B2 — prune to the 6-chapter subset | ✅ done | #7 |
| B3 — reroute broken xrefs | ✅ done | #9 |
| B4 — prune the appendix | ✅ done | #11 |
| B5 — spherical-convention alignment (B5a + B5b) | ✅ done | #19, #20 |
| C1 — GLN roadmap (+ Section 0 review plan) | ✅ done | #12, #13 |
| C2 §0 — prerequisite review R1–R4 | ✅ done | #14–#17 |
| C2 §1–§4 — vector analysis + Fourier | todo | — |
| D1 — new-macro rule | standing (enforced per PR) | — |
| D2 — macro audit | todo | — |
| M1–M6 — maintenance | as needed | — |

Labels: **todo** = not yet started; **🔜 planned** = documented and next
up; **standing** = an always-on rule; **as needed** = run on demand.

Track B is complete: the coursebook is pruned, internally consistent, and
its spherical-coordinate material now uses the standard polar-angle
convention (B5a #19, B5b #20). B5b intentionally deferred the affected
spherical **exercise** answers (statements kept, marked `TODO(geoff)`);
re-authoring those under the new convention is tracked as an ad-hoc
maintenance item. GLN Section 0 (the prerequisite review) is complete;
Track C resumes at Section 1 (`ws-curves`, the first worksheet translated
from a Beamer deck).

## Global rules (apply to every task)

1. One task per branch, one branch per PR, PR template filled out
   completely, `preview` label applied.
2. All four verification gates from `CLAUDE.md` §4 pass, with literal
   command output pasted in the PR.
3. `source/homepage/syllabus/common/`, `source/notes/latex/`, and
   `source/tests/latex/` are never modified.
4. Improvements are welcome and encouraged — new examples, better
   explanations, corrections — but every one is itemized in the PR's
   "Improvements" section, and judgment calls get
   `<!-- TODO(geoff): ... -->` markers plus an "Open questions" line.
5. Any new LaTeX macro used anywhere goes into
   `source/bookends/docinfo.ptx` in the same PR (Task D1 rule).
6. If a task's inputs are missing or contradictory, open the PR anyway
   with what can be done safely and put the blocker under "Open
   questions" — do not guess on critical decisions (grading schemes,
   deletion of content not listed for deletion, license text).

## Mobile request recipes

Copy-paste starters for the phone:

- `@claude Do Task E1.`
- `@claude Do Task A1, then A2 in the same PR if A1 raises no blockers.`
- `@claude Do Task B1 and attach the audit report to the PR.`
- `@claude Do Task C2 for the section "The Dot Product". Old deck: source/notes/latex/01--functions-vectors/01_02_Dot_Product.tex.`
- `@claude Address my review comments on PR #12 and re-run all verification gates.`
- `@claude Run Task D2 and report, but only open a PR if fixes are needed.`
- `@claude Do Task B5a (spherical-convention definitional core).`
