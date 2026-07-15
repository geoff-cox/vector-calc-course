# Track M — Maintenance Tasks (ad hoc, repeatable)

Small repeatable jobs that don't belong to the A–E build tracks. These
replace the retired `BUILD-TASKS.md` catalog; paths and conventions are
updated for this repo (macros live in the per-stream
`bookends/docinfo.ptx` files — see Track D — not `main.ptx`; targets
come from `project.ptx` — read them, don't assume).
The verification gates (`CLAUDE.md` §4) and PR workflow (§5) apply to
every task and are not repeated below.

## Task M1 — Revise or extend answer keys

**You provide:** which worksheet; which blanks/answers to add, fix, or reword.

1. New-style worksheets (shared conventions): locate the paired
   `<p component="stu">` / `<p component="key">` paragraphs and edit
   both halves together so they stay mirrored — `stu` carries the
   `<fillin>`s, `key` the same sentence with answers as
   `\underline{\textbf{...}}` math.
   Legacy worksheets (pre-migration): locate the paragraph(s) and their
   trailing `<commentary component="instructor">` block(s); keep one
   ordered answer list per cluster of blanks. Consider doing Task M6
   first instead of extending legacy commentary.
2. New `<fillin>`s get a sensible `@characters` width.

**Accept:** sentinel grep passes (0 student / >=1 instructor); answer
order matches blank order; no "(Fill in: .)" debris — that's the symptom
of answer-text-inside-`<fillin>`.

## Task M2 — Wire in figures (replace placeholders)

**You provide:** image files (for `source/notes/figures/` or the
existing assets path — check what the repo uses), or a description if a
TikZ `<latex-image>` should be drawn instead.

1. Raster: place the file, replace the placeholder with
   `<image source="..." width="...%"/>`, confirm the publication files
   declare the asset directory.
2. TikZ: replace the placeholder with `<latex-image>`; note in the PR
   that `pretext build -g` (asset generation) was run.
3. Keep captions; remove the `<!-- TODO -->` once resolved.

**Accept:** builds succeed; no broken `source=` paths; never fabricate
an image that wasn't supplied or drawn.

## Task M3 — Build & verify all targets (QA only)

**You provide:** nothing.

1. Run the full verification gate for every HTML target; PDF targets
   only if TeX is available (say so if skipped).
2. Report a pass/fail table plus the visibility grep counts. On a clean
   `main`, post results as a comment — no PR needed.

## Task M4 — Fix a build or schema error

**You provide:** the error text if you have it (optional).

1. Reproduce; capture the real error (filter the harmless asset-dirs
   warning).
2. Common culprits: publication-file schema drift, malformed
   `<md>`/`<mrow>` alignment, unescaped `<`/`&` in math, bad
   `<xi:include>` path.
3. Fix minimally — never restructure working content to paper over an
   error; PR explains the root cause in 1–2 lines.

## Task M5 — Adjust solution/commentary visibility

**You provide:** which element/worksheet; desired student-vs-instructor
behavior.

1. Choose the correct mechanism (`checklists/worksheet-conventions.md`).
   The most common fix is converting an `<example>` that must hide its
   answer into an `<exercise>`.
2. For global toggles, edit the publication files (`<version include>`
   lists, `<exercise-worksheet>` switches) — never per-element hacks.

**Accept:** the targeted content shows/hides exactly as requested,
proven by grep counts in both builds; nothing else changed visibility.

## Task M6 — Migrate a legacy worksheet to the shared conventions

**You provide:** which worksheet (one per PR).

1. Convert per `checklists/worksheet-conventions.md`:
   - each `<fillin>` cluster + trailing `<commentary>` block (currently
     COMMENTED OUT in the legacy source — recover the answer text from
     it) → paired `<p component="stu">` (blanks) / `<p component="key">`
     (answers as `\underline{\textbf{...}}` math); delete the commentary;
   - each worked `<exercise>` → the paired
     `<exercise component="stu" workspace="Xin">` /
     `<exercise component="key">` form (size `workspace` conservatively);
   - `<title>` on `<page>` → `<p><term>...</term></p>` heading; drop
     exercise titles unless essential; `<me>`/`<men>` → `<md>`.
2. Structures must mirror: every `stu` element has its `key` partner.
3. When the LAST legacy worksheet is migrated, remove `instructor` from
   `publication-key.ptx`'s `<version include>` list and note it in the PR.

**Accept:** all four gates pass; sentinel counts 0 / >=1; no
`<commentary>` remains in the migrated worksheet; student and
instructor copies mirror each other.
