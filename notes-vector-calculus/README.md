# Vector Calculus — Guided Lecture Notes (PreTeXt)

A PreTeXt project for re-authoring the existing LaTeX/Beamer lecture
notes as a book of `<worksheet>`s.  One source tree produces both
**student handouts** (blanks unfilled, solutions hidden) and
**instructor keys** (blanks filled, solutions revealed).

This project has been built and verified against PreTeXt CLI 0.8.3.

## Layout

```
notes-vector-calculus/
├── README.md                          ← you are here
├── project.ptx                        ← four build targets
├── publication/
│   ├── publication-student.ptx        ← hides task/exercise solutions
│   └── publication-instructor.ptx     ← reveals task/exercise solutions
└── source/
    ├── main.ptx                       ← docinfo, macros, book frame
    ├── ch-functions-vectors.ptx       ← Chapter 1 container
    ├── ws-function-notation.ptx       ← Worksheet 1.1
    └── ws-vectors.ptx                 ← Worksheet 1.2
```

## One-time setup

1. Install the PreTeXt CLI (Python ≥ 3.10):
   ```
   pip install pretext        # CLI ≥ 1.0
   ```
   (This project was built against the older `pretextbook` 0.8.3.
   If you have that installed, the build still works; upgrade when
   convenient.)
2. For PDF output, install TeX Live or MacTeX.  HTML output needs
   nothing else.

## Daily use

From the project root:

```
pretext build web-student        # HTML, blanks shown, no answers
pretext build web-instructor     # HTML, blanks shown, all answers revealed
pretext build print-student      # PDF student handout
pretext build print-instructor   # PDF answer key

pretext view  web-student        # opens most recent build in browser
```

Output lands in `output/<target-name>/`.

## How the student/instructor split works

The split uses **three** complementary mechanisms in the source.
They serve different pedagogical roles and are toggled by different
project knobs.

### 1. `<fillin characters="N"/>` — short blanks for in-class writing

```xml
<li>For each input there is <fillin characters="14"/> output.</li>
```

This renders as an **underlined blank** of width N characters in
both student and instructor builds.  Students write in it; the
instructor reads the answer aloud from their own notes (or from
the commentary block below; see #2).

**Important.** PreTeXt's `<fillin>` only honors the `@characters`
attribute.  Any text written inside the tag is **silently
discarded** in HTML/PDF output, so do *not* write
`<fillin characters="14">exactly one</fillin>` and expect anyone
to see the answer.  Use a `<commentary>` block instead.

### 2. `<commentary>` — instructor-only answer key for the blanks

```xml
<p>For each input there is <fillin characters="14"/> output.
Two different inputs <fillin characters="4"/> produce the same
output.</p>
<commentary>
    <p>Blanks, in order: <q>exactly one</q>, <q>can</q>.</p>
</commentary>
```

`<commentary>` is a block-level element whose visibility is
toggled by the **`commentary` stringparam** in `project.ptx`.
Instructor targets set `commentary="yes"`; student targets omit
the param and the entire commentary block vanishes.

Because it's block-level, commentary cannot appear mid-sentence;
instead it goes immediately *after* the prose that contains the
blanks it explains.  Group related blanks into one paragraph,
then drop in one commentary block that lists their answers in
order.

### 3. `<exercise>` with `<statement>` and `<solution>` — for worked computations

```xml
<exercise>
    <statement>
        <p>Compute <m>f(2,-1)</m> for <m>f(x,y) = x^2 - 3xy + y^2</m>.</p>
    </statement>
    <solution>
        <p><m>f(2,-1) = 4 + 6 + 1 = 11</m>.</p>
    </solution>
</exercise>
```

Visibility is controlled by the publication files via the
`<exercise-worksheet>` element:

- Student build:
  `<exercise-worksheet statement="yes" hint="no" answer="no" solution="no"/>`
- Instructor build:
  `<exercise-worksheet statement="yes" hint="yes" answer="yes" solution="yes"/>`

This is the right tool for the multi-step worked examples in
each worksheet — the kind of computation you'd normally do on
the board during class.

**Note on `<example>` vs `<exercise>`.**  PreTeXt's `<example>`
element always shows its solution body in both builds (textbook
convention).  In this project we therefore use `<exercise>` for
anything whose answer should appear *only* on the instructor key.
A few short read-along examples in the source still use
`<example>`; that's intentional when the example has no hidden
content.

## Quick reference: which mechanism for which purpose?

| Pedagogical goal                              | Use                            |
| --------------------------------------------- | ------------------------------ |
| One- or two-word blank inside a sentence      | `<fillin>` + `<commentary>`    |
| Definition with a short blank in it           | `<fillin>` + `<commentary>`    |
| Multi-step worked computation                 | `<exercise>` + `<solution>`    |
| "Your turn" practice problem                  | `<exercise>` + `<solution>`    |
| Read-along illustration with no hidden answer | `<example>` (no `<solution>`)  |

## Adding new worksheets

1. Copy `ws-vectors.ptx` (or `ws-function-notation.ptx`) to a new
   name, e.g. `ws-dot-cross-product.ptx`, and replace its contents.
2. Add an `<xi:include href="./ws-dot-cross-product.ptx"/>` line
   inside `ch-functions-vectors.ptx` (there are pre-written
   comment stubs for the obvious next ones).
3. Rebuild.

## Adding new chapters

1. Create `ch-line-integrals.ptx` modeled on
   `ch-functions-vectors.ptx`.
2. Uncomment (or add) the matching `<xi:include/>` in `main.ptx`.

## Notes on porting the old LaTeX

The Beamer pattern

```latex
\ON<1>{\B{ exactly one }}
```

is the direct ancestor of the `<fillin>` + `<commentary>` pair
here: text that appears only at the right moment.  In PreTeXt the
"moment" is build-time rather than slide-overlay-time, but the
pedagogical role — the instructor reveals; the student writes —
is the same.

Your custom LaTeX macros (`\VF`, `\VV`, `\RE`, `\RRE`, etc.) have
PreTeXt-friendly analogues defined in the `<macros>` block of
`source/main.ptx`: `\vF`, `\R`, plus `\vv`, `\vw`, `\vi`, `\vj`,
`\vk`, `\norm{...}`, and `\vzero`.  Add more as needed when porting
later sections.

Figures in the original Beamer source are listed as
`<image><description>...</description></image>` placeholders inside
`<figure>` blocks in the worksheets.  To wire in the actual PNGs:

1. Create `source/figures/` and drop the existing PNG files there.
2. Replace the placeholder with
   `<image source="figures/my-figure.png" width="60%"/>`.
3. Tell the publication file where to find them by adding a
   `<source><directories external="figures"/></source>` block — see
   the PreTeXt Author Guide for the exact spelling in the version
   you're running.

Alternatively, redraw figures as inline `<latex-image>` (TikZ) for
crisper rendering at any size; that requires `pretext build -g` the
first time to generate the figure assets.

## Caveat on PreTeXt versions

PreTeXt's publication-file schema and element set have evolved.  The
elements used here — `<exercise-worksheet>`, `<exercise-divisional>`,
`<exercise-inline>` in the publication files, and the `commentary`
stringparam in `project.ptx` — work in CLI 0.8.3.  If a future
upgrade complains, check:

- the PreTeXt Author Guide section on publication files:
  https://pretextbook.org/doc/guide/html/publication-file.html
- `pretext init --refresh` for a sample project that reflects the
  installed CLI's expected layout.
