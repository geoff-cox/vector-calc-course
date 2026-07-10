# Guided Lecture Notes (GLN) Roadmap — Track C

The plan for the MA 301 guided-notes worksheets: one PreTeXt `<worksheet>`
per class meeting under `source/notes/`, wired into the notes article
(`source/notes.ptx`) through per-section container files. This roadmap is
the authoritative work-list for Track C; **each C2 PR flips its row's
`status`** (`todo` → `in-review` → `done`).

## How the notes are wired

- **Entry point / targets** (`project.ptx`): `web-stu` and `web-key`
  (HTML student/instructor) and `pdf-key` (print instructor), all built
  from **`source/notes.ptx`** — an `<article>` titled "MA 301 — Guided
  Lecture Notes".
- **Structure:** the article holds one `<section>` per course unit; each
  section container `<xi:include>`s one `<worksheet>` file per class
  meeting. Only **Section 1** exists today
  (`source/notes/sec-functions-vectors.ptx`); the container files for
  Sections 2–4 are created in the first C2 PR that targets them (the
  `sec-*` container is added together with its first worksheet so the
  build never carries an empty division).
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
`source/notes/latex/` follow that same arc, so the worksheet sequence
mirrors the decks, sourced additionally from the kept coursebook
chapters where they overlap. Foundational multivariable calculus
(partial derivatives, multiple integrals, Lagrange multipliers) sits in
the coursebook as prerequisite support and has **no** deck; whether the
GLN should add units for it is the open A2 question (see bottom).

---

## Section 1 — Functions, Vectors, and Vector Fields

Container: `source/notes/sec-functions-vectors.ptx` (exists).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 1 | `ws-function-notation` | Review of Multivariable Function Notation | `00_01_Intro`, `1-0-notes-intro` | `sec_multi_intro`, `sec_vvf` | done (legacy → M6) |
| 2 | `ws-vectors` | Vectors | `01_01_Vectors`, `1-1-notes-vectors` | `sec_space_coord`, `sec_vector_intro` | done (legacy → M6) |
| 3 | `ws-dot-product` | The Dot Product | `01_02_Dot_Product` | `sec_dot_product` | done (legacy → M6) |
| 4 | `ws-cross-product` | The Cross Product | `01_03_Cross_Product` | `sec_cross_product` | done (legacy → M6) |
| 5 | `ws-curves` | Curves and Vector-Valued Functions | `01_04_Curves` | `sec_vvf`, `sec_vvf_calc`, `sec_tan_norm`, `sec_curvature` | todo |
| 6 | `ws-gradient` | The Gradient and Directional Derivatives | `01_05_Gradient` | `sec_partial_derivatives`, `sec_directional_derivative` | todo |
| 7 | `ws-vector-fields` | Vector Fields | *(from coursebook; deck material in `01_05_Gradient`)* | `sec_vector_fields` | todo |

## Section 2 — Line Integrals and Green's Theorem

Container: `source/notes/sec-line-integrals.ptx` (create with first C2).

| # | worksheet slug | title | old deck(s) | book section(s) | status |
|---|---|---|---|---|---|
| 8 | `ws-line-integrals` | Line Integrals | `02_01_LineIntegrals` | `sec_line_int_intro`, `sec_line_int_vf` | todo |
| 9 | `ws-divergence-curl` | Divergence and Curl | `02_02_Divergence_Curl` | `sec_vector_fields`, `sec_greensthm` | todo |
| 10 | `ws-path-independence` | Path Independence and Conservative Fields | `02_03_PathIndependence` | `sec_line_int_vf` | todo |
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
  1–3; Fourier series / complex variables / PDEs → Section 4
  (PDEs enter through `ws-fourier-des` / `ws-forced-oscillations`).
- **Every Beamer deck in `source/notes/latex/` maps to a row** (the
  `05_00` summary folds into `ws-fourier-series`; the two `1-x-notes-*`
  drafts fold into the corresponding Section 1 rows).
- **No orphan `ws-*.ptx`:** the four existing worksheet files are all
  `<xi:include>`d by `sec-functions-vectors.ptx`.

## Open questions for the instructor

1. **Foundational multivariable units?** The 2015 syllabus treats partial
   derivatives, multiple integrals, and Lagrange multipliers as
   prerequisite (MA 215), so no decks or GLN rows exist for them, even
   though the coursebook keeps those chapters. This is the same call
   raised in the A2 syllabus PR. If you want GLN worksheets for that
   material, I'll add a Section 0 (or fold rows into Sections 1–2) —
   candidate book sections: `sec_partial_derivatives`, `sec_multi_chain`,
   `sec_directional_derivative`, `sec_multi_extreme_values`,
   `sec_lagrange`, `sec_iterated_integrals`, `sec_double_int_volume`,
   `sec_triple_int`, `sec_transformations`.
2. **Deck-to-meeting granularity.** A few decks may each want two class
   meetings (e.g. `05_04_Fourier_Series_Diff_Eqns`); per the C2
   acceptance criteria I'll propose any such split in that worksheet's PR
   rather than pre-committing here.
3. **`ws-vector-fields` sourcing.** Row 7 has no dedicated deck (vector
   fields appear inside the gradient and line-integral decks). I'll draft
   it from the coursebook `sec_vector_fields` unless you'd rather fold it
   into `ws-gradient` or `ws-line-integrals`.
