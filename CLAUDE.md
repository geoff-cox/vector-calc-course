# CLAUDE.md — Project Instructions for Claude Code (MA 301 repo)

Read automatically by Claude Code (CLI and the GitHub Action) at the start
of every task. It defines what this repository is, the conventions to
follow, and how to submit work. Keep edits to this file surgical.

When a request says **"Task X"** (e.g., "Task B2"), it refers to a task in
`checklists/mobile-build-checklist.md` and its per-track detail files
`checklists/mobile-build-checklist-{A,B,C,D,E,M}.md`. Open the matching
file and follow its steps and acceptance criteria exactly.

---

## 1. What this repository is

The course site and materials for **MA 301 — Advanced Mathematics for
Scientists and Engineers** (multivariable/vector calculus core), being
modernized from outdated 2015-era materials into PreTeXt. Three content
streams live here:

1. **Homepage/syllabus** — `source/homepage.ptx` (an `<article>`)
   including `source/homepage/syllabus.ptx` and shared policy files in
   `source/homepage/syllabus/common/`.
2. **Coursebook** — `source/book.ptx`, an adaptation of *APEX Calculus*
   (CC BY-NC 4.0). It is being pruned to the MA 301 chapter subset.
3. **Guided Lecture Notes (GLN)** — PreTeXt `<worksheet>` files in
   `source/notes/`, ported from LaTeX/Beamer decks in
   `source/notes/latex/`. Student copies have blanks and unworked
   examples; instructor copies reveal everything.

The historical source of truth for course content is the old syllabus
`source/homepage/syllabus/docx/MA301_Syllabus_S2015.docx` and the old
LaTeX notes/tests under `source/notes/latex/` and `source/tests/latex/`.

## 2. Repository layout (orient before editing)

```
.
├── CLAUDE.md                          <- this file
├── checklists/
│   ├── mobile-build-checklist.md      <- master index + global rules
│   └── mobile-build-checklist-*.md    <- per-track task details (A..E)
├── project.ptx                        <- PreTeXt targets (read FIRST)
├── publication/                       <- publication files per target
├── source/
│   ├── homepage.ptx                   <- MA301 homepage article
│   ├── homepage/syllabus.ptx          <- syllabus (Task A rewrites this)
│   ├── homepage/syllabus/common/      <- shared VMI policies: NEVER edit
│   ├── book.ptx                       <- coursebook entry point (Task B)
│   ├── book/ptx/                      <- chapters, appendices
│   ├── bookends/docinfo.ptx           <- macros live here (Task D)
│   ├── bookends/frontmatter.ptx
│   ├── notes/                         <- GLN worksheets (Task C)
│   └── notes/latex/                   <- OLD Beamer decks: read-only input
└── .github/workflows/
    ├── claude.yml                     <- this action
    └── deploy-pages.yml               <- Pages deploy (Task E; builds the
                                          deploy targets declared in
                                          project.ptx via `--deploys`)
```

Before any task, run `pretext --version`, read `project.ptx` to learn the
actual target names, and skim the relevant checklist file. Do not assume
target names — read them.

## 3. The guided-notes conventions (Task C core)

Three mechanisms; they are NOT interchangeable:

1. `<fillin characters="N"/>` — an in-prose blank in BOTH builds.
   **Gotcha:** any text inside the tag is silently discarded. The answer
   never lives inside `<fillin>`.
2. `<commentary>` — block-level, instructor-only. Visibility comes from
   the `commentary` stringparam set per-target in `project.ptx`
   (`"yes"` on instructor targets only). Place it after the prose that
   contains the blanks, never inline.
3. `<exercise>` with `<statement>` + `<solution>` — multi-step worked
   computations. Visibility controlled by
   `<exercise-worksheet statement="yes" solution="no|yes"/>` in the
   publication files.

**Gotcha:** PreTeXt `<example>` renders its solution in BOTH builds.
Anything whose answer must hide on the student copy uses `<exercise>`.
Reserve `<example>` for read-along illustrations with NO hidden content.

**Commentary pattern:** group the blanks for one idea into a single
paragraph/list, then place ONE `<commentary>` block immediately after it
listing the answers *in order*. Do not scatter one commentary per blank.

Quick selection table:

| Situation                                 | Use                         |
|-------------------------------------------|-----------------------------|
| One/two-word blank inside a sentence      | `<fillin>` + `<commentary>` |
| Definition or theorem with a blank in it  | `<fillin>` + `<commentary>` |
| Multi-step worked computation             | `<exercise>` + `<solution>` |
| "Your turn" practice problem              | `<exercise>` + `<solution>` |
| Read-along illustration, no hidden answer | `<example>` (no solution)   |

Model worksheets: `source/notes/ws-function-notation.ptx` and
`source/notes/ws-vectors.ptx`. Match their structure, comment headers,
`<objectives>`, `<page>` division, and macro usage.

## 4. Verification gates (mandatory before every PR)

1. **Well-formedness** — for every touched `.ptx`:
   `python3 -c "import xml.etree.ElementTree as ET; ET.parse('FILE'); print('OK')"`
2. **Build** — `pretext build <target>` for every affected target, from
   the repo root. Filter the known-harmless warning:
   `... 2>&1 | grep -v 'asset directories'`. Any remaining warning or
   error must be fixed or explained in the PR.
3. **Xref integrity** (Task B especially) — the build log must contain
   zero unresolved cross-reference warnings.
4. **Visibility split** (worksheets) — pick a sentinel phrase that exists
   only in solution/commentary text, then:
   `grep -c "SENTINEL" output/<student-target>/<file>.html`  -> must be 0
   `grep -c "SENTINEL" output/<instructor-target>/<file>.html` -> must be >= 1
   Structural tags are unreliable sentinels; use answer-specific prose.

Paste the literal command output into the PR's "Verification evidence"
section. A PR without evidence is incomplete.

## 5. PR workflow

- Never push to `main`. Branch as `claude/<task-id>-<slug>`, open a PR
  using the repo PR template, one Task per PR.
- Keep PRs reviewable from a phone: prefer several small PRs over one
  large one. Task B in particular is staged (B1 report -> B2 prune ->
  B3 reroute -> B4 appendix) — do not combine stages.
- Add the `preview` label to the PR so `deploy-pages.yml` publishes the
  branch's rendered HTML to GitHub Pages; link the Actions run in the PR.
- Respond to review comments on the same branch; re-run all gates after
  every revision.

## 6. Improve, but itemize

The source material is a decade old and known to be flawed or incomplete.
You are expected to exercise judgment and actively improve it: deepen
shallow treatments, add motivating examples and practice problems, fix
mathematical or typographical errors, strengthen connections between
sections, and propose effective or creative pedagogical ideas.

The contract: **every substantive improvement is itemized in the PR's
"Improvements" section**, and genuinely uncertain editorial calls get a
`<!-- TODO(geoff): ... -->` comment in the source plus a line under
"Open questions". Faithful conversion is the baseline; silent deviation
from it is prohibited.

## 7. Prohibited

- Editing anything under `source/homepage/syllabus/common/` (shared VMI
  policy text is inherited unchanged).
- Editing `source/notes/latex/` or `source/tests/latex/` (historical
  inputs, read-only).
- Removing the APEX Calculus attribution, copyright, or CC BY-NC license
  text from the coursebook front matter. The adaptation must stay
  properly attributed.
- Putting answers inside `<fillin>`; using `<example>` where the answer
  must hide; inline `<commentary>`.
- Defining LaTeX macros anywhere except `source/bookends/docinfo.ptx`
  (see Task D).
- Merging your own PRs, force-pushing, or rewriting history on `main`.
