---
name: pre-launch
description: >
  Run the full pre-launch checklist before a beta or store release. Use this skill whenever the user
  asks to "run the pre-launch check", "pre-launch audit", "is this ready to ship", "ready for beta",
  "ready for release", "submission check", "launch readiness", or before any production submission.
  Aggregates verdicts from security-reviewer, accessibility-checker, third-party-api-auditor, and
  db-rules-validator.
---

# Pre-launch checklist

Read the project's pre-launch doc. Walk every checklist item and:

1. **Verify it's done** by reading the relevant file or running the relevant check.
2. For each item, output one of: `PASS`, `BLOCK — <reason>`, or `REVIEW — <human action required>`.
3. Group the report by owner (client / backend / compliance / legal).
4. End with an overall verdict: `READY FOR SUBMISSION` (all PASS), `BLOCKED — N items`, or `REVIEW REQUIRED — N items`.

## In parallel, invoke

- `security-reviewer` against the full repo (not just diff)
- `accessibility-checker` against all view files
- `third-party-api-auditor` (full surface)
- `db-rules-validator`

Aggregate their verdicts into the final report.

## End

End with a Conventional Commits-style commit message if any docs need updating: `chore(prelaunch): mark <items> as verified`.
