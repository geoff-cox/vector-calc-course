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

Model files: `source/notes/ws-function-notation.ptx`,
`source/notes/ws-vectors.ptx`. Match their comment headers,
`<objectives>`, `<page>` pacing (one class meeting per worksheet), and
the three guided-notes mechanisms from `CLAUDE.md` §3.

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

1. Read the old deck, the mapped book section(s), and both model
   worksheets. Translate the Beamer reveal pattern:
   - short revealed phrase → `<fillin characters="N"/>` + answer in a
     following `<commentary>` block,
   - revealed multi-line computation → `<exercise>` with `<solution>`,
   - static exposition → ordinary prose, tightened.
2. Structure: `<objectives>` (3–6 outcome verbs), then `<page>`s that
   pace a 50-minute meeting; end with a short "Looking ahead" paragraph
   connecting to the next worksheet (see `ws-cross-product.ptx` style).
3. Figures: create `<figure>` placeholders that name the source PNG
   from the old deck (path in a comment) rather than blocking on
   assets; list them under "Open questions".
4. Improvements are expected here, not optional: at minimum consider
   one modern application example and one common-misconception check
   per worksheet; itemize everything added beyond the deck/book.
5. Wire the worksheet into the notes container via `<xi:include>` and
   flip its roadmap row to `in-review`.
6. Macro discipline: any new macro → `source/bookends/docinfo.ptx`
   (Task D1 rule) in the same PR.

**Verification:** all four gates in `CLAUDE.md` §4 — the visibility
split (gate 4) is the heart of this track. Choose the sentinel from a
`<solution>` or `<commentary>` phrase unique to this worksheet; paste
both grep counts. Then confirm on the Pages preview that the student
copy shows blanks where intended.

**Acceptance per worksheet:** builds in student AND instructor targets;
sentinel counts 0 / >=1; objectives match content; Improvements and
figure TODOs itemized; roadmap updated.

**One worksheet per PR.** If a deck naturally splits into two meetings,
propose the split in the PR rather than shipping a 12-page worksheet.
