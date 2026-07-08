# Coursebook Cross-Boundary Reference Audit (Task B1)

**Read-only.** This report changes no source files. It catalogs every
cross-reference from the six **kept** MA 301 chapters (and the appendix)
into the ten **deleted** chapters, so that B2 (prune) and B3 (reroute)
can be executed mechanically. All findings were produced by static
analysis of `source/book/ptx/` against `source/book.ptx`; see
[Methodology](#methodology--reproducibility) to regenerate.

## Scope

`source/book.ptx` includes 16 chapters. Per Track B:

- **Keep (6):** `chapter_vectors`, `chapter_vvf`, `chapter_multi_UL3`,
  `chapter_multi_UL4`, `chapter_mult_int_UL`, `chapter_vector_calc`.
- **Delete (10):** `chapter_limits`, `chapter_derivatives`,
  `chapter_graphbehavior`, `chapter_deriv_apps_UL-std`,
  `chapter_integration`, `chapter_anti_tech`, `chapter_app_of_int`,
  `chapter_differential_equations`, `chapter_planar_curves`,
  `chapter_sequences_series_UL`.

A "chapter" = its `chapter_*.ptx` file **plus** every `sec_*.ptx` /
`review-exercises-*.ptx` file it `<xi:include>`s.

## Headline numbers

| Metric | Value |
|---|---|
| Files to delete in B2 (10 chapters + exclusive sections) | **72** (10 chapter files + 62 section files) |
| Section files shared between a kept and a deleted chapter | **0** (deletion is clean) |
| Distinct (parser-visible) ids defined in deleted chapters (`OUT`) | **6,600** |
| Distinct ids in kept chapters + frontmatter + appendix (`IN`) | 3,153 |
| **Cross-boundary xref occurrences (keep/appendix → deleted)** | **69** |
| → classified `IMPORT` | 30 occurrences / **23 unique items** |
| → classified `GENERIC` | 39 occurrences / **23 unique targets** |
| → classified `DROP-REF` | **0** |
| → classified `DROP-EX` | **0** |
| Frontmatter (preface/history) xrefs into deleted chapters | 0 |

Both an lxml parse **and** an independent raw-regex scan agree on the 69
occurrences / 46 unique target ids, so the classification below is
complete.

## Include graph — deletion manifest (for B2)

No `sec_*.ptx` is shared between a kept and a deleted chapter, so every
file below can be deleted outright. **One caveat:** `sec_taylor_poly.ptx`
is included by *two* deleted chapters (`chapter_deriv_apps_UL-std` and
`chapter_sequences_series_UL`) — delete it once; removing either chapter
alone would strand it.

| deleted chapter file | exclusive section files |
|---|---|
| `chapter_limits.ptx` | `sec_limit_intro.ptx`, `sec_limit_def.ptx`, `sec_limit_analytically.ptx`, `sec_limit_onesided.ptx`, `sec_limit_continuity.ptx`, `sec_limit_infty.ptx`, `review-exercises-limits.ptx` |
| `chapter_derivatives.ptx` | `sec_deriv_intro.ptx`, `sec_deriv_interpret.ptx`, `sec_deriv_basic_rules.ptx`, `sec_deriv_prodquot.ptx`, `sec_deriv_chainrule.ptx`, `sec_deriv_implicit.ptx`, `sec_deriv_inverse_function.ptx`, `review-exercises-derivatives.ptx` |
| `chapter_graphbehavior.ptx` | `sec_graph_extreme_values.ptx`, `sec_graph_mvt.ptx`, `sec_graph_incr_decr.ptx`, `sec_graph_concavity.ptx`, `sec_graph_sketch.ptx`, `review-exercises-graphs.ptx` |
| `chapter_deriv_apps_UL-std.ptx` | `sec_newton.ptx`, `sec_related_rates.ptx`, `sec_optimization.ptx`, `sec_differentials.ptx`, `sec_taylor_poly.ptx` † |
| `chapter_integration.ptx` | `sec_antider.ptx`, `sec_def_int.ptx`, `sec_riemann.ptx`, `sec_FTC.ptx`, `sec_numerical_integration.ptx`, `review-exercises-integration.ptx` |
| `chapter_anti_tech.ptx` | `sec_substitution.ptx`, `sec_IBP.ptx`, `sec_trigint.ptx`, `sec_trig_sub.ptx`, `sec_partial_fraction.ptx`, `sec_hyperbolic.ptx`, `sec_lhopitals_rule.ptx`, `sec_improper_integration.ptx` |
| `chapter_app_of_int.ptx` | `sec_ABC.ptx`, `sec_disk.ptx`, `sec_shell_method.ptx`, `sec_arc_length.ptx`, `sec_work.ptx`, `sec_fluid_force.ptx` |
| `chapter_differential_equations.ptx` | `sec_Graphical_Numerical.ptx`, `sec_Separable.ptx`, `sec_Linear.ptx`, `sec_Modeling.ptx` |
| `chapter_planar_curves.ptx` | `sec_conic_sections.ptx`, `sec_param_eqs.ptx`, `sec_par_calc.ptx`, `sec_polar.ptx`, `sec_polarcalc.ptx` |
| `chapter_sequences_series_UL.ptx` | `sec_sequences.ptx`, `sec_series.ptx`, `sec_int_comp_tests.ptx`, `sec_ratio_root_tests.ptx`, `sec_alt_series.ptx`, `sec_power_series.ptx`, `sec_taylor_poly.ptx` †, `sec_taylor_series.ptx` |

† `sec_taylor_poly.ptx` listed under both deleted chapters — a single file.

## Disposition tables (for B3)

### IMPORT — copy the item into the new appendix section and reroute

Each of these targets a small, self-contained block (definition, theorem,
worked example, or key-idea insight). B3 copies the smallest enclosing
element from the deleted source (recover with
`git show <pre-B2-sha>:source/book/ptx/<file>`) into
`appendix_back_reference.ptx` under `<section xml:id="reference-imported">`,
gives it id `imported-<old-id>`, and reroutes the xref.

| # | old id | target type | source file (deleted) | title | referenced from (file:line) | new appendix id |
|---|---|---|---|---|---|---|
| 1 | `ex_shell4` | example | `sec_shell_method.ptx` | Finding volume using the Shell Method | sec_space_coord:1794 | `imported-ex_shell4` |
| 2 | `ex_abc4` | example | `sec_ABC.ptx` | Finding the area of a triangle | sec_cross_product:916 | `imported-ex_abc4` |
| 3 | `def_limit` | definition | `sec_limit_def.ptx` | The Limit of a Function f at a point | sec_vvf_calc:18 | `imported-def_limit` |
| 4 | `def_smooth` | definition | `sec_param_eqs.ptx` | Smooth | sec_vvf_calc:850 | `imported-def_smooth` |
| 5 | `def_antider` | definition | `sec_antider.ptx` | Antiderivatives and Indefinite Integrals | sec_vvf_calc:1172 | `imported-def_antider` |
| 6 | `def_def_int` | definition | `sec_def_int.ptx` | The Definite Integral, Total Signed Area | sec_vvf_calc:1173 | `imported-def_def_int` |
| 7 | `thm_riemann_sum` | theorem | `sec_riemann.ptx` | Definite Integrals and the Limit of Riemann Sums | sec_vvf_calc:1176<br>sec_double_int_volume:13 | `imported-thm_riemann_sum` |
| 8 | `thm_arc_length_parametric` | theorem | `sec_par_calc.ptx` | Arc Length of Parametric Curves | sec_vvf_calc:1397 | `imported-thm_arc_length_parametric` |
| 9 | `def_av_val` | definition | `sec_FTC.ptx` | The Average Value of f on [a,b] | sec_vvf_motion:1198<br>sec_vvf_motion:1218<br>sec_double_int_volume:1538 | `imported-def_av_val` |
| 10 | `thm_FTC1` | theorem | `sec_FTC.ptx` | The Fundamental Theorem of Calculus, Part 1 | sec_curvature:287 | `imported-thm_FTC1` |
| 11 | `thm_poly_rat` | theorem | `sec_limit_analytically.ptx` | Limits of Polynomial and Rational Functions | sec_multi_limit:573 | `imported-thm_poly_rat` |
| 12 | `thm_lim_continuous` | theorem | `sec_limit_analytically.ptx` | Limits of Common Functions | sec_multi_limit:574 | `imported-thm_lim_continuous` |
| 13 | `def_continuous` | definition | `sec_limit_continuity.ptx` | Continuous Function | sec_multi_limit:796 | `imported-def_continuous` |
| 14 | `thm_special_limits` | theorem | `sec_limit_analytically.ptx` | Special Limits | sec_multi_limit:875 | `imported-thm_special_limits` |
| 15 | `thm_continuity_algebra` | theorem | `sec_limit_continuity.ptx` | Properties of Continuous Functions | sec_multi_limit:973<br>sec_multi_limit:1050<br>sec_multi_limit:1055 | `imported-thm_continuity_algebra` |
| 16 | `def_differential` | definition | `sec_differentials.ptx` | Differentials of x and y | sec_total_differential:8 | `imported-def_differential` |
| 17 | `def-linearization` | definition | `sec_differentials.ptx` | *(untitled — "Linearization")* | sec_total_differential:476 | `imported-def-linearization` |
| 18 | `ex_implicit5` | example | `sec_deriv_implicit.ptx` | Using Implicit Differentiation | sec_multi_chain:628<br>sec_multi_chain:647 | `imported-ex_implicit5` |
| 19 | `thm_extreme_val` | theorem | `sec_graph_extreme_values.ptx` | The Extreme Value Theorem | sec_multi_extreme_values:796 | `imported-thm_extreme_val` |
| 20 | `def_derivative_at_a_point` | definition | `sec_deriv_intro.ptx` | Derivative at a Point | sec_multi_derivative_matrix:80<br>sec_multi_derivative_matrix:451 | `imported-def_derivative_at_a_point` |
| 21 | `thm_volume_by_cross_section` | theorem | `sec_disk.ptx` | Volume By Cross-Sectional Area | sec_double_int_volume:442 | `imported-thm_volume_by_cross_section` |
| 22 | `idea_polarconvert` | insight | `sec_polar.ptx` | Converting Between Rectangular and Polar Coordinates | sec_cylindrical_spherical:145 | `imported-idea_polarconvert` |
| 23 | `thm_FTC2` | theorem | `sec_FTC.ptx` | Fundamental Theorem of Calculus, Part 2 | sec_transformations:102 | `imported-thm_FTC2` |

**IMPORT set composition:** 10 theorems, 9 definitions, 3 worked
examples, 1 key-idea (`insight`) — **23 blocks**. The three examples are
the largest; the rest are compact statement blocks. Estimated new
appendix section: ~2–3 printed pages. Note `sec_FTC.ptx` supplies three
of these (`def_av_val`, `thm_FTC1`, `thm_FTC2`) and `sec_limit_*`
supplies six — most imports cluster in a handful of source files, so
recovery is cheap.

### GENERIC — replace the xref with neutral prose

Each targets a whole section/chapter; B3 rewrites the sentence to drop
the link. Per the resolved editorial decision (see
[Editorial decisions](#editorial-decisions-resolved-with-instructor)),
the canonical replacement term is **"single-variable calculus"** applied
uniformly; the column below is a starting point — reword to fit the
sentence, with no dangling "see …".

| # | xref ref | target type | title | referenced from (file:line) | suggested replacement prose |
|---|---|---|---|---|---|
| 1 | `sec_shell_method` | section | The Shell Method | sec_space_coord:1795 | "from single-variable calculus" |
| 2 | `sec_limit_intro` | section | An Introduction To Limits | sec_vvf:861 | "from single-variable calculus" |
| 3 | `sec_derivative` | section | Instantaneous Rates of Change: The Derivative | sec_vvf:862 | "from single-variable calculus" |
| 4 | `sec_param_eqs` | section | Parametric Equations | sec_vvf_calc:851<br>sec_lagrange:24 | "from single-variable calculus" |
| 5 | `sec_par_calc` | section | Calculus and Parametric Equations | sec_vvf_calc:1398 | "from single-variable calculus" |
| 6 | `sec_FTC` | section | The Fundamental Theorem of Calculus | sec_vvf_motion:1199 | "from single-variable calculus" |
| 7 | `chapter_integration` | chapter | Integration | sec_vvf_motion:1219<br>chapter_mult_int_UL:13<br>sec_stokes_divergence:1163 | "as developed in single-variable calculus" |
| 8 | `sec_limit_analytically` | section | Finding Limits Analytically | sec_multi_limit:575 | "from single-variable calculus" |
| 9 | `sec_differentials` | section | Differentials | sec_total_differential:7<br>sec_total_differential:465<br>sec_transformations:612 | "from single-variable calculus" |
| 10 | `chapter_derivatives` | chapter | Derivatives | sec_total_differential:463<br>sec_multi_derivative_matrix:35<br>sec_multi_derivative_matrix:80 | "as developed in single-variable calculus" |
| 11 | `sec_chainrule` | section | The Chain Rule | sec_multi_chain:144 | "from single-variable calculus" |
| 12 | `sec_imp_deriv` | section | Implicit Differentiation | sec_multi_chain:552<br>sec_multi_chain:619<br>sec_multi_chain:629 | "from single-variable calculus" |
| 13 | `sec_extreme_values` | section | Extreme Values | sec_multi_extreme_values:69<br>sec_lagrange:58<br>sec_lagrange:580<br>sec_hessian:8 | "from single-variable calculus" |
| 14 | `chapter_deriv_apps` | chapter | Applications of the Derivative | sec_lagrange:555 | "as developed in single-variable calculus" |
| 15 | `sec_optimization` | section | Optimization | sec_lagrange:557<br>sec_lagrange:569<br>sec_lagrange:578<br>sec_lagrange:604 | "from single-variable calculus" |
| 16 | `sec_ABC` | section | Area Between Curves | sec_iterated_integrals:220 | "from single-variable calculus" |
| 17 | `sec_disk` | section | Volume by Cross-Sectional Area; Disk and Washer Methods | sec_double_int_volume:443 | "from single-variable calculus" |
| 18 | `sec_numerical_integration` | section | Numerical Integration | sec_double_int_volume:1412 | "from single-variable calculus" |
| 19 | `sec_polar` | section | Introduction to Polar Coordinates | sec_double_int_polar:261<br>sec_transformations:148 | "from single-variable calculus" |
| 20 | `sec_arc_length` | section | Arc Length and Surface Area | sec_surface_area:5 | "from single-variable calculus" |
| 21 | `sec_improper_integration` | section | Improper Integration | sec_surface_area:495 | "from single-variable calculus" |
| 22 | `sec_substitution` | section | Substitution | sec_transformations:67 | "from single-variable calculus" |
| 23 | `sec_deriv_inverse_function` | section | Derivatives of Inverse Functions | sec_transformations:336 | "from single-variable calculus" |

### DROP-REF and DROP-EX — none

- **DROP-REF (0):** no kept-chapter or appendix xref targets an
  *exercise* inside a deleted chapter.
- **DROP-EX (0):** no exercise *inside* a kept chapter contains an xref
  into a deleted chapter (checked by ancestor-chain: no cross-boundary
  xref has an `<exercise>` ancestor).

So B3 has no exercises to delete and no `<exercisegroup>` renumbering to
repair on account of cross-boundary references.

## Backmatter, solutions, and index dependencies

- `source/book.ptx` contains **zero** `<xref>` elements; the
  `<backmatter>` wiring introduces no id dependency to repair.
- `<solutions divisional="answer" label="selected-answers">` collects
  exercise answers **globally** by walking the live document tree — it
  references no specific ids. Deleting the ten chapters simply drops
  their exercises (and answers) with no dangling reference.
- `<index label="terminology-index">` is built from inline `<idx>`
  entries, not `ref=` targets, so deleted-chapter index terms disappear
  cleanly.
- The appendix (`appendix_back_reference.ptx`) currently has **no**
  cross-boundary xrefs of its own (all 69 hits originate in kept section
  files), which simplifies B4.

## Data-quality notes (pre-existing, in files being deleted)

- Two deleted section files carry **internal duplicate `xml:id`s** —
  `fig_tangentsinx` (in `sec_deriv_intro.ptx`) and `fig_taypolyintrob`
  (in `sec_taylor_poly.ptx`). These already violate id-uniqueness but sit
  entirely inside deleted content, so B2 removes the problem. No action
  needed; noted for completeness.
- The `OUT` set is **6,600 distinct parser-visible ids** (lxml). A raw
  text scan that also matches `xml:id`/`label` attributes *inside*
  commented-out blocks finds 7,317 distinct id strings; the entire
  717-id difference is ids that appear **only inside XML comments**
  (comment-stripped regex and the parser agree exactly at 6,600). None of
  those commented ids are referenced from kept content, so the
  disposition tables are unaffected — re-running the xref scan against
  the full 7,317-string superset yields the identical 69/46 result.

## Editorial decisions (resolved with instructor)

Both B3 editorial questions raised by this audit are settled:

1. **GENERIC prose voice — uniform "single-variable calculus".** All 39
   GENERIC references are reworded with the single canonical term
   *single-variable calculus* (no VMI course numbers, keeping the
   CC-BY-NC book portable). The suggested-prose column and B3 plan above
   reflect this.
2. **Recap vs. generic — depend-on rule.** A GENERIC reference gets a
   1–3 sentence self-contained recap **only where the following math
   depends** on the deleted technique; motivational/"compare to"
   mentions get the generic phrase. Every recap is itemized in the B3 PR
   for review (estimated ~5–8; candidates listed in B3 step 3).

## Proposed B2 / B3 execution plan

**B2 — prune (own PR):**
1. Remove the ten `<xi:include>` lines for `del_chpts` from
   `source/book.ptx`.
2. `git rm` the 72 files in the deletion manifest (10 chapters + 62
   exclusive sections; `sec_taylor_poly.ptx` once).
3. Retitle for MA 301 (e.g., subtitle "adapted for MA 301") and add an
   adaptation note, **keeping** APEX authorship, `<copyright>`, and the
   CC BY-NC `<shortlicense>` verbatim (license requirement).
4. Prune preface / `preface-history.ptx` prose describing now-absent
   chapters (itemize in Improvements). The frontmatter has no xrefs into
   deleted chapters, so this is prose-only.
5. Expect exactly the 69 broken-xref warnings below and no others. Only
   add `<!-- STUB(B3) -->` reroutes if PreTeXt *hard-errors*; otherwise
   land B3 the same day.

**B3 — reroute (own PR):**
1. Create `<section xml:id="reference-imported" label="reference-imported">`
   ("Results Referenced from Earlier Calculus") in
   `appendix_back_reference.ptx`.
2. For the **23 IMPORT** items: `git show <pre-B2-sha>:source/book/ptx/<file>`
   to recover each block, paste under a one-line lead-in
   ("From differential calculus:" / "From integral calculus:"), assign
   `imported-<old-id>`, and reroute all 30 references.
3. For the **23 GENERIC** targets (39 references): reword each sentence
   using the canonical term **"single-variable calculus"** (uniform);
   verify no dangling "see". Where the surrounding math actually
   *depends* on the deleted technique, write a **1–3 sentence
   self-contained recap** instead of a bare generic phrase, and itemize
   every recap in the B3 PR's Improvements. Likely recap candidates
   (~5–8): the multivariable chain-rule / implicit-differentiation
   passages (`sec_multi_chain` → `sec_chainrule`, `sec_imp_deriv`),
   Lagrange multipliers leaning on single-variable optimization /
   extreme values (`sec_lagrange`, `sec_multi_extreme_values`), and
   change-of-variables invoking substitution (`sec_transformations` →
   `sec_substitution`). Passing "compare to" mentions get the generic
   phrase only.
4. Rebuild; the gate is **zero** unresolved xref warnings.
   `grep -c 'imported-' appendix_back_reference.ptx` should be ≥ 23.

## Acceptance

- `docs/xref-audit.md` produced; **no source files changed** (B1 is
  read-only — verify with `git status`: only this file is added).
- Report is complete enough to run B2/B3 mechanically: exhaustive
  disposition table (69 occurrences, all 46 unique targets classified),
  full deletion manifest, IMPORT-set size, and a stage plan.

## Methodology / reproducibility

Analysis scripts live under the session scratchpad; the procedure:

1. Build the include graph by parsing `<xi:include href>` in each of the
   16 chapter files → confirm no kept/deleted section sharing and derive
   the deletion manifest.
2. `OUT` = every `xml:id`/`label` in the 10 deleted chapters + their
   sections; `IN` = the same for the 6 kept chapters + frontmatter +
   appendix (via `lxml`, `recover=True`).
3. Walk every `<xref>` in kept sections + appendix; for each
   space-separated `ref` id in `OUT`, record source `file:line`, target
   element `localname`, target source file, and whether the xref has an
   `<exercise>` ancestor.
4. Classify: `<exercise>` ancestor → DROP-EX; target is `exercise` →
   DROP-REF; target is chapter/section/subsection → GENERIC; else
   (definition/theorem/example/insight/figure/table/paragraph) → IMPORT.
5. Cross-validate the occurrence/id counts with an independent raw-regex
   scan over the full id superset (identical result).
