# MA 301 Syllabus — 2015 Archive Transcription

Plain-text transcription of `source/homepage/syllabus/docx/MA301_Syllabus_S2015.docx`
(Spring 2015). This is the durable, mobile-readable reference for the
authoritative 2015 course facts used to rebuild the PreTeXt syllabus
(Task A1). Section order, the topic list, grading weights, and exam
structure are preserved. Editorial `> NOTE` callouts flag items that are
clearly stale in 2026; they are commentary, not part of the original
document.

---

## Header

- **Course:** Math 301 — Advanced Mathematics for Scientists and Engineers

## Instructor

- **Name:** Geoffrey Cox
- **Office:** 433 Mallory Hall
- **Phone:** 540-464-7499
- **E-mail:** coxgw10@vmi.edu
- **Webpage:** www.geoffsmathpages.com/Teaching/ma-301
- **Office Hours:** By Appointment; Open Door Policy

> NOTE (stale): The current inherited instructor block
> (`syllabus/common/instructor-info.ptx`) lists Office **MA 425**, email
> **coxgeoff@vmi.edu**, and office hours **MWF 1430-1600, By Appointment**.
> The 2015 office (433 Mallory Hall), phone, and `coxgw10@vmi.edu` address
> differ. The common include is inherited unchanged, so the syllabus page
> shows the current values, not these 2015 ones.

## Course Information

- **Text:** *Calculus, Early Transcendental Functions* (Fourth ed.), by
  Larson, Hostetler and Edwards.
- **Prerequisites:** C or better in MA 215 and MA 311.
- **Department Head:** LTC Troy Siemers.

> NOTE (stale): The printed Larson text is superseded — the course is
> being rebuilt on the in-repo APEX Calculus adaptation (`source/book/`).
> Department-head rank likely changed since 2015 (the MA 311 template
> lists "COL Troy Siemers").

## Grading

| Component  | Weight | Notes    |
|------------|--------|----------|
| Tests      | 30%    | 3 Tests  |
| Homework   | 40%    |          |
| Final Exam | 30%    |          |

This is **traditional weighted grading**, not the proficiency-based
grading (ODP / Pass–Not-yet) scheme used by the MA 311 template the
PreTeXt syllabus is being adapted from.

## Homework

Homework consists of both hand-written and online assignments.
Hand-written assignments should be organized and rigorous — no
scratch-work solutions. Due dates are announced in class and/or posted on
the class website. Online homework is assigned for each topic covered and
must be submitted by the due date on the homework website.

- **Online Homework Website:** https://euler.vmi.edu/webwork2
- The class is listed as **"MA_301_S15"**. Sign in with VMI login
  credentials. (2015 note about browser security warnings for that site.)

> NOTE (stale): `euler.vmi.edu/webwork2` and the section id `MA_301_S15`
> (Spring 2015) are almost certainly dead. The MA 311 template's current
> WeBWorK host is `vmi-math.com/webwork2`.

## Course Topics

- **Vector Analysis:** Vector Fields, Line Integrals, Conservative Vector
  Fields, Green's Theorem, Parameterization of Lines and Surfaces,
  Divergence Theorem, Stokes' Theorem.
- **Miscellaneous Topics:** Fourier Series, Complex Variables, Partial
  Differential Equations.

> NOTE: The 2015 topic list is narrower than the "full multivariable/vector
> calculus" framing in `CLAUDE.md`. In 2015 the earlier multivariable
> material (vectors, vector-valued functions, partial derivatives,
> multiple integrals) sat in the prerequisites (MA 215 / MA 311), and
> MA 301 opened directly at vector analysis. Whether the modern MA 301
> should also cover that foundational material is an open editorial
> question (see the PR).

## Attendance Policy

Standard VMI attendance policy: academic excellence is best achieved
through consistent attendance; maximum allowed absences is 30% (no
category exempt). At 20% absences the instructor issues a written warning
and the cadet signs a receipt; at 30% the cadet is referred to the Dean,
and normally must withdraw with a W or WF.

> NOTE: Inherited unchanged via `syllabus/common/attendance.ptx`.

## Students with Disabilities

VMI abides by Section 504 of the Rehabilitation Act of 1973 and the ADA
(1990); reasonable accommodations are provided for documented
disabilities. Cadets should contact the instructor early and register
with the Office of Disabilities Services (2nd floor, VMI Health Center).
The 2015 text names **LTC Jones, Director of Disabilities Services,
464-7667, jonessl10@vmi.edu**.

> NOTE (stale): Director name / contact are 2015-specific. Inherited
> policy now lives in `syllabus/common/accessibility.ptx`.

## Your Responsibility

Cadets must understand all policies in the document, especially those
concerning work for grade, and contact the instructor immediately with
any disagreement or confusion.

## Work for Grade

Full VMI "Work for Grade" honor policy: all submitted work is the cadet's
own; failure to distinguish one's own work from others' is plagiarism;
every written submission must carry a conspicuous **"HELP RECEIVED"**
statement (either "none" or a detailed explanation); the same declaration
is made orally before graded oral work; violations found by the Honor
Court result in dismissal.

> NOTE: Inherited unchanged via `syllabus/common/workforgrade.ptx`. The
> 2015 text has a few blanks where "Honor Court" was dropped ("reported to
> the professor and the .").

## Departmental Work for Grade Policy

The Department of Applied Mathematics fully supports the Institute Work
for Grade Policy; faculty will not grade work lacking the "HELP RECEIVED"
statement until the cadet adds it.

## Writing Center

Use of the Writing Center is approved for all Department courses.

## Mathematics Education and Resource Center (MERC)

Use of the MERC and its Open Math Lab (OML) is approved for all Department
courses unless otherwise specified.

> NOTE: Inherited unchanged via `syllabus/common/merc.ptx`.

## Tutoring, Peer Collaboration, Academic Center

Department policy: work submitted for grade precludes tutors or peer
collaboration unless the instructor states otherwise in the syllabus;
tutors and peer collaboration are authorized for non-graded work
(homework, drill exercises).

## Use of Computer Aids

Software packages are not permitted unless the instructor states
otherwise; spelling, style, and grammar checkers are approved. Calculator
use is determined by the instructor per course.

---

## Summary of stale items (2026)

- **Textbook:** Larson 4th ed. → replaced by the in-repo APEX Calculus
  adaptation.
- **WeBWorK:** `euler.vmi.edu/webwork2`, section `MA_301_S15` → dead
  host / dead section id.
- **Instructor block:** 2015 office/phone/email differ from the current
  inherited `common/instructor-info.ptx`; page shows the current values.
- **Department Head rank:** "LTC Troy Siemers" (2015) vs "COL Troy
  Siemers" (current template).
- **Disability Services contact:** 2015 director/phone/email are dated;
  now carried by `common/accessibility.ptx`.
- **Meeting time/room:** none given in the 2015 document — must be set for
  the current term (placeholder in the PreTeXt syllabus).
- **Instructor webpage:** `www.geoffsmathpages.com/Teaching/ma-301` —
  unverified, likely stale.
- **Grading model:** 2015 uses traditional weights (Tests 30 / HW 40 /
  Final 30); the PreTeXt template it is being merged into uses
  proficiency-based grading. This choice is surfaced to the instructor,
  not guessed.
