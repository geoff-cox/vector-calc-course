# Guided Lecture Notes (GLN) Roadmap — Track C

The plan for the MA 301 guided-notes worksheets: one PreTeXt `<worksheet>`
per class meeting under `source/notes/`, wired into the notes article
(`source/notes.ptx`) through per-section container files. This roadmap is
the authoritative work-list for Track C; **each C2 PR flips its row's
`status`** (`todo` → `in-review` → `done`).

## How the notes are wired

- **Entry point / targets** (`project.ptx`): `web-stu` and `web-key`
  (HTML student/instructor) and `pdf-key` (print instructor), all built
  from **`source/notes.ptx`** — an `<article>` with `<title>MA 301</title>`
  and `<subtitle>Guided Lecture Notes</subtitle>`.
- **Structure:** the article holds one `<section>` per course unit; each
  section container `<xi:include>`s one `<worksheet>` file per class
  meeting. Only **Section 1** exists today
  (`source/notes/sec-functions-vectors.ptx`, included via
  `href="./notes/sec-functions-vectors.ptx"`); the container files for
  Sections 0 and 2–4 are created in the first C2 PR that targets them (the
  `sec-*` container is added together with its first worksheet so the
  build never carries an empty division). `source/notes.ptx` currently
  holds two **outdated commented-out stubs** (`./ch-line-integrals.ptx`,
  `./ch-surface-integrals.ptx`); the first C2 for each section replaces
  its stub with a proper `./notes/sec-<slug>.ptx` include matching
  Section 1's naming and path (the `ch-*`, source-root paths are not
  used).
- **Authoring conventions:** `checklists/worksheet-conventions.md`
  (shared byte-identical with `diff-eqs-course`). The four existing
  worksheets predate those conventions and are pending Task **M6**
  migration — do **not** copy their commented-out `<commentary>` pattern.

## Status legend

- `done` — drafted and wired into the notes build. (The four existing
  worksheets build today but are **legacy**, pending M6 migration to the
  shared conventions; tracked separately from C2.)
- `in-review` — a C2 PR is open for it.
- `todo` — not yet drafted.

## Source scope

Topic authority is `docs/ma301-syllabus-2015.md`: **Vector Analysis**
(vector fields, line integrals, conservative fields, Green's Theorem,
parameterization of curves/surfaces, the Divergence Theorem, Stokes'
Theorem) plus **Miscellaneous** (Fourier series, complex variables,
partial differential equations). The old Beamer decks in
`outdated-material/notes/` follow that same arc, so the worksheet sequence
mirrors the decks, sourced additionally from the kept coursebook
chapters where they overlap. Foundational multivariable calculus
(functions of several variables, partial derivatives, multiple
integrals) sits in the coursebook as prerequisite support and has **no**
deck; per the instructor's decision, the GLN opens with a short
**Section 0** of *review* worksheets for the prerequisite topics MA 301
most directly builds on, sourced from the coursebook. These are lighter
refreshers, not full guided-notes meetings.

---

## Section 0 — Multivariable Calculus Review (Prerequisite)

Container: `source/notes/sec-multivariable-review.ptx` (exists). Short
*review* worksheets for the prerequisite multivariable topics that
MA 301's vector analysis most depends on — the geometry of functions of
several variables (graphs and level sets), partial derivatives, and
double/triple integration. No decks; sourced from the coursebook. (Multivariable chain
rule, extreme values, Lagrange multipliers, and change of variables are
intentionally **not** included as standalone reviews — they are less
central to vector analysis; see open questions if you want any added. A
limits/continuity review is **shelved** pending the instructor's decision
on an epsilon–delta treatment.)

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| R1 | `ws-review-multivariable-functions` | Graphs and Level Sets (Review) | — (from coursebook) | `sec_multi_intro` | done |
| R2 | `ws-review-partial-derivatives` | Partial Derivatives (Review) | — (from coursebook) | `sec_partial_derivatives`, `sec_total_differential` | done |
| R3 | `ws-review-double-integrals` | Double Integrals (Review) | — (from coursebook) | `sec_iterated_integrals`, `sec_double_int_volume`, `sec_double_int_polar` | done |
| R4 | `ws-review-triple-integrals` | Triple Integrals in Cylindrical & Spherical Coordinates (Review) | — (from coursebook) | `sec_triple_int`, `sec_cylindrical_spherical` | done |

## Section 1 — Functions, Vectors, and Vector Fields

Container: `source/notes/sec-functions-vectors.ptx` (exists).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 1 | `ws-function-notation` | Review of Multivariable Function Notation | `00_01_Intro`, `1-0-notes-intro` | `sec_multi_intro`, `sec_vvf` | done |
| 2 | `ws-vectors` | Vectors | `01_01_Vectors`, `1-1-notes-vectors` | `sec_space_coord`, `sec_vector_intro` | done |
| 3 | `ws-dot-product` | The Dot Product | `01_02_Dot_Product` | `sec_dot_product` | done |
| 4 | `ws-cross-product` | The Cross Product | `01_03_Cross_Product` | `sec_cross_product` | done |
| 5 | `ws-curves` | Curves and Vector-Valued Functions | `01_04_Curves` | `sec_vvf`, `sec_vvf_calc`, `sec_tan_norm`, `sec_curvature` | in-review |
| 6 | `ws-gradient` | The Gradient and Directional Derivatives | `01_05_Gradient` | `sec_partial_derivatives`, `sec_directional_derivative` | in-review |
| 7 | `ws-vector-fields` | Vector Fields | *(from coursebook; deck material in `01_05_Gradient`)* | `sec_vector_fields` | in-review |

Rows 1–4 are `done` but **legacy** — they build today yet predate the
shared conventions and await Task M6 migration (see the status legend).

## Section 2 — Line Integrals and Green's Theorem

Container: `source/notes/sec-line-integrals.ptx` (created with worksheet 8).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 8 | `ws-line-integrals` | Line Integrals | `02_01_LineIntegrals` | `sec_line_int_intro`, `sec_line_int_vf` | in-review |
| 9 | `ws-divergence-curl` | Divergence and Curl | `02_02_Divergence_Curl` | `sec_vector_fields`, `sec_greensthm` | in-review |
| 10 | `ws-path-independence` | Path Independence and Conservative Fields | `02_03_PathIndependence` | `sec_line_int_vf` | in-review |
| 11 | `ws-greens-theorem` | Green's Theorem | `02_04_Greens_Theorem` | `sec_greensthm` | todo |

## Section 3 — Surface Integrals, Stokes', and the Divergence Theorem

Container: `source/notes/sec-surface-integrals.ptx` (create with first C2).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 12 | `ws-surface-integrals` | Parametrized Surfaces and Surface Integrals | `03_01_SurfaceIntegrals` | `sec_parametric_surfaces`, `sec_surface_integral` | todo |
| 13 | `ws-divergence-theorem` | The Divergence Theorem | `03_02_DivergenceTheorem` | `sec_stokes_divergence` | todo |
| 14 | `ws-stokes-theorem` | Stokes' Theorem | `03_03_StokesTheorem` | `sec_stokes_divergence` | todo |

## Section 4 — Fourier Series and Related Topics

Container: `source/notes/sec-fourier-series.ptx` (create with first C2).
No coursebook backing — the APEX adaptation does not cover Fourier
series / complex variables / PDEs, so these worksheets are sourced from
the decks plus new material (flag figure/exercise sourcing in each C2).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 15 | `ws-fourier-intro` | Introduction to Fourier Series | `05_01_FourierIntro` | — (none) | todo |
| 16 | `ws-fourier-series` | Computing Fourier Series | `05_02_FourierSeries`, `05_00_FourierSeriesSummary` | — (none) | todo |
| 17 | `ws-ode-review` | Review of ODEs for Fourier Methods | `05_03_ODE_Review` | — (none) | todo |
| 18 | `ws-fourier-des` | Fourier Series and Differential Equations | `05_04_Fourier_Series_Diff_Eqns` | — (none) | todo |
| 19 | `ws-forced-oscillations` | Forced Oscillations | `05_05_ForcedOscillations` | — (none) | todo |
| 20 | `ws-complex-variables` | Introduction to Complex Variables | *(no deck — from scratch)* | — (none) | todo |

---

## Coverage check

- **Every 2015 syllabus topic is covered.** Vector Analysis → Sections
  1–3; Fourier series / complex variables / PDEs → Section 4 (PDEs enter
  through `ws-fourier-des` / `ws-forced-oscillations`).
- **Added prerequisite support (not a 2015 syllabus topic).** Section 0
  reviews the multivariable calculus MA 301 builds on — `ma301-syllabus-2015.md`
  lists this as prerequisite (MA 215), so it sits outside the syllabus
  topic list and is included only as a refresher.
- **Every Beamer deck in `outdated-material/notes/` maps to a row** (the
  `05_00` summary folds into `ws-fourier-series`; the two `1-x-notes-*`
  drafts fold into the corresponding Section 1 rows).
- **No orphan `ws-*.ptx`:** the four existing worksheet files are all
  `<xi:include>`d by `sec-functions-vectors.ptx`.

## Open questions for the instructor

1. **Foundational multivariable units — RESOLVED.** Per the instructor,
   the GLN includes **review** worksheets for the important prerequisite
   topics; these are now **Section 0** (R1 graphs and level sets, R2
   partial derivatives, R3 double integrals, R4 triple integrals).
   Deliberately excluded as standalone reviews (less central to vector
   analysis): the multivariable chain rule (`sec_multi_chain`), extreme
   values (`sec_multi_extreme_values`), Lagrange multipliers
   (`sec_lagrange`), and change of variables (`sec_transformations`). Say
   the word if you'd like any of these added as a Section 0 row.
2. **Limits/continuity review — SHELVED.** Per the instructor, held
   pending a decision on whether MA 301 gives an epsilon–delta treatment
   of multivariable limits. `sec_multi_limit` is therefore not mapped to
   any Section 0 row for now; R1 covers the visualization side of
   `sec_multi_intro` only. (The existing `ws-function-notation` remains
   the single function-notation review; R1 is retitled "Graphs and Level
   Sets" so it is a distinct geometry topic, not a second functions
   review.)
3. **Deck-to-meeting granularity.** A few decks may each want two class
   meetings (e.g. `05_04_Fourier_Series_Diff_Eqns`); per the C2
   acceptance criteria I'll propose any such split in that worksheet's PR
   rather than pre-committing here.
4. **`ws-vector-fields` sourcing — RESOLVED.** Row 7 has no dedicated
   deck (vector fields appear inside the gradient and line-integral
   decks), so it was drafted from the coursebook `sec_vector_fields`
   (definition, del operator, divergence, curl). Say the word if you'd
   rather it had instead been folded into `ws-gradient` or
   `ws-line-integrals`.
