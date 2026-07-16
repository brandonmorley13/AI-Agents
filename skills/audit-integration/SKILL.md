---
name: audit-integration
description: >
  Run the third-party-api-auditor subagent over the full surface of a third-party financial/data-API
  integration — client, server, database, and hosting. Use this skill whenever the user asks to
  "audit the integration", "review the vendor integration", "check the API setup", "verify
  integration security", "make sure the connection is correct", "audit my integration code", or
  before any beta build / after any integration-touching PR. Returns severity-tagged findings and
  a PASS/BLOCK verdict.
---

# Integration audit

Invoke the `third-party-api-auditor` subagent. The agent reviews the entire integration surface, not a single diff.

## The agent should

1. Read the root rule file, the conventions doc, the security doc, the backend doc, and the vendor's own developer policy.
2. Audit:
   - **Client:** the connection-manager and connection-service types. Verify the client never holds a long-lived access token; session/link tokens fetched fresh per attempt; OAuth chain (app-site-association → app delegate → scene delegate) intact.
   - **Server:** token exchange happens server-side; webhooks verified via signature + key-set lookup; error responses sanitized before reaching the client; retries use backoff + jitter.
   - **Database:** vendor item/account identifiers and balances encrypted at the field level; access tokens stored encrypted server-side; security rules block client writes to token or encrypted-field paths.
   - **Hosting:** OAuth callback rewrite + app-site-association content-type configured.
3. Output: numbered findings with severity, file + line, and specific fix.
4. End with `VERDICT: PASS` or `VERDICT: BLOCK — <reason>`. BLOCK if any `CRITICAL` (e.g., a long-lived token reachable from the client) is open.
