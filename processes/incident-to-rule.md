# Incident → rule loop

How production scar tissue becomes enforceable rules. Every signal from real users — crash reports, performance monitoring, store-review rejections, customer reports — should produce 1–3 rules in the root rule file, an example in `examples/`, or a new linter custom rule.

This loop is what closes the gap between "competent" and "best-in-class veteran."

## The loop

1. **Signal arrives** (crash alert, customer ticket, store review, performance-budget violation, store-review rejection).
2. **Root-cause within 48 hours.** The fix is one thing; the *rule* is another. Always ask: *"What would have prevented an agent or developer from writing this code in the first place?"*
3. **Pick the layer** to enforce at:

   | Failure mode | Best enforcement layer |
   |---|---|
   | Anti-pattern an agent could re-do | Linter custom rule |
   | Conceptual mistake (wrong service, wrong scope) | Root rule file's anti-patterns list + domain doc |
   | Pattern that's hard to express in lint | `examples/bad/` annotated counter-example |
   | Decision-level (we chose wrong) | New architecture decision record |
   | Process gap (missing review step) | New slash command or subagent prompt |

4. **Write the rule the same week.** Capture the rule, not just the fix.

5. **Run the eval harness** against the new rule to make sure it triggers correctly.

## Examples of what this looks like

| Signal | Rule produced |
|---|---|
| Crash report: force-unwrap on a value from a service layer | Linter custom rule banning force-unwraps on protocol returns. |
| Store-review rejection: a lock-screen preview showed sensitive data | A push-notification content policy + a custom rule scanning payloads. |
| Performance monitor: P90 cold launch creeping past budget | New `examples/bad/` showing the slow-launch pattern + a clarification in the performance doc. |
| Customer ticket: an export was missing a data category | New code-reviewer subagent check verifying every collection is included in exports. |

## Quarterly review

Once a quarter:
- List every crash/issue closed since the last review.
- For each, confirm a rule, example, or ADR exists.
- If not, write it now.

## Anti-pattern: fix without rule

Closing an incident without capturing the rule is **the single most expensive failure mode** for long-term code quality. The same agent will write the same bug next month. Always close the loop.
