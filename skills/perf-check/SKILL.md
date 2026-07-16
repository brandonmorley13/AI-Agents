---
name: perf-check
description: >
  Score recent changes (or a named file) against the project's performance budgets. Use this skill
  whenever the user asks to "check performance", "perf review", "is this slow", "audit performance",
  "review perf budgets", "check main thread blocking", "performance audit", or before merging any
  change that touches hot paths (data-layer queries, image rendering, lists, network, crypto, JSON
  decode).
---

# Performance check

Read the root rule file and the performance doc. Then review the change (or the file the user named) against:

- Main-thread frame budget — anything over the project's ProMotion/60Hz threshold gets flagged
- Predicate-based fetches (no `.filter { }` after a full fetch)
- Lazy-loading containers for any unbounded data (no eager `ForEach` in a scroll view)
- Image decoding off-main, thumbnails sized correctly
- Structured concurrency tied to view identity, not fire-and-forget `Task` in a lifecycle callback
- Crypto / JSON decode off the main actor
- No new debug-only logging or string formatting on hot paths
- Memory footprint — large fixtures, retained closures, observer cycles
- App-size implications — large bundled assets, unnecessary dependencies

## Output

1. Numbered findings with severity (`CRITICAL` if a budget will likely be exceeded), file + line, specific fix.
2. Estimated impact on each affected performance-doc metric.
3. `VERDICT: PASS` or `VERDICT: BLOCK`.
