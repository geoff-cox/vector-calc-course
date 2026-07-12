# Track B — Coursebook Pruning & Rerouting

**Goal:** align `source/book.ptx` (APEX Calculus adaptation, CC BY-NC)
with the MA 301 topics: keep six chapters, delete ten, keep only the
relevant appendices, and repair every cross-reference that the deletions
break. Work in the strict stage order B1 → B2 → B3 → B4; each stage is
its own PR and must leave the book building green (B1 changes nothing).

**Definitions**

`keep_chpts` (stay):
```
book/ptx/chapter_vectors.ptx
book/ptx/chapter_vvf.ptx
book/ptx/chapter_multi_UL3.ptx
book/ptx/chapter_multi_UL4.ptx
book/ptx/chapter_mult_int_UL.ptx
book/ptx/chapter_vector_calc.ptx
```

`del_chpts` (go):
```
book/ptx/chapter_limits.ptx
book/ptx/chapter_derivatives.ptx
book/ptx/chapter_graphbehavior.ptx
book/ptx/chapter_deriv_apps_UL-std.ptx
book/ptx/chapter_integration.ptx
book/ptx/chapter_anti_tech.ptx
book/ptx/chapter_app_of_int.ptx
book/ptx/chapter_differential_equations.ptx
book/ptx/chapter_planar_curves.ptx
book/ptx/chapter_sequences_series_UL.ptx
```

Note: chapters include their sections via `<xi:include>` of
`sec_*.ptx` files — a "chapter" means the chapter file plus every
section file only it includes. Build the include graph before deleting
anything (a `sec_*.ptx` shared with a kept chapter must survive).

---

## Task B1 — Cross-boundary reference audit (read-only)

Produce `docs/xref-audit.md` and change no content.

1. Collect every `xml:id` and `label` defined inside `del_chpts` (and
   their exclusive section files): call this set `OUT`.
2. Collect every `xml:id`/`label` in `keep_chpts`, their sections, the
   frontmatter, and the appendix: call this `IN`.
3. Scan `keep_chpts` + appendix for `<xref ref="...">` whose target is
   in `OUT`. For each, record: source file/line, target id, and the
   target's **element type** (equation `men`/`mdn`, theorem, definition,
   figure, table, example, exercise, paragraph vs. section, subsection,
   chapter).
4. Classify each hit into the B3 disposition table:
   - `IMPORT` — small item (equation, theorem, definition, key idea,
     figure, table, short paragraph): will be copied to the new
     appendix section and rerouted.
   - `GENERIC` — large item (section, subsection, chapter): xref will be
     replaced with generic prose.
   - `DROP-REF` — reference *to* an exercise outside `keep_chpts`:
     the reference is deleted.
   - `DROP-EX` — an exercise *inside* `keep_chpts` that references
     anything outside: the whole exercise is deleted.
5. Also scan `del_chpts` for ids that the backmatter `<solutions>` or
   index machinery depends on, and list any `sec_*.ptx` files shared
   between kept and deleted chapters.
6. Write the report as a table plus a proposed B2/B3 execution plan and
   an estimated size of the `IMPORT` set.

**Acceptance:** report is complete enough that B2/B3 could be executed
mechanically from it; no source files changed.

## Task B2 — Prune the chapters

1. Remove the ten `del_chpts` `<xi:include>` lines from
   `source/book.ptx`; delete the chapter files and every section file
   used *only* by them (per the B1 include graph). Git history preserves
   everything — no attic copies.
2. Update frontmatter honestly: retitle the book for MA 301 use (e.g.,
   subtitle "adapted for MA 301") while **keeping** the APEX authorship,
   copyright, and CC BY-NC license text, and adding an adaptation note
   naming this course. Do not delete attribution — license requirement.
3. Expect the build to fail on the B1-catalogued broken xrefs. Insert
   temporary stub reroutes ONLY if PreTeXt hard-errors (prefer to land
   B2+B3 as consecutive PRs the same day; if stubs are needed, mark each
   `<!-- STUB(B3) -->`).
4. Prune the preface/history text that describes chapters that no
   longer exist (itemize in Improvements).

**Verification:** gates 1–3; the build log's remaining xref warnings
must exactly match the B1 audit list (nothing new broke).

## Task B3 — Reroute references

1. Create a new section in `source/book/ptx/appendix_back_reference.ptx`:
   ```xml
   <section xml:id="reference-imported" label="reference-imported">
     <title>Results Referenced from Earlier Calculus</title>
   ```
   For every `IMPORT` item, copy the smallest self-contained element
   from the (deleted) source — recover it with
   `git show <pre-B2-sha>:source/book/ptx/<file>` — into this section,
   giving it a new id `imported-<old-id>`, and reroute the xref. Add a
   one-line lead-in per item ("From differential calculus:") so the
   appendix reads as a reference, not a scrapbook.
2. For every `GENERIC` item, replace the `<xref>` with neutral prose
   such as "as covered in a first-year calculus course" — reworded to
   fit the sentence; no dangling "see" verbs.
3. Apply `DROP-REF` and `DROP-EX`. When deleting an exercise, also fix
   any now-empty `<exercisegroup>` and renumber-sensitive prose ("in
   the previous exercise").
4. Rebuild. Zero unresolved xref warnings is the gate — no exceptions.
5. Improvements: where a `GENERIC` replacement makes a passage weaker,
   you may instead write a 1–3 sentence self-contained recap of the
   needed fact; itemize each.

**Verification:** gates 1–3 plus
`grep -c 'imported-' source/book/ptx/appendix_back_reference.ptx` matches
the B1 `IMPORT` count; spot-check three rerouted links on the Pages
preview.

## Task B4 — Prune the appendix

1. In `appendix_back_reference.ptx`, keep the subsections relevant to
   MA 301 (trig identities, differentiation/integration tables, algebra,
   areas & volumes, the new `reference-imported` section) and delete the
   rest (e.g., Taylor/Maclaurin series, sequences material) **unless**
   something in `keep_chpts` references it — re-run the B1 scan against
   the appendix ids before deleting.
2. Itemize every deleted assemblage in the PR so the instructor can
   restore any with one comment.

**Verification:** gates 1–3; the Pages preview appendix contains no
orphaned headings.

## Task B5 — Align the spherical-coordinate convention with the standard

Independent of the B1–B4 prune pipeline; a coursebook enhancement.

**Why.** `source/book/ptx/sec_cylindrical_spherical.ptx` measures the
spherical angle `\varphi` **up from the `xy`-plane**
(`-\pi/2 \le \varphi \le \pi/2`), so its volume element is
`dV = \rho^2\cos\varphi\,d\rho\,d\theta\,d\varphi`. Almost every other
textbook, WeBWorK problem, CAS, and downstream course measures `\varphi`
**from the `+z`-axis** (`0 \le \varphi \le \pi`) with
`dV = \rho^2\sin\varphi\,d\rho\,d\varphi\,d\theta`. The instructor has
decided to switch to the standard convention so the book, the notes, the
tests, and outside resources all agree.

**Standard convention to install.**
`x=\rho\sin\varphi\cos\theta`, `y=\rho\sin\varphi\sin\theta`,
`z=\rho\cos\varphi`; `0 \le \varphi \le \pi`;
`dV = \rho^2\sin\varphi\,d\rho\,d\varphi\,d\theta`.

**Refined scope (decided — "Option 2").** Update all student-facing
**exposition** to the standard convention, but do **not** re-derive the
section's exercises (they will not be used in class). For each **affected
(spherical)** exercise, keep the **statement** and **remove its
`<answer>`/`<solution>`** (its worked value is tied to the old
convention); leave a one-line `<!-- TODO(geoff): answer pending
re-derivation under the standard convention -->`. Cylindrical-only
exercises (`r\,dz\,dr\,d\theta` is unchanged) are left fully intact.

**Downstream footprint (from the audit).**
- `sec_cylindrical_spherical.ptx` (core): the Key Idea conversions; the
  theorem `thm_triple_int_spherical` (dV, `\varphi` range, integration
  order); the remark that *justifies* the old convention (rewrite or
  drop); the **4 worked examples** `ex_spherical1`–`ex_spherical4`; and
  the defining **Asymptote figures** (`fig_sphericalintro`,
  `fig_sphericalwedge`, and any example figure that draws the angle).
- `sec_transformations.ptx`: the spherical-**Jacobian** derivation
  (~lines 1192–1260) that lands on `\rho^2\cos\varphi`, plus its prose,
  its `<xref>` to `thm_triple_int_spherical`, and its video.
- GLN `source/notes/ws-review-triple-integrals.ptx` (**R4**): flip to the
  standard convention (the "read carefully" callout, the conversions, the
  dV, the limits, and the spherical diagram).
- **Leave untouched:** generic `\rho`/`\varphi` in `sec_vector_intro` and
  `sec_parametric_surfaces` (generic angles / a generic sphere
  parametrization, not the integration convention); the orphaned
  `*_old.ptx` copies (not in the build).

**Staging (consecutive PRs, each targeting `main`, parent-before-child
per `CLAUDE.md` §5).**
- **B5a** — definitional core: Key Idea + `thm_triple_int_spherical` + the
  two defining figures + the convention remark; **flip the R4 GLN
  worksheet** (and its diagram) in the same PR so notes and book stay in
  agreement. Small and reviewable — renders the new convention before the
  heavier work.
- **B5b** — re-derive the 4 worked examples and the `sec_transformations`
  Jacobian (verify **every** integral by hand); strip
  `<answer>`/`<solution>` from the affected spherical exercises
  (statements stay).

**Verification.** Gates 1–3 on the `book` target (the coursebook is not a
deploy target — building it in CI is optional per the note in
`project.ptx`). Sanity-check each re-derived spherical integral by hand
(e.g. a ball of radius `r` must give `\tfrac43\pi r^3`); grep that no
`\cos\varphi` volume element or `-\pi/2` bound survives in exposition; and
confirm each stripped exercise keeps its statement and carries no orphaned
answer/solution. Because the book warns this area is "a source of many
common sign errors," treat unverified arithmetic as a blocker, not a
detail. If a redrawn Asymptote figure can't be regenerated without the
toolchain, mark it and flag under Open questions rather than shipping a
stale picture.

---

**Out of scope for Track B:** fine-grained pruning of sections *within*
`keep_chpts` — the instructor does that manually case-by-case. If a kept
section is obviously incoherent after B2–B3, flag it under "Open
questions"; do not delete it.
