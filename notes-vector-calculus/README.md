# Vector Calculus — Guided Lecture Notes (PreTeXt)

A starter PreTeXt project for re-authoring the existing LaTeX/Beamer
lecture notes as a book of `<worksheet>`s.  One source tree produces
both **student handouts** (blanks unfilled, solutions hidden) and
**instructor keys** (blanks filled, solutions revealed).

## Layout

```
notes-vector-calculus/
├── README.md                           ← you are here
├── project.ptx                         ← defines the four build targets
├── publication/
│   ├── publication-student.ptx         ← hides solutions
│   └── publication-instructor.ptx      ← reveals solutions
└── source/
    ├── main.ptx                        ← root: docinfo, macros, book frame
    ├── ch-functions-vectors.ptx        ← Chapter 1 container
    └── ws-function-notation.ptx        ← Worksheet 1.1 (the fleshed-out one)
```

## One-time setup

1. Install the PreTeXt CLI (Python ≥ 3.10 required):
   ```
   pip install pretext
   pretext --version
   ```
2. For PDF output, also install a TeX distribution (TeX Live or
   MacTeX); for HTML output nothing else is needed.

## Daily use

From the project root:

```
pretext build web-student        # HTML, blanks shown, solutions hidden
pretext build web-instructor     # HTML, blanks shown, solutions revealed
pretext build print-student      # PDF student handout
pretext build print-instructor   # PDF answer key

pretext view  web-student        # open most recent build in a browser
```

Output lands in `output/<target-name>/`.

## How the student/instructor split works

There are **two** guided-notes mechanisms in the source, each with its
own switching behavior.

### 1. `<fillin>` — short blanks in prose

Used for one- or two-word completions during lecture:

```xml
<li>For each input there is
    <fillin characters="14">exactly one</fillin> output.</li>
```

This renders as an **underlined blank** on both the student and the
instructor copy.  The text inside the tag (`exactly one`) is the
suggested answer to fill in; with the publication settings in this
project it is visible only in “answer” mode.  If you don’t want it
visible anywhere ever, use `<fillin characters="14"/>` with no body —
PreTeXt will still draw a blank of that width and you keep the answer
in your head or on a separate slide.

### 2. `<task>` with `<statement>` and `<solution>` — worked examples

Used for multi-step computations the class works through:

```xml
<task>
    <statement>
        <p>Compute <m>f(2,-1)</m> for <m>f(x,y) = x^2 - 3xy + y^2</m>.</p>
    </statement>
    <solution>
        <p><m>f(2,-1) = 4 + 6 + 1 = 11</m>.</p>
    </solution>
</task>
```

The publication file controls which children of `<task>` are emitted.
`publication-student.ptx` lists only `<statement/>`, so the whole
`<solution>` is dropped from that build.  `publication-instructor.ptx`
lists `<statement/>`, `<hint/>`, `<answer/>`, `<solution/>`, so the
solution appears inline immediately after the question.

The same scheme applies to standalone `<exercise>` and `<example>`
elements through the `<solutions-divisional>` block in the publication
files.

## Adding new worksheets

1. Copy `ws-function-notation.ptx` to a new name, e.g.
   `ws-vectors.ptx`, and replace its contents with the next class.
2. Add an `<xi:include href="./ws-vectors.ptx"/>` line inside
   `ch-functions-vectors.ptx` (there are pre-written comment stubs
   for the obvious next ones).
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

is the direct ancestor of what `<fillin>` does here: text that appears
only at the right moment.  In PreTeXt the “moment” is build-time
rather than slide-overlay-time, but the pedagogical role — the
instructor reveals; the student writes — is the same.

Your custom LaTeX macros (`\VF`, `\VV`, `\RE`, `\RRE`, etc.) have
PreTeXt-friendly analogues defined in the `<macros>` block of
`source/main.ptx`: `\vF`, `\R`, `\R^2`, and friends.  Add more as you
port more material.

## Compatibility note on the publication file

PreTeXt is actively developed and the exact element names that
control task/exercise-component visibility have evolved across
versions.  The settings used here (`<task-default>`,
`<solutions-divisional>`, `<solutions-worksheet>`) target the
current `ptx-version="2"` schema.  If `pretext build` complains
about an unknown element, run `pretext --version` and consult the
PreTeXt Author Guide section on publication-file schemas at
`https://pretextbook.org/doc/guide/html/publication-file.html` for
the exact spelling in your installed version.  The structural intent
is what matters: *student build emits only `<statement/>`; instructor
build emits all four parts.*
