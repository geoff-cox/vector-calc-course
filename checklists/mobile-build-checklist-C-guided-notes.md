# Track C — Guided Lecture Notes (GLN)

**Goal:** one PreTeXt `<worksheet>` per course section, in
`source/notes/`, blending three inputs:

1. the old Beamer decks in `source/notes/latex/` (structure, examples,
   the reveal pattern `\ON<1>{\B{...}}` marks what becomes a blank or a
   hidden solution),
2. the corresponding `keep_chpts` coursebook sections (definitions,
   theorems, better exposition, exercise pools), and
3. **new material Claude recommends** — modern applications, conceptual
   warm-ups, common-misconception checks — itemized as Improvements.

Worksheet-authoring conventions: **`checklists/worksheet-conventions.md`**
(shared byte-identical with `diff-eqs-course` — see `CLAUDE.md` §3 for
this repo's parameters and the legacy-worksheet note). The existing
`ws-*.ptx` files predate the shared conventions — do NOT copy their
`<commentary>` pattern into new worksheets.

---

## Task C1 — Worksheet roadmap (once, before any C2)

1. Inventory `source/notes/latex/` (decks) and map each deck to the
   coursebook section(s) covering the same material, and to the topic
   list from Task A1's `docs/ma301-syllabus-2015.md`.
2. Where the course covers a topic that has no old deck (or the deck is
   too thin), plan a from-scratch worksheet sourced from the coursebook.
3. Write `docs/gln-roadmap.md`: an ordered table —
   `worksheet slug | title | old deck(s) | book section(s) | status` —
   with `status` starting at `todo` except the two existing worksheets
   (`done`). Also confirm/set up the notes entry point: read
   `project.ptx` and whatever master file includes the worksheets; if a
   worksheet chapter container is missing, create it and wire the two
   existing worksheets in.
4. Update the roadmap's `status` column in every later C2 PR.

**Acceptance:** roadmap covers every course topic; notes targets build
with the existing worksheets included; no orphan `ws-*.ptx`.

## Task C2 — Draft one worksheet (repeat per roadmap row)

Invocation from mobile names the row, e.g.:
`@claude Task C2 for "The Dot Product" (deck 01_02_Dot_Product.tex).`

1. Read the old deck and the mapped book section(s).
2. Author per the shared conventions —
   **`checklists/worksheet-conventions.md`** — which govern the
   mechanisms (stu/key pairs, `workspace`), layout, structure,
   Beamer-deck translation, sourcing rules (including "never reuse the
   book's example equations"), figures, improvements, and macros.
   Until a migrated model exists in this repo, model the structure on
   MA 311's `source/notes/ws-what-is-a-de.ptx`
   (`geoff-cox/diff-eqs-course`, same conventions).
3. Wire the worksheet into the notes container via `<xi:include>` and
   flip its roadmap row to `in-review`.

**Verification:** all four gates in `CLAUDE.md` §4, with the
visibility-split procedure from `worksheet-conventions.md` §6 — it is
the heart of this track. Also confirm on the Pages preview that the
student copy shows blanks where intended.

**Acceptance per worksheet:** `worksheet-conventions.md` §7 (builds in
student AND instructor targets; sentinel counts 0 / >=1; objectives
match content; Improvements and figure TODOs itemized; roadmap updated;
one worksheet per PR — if a deck naturally splits into two meetings,
propose the split in the PR).
