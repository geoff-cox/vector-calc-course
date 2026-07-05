# Claude Code Setup &amp; Mobile Request Recipe

How to wire this repo up once, and how to request work from your phone after
that. Setup details verified against the official docs at
<https://code.claude.com/docs/en/github-actions> (action `@v1`, GA).

---

## A. One-time setup (do this once, from a computer)

You need to be an **admin** of the GitHub repository.

### Easiest path — the installer

1. Push this repository to GitHub.
2. On your computer, install Claude Code and run it in the repo, then run the
   slash command:
   ```
   /install-github-app
   ```
   It walks you through installing the Claude GitHub App and storing your API
   key as a repository secret. The app requests read &amp; write on Contents,
   Issues, and Pull requests.

### Manual path — if the installer can't be used

1. Install the Claude GitHub App on the repo:
   <https://github.com/apps/claude>
   (grant Contents, Issues, Pull requests — all read &amp; write).
2. Add your Claude API key as a repository secret named **`ANTHROPIC_API_KEY`**
   (Settings → Secrets and variables → Actions → New repository secret). Get
   the key from <https://console.anthropic.com>.
3. The workflow file already lives at `.github/workflows/claude.yml` in this
   repo, so there's nothing to copy — just make sure Actions are enabled for
   the repo (Settings → Actions → General).

> **Cost note:** runs consume GitHub Actions minutes *and* Claude API tokens.
> The workflow caps each run at `--max-turns 30` and 30 wall-clock minutes,
> and only fires when a message literally contains `@claude`.

---

## B. The model

The action defaults to Claude Sonnet. For this project's nuanced authoring you
may prefer Opus 4.7 — uncomment the `--model claude-opus-4-7` line in
`.github/workflows/claude.yml` (it's in the `claude_args` block, with a note).
Sonnet is cheaper and usually fine for ports and QA; Opus is worth it for
drafting new material from scratch.

---

## C. Requesting work from your phone

The flow is built around `@claude` mentions, which you can post from the GitHub
mobile app (or any browser). You never need a terminal after setup.

### To start a new piece of work — open an issue

Open a new issue in the repo. Title it whatever you like; in the **body**, name
the task by number from `BUILD-CHECKLIST.md` and give the inputs that task
needs. Examples:

```
@claude run Task 1 to port the dot-product section.
LaTeX is in the old repo at 01_02_Dot_Product.tex (pasted below).
Title it "Dot Product"; it belongs in Chapter 1.

<paste the .tex here>
```

```
@claude run Task 2: new worksheet on the cross product.
Cover: definition via determinant, geometric meaning (area + right-hand
rule), orthogonality to both inputs, and 3 practice problems.
Propose an outline first and wait for my OK.
```

```
@claude run Task 6
```
(build &amp; verify everything — no other input needed)

Claude reads `CLAUDE.md` and `BUILD-CHECKLIST.md` from the repo, does the work
on a `task-N/...` branch, runs the verification gate, and opens a **pull
request** with the results pasted in.

### To review and revise — comment on the PR

Open the PR Claude created (you'll get a notification). Skim the pasted build +
grep results to confirm the student/instructor split. Then:

- **Request changes** by commenting with `@claude`, e.g.
  `@claude tighten the unit-vector example and add one more practice problem`.
- You can also leave an inline review comment on a specific line and include
  `@claude` in it.

Each `@claude` reply wakes the action back up; Claude makes the change on the
**same PR branch**, re-runs the gate, pushes, and replies with a short
changelog. This is the "subscribe to the PR" loop — repeat until you're happy,
then **you** merge. (Claude never merges or pushes to `main`.)

### Phrasing tips

- Always include the literal string `@claude` — `/claude` will not trigger it.
- Lead with the **Task number**; it pulls in the whole playbook so you don't
  have to re-explain conventions.
- One request per issue/PR thread keeps Claude's context clean.

---

## D. Quick troubleshooting

| Symptom                          | Check                                                        |
| -------------------------------- | ----------------------------------------------------------- |
| Claude doesn't respond           | Is the GitHub App installed? Are Actions enabled? Did you write `@claude` (not `/claude`)? |
| "Authentication error" in logs   | Is the `ANTHROPIC_API_KEY` secret set and valid?            |
| Build step fails in the PR       | Open it as **Task 7** — comment `@claude run Task 7` on the PR with the error. |
| CI doesn't run on Claude's commit| Confirm the GitHub App (not the Actions user) is pushing; check workflow triggers. |

For deeper detail see the official guide:
<https://code.claude.com/docs/en/github-actions>.
