# MA 301 — Advanced Mathematics for Scientists and Engineers

The course site and materials for **MA 301** (multivariable/vector
calculus core) at VMI, authored in [PreTeXt](https://pretextbook.org).
The 2015-era LaTeX/Beamer/docx originals are archived read-only in
`outdated-material/` and are being modernized into three content
streams:

1. **Homepage/syllabus** — `source/homepage.ptx`, an `<article>` with
   the syllabus and links to the other materials.
2. **Coursebook** — `source/book.ptx`, an adaptation of *APEX Calculus*
   (CC BY-NC 4.0), pruned to the MA 301 chapter subset.
3. **Guided Lecture Notes (GLN)** — PreTeXt `<worksheet>`s in
   `source/notes/`, one per class meeting. One source tree builds both
   the **student** copy (blanks, no answers) and the **instructor key**
   (everything revealed).

Contributor conventions, verification gates, and the task system live in
[`CLAUDE.md`](CLAUDE.md) and [`checklists/`](checklists/) — read those
before editing. Worksheet authoring rules are in
[`checklists/worksheet-conventions.md`](checklists/worksheet-conventions.md)
(shared byte-identical with `geoff-cox/diff-eqs-course`).

## Layout

```
.
├── CLAUDE.md                <- contributor instructions (read first)
├── checklists/              <- task tracks A–E, M + worksheet conventions
├── docs/                    <- roadmaps, audits, 2015 syllabus transcription
├── outdated-material/       <- 2015-era originals: read-only, never edited
├── project.ptx              <- the build targets (authoritative list)
├── publication/             <- one publication file per target flavor
├── site/                    <- static root landing page for GitHub Pages
└── source/
    ├── homepage.ptx         <- homepage/syllabus entry point
    ├── homepage/            <- syllabus, course-materials, bookends, assets
    ├── book.ptx             <- coursebook entry point
    ├── book/                <- APEX chapters (ptx/), bookends, assets
    ├── notes.ptx            <- guided-lecture-notes entry point
    └── notes/               <- ws-*.ptx worksheets, bookends, assets
```

## Building

Requires Python ≥ 3.10 and the pinned PreTeXt CLI
(`pip install -r requirements.txt`; see `python-venv-pretext-guide.md`
for a venv walkthrough). TeX is needed only for PDF output and
`<latex-image>` (TikZ) asset generation.

Targets are defined in `project.ptx` (read it — don't assume names):

| Target    | Output | What it is                                  |
|-----------|--------|---------------------------------------------|
| `homepage`| HTML   | Course homepage + syllabus                   |
| `web-stu` | HTML   | Guided notes, student copy                   |
| `web-key` | HTML   | Guided notes, instructor key                 |
| `pdf-key` | PDF    | Guided notes, print instructor key           |
| `book`    | HTML   | Coursebook (not yet marked for deploy)       |

```
pretext build homepage       # or: make homepage / make notes / make book
pretext view homepage        # open the most recent build
```

The student/instructor split is driven by the paired
`publication/publication-stu.ptx` / `publication-key.ptx` files
(`<version include>` component filtering) — see the worksheet
conventions for how `component="stu"` / `component="key"` pairs work.

## Deployment

`.github/workflows/deploy-pages.yml` builds every target with a
`deploy-dir` in `project.ptx`, stages them with `pretext deploy
--stage-only`, copies `site/` over the top, and publishes to GitHub
Pages (on push to `main`, or for any PR carrying the `preview` label).

## License

The coursebook is adapted from *APEX Calculus*
(<https://apexcalculus.com>), used under CC BY-NC 4.0; its attribution
and license text in `source/book/bookends/` must be preserved.
