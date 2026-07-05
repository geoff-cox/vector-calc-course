# Track M — Maintenance Tasks (ad hoc, repeatable)

Small repeatable jobs that don't belong to the A–E build tracks. These
replace the retired `BUILD-TASKS.md` catalog; paths and conventions are
updated for this repo (macros live in `source/bookends/docinfo.ptx`, not
`main.ptx`; targets come from `project.ptx` — read them, don't assume).
The verification gates (`CLAUDE.md` §4) and PR workflow (§5) apply to
every task and are not repeated below.

## Task M1 — Revise or extend commentary answer keys

**You provide:** which worksheet; which blanks/answers to add, fix, or reword.

1. Locate the paragraph(s) and their trailing `<commentary>` block(s).
2. Edit or split commentary so each cluster of blanks has exactly one
   ordered answer list immediately after it (§3 pattern).
3. New `<fillin>`s get a sensible `@characters` width.

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

1. Choose the correct mechanism (`CLAUDE.md` §3). The most common fix is
   converting an `<example>` that must hide its answer into an
   `<exercise>`.
2. For global toggles, edit the publication files or the `commentary`
   stringparam in `project.ptx` — never per-element hacks.

**Accept:** the targeted content shows/hides exactly as requested,
proven by grep counts in both builds; nothing else changed visibility.
