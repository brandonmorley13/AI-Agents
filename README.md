# AI-Agents

My library of **Claude Code subagents** — focused reviewers and validators invoked on demand
(a slash command or a direct request), each returning severity-tagged findings and a PASS/BLOCK
verdict. Copy any `agents/*.md` into a project's `.claude/agents/` to use it.

Companion repo: [AI-Skills](https://github.com/brandonmorley13/AI-Skills) — the skills that invoke
these agents. (The skills that used to live here now live there.)

## Agents

| Agent | What it accomplishes | Model | Tools |
|---|---|---|---|
| [`code-reviewer`](agents/code-reviewer.md) | Reviews a diff against the project's rule set — the verification pass that turns decent output into best-in-class. Numbered findings + PASS/BLOCK. | sonnet | Read, Grep, Glob, Bash |
| [`security-reviewer`](agents/security-reviewer.md) | Audits code/config against the security policy: auth, secrets, third-party integrations, DB rules, encryption, logging, money-movement. | sonnet | Read, Grep, Glob, Bash |
| [`accessibility-checker`](agents/accessibility-checker.md) | Audits SwiftUI views against WCAG 2.2 AAA + iOS accessibility-feature parity (VoiceOver, Dynamic Type, contrast, targets). | haiku | Read, Grep, Glob |
| [`db-rules-validator`](agents/db-rules-validator.md) | Validates database security rules against the data shapes actually used in client + server code. | sonnet | Read, Grep, Glob, Bash |
| [`firestore-rules-validator`](agents/firestore-rules-validator.md) | Firestore-specific rules validator — every path default-denied, auth/ownership enforced, sensitive fields client-unwritable. | sonnet | Read, Grep, Glob, Bash |
| [`third-party-api-auditor`](agents/third-party-api-auditor.md) | Audits a third-party financial/data-API integration end to end (client + server + DB + hosting) vs the vendor's policy. | sonnet | Read, Grep, Glob, Bash |
| [`plaid-auditor`](agents/plaid-auditor.md) | Plaid-specific integration auditor — no client `access_token`, server-side token exchange, webhook signature verification, field-level encryption. | sonnet | Read, Grep, Glob, Bash |

See [`agents/README.md`](agents/README.md) for install steps and which skills invoke each agent.

## `harness/`
The agent-harness methodology these were built with — the full write-up, the three quality loops, and the **flow diagram** live in [`harness/README.md`](harness/README.md).

## License
MIT — see `LICENSE` (if present) or reuse freely.
