# Track A — MA 301 Syllabus

**Goal:** convert the differential-equations syllabus template
`source/homepage/syllabus.ptx` (written for MA 311) into a syllabus for
**MA 301 — Advanced Mathematics for Scientists and Engineers**, sourcing
course facts from `outdated-material/syllabus/MA301_Syllabus_S2015.docx`.

**Hard constraint:** the common policies included from
`source/homepage/syllabus/common/` (attendance, work-for-grade, MERC,
Writing Center, AI policy, etc.) are inherited **unchanged** — keep the
`<xi:include>` lines exactly as they are and never edit those files.

---

## Task A1 — Extract and archive the 2015 syllabus content

1. Read the docx without adding heavy dependencies. Either:
   - `pip install python-docx` and dump paragraphs + tables, or
   - `unzip -p outdated-material/syllabus/MA301_Syllabus_S2015.docx word/document.xml`
     and strip tags.
2. Save a clean plain-text transcription to
   `docs/ma301-syllabus-2015.md`, preserving section order, the topic
   list/schedule, grading weights, and exam structure. This file becomes
   the durable reference (the docx is awkward to read on mobile).
3. In the PR body, summarize: course description, prerequisites, topic
   list, grading scheme, and anything that looks stale (dead URLs, old
   room numbers, retired policies).

**Acceptance:** `docs/ma301-syllabus-2015.md` exists, is readable, and
the PR summary flags every obviously outdated item.

## Task A2 — Rewrite `source/homepage/syllabus.ptx` for MA 301

1. Keep the template's overall architecture (General → Grades &
   Coursework → Resources → common policy includes). It is the current
   department style; the 2015 document supplies *content*, not layout.
2. Replace all course-specific content:
   - Title/intro text, course description, prerequisites, meeting info,
     department head — from the 2015 docx, updated where clearly stale.
     Meeting times/rooms from 2015 are certainly wrong: insert
     placeholders like `<insert>Room/Time TBD</insert>` and a
     `<!-- TODO(geoff) -->`.
   - Course topics: list the MA 301 topics (vectors, vector-valued
     functions, partial derivatives, multiple integrals, vector
     calculus, plus whatever the 2015 syllabus adds, e.g. complex
     numbers/Fourier series if present) as the topic section.
3. **Grading scheme — critical decision, do not guess.** The template
   uses proficiency-based grading (ODPs); the 2015 syllabus almost
   certainly uses traditional weights. Default action: port the
   *structure* of the template's grading sections but populate them
   with `<!-- TODO(geoff): choose PBG vs. traditional -->` and include
   BOTH schemes in the PR body as ready-to-paste PreTeXt snippets, so
   the instructor picks one with a single review comment.
4. Relabel: every `label`/`xml:id` beginning `ma311-` becomes `ma301-`.
   Labels in `common/` files stay untouched. Grep afterwards:
   `grep -rn "ma311" source/homepage/ --include='*.ptx' | grep -v common/`
   must return nothing.
5. Resources section: the Runestone/WebWork entries are MA 311-specific.
   Replace with MA 301 equivalents if the 2015 syllabus names any;
   otherwise keep the subsection skeletons with TODO placeholders and
   note it under "Open questions".
6. Improvements welcome (clearer phrasing, better organization of the
   topic list, a week-by-week schedule table derived from the 2015
   schedule) — itemized in the PR.

**Verification:** gates 1–2 from `CLAUDE.md` §4 on the homepage target;
confirm the rendered syllabus page on the Pages preview reads coherently
with no MA 311/ODE leftovers:
`grep -in "311\|differential equation" output/<homepage-target>/*.html`
should return only intentional matches (e.g., MERC tutoring list).

**Acceptance:** homepage target builds clean; no unintended MA 311
remnants; grading decision surfaced, not guessed; common includes
byte-identical (`git diff --stat` shows no changes under `common/`).
