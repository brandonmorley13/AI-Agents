---
name: a11y-check
description: >
  Run the accessibility-checker subagent against SwiftUI views to verify WCAG 2.2 AAA compliance
  and full iOS accessibility-feature parity. Use this skill whenever the user asks to "check
  accessibility", "audit a11y", "is this accessible", "review for VoiceOver", "check Dynamic Type",
  "verify accessibility", "a11y audit", "accessibility review", or after any UI change. Returns
  severity-tagged findings and a PASS/BLOCK verdict.
---

# Accessibility check

Invoke the `accessibility-checker` subagent.

If the user named a specific file or path, target that. Otherwise default to `git diff main...HEAD`.

## The agent should

1. Read the root rule file and the accessibility doc.
2. Score the change/file against the WCAG 2.2 AAA checklist plus iOS-feature parity:
   - `accessibilityLabel` on every interactive element
   - `accessibilityHint` where outcome isn't obvious
   - `accessibilityValue` on stateful controls
   - Dynamic Type tested through the largest accessibility size (no hardcoded sizes)
   - Color contrast ≥ 7:1 body / ≥ 4.5:1 large
   - Target size ≥ 44×44 pt
   - Reduce Motion respected
   - Differentiate Without Color (no color-only signal)
   - Reduce Transparency fallback for glass/translucent materials
   - Focus indicator visible at ≥ 3:1 contrast
   - No time limits (or 80% warning + extension)
   - Error prevention: confirm/reverse/check on legal/financial actions
3. Output: numbered findings with severity, file + line, and a specific SwiftUI fix.
4. End with `VERDICT: PASS` or `VERDICT: BLOCK — N findings AAA-blocking`.

Cite the accessibility doc's rows. If a screen genuinely can't meet a criterion, suggest an entry for a documented-exceptions list rather than relaxing the rule.
