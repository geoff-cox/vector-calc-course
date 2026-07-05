# CLAUDE.md — Project Instructions for Claude Code

This file is read automatically by Claude Code (CLI and the GitHub Action)
at the start of every task. It defines what this repository is, the
conventions you must follow, and the workflow for submitting and revising
work. Keep edits to it surgical.

When a request says **"Task N"**, it refers to a numbered job in
`BUILD-CHECKLIST.md`. Open that file, find the matching task, and follow
its steps and acceptance criteria exactly. The deep reference for *why*
the conventions exist lives in `README.md`; this file is the short version
you should rely on by default.

---

## 1. What this repository is

A PreTeXt source tree for **guided** vector-calculus lecture notes. "Guided"
means the student handout has blanks and unworked examples that get filled in
together during class; the instructor copy shows every answer. Both versions
build from one source tree — the difference is entirely in the build target.

The notes are being ported, one class meeting at a time, from an older
LaTeX/Beamer deck whose source lives outside this repo (the user pastes or
references the relevant `.tex` when needed). The Beamer reveal pattern
`\ON<1>{\B{...}}` (hidden until a slide click) is the direct ancestor of the
fill-in/commentary pattern below.

---

## 2. Repository layout

```
.
├── CLAUDE.md                       ← this file
├── BUILD-CHECKLIST.md              ← numbered task catalog
├── README.md                       ← full human-facing reference
├── docs/claude-code-setup.md       ← one-time setup + mobile recipe
├── project.ptx                     ← four build targets
├── publication/
│   ├── publication-student.ptx     ← hides exercise/task solutions
│   └── publication-instructor.ptx  ← reveals exercise/task solutions
├── source/
│   ├── main.ptx                    ← docinfo, macros, book frame
│   ├── ch-functions-vectors.ptx    ← Chapter 1 container
│   ├── ws-*.ptx                    ← one worksheet per class meeting
│   └── figures/                    ← image assets (create as needed)
└── .github/workflows/claude.yml    ← the @claude GitHub Action
```

Worksheets are included into chapters via `<xi:include>`, and chapters into
`main.ptx` via `<xi:include>`. To add a worksheet: create `source/ws-NAME.ptx`,
then add one include line to the relevant chapter file.

---

## 3. The three guided-notes mechanisms (the core conventions)

These are the heart of the project. Use the right one for each situation.
The first two are how blanks work; the third is how worked problems work.

### 3a. `<fillin characters="N"/>` — short in-prose blank

Renders as an underline of width N in **both** builds. Students write in it.

> **Critical gotcha:** PreTeXt `<fillin>` honors only the `@characters`
> attribute. Any text placed *inside* the tag is silently discarded in the
> output. Never write `<fillin characters="14">exactly one</fillin>` and
> expect the answer to appear. The answer goes in a `<commentary>` block
> (see 3b).

### 3b. `<commentary>` — instructor-only answer key for the blanks

```xml
<p>For each input there is <fillin characters="14"/> output.
Two different inputs <fillin characters="4"/> produce the same output.</p>
<commentary>
    <p>Blanks, in order: <q>exactly one</q>, <q>can</q>.</p>
</commentary>
```

`<commentary>` is **block-level** (cannot sit mid-sentence) and its
visibility is toggled by the **`commentary` stringparam** in `project.ptx`.
Instructor targets set `commentary="yes"`; student targets omit it, so the
block vanishes entirely from the student handout.

**Pattern to follow:** group the blanks for one idea into a single
paragraph/list, then place one `<commentary>` block immediately after it
that lists the answers *in order*. Do not scatter one commentary per blank.

### 3c. `<exercise>` with `<statement>` + `<solution>` — worked problems

```xml
<exercise xml:id="...">
    <statement><p>Compute <m>f(2,-1)</m> for <m>f(x,y)=x^2-3xy+y^2</m>.</p></statement>
    <solution><p><m>f(2,-1)=4+6+1=11</m>.</p></solution>
</exercise>
```

Solution visibility is controlled by the publication files'
`<exercise-worksheet>` element (student = `solution="no"`,
instructor = `solution="yes"`). Use this for every multi-step computation —
both the worked examples you demonstrate and the "your turn" practice.

> **`<example>` vs `<exercise>`:** PreTeXt's `<example>` *always* shows its
> solution in both builds. So anything whose answer must be hidden from
> students must be an `<exercise>`, never an `<example>`. Reserve `<example>`
> for read-along illustrations that contain **no** hidden content.

### Quick selection table

| Situation                                   | Use                          |
| ------------------------------------------- | ---------------------------- |
| One/two-word blank inside a sentence        | `<fillin>` + `<commentary>`  |
| Definition or theorem with a blank in it    | `<fillin>` + `<commentary>`  |
| Multi-step worked computation               | `<exercise>` + `<solution>`  |
| "Your turn" practice problem                | `<exercise>` + `<solution>`  |
| Read-along illustration, no hidden answer   | `<example>` (no `<solution>`)|

---

## 4. Build targets and the mandatory verification gate

Four targets are defined in `project.ptx`:

| Target             | Format | Audience   | Solutions | Commentary |
| ------------------ | ------ | ---------- | --------- | ---------- |
| `web-student`      | HTML   | student    | hidden    | hidden     |
| `web-instructor`   | HTML   | instructor | shown     | shown      |
| `print-student`    | PDF    | student    | hidden    | hidden     |
| `print-instructor` | PDF    | instructor | shown     | shown      |

**Before opening or updating any PR, you MUST run this gate and paste the
results into the PR description.** Do not rely on XML well-formedness alone —
it does not catch PreTeXt schema or visibility-toggle problems.

```bash
# Install the CLI if the runner doesn't have it.
pip install pretext --quiet || pip install pretextbook --break-system-packages --quiet

# 1. Both HTML builds must succeed.
pretext build web-student
pretext build web-instructor

# 2. Visibility check: pick a phrase that lives ONLY in a <solution> or
#    <commentary> of the file you changed. It must be ABSENT from the
#    student build and PRESENT in the instructor build.
#    Example for ws-vectors:
grep -c "no additional force is needed" output/web-student/ws-vectors-letter.html      # expect 0
grep -c "no additional force is needed" output/web-instructor/ws-vectors-letter.html   # expect >=1
grep -c "Blanks, in order"             output/web-student/ws-vectors-letter.html        # expect 0
grep -c "Blanks, in order"             output/web-instructor/ws-vectors-letter.html     # expect >=1
```

If any check fails, fix it before opening the PR. A common cause of a failed
visibility check is using `<example>` where `<exercise>` was required (see 3c),
or putting an answer in `<fillin>` text instead of `<commentary>` (see 3a).

PDF targets need a TeX installation; build them only when asked, and say so
if TeX is unavailable in the environment rather than silently skipping.

---

## 5. Math macros available

Defined in the `<macros>` block of `source/main.ptx`. Reuse these rather than
inlining raw LaTeX; add new ones there when a symbol recurs.

```
\R        \mathbb{R}              \vv \vw \vu \va \vb \vc   bold vectors
\vF \vG   bold field letters      \vi \vj \vk               basis vectors
\vr \vn                           \vzero  \mathbf{0}
\norm{#1} \left\lvert…\rvert      \dom \range               operators
```

---

## 6. Porting conventions (old LaTeX → PreTeXt)

- Preserve the **section organization** of the original (e.g. the vectors
  deck's I–V structure became five `<page>`s). One `<page>` per logical
  "board" of the lecture.
- Each `\ON<1>{\B{...}}` reveal becomes either a `<fillin>`+`<commentary>`
  pair (if it was a short blank) or an `<exercise>` `<solution>` (if it was a
  multi-line derivation). Judge by length and role.
- Figures from the deck become `<figure>` blocks. If you don't have the image
  file, leave an `<image><description>…</description></image>` placeholder and
  a `<!-- TODO -->` noting which original figure it corresponds to. Never
  invent or fabricate image files.
- Keep the original's voice. Write tightly: every added sentence must earn its
  place by adding understanding, never length for its own sake. Tightness and
  the enrichment mandate in §6b are partners, not opposites — enrich where the
  treatment is thin, and cut filler everywhere.

---

## 6b. Improve on the source — don't just transcribe it

These notes are being modernized, not photocopied. You are expected to act as
an editor who improves the material, not merely a porter who preserves it.
Faithful structure (§6) is the default, but within that structure you should
actively raise the quality:

- **Deepen shallow treatments.** Where the original states a definition or
  result with little explanation, add the missing intuition: why the idea
  matters, what it generalizes, a sentence of motivation, a common pitfall, or
  a geometric/physical interpretation. A topic given one terse line in the deck
  is a signal to expand it, not a length to match.
- **Add examples and practice.** Where a concept has too few worked examples or
  no "your turn" problems, add them (as `<exercise>` with `<solution>` per §3c).
  Aim for a sensible difficulty ramp and at least one example that surfaces a
  typical mistake.
- **Strengthen connections.** Add brief forward/backward links ("this is the
  same componentwise idea from §…", "we'll reuse this in the gradient
  worksheet") and a short "Looking ahead" close where one is missing.
- **Fix and modernize.** Correct outright errors, dated notation, or awkward
  phrasing. Prefer the project's macros and the three-mechanism style even when
  the original did something cruder.

Two guardrails on this latitude, because the user is the instructor and owns
the course content:

1. **Stay within scope and level.** Match the course's rigor and audience;
   don't bolt on tangential advanced material or change what the lecture is
   fundamentally about. Mathematical additions must be correct and verifiable.
2. **Flag every substantive change for review.** In the PR description, include
   a short **"Improvements"** list itemizing what you added or changed beyond a
   faithful port (e.g. "added 2 practice problems on unit vectors", "expanded
   the equilibrium discussion with a worked physics example", "corrected the
   domain restriction wording"). This lets the instructor accept or reject each
   enrichment deliberately rather than discovering silent rewrites. When unsure
   whether an addition fits the course, make it and flag it — or, for larger
   structural ideas, propose it in a PR comment and ask before writing.

---

## 7. PR workflow (how to submit and revise work)

You operate through pull requests. Follow this every time.

1. **Never commit to `main` directly.** Create a branch named
   `task-N/<short-slug>` (e.g. `task-1/dot-product`).
2. Make the changes per the task spec in `BUILD-CHECKLIST.md`.
3. Run the **verification gate** in section 4.
4. Open a PR whose description contains:
   - which Task number this addresses and on what input;
   - a 2–4 line summary of what changed;
   - an **"Improvements"** list itemizing anything added or changed beyond a
     faithful port (deepened explanations, added examples/practice, fixes), per
     §6b — or "Improvements: none (faithful port)" if you genuinely made none;
   - the pasted verification-gate output (build success lines + the grep
     counts), so the reviewer can confirm the student/instructor split
     without rebuilding.
5. End the PR description with a short line inviting review and stating that
   replies containing `@claude` will be addressed automatically.
6. **Do not merge.** The human reviews and merges.

### Addressing review feedback ("subscribing" to the PR)

The GitHub Action is configured (see `.github/workflows/claude.yml`) to wake
up whenever a PR comment, a review, or a review-thread comment contains
`@claude`. When that happens:

- Read the full review thread and the specific lines referenced.
- Make the requested changes on the **same PR branch** (do not open a new PR).
- Re-run the verification gate.
- Push the new commits and post a brief reply summarizing what you changed and
  the updated grep counts.

Treat each round of review as a continuation of the same task, not a new one.

---

## 8. Things to never do

- Never put answer text inside a `<fillin>` tag (it's discarded — use
  `<commentary>`).
- Never use `<example>` for content whose answer must be hidden from students.
- Never open a PR without pasting passing verification-gate output.
- Never merge your own PR or push to `main`.
- Never fabricate image files or cite figures that don't exist; use TODO
  placeholders.
- Never reduce or remove the student/instructor split to make a build pass.
- Never make substantive changes to the mathematical content without listing
  them in the PR's "Improvements" section (§6b) — enrich openly, never silently.
