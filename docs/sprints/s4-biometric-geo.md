# Sprint 4 — Biometric + Geo Capture

**Goal**: enrich sessions with HR / HRV + start/end location, all local.
**Duration**: 2 weeks.

## Tasks

### S4.1 Permissions UX
- [ ] Explainer screens before Health + Location requests
- [ ] Granular opt-in (Health only / Geo only / both / neither)
- [ ] App degrades gracefully on denial
- **DoD**: all perm combos functional.

### S4.2 HealthService
- [ ] `health` pkg init, HealthKit + Health Connect
- [ ] On start: mark t0, fetch HR + HRV samples `[t0-5m, t0]`
- [ ] On end: fetch samples `[tEnd, tEnd+5m]`
- [ ] Persist `biometric_snapshots` + `biometric_samples`
- **DoD**: snapshot row per finalized session when permitted.

### S4.3 LocationService
- [ ] Coarse-only permission
- [ ] Capture start + end lat/lng + accuracy
- [ ] No continuous tracking
- **DoD**: 2 geo points / session.

### S4.4 Biometric display
- [ ] Session detail: HR avg pre vs during
- [ ] HRV trend sparkline
- [ ] Empty state when no data
- **DoD**: charts render for enriched + empty sessions.

## Deliverables
- Enriched sessions end-to-end.
- Privacy-respecting capture confirmed by manual audit.
