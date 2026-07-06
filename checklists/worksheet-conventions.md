# Guided-Notes Worksheet Conventions (shared across course repos)

> **This file is kept byte-identical in `geoff-cox/diff-eqs-course` and
> `geoff-cox/vector-calc-course`.** Never edit it in one repo alone: any
> change must be PR'd to both repos in the same round, and `diff` between
> the two copies must come back empty. Everything here is
> course-agnostic; the values that differ per course — target names,
> publication files, `<version include>` lists, the model worksheet, the
> coursebook and its location, the GLN track letter — live in each
> repo's `CLAUDE.md` (guided-notes section). Read that section first,
> then apply these conventions with those values.

## 1. The student/instructor split

Every worksheet builds twice from one source: a **student** copy
(blanks and unworked problems) and an **instructor** copy (everything
revealed). The split uses PreTeXt's component/version mechanism:

- Elements marked `component="stu"` appear only in the student build;
  elements marked `component="key"` appear only in the instructor
  build.
- The publication files select which survive: the student publication
  file lists `stu` (and not `key`) in `<source><version include="…"/>`;
  the instructor publication file lists `key` (and not `stu`). Each
  repo's `CLAUDE.md` names its publication files and full include
  lists.
- **Both versions must mirror each other in structure**: a `stu`
  element is always paired with a matching `key` element at the same
  spot, and vice versa. An unpaired `stu` or `key` element is a defect.

## 2. The mechanisms (NOT interchangeable)

1. **Reading-check blanks** — paired paragraphs:
   `<p component="stu">` containing `<fillin characters="N"/>` blanks,
   immediately followed by `<p component="key">` with the same sentence
   and the answers written as `<m>\underline{\textbf{answer}}</m>`.
   **Gotcha:** text inside `<fillin>` is silently discarded; the answer
   never lives inside `<fillin>`. Give each `<fillin>` a sensible
   `@characters` width.
2. **Worked problems** — paired exercises:
   `<exercise component="stu" workspace="Xin">` (statement only)
   followed by `<exercise component="key">` (same statement plus
   `<solution>`). `workspace="Xin"` reserves X inches of write-in space
   on the printed student copy — be conservative and add extra room for
   students who write large.
3. **Quick True/False checks** — may instead be a single `<exercise>`
   with `<solution component="key">` (statement shared, solution
   instructor-only).
4. `<exercise-worksheet statement="yes" solution="no|yes"/>` in the
   publication files additionally hides/reveals bare `<solution>`s
   (student: `no`; instructor: `yes`).

**Gotcha:** PreTeXt `<example>` renders its solution in BOTH builds —
anything whose answer must hide on the student copy uses `<exercise>`.
Reserve `<example>` for read-along illustrations with NO hidden content.

Quick selection table:

| Situation                                 | Use                                          |
|-------------------------------------------|----------------------------------------------|
| One/two-word blank inside a sentence      | paired `<p component="stu|key">` + `<fillin>`|
| Definition or theorem with a blank in it  | paired `<p component="stu|key">` + `<fillin>`|
| Multi-step worked computation             | paired `<exercise component="stu|key">` + `workspace` |
| "Your turn" practice problem              | paired `<exercise component="stu|key">` + `workspace` |
| Quick True/False check                    | one `<exercise>` + `<solution component="key">` |
| Read-along illustration, no hidden answer | `<example>` (no solution)                    |

## 3. Layout rules

- `<page>` delimits vertical space for letter-size printing, NOT
  topics. Never put a `<title>` on a `<page>`; write headings as
  `<p><term>Heading text.</term></p>`.
- No `<title>` on exercises unless it is important to the statement
  (e.g. "True or False") — space is precious on these worksheets.
- Display math uses `<md>`; `<me>`/`<men>` are deprecated.

## 4. Worksheet structure

- Open with `<objectives>` (3–6 outcome verbs).
- Lead with a quick reading-check (1–2 fillins), then the section's
  core computation(s) as guided exercises, then one extension the
  coursebook doesn't work out.
- Close the last page with a short "Looking ahead" `<conclusion>`
  connecting to the next worksheet/section.

## 5. Sourcing rules

- Track the coursebook, don't transcribe it: keep its notation, but
  **never reuse the book's example equations** — concepts can mirror
  the book, the examples cannot.
- Translating an old Beamer deck (the reveal pattern `\ON<1>{\B{...}}`
  marks what becomes hidden):
  - short revealed phrase → reading-check pair (mechanism 1),
  - revealed multi-line computation → worked-problem pair (mechanism 2),
  - static exposition → ordinary prose, tightened.
- Figures: placeholder `<figure>`s naming the source image (deck PNG or
  book asset path in a comment); list them under the PR's "Open
  questions". Never copy binary assets from an external book repo.
- Improvements are expected, not optional: at minimum consider one
  modern application and one misconception check per worksheet; itemize
  every improvement in the PR.
- Any new LaTeX macro goes into `source/bookends/docinfo.ptx` in the
  same PR.
- If the deck and the book disagree mathematically, the book wins; note
  the discrepancy. If the *book* looks wrong, do not "fix" it silently —
  flag it under "Open questions".

## 6. Worksheet verification (the visibility-split gate)

Beyond the repo's standard gates (well-formedness, clean build, xref
integrity), every worksheet PR proves the split:

1. Pick a sentinel phrase that exists only in `<solution>` or
   `component="key"` prose and is unique to the worksheet. Structural
   tags are unreliable sentinels; use answer-specific prose.
2. Grep the rendered HTML of the student and instructor targets (output
   directories per `project.ptx`):
   student count **= 0**, instructor count **>= 1**. Paste both counts
   in the PR.
3. Confirm blanks render on the student copy, and that student and
   instructor copies mirror each other in structure.

## 7. Per-worksheet acceptance

Builds in the student AND instructor targets; sentinel counts pass;
objectives match content; Improvements and figure TODOs itemized; the
GLN roadmap row updated. **One worksheet per PR** — if a topic needs
two class meetings, propose a split in the PR rather than shipping one
oversized worksheet.
