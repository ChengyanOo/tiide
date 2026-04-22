# Claude Instructions — Tiide

**Always read [docs/](docs/) first before making changes.** The folder is the
source of truth for product intent, architecture, and current progress. Start
here every session:

1. [docs/design.md](docs/design.md) — principles, primary user story, docs index.
2. [docs/progress.md](docs/progress.md) — what's shipped, what's in-flight, open
   questions. Update this after non-trivial changes so the next session has context.
3. [docs/redesign/](docs/redesign/) — mockups and JSX source of truth for UI.
   Flutter screens should match these.
4. [docs/diagrams/](docs/diagrams/), [docs/stack.md](docs/stack.md),
   [docs/privacy.md](docs/privacy.md), [docs/acceptance.md](docs/acceptance.md)
   — architecture, tech stack, privacy model, BDD criteria.

## Project layout
- Flutter app: [tiide/lib/](tiide/lib/)
  - `core/` — theme, permissions, session controller, services.
  - `features/` — one folder per feature (home, session, onboarding, settings,
    dashboard, tag).
  - `data/` — Drift database.
  - `app/` — router + providers.
- Docs: [docs/](docs/)

## Conventions
- Palette + typography: [tiide/lib/core/theme.dart](tiide/lib/core/theme.dart).
  Use `TiideColors` / `TiideSpacing` / `TiideRadius` tokens — no raw hex or
  magic numbers in screens.
- Lowercase UI copy, serif italic for titles, match the redesign mocks.
- Routes live in [tiide/lib/app/router.dart](tiide/lib/app/router.dart).
- Keep code clean: no redundant aliases, dead code, or commented-out blocks
  after a refactor.

## When finishing work
- Run `flutter analyze` from `tiide/` — must be clean.
- If behavior or screens changed, update [docs/progress.md](docs/progress.md).
- Commit only when asked.
