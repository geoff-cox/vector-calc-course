<!-- Every PR (human or @claude) uses this template. Keep sections even if empty. -->

## Task

Task ID from `checklists/mobile-build-checklist.md` (e.g., `B2`), or "ad hoc".

## What changed

One short paragraph. Name every file touched.

## Improvements (beyond the source material)

Itemize EVERY substantive change that goes beyond faithful conversion:
new examples, rewritten explanations, added exercises, corrected math,
reorganized content. The instructor retains editorial control - anything
not listed here should be a faithful port. Write "None" if none.

## Verification evidence

Paste the actual command output, not a summary:

- [ ] XML well-formedness check on every touched `.ptx` file
- [ ] `pretext build <target(s)>` succeeds (log filtered with `grep -v 'asset directories'`)
- [ ] Zero unresolved `<xref>` warnings in the build log
- [ ] (Worksheets only) sentinel grep: 0 hits in student build, >=1 in instructor build

## Preview

- [ ] `preview` label added so the Pages workflow publishes this branch
      (reviewer: check the deployed site link in the Actions run)

## Open questions for the instructor

Decisions deferred to review; also marked `<!-- TODO(geoff): ... -->` in source.
