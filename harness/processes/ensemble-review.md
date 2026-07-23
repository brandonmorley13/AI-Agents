# Multi-lens ensemble review (for high-stakes work)

> **Invoke-only.** This panel never runs automatically. Trigger it deliberately for the high-stakes categories below — it costs ~3× a single review and works against the usage cap.

For changes that touch money paths, security-sensitive code, database security rules, and store submissions, a single review pass can miss blind spots. The panel runs the same diff through **three model tiers with different prompt scaffolds (lenses)** and takes the **union** of CRITICAL + HIGH findings:

| Lens | Model tier | Prompt scaffold |
|---|---|---|
| Correctness | Top tier | "Find logic errors, broken invariants, wrong state transitions." |
| Security / abuse | Top tier (or mid tier for smaller diffs) | "Assume an attacker. Find auth gaps, secret leaks, missing server-side checks, PII exposure." |
| Repro / does-it-ship | Cheapest tier | "Walk the change as a user/QA. What breaks at runtime, offline, or at scale?" |

Diversity of *scaffold* is what catches what redundancy can't — three identical prompts add little. Tier choice keeps the cheap lenses cheap.

## When to use it

- Money-movement code (initiates a transaction, transfer, or balance update)
- Security-sensitive changes (auth, strong-auth gating, encryption, third-party token handling, key escrow)
- Database security-rule changes (esp. any minors/consent write-gate)
- Account deletion / data export changes
- Store submission packets (binary changes, privacy answers/manifest, marketing copy)
- Any architecture decision that touches the categories above

**Don't use it for** routine feature work, UI tweaks, or doc edits — a single focused review (or no review) is the right cost there.

## How

For a code review:

1. Pick the change (a PR diff, a function, a flow).
2. Run each lens as a separate pass — either three separate agent calls with the scaffolds above, or three sequential review prompts naming the lens. Save each output.
3. Take the **union of CRITICAL and HIGH findings** across the three.
4. For each finding, decide: fix, accept-with-rationale-in-PR, or false-positive.

## Capture the false-positives

When one lens flags something the others don't and you judge it a false positive, **write down why**:
- The rule isn't in the root rule file and should be → add it.
- The lens hallucinated a convention the project doesn't follow → note it so future panels don't repeat it.
- The lens is right and the others missed it → now you know which scaffold to weight on this category.

## Limits

- **Diminishing returns past three lenses.** Correctness + security + repro is the practical set.
- **Cost is real** — reserve for genuine high-stakes work; the usage cap is the binding constraint.
- **No lens knows the codebase's history.** Architecture decision records are still the source of "why is this here." The panel catches violations against rules, not missing context.

## Quarterly: measure agreement

For the last quarter's panel reviews: what was each lens's unique catch rate? If one scaffold is consistently a waste, drop it. If one dominates a category, note it here.
