# Personal Context

## Current Focus
- **Main project**: Activation (Jira project key: ACT)

## Defaults
- When creating Jira tickets, default to the ACT project unless specified otherwise

## Code Style Preferences
- **Plain functions over closure factories** — add extra context as explicit parameters, bind at the call site
- **`useMemo` over `useCallback`** for derived functions (not user interaction handlers). Prefix with `memoized`
- **Keep return statements clean** — move logic, closures, and derivations above the return. Prioritize readability over brevity
- **Platform-level fixes** — fix shared components rather than adding per-caller workarounds
- **Testing: `getByLabelText`** over `getByRole("img", { name })` for aria-label queries
- **No ticket/issue references in code comments** (e.g. "ACT-4213", "per VRM-1234"). Comment on what the code does or a non-obvious constraint — not tracking or why-we-did-it provenance.

## Git & GitHub
- **Never commit without my explicit go-ahead.** Make and verify changes (tests, typecheck), then stop and wait for me to approve before running `git commit`.
- **I manage all GitHub interactions.** Don't push, create/update PRs, or post comments/reviews unless I explicitly tell you to do that specific action.

## Meta
- After resolving feedback on plans or code, ask what should be added to this file so the lesson isn't repeated. Adjust existing entries rather than appending to keep the file short.
- Do not use the memory system (`~/.claude/projects/.../memory/`). It doesn't survive devcontainer rebuilds. This file is the durable store for preferences.
