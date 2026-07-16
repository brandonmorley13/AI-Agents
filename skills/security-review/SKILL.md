---
name: security-review
description: >
  Run the security-reviewer subagent over a file or recent diff. Use this skill whenever the user
  asks to "security review this", "check this for security issues", "audit security on", "review
  auth changes", "scan for security problems", "make sure this is secure", "is this safe to ship",
  or before any merge that touches auth, third-party API integrations, database security rules,
  server functions, encryption, secrets, logging, or money-movement paths. Returns severity-tagged
  findings and a PASS/BLOCK verdict.
---

# Security review

Invoke the `security-reviewer` subagent.

If the user named a specific file or path, target that. Otherwise default to `git diff main...HEAD`.

## The agent should

1. Read the root rule file, the security doc, and the relevant compliance policies.
2. Score the change/file against the security checklist:
   - Secrets storage (platform keychain vs. plain preferences vs. in-memory)
   - Authentication / biometric re-auth gates
   - MFA bypass paths
   - TLS / transport-security configuration
   - PII in logs (privacy-scoped interpolation)
   - PII in error messages
   - Encryption of sensitive database fields
   - Third-party access tokens kept server-side only
   - AI prompt sanitization
   - Database security-rules coverage
3. Output: numbered findings with severity (`CRITICAL`, `HIGH`, `MEDIUM`, `LOW`, `INFO`), file path, line range (if applicable), and a specific fix.
4. End with `VERDICT: PASS` or `VERDICT: BLOCK — N CRITICAL, M HIGH open`.

Cite policy sections by file + section number.
