# Context engineering

Why the root rule file stays slim, and where the detail actually lives.

## The problem

An agent that reads everything on every task burns tokens on context it doesn't need and loses focus in the process — the rule that matters for the file being touched gets buried under forty rules for files that aren't. A root rule file that tries to be exhaustive becomes a wall nobody (human or agent) actually reads closely.

## The shape

- **Root rule file** — invariants + a routing table. One row per area: "if you're working in X, read Y first, and Z if you need more." Nothing else. If a rule only applies to one folder, it doesn't belong at the root.
- **Per-folder leaves** — a `CLAUDE.md` (or equivalent) inside the folder it governs, summarizing the rules for that area specifically. An agent editing that folder reads the leaf before anything else; the leaf usually says enough on its own.
- **Domain docs** (`docs/*.md` or equivalent) — one file per cross-cutting concern (security, performance, accessibility, AI, backend). Loaded only when the change actually touches that concern, not on every task.
- **Policy docs** — anything with real compliance weight (data retention, incident response) gets its own file, opens with a short TL;DR for agents, and the full text loads only when the change edits that policy area.

## The routing table

The root file's routing table is the single most load-bearing artifact in the whole scheme. Format: a table with "working in…" / "read first" / "then if needed" columns. It has to stay accurate — a stale routing table is worse than none, because it actively points the next session at the wrong doc.

## Token-cost argument

Reading is not free. A root file plus every domain doc plus every leaf, read on every single task regardless of relevance, doesn't just cost tokens — it drowns the two or three rules that actually apply to this diff inside dozens that don't, and the ones that matter are the ones most likely to get missed. Loading on demand keeps the ratio of "rules read" to "rules relevant" close to 1:1.

## Focus argument

Beyond cost: a shorter, more relevant context produces better output. An agent given the security doc right before writing security-sensitive code applies it more reliably than one that read the security doc forty tool calls ago, buried under everything else read since.

## Maintaining it

- When a rule stops applying to the whole project and starts applying to one area, move it from the root file to that area's leaf.
- When a leaf grows past what a "summary" should be, split the detail into a domain doc and have the leaf point to it.
- Review the routing table whenever a folder is added, renamed, or merged — it's the thing most likely to silently go stale.
