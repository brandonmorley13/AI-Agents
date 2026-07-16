# Eval harness

A regular check that the root rule set holds and that the review subagents catch what they should **when explicitly invoked** (they don't run proactively — see the "why nothing runs automatically" note in the README). Without this loop, the rule set drifts from reality and you don't notice until production fails.

## The idea

Maintain a fixed set of ~15–20 representative prompts in `evals/prompts.md`. Each has an expected behavior (what should happen if the rules are followed). Run them quarterly. Score the output. Refine the rules where compliance dropped.

This is the only way to **measure** rule effectiveness instead of guessing.

## What "good" looks like

| Metric | Target |
|---|---|
| Anti-pattern catches (e.g., agent uses a banned pattern and gets blocked or warned) | ≥ 95% |
| Doc citations correct (cited section actually contains the rule) | ≥ 90% |
| `code-reviewer` subagent finds the seeded violation | ≥ 95% |
| Slash command triggers the right subagent | 100% |
| Time to complete representative tasks (median) | within 25% of baseline |

## How to run

1. Open `evals/prompts.md`. Start a fresh session in the repo (no prior conversation).
2. For each prompt, run it as-is. Capture the response.
3. Compare to `evals/expected.md` (your notes on what should happen). Score 1 = pass, 0.5 = partial, 0 = fail.
4. Tally per category (security, accessibility, performance, AI, anti-patterns, naming, workflow).
5. Where compliance < 80%, refine the rule: tighten language, add an example, surface it higher in the root rule file, add to the anti-patterns list, or write a linter custom rule.

A thin runner script that opens each prompt in turn is useful, but manual scoring is still required — automating the scoring itself would need a separate harness.

## Cadence

- **Quarterly** baseline run on a calm week.
- **Whenever you ship a new root-rule change / subagent / slash command** as a smoke test.
- **After every model version bump** to verify the tier mapping still holds.

## Don't

- Don't change the prompts to make them easier. The prompts capture the bar; if compliance is low, fix the rules, not the prompts.
- Don't run the eval the same week as a release — it's not a release gate, it's a long-cycle quality signal.

## File layout

```
evals/
  prompts.md     <-- 15–20 representative tasks
  expected.md    <-- expected outputs / behaviors (your private rubric)
  results/
    YYYY-QN.md   <-- one file per quarterly run, with scores + lessons
```
