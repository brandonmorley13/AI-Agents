# Agents — install & usage

Each file here is a Claude Code **subagent**. To use one in a project:

1. Copy the `.md` into `.claude/agents/` at your project root.
2. Invoke it — via a skill that chains it (see [AI-Skills](https://github.com/brandonmorley13/AI-Skills))
   or a direct request like "run the security-reviewer on this diff".
3. Each returns severity-tagged findings and ends with `VERDICT: PASS` or `VERDICT: BLOCK — <reason>`.

None run automatically — they're invoked on demand, keeping them inside a predictable compute budget.

| Agent | Invoked by skill(s) |
|---|---|
| `code-reviewer` | `feature` (end-of-run review) |
| `security-reviewer` | `security-review`, `pre-launch` |
| `accessibility-checker` | `a11y-check`, `pre-launch` |
| `db-rules-validator` | `pre-launch` |
| `firestore-rules-validator` | (Firestore projects — chain from a pre-launch/security flow) |
| `third-party-api-auditor` | `audit-integration`, `pre-launch` |
| `plaid-auditor` | `audit-plaid` |
