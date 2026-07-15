# Track D — LaTeX Macro Management

Each document stream carries its own docinfo: macros live in the
`<macros>` element of `source/notes/bookends/docinfo.ptx` and
`source/homepage/bookends/docinfo.ptx` — two copies of the same file,
kept identical — plus `<latex-image-preamble>` for TikZ-only packages.
The book's own `source/book/bookends/docinfo.ptx` defines the APEX
macro set — check which docinfo each target actually uses in
`project.ptx` and the entry files (`book.ptx`, `notes.ptx`,
`homepage.ptx`) before assuming; a macro must be added to **every
docinfo used by a target that renders it**.

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
   reveal system, replaced by the stu/key component pairs. Port genuinely
   semantic ones (e.g., a `\WORK`-style line-integral shorthand) only
   if used in 3+ places; otherwise inline the LaTeX.

## Task D2 — Macro audit (run occasionally, or when math renders wrong)

1. Extract every control sequence used in `source/**/*.ptx` math:
   `grep -rhoE '\\\\[a-zA-Z]+' source --include='*.ptx' | sort | uniq -c | sort -rn`
   (crude but effective; ignore XML entities and PreTeXt tags).
2. Diff against (a) macros defined in each docinfo and (b) a whitelist
   of standard LaTeX/AMS commands. Anything undefined and nonstandard
   is a bug: define it or fix the usage.
3. Flag duplicates/conflicts among the three docinfo files
   (`source/notes/bookends/`, `source/homepage/bookends/`,
   `source/book/bookends/`), drift between the notes and homepage
   copies (they must stay identical), and dead macros defined but never
   used (report only — deleting definitions is the instructor's call).
4. Build all targets; confirm no MathJax/LaTeX "undefined control
   sequence" output. Open a PR only if fixes are needed; otherwise post
   the report as an issue comment.

**Acceptance:** zero undefined control sequences across all targets;
report distinguishes fixed / duplicate / dead.
