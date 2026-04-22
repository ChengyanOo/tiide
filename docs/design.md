# Tiide — Design Doc

> "Make your effort seen."

Timer app for distress / craving sessions. Passive, low-friction. Makes *not acting* visible. Correlates sessions with geo + biometric to surface triggers.

## Principles
- Zero-friction start (lockscreen widget, Back-Tap, QS tile).
- No raw stopwatch — calming abstract visual + 15-min progress.
- Passive end via rich notification.
- Forgiving retroactive edit.
- Private-first. Local-encrypted. Cloud opt-in.
- Timeboxed — extensions capped.

## Primary User Story
User hit by a craving → taps widget → app starts session in background → sees calming visual → at 15 min gets "Has the wave passed?" notification → saves & tags or extends +5 → later retro-edits if ignored.

See [BDD acceptance criteria](acceptance.md).

## Docs Index
- [Progress log](progress.md)
- [System architecture](diagrams/architecture.md)
- [Session flow](diagrams/session-flow.md)
- [Data model (ERD)](diagrams/data-model.md)
- [Tech stack](stack.md)
- [Privacy](privacy.md)
- [Acceptance criteria](acceptance.md)
- [UI design notes](ui-design.md) · [Redesign mocks (HTML)](redesign/Tiide.html)

## Open Questions
- Cloud provider: Supabase vs Firebase?
- Rive vs Lottie for calming visual?
- Health Connect sampling fallback for low-end Android?
- Retro-edit: "hardest part" separate field from total duration?
