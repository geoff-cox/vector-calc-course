# BUILD-CHECKLIST.md — Numbered Task Catalog

A menu of repeatable jobs. From your phone you can write, for example,

> @claude run **Task 1** to port `01_02_Dot_Product.tex`

and Claude Code will open this file, follow the matching playbook, and submit
a PR. Each task lists its **trigger**, the **inputs** it needs from you, the
**steps** Claude follows, and the **acceptance criteria** the PR must meet.

Claude: every task ends by running the **verification gate** (CLAUDE.md §4)
and opening a PR per the **PR workflow** (CLAUDE.md §7). Those two are assumed
in every task below and are not repeated each time.

## Quick reference

| #  | Task                                          | You provide                       |
| -- | --------------------------------------------- | --------------------------------- |
| 1  | Port a worksheet from legacy LaTeX            | the `.tex` (paste or path) + title|
| 2  | Draft a new worksheet from scratch            | topic + what to cover             |
| 3  | Revise/extend the commentary answer keys      | which worksheet + which blanks    |
| 4  | Wire in figures (replace placeholders)        | image files or describe them      |
| 5  | Add a new chapter                             | chapter title + which worksheets  |
| 6  | Build & verify all targets (QA only)          | nothing                           |
| 7  | Fix a build or schema error                   | the error text, if you have it    |
| 8  | Adjust solution/commentary visibility         | which element + desired behavior  |
| 9  | Add or change math macros                     | the symbol(s) and intended use    |
| 10 | Address review feedback on an open PR         | just comment `@claude` on the PR  |

---

## Task 1 — Port a worksheet from legacy LaTeX

**Trigger:** "run Task 1 to port `<file>.tex`" (paste the LaTeX if it's not in
the repo).
**Inputs:** the legacy `.tex` content; the worksheet title; which chapter it
belongs to (default: the current chapter).

**Steps**
1. Read the legacy source. Identify its section structure (the I, II, III …
   boards) — each becomes one `<page>`.
2. For each revealed item (`\ON<1>{\B{...}}`), choose the mechanism per
   CLAUDE.md §3: short blank → `<fillin>`+`<commentary>`; multi-line
   derivation → `<exercise>`+`<solution>`.
3. Convert worked demonstrations and "your turn" problems to `<exercise>`
   (never `<example>` if the answer must hide).
4. Convert figures to `<figure>` blocks; leave TODO placeholders for images
   you don't have (CLAUDE.md §6).
5. Reuse macros from `main.ptx`; add new ones only if a symbol recurs (that's
   Task 9 territory — do it inline here if small).
6. **Improve while porting (CLAUDE.md §6b):** deepen any treatment the deck
   handles in a line or two, add examples/practice where a concept is
   under-supported, and fix errors or dated notation. Itemize these in the PR's
   "Improvements" list so the instructor can accept or reject each one.
7. Create `source/ws-<slug>.ptx`; add the `<xi:include>` to the chapter file.
8. Add an `<objectives>` list at the top mirroring the deck's learning goals.

**Acceptance criteria**
- Both HTML builds succeed.
- A solution-only phrase and a commentary-only phrase from the new file are
  absent in `web-student` and present in `web-instructor`.
- Section structure follows the original; prose preserved in the original
  voice; shallow spots meaningfully enriched (not padded); no fabricated
  figures; the PR lists its improvements.

---

## Task 2 — Draft a new worksheet from scratch

**Trigger:** "run Task 2: new worksheet on `<topic>`".
**Inputs:** the topic; a bullet list of what to cover (or let Claude propose an
outline first and wait for approval).

**Steps**
1. If no outline was given, propose a short outline (pages + objectives) in a
   PR-draft comment and **stop for approval** before writing the full file.
2. Once approved (or if an outline was supplied), write the worksheet using
   the three mechanisms, mirroring the style of `ws-function-notation.ptx`.
3. Include `<objectives>`, 4–6 `<page>`s, a mix of `<fillin>`/`<commentary>`
   for definitions and `<exercise>`/`<solution>` for computations, and a
   "Looking ahead" closing paragraph.
4. Create the file and add the chapter `<xi:include>`.

**Acceptance criteria:** same visibility checks as Task 1; content is
mathematically correct and self-consistent; difficulty ramps sensibly.

---

## Task 3 — Revise or extend commentary answer keys

**Trigger:** "run Task 3 on `ws-<name>`: …".
**Inputs:** which worksheet; which blanks/answers to add, fix, or reword.

**Steps**
1. Locate the relevant paragraph(s) and their trailing `<commentary>` block(s).
2. Edit, add, or split commentary so each cluster of blanks has exactly one
   ordered answer list immediately after it.
3. If you add new `<fillin>`s, give each a sensible `@characters` width.

**Acceptance criteria:** commentary phrases absent from student build, present
in instructor build; answer order matches blank order; no orphaned
"(Fill in: .)" debris (that's the symptom of answer-in-fillin — see CLAUDE.md
§3a).

---

## Task 4 — Wire in figures

**Trigger:** "run Task 4 on `ws-<name>`" (attach images, or describe them).
**Inputs:** image files (placed in or to be placed in `source/figures/`), or a
clear description if Claude should create a TikZ `<latex-image>` instead.

**Steps**
1. For raster images: put files under `source/figures/`, replace the
   placeholder with `<image source="figures/<file>" width="…%"/>`, and ensure
   the publication files declare the external assets directory if not already.
2. For diagrams to be drawn: replace the placeholder with an inline
   `<latex-image>` (TikZ) and note that `pretext build -g` is needed once to
   generate assets.
3. Keep captions; remove the TODO comment once resolved.

**Acceptance criteria:** builds succeed; figure renders (or, for TikZ, the
`-g` generation step is documented in the PR); no broken `source=` paths.

---

## Task 5 — Add a new chapter

**Trigger:** "run Task 5: new chapter `<title>`".
**Inputs:** chapter title; which worksheets (existing or to-be-created) it
contains.

**Steps**
1. Create `source/ch-<slug>.ptx` modeled on `ch-functions-vectors.ptx` (title,
   short `<introduction>`, `<xi:include>` lines + commented stubs).
2. Add the chapter `<xi:include>` to `main.ptx`.
3. If worksheets don't exist yet, list them as commented stubs and note that
   each is a follow-up Task 1 or Task 2.

**Acceptance criteria:** builds succeed; new chapter appears in the table of
contents; includes resolve.

---

## Task 6 — Build & verify all targets (QA only)

**Trigger:** "run Task 6" (use after manual edits, or to sanity-check `main`).
**Inputs:** none.

**Steps**
1. Run the full verification gate (CLAUDE.md §4) for both HTML targets.
2. Attempt the PDF targets only if TeX is available; otherwise report that
   PDF was skipped and why.
3. Report results. If on a branch with changes, open/refresh the PR; if `main`
   is clean, just post the results as a comment (no PR needed).

**Acceptance criteria:** a clear pass/fail table covering all attempted
targets and the grep visibility checks.

---

## Task 7 — Fix a build or schema error

**Trigger:** "run Task 7" + paste the error if you have it.
**Inputs:** the failing target and error text (optional — Claude can reproduce).

**Steps**
1. Reproduce the failing build; capture the real error (filter the harmless
   "Publication file does not specify asset directories" warnings).
2. Diagnose: common culprits are unknown publication elements (schema drift),
   malformed `<md>`/`<mrow>` alignment, unescaped `<`/`&` in math, or a bad
   `<xi:include>` path.
3. Fix minimally; do not restructure working content to paper over an error.

**Acceptance criteria:** the previously failing target builds; the
verification gate still passes; the PR explains the root cause in 1–2 lines.

---

## Task 8 — Adjust solution/commentary visibility

**Trigger:** "run Task 8 on `<element>`: …".
**Inputs:** which element/worksheet; the desired student-vs-instructor
behavior.

**Steps**
1. Decide the correct mechanism (CLAUDE.md §3). Converting an `<example>` that
   must hide its answer into an `<exercise>` is the most common case.
2. Make the change; if it's a global toggle, edit the publication files or the
   `commentary` stringparam in `project.ptx` rather than per-element hacks.

**Acceptance criteria:** the targeted content shows/hides exactly as requested,
confirmed by grep counts in both builds; nothing else changes visibility.

---

## Task 9 — Add or change math macros

**Trigger:** "run Task 9: add macro for `<symbol>`".
**Inputs:** the symbol/notation and how it'll be used.

**Steps**
1. Add or edit the `\newcommand` / `\DeclareMathOperator` in the `<macros>`
   block of `source/main.ptx`.
2. Optionally sweep existing worksheets to adopt the new macro where it
   improves consistency (only if asked).

**Acceptance criteria:** builds succeed; the macro renders correctly in a quick
test instance; no clash with existing macro names.

---

## Task 10 — Address review feedback on an open PR

**Trigger:** comment `@claude …` directly on the PR (a review comment, a
review summary, or an inline thread).
**Inputs:** your review comments.

**Steps**
1. Read the entire review thread and the referenced lines.
2. Apply changes on the **same PR branch** (never a new PR).
3. Re-run the verification gate; push; reply with a short changelog and updated
   grep counts.

**Acceptance criteria:** each review point is addressed or explicitly answered;
gate still passes; no new PR was opened for the revision.
