# Track D — LaTeX Macro Management

All macros live in exactly one place: the `<macros>` element of
`source/bookends/docinfo.ptx` (plus `<latex-image-preamble>` for
TikZ-only packages). The book's own `book/ptx/docinfo.ptx` may define
its own set — check which docinfo each target actually uses in
`project.ptx`/`book.ptx` before assuming; if the book and the
notes/homepage use different docinfo files, a macro must be added to
**every docinfo used by a target that renders it**.

## Task D1 — Standing rule (enforced inside every other task)

Whenever a document authored in Tracks A–C uses a LaTeX macro:

1. If it's already defined in the relevant docinfo, use it — do not
   redefine, do not invent a synonym (`\vv` exists; don't add `\vecv`).
2. If it's new, add it in the same PR: semantic name, `\newcommand` (or
   `\DeclareMathOperator`), grouped with its family, one per line,
   with the existing style (e.g., `\vF`, `\norm{...}`, `\proj`).
3. Old Beamer decks use header macros like `\D` (displaystyle), `\B`
   (reveal box), `\ON`, `\OBUL`, `\WORK`. Do **not** port
   presentation-mechanic macros (`\B`, `\ON`, `\OBUL`) — they are the
   reveal system, replaced by fillin/commentary. Port genuinely
   semantic ones (e.g., a `\WORK`-style line-integral shorthand) only
   if used in 3+ places; otherwise inline the LaTeX.

## Task D2 — Macro audit (run occasionally, or when math renders wrong)

1. Extract every control sequence used in `source/**/*.ptx` math:
   `grep -rhoE '\\\\[a-zA-Z]+' source --include='*.ptx' | sort | uniq -c | sort -rn`
   (crude but effective; ignore XML entities and PreTeXt tags).
2. Diff against (a) macros defined in each docinfo and (b) a whitelist
   of standard LaTeX/AMS commands. Anything undefined and nonstandard
   is a bug: define it or fix the usage.
3. Flag duplicates/conflicts between `source/bookends/docinfo.ptx` and
   `source/book/ptx/docinfo.ptx`, and dead macros defined but never
   used (report only — deleting definitions is the instructor's call).
4. Build all targets; confirm no MathJax/LaTeX "undefined control
   sequence" output. Open a PR only if fixes are needed; otherwise post
   the report as an issue comment.

**Acceptance:** zero undefined control sequences across all targets;
report distinguishes fixed / duplicate / dead.
