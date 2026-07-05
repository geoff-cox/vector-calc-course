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

---

**Out of scope for Track B:** fine-grained pruning of sections *within*
`keep_chpts` — the instructor does that manually case-by-case. If a kept
section is obviously incoherent after B2–B3, flag it under "Open
questions"; do not delete it.
