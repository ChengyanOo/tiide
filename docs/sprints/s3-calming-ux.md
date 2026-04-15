# Sprint 3 — Calming Active Screen + Retro Edit

**Goal**: replace stopwatch with calming visual; forgive ignored sessions.
**Duration**: 2 weeks.

## Tasks

### S3.1 Calming visual
- [ ] Choose Rive vs Lottie (spike first 2 days)
- [ ] Breathing circle OR untangling knot asset
- [ ] Progress encoded as animation phase
- [ ] Haptic tick at 5 / 10 / 15 min
- **DoD**: animation syncs to timer ±500 ms.

### S3.2 Hide numeric timer
- [ ] Active screen shows only shape + soft % ring
- [ ] Long-press reveals remaining time (optional)
- **DoD**: no digits visible by default.

### S3.3 Retro-edit sheet
- [ ] Trigger condition: active session w/ null `endedAt` past planned+grace 1 h
- [ ] Slider snaps 5 / 10 / 15 / custom
- [ ] Preview duration label
- [ ] Save writes `actualDurationMin`, outcome = `saved`
- **DoD**: orphaned session resolvable in ≤ 3 taps.

### S3.4 Extend +5 polish
- [ ] Cap `extensionCount ≤ 3` (ceiling 25 min)
- [ ] Disable button after cap with friendly copy
- **DoD**: 4th extension blocked with message.

## Deliverables
- Final active-screen UX.
- Retro-edit flow covering all orphan paths.
