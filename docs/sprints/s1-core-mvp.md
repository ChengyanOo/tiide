# Sprint 1 — Core Session MVP

**Goal**: user can manually start, stop, tag, and review sessions.
**Duration**: 2 weeks.

## Tasks

### S1.1 Bootstrap project
- [ ] `flutter create tiide` (org id, iOS + Android targets)
- [ ] Add Riverpod, go_router, Drift, `flutter_lints`
- [ ] Theme tokens (colors, typography, spacing)
- [ ] GitHub Actions: `flutter analyze` + `flutter test`
- **DoD**: app launches on both platforms, CI green.

### S1.2 DB schema + SessionRepo
- [ ] Drift tables: `sessions`, `tags`, `session_tags`
- [ ] Migrations + seed default tags
- [ ] `SessionRepo`: create, finalize, list, stream active
- [ ] Unit tests (in-memory DB)
- **DoD**: repo tests ≥ 60% coverage.

### S1.3 Manual start / stop
- [ ] Home screen "Start" button
- [ ] Active view with plain 15-min progress bar
- [ ] Stop writes `actualDurationMin`
- **DoD**: round-trip create→stop→persisted.

### S1.4 Session list
- [ ] Chronological list (date + duration)
- [ ] Empty state
- **DoD**: list updates reactively after save.

### S1.5 Tag picker
- [ ] Seed tags: relationship, habit, social, work, other
- [ ] Multi-select sheet on save
- [ ] Persist `session_tags` rows
- **DoD**: tags visible in list and detail.

## Deliverables
- Runnable MVP (manual flow only).
- README with run/test instructions.
