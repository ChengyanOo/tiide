# Sprint 2 — Zero-Friction Start + Notifications

**Goal**: start a session without opening the app; end via rich notification.
**Duration**: 2 weeks.

## Tasks

### S2.1 iOS Lock Screen Widget
- [ ] Swift WidgetKit target
- [ ] `StartSessionIntent` (App Intents)
- [ ] Deep link `tiide://session/start` via `home_widget`
- **DoD**: tap widget on locked device → session row created.

### S2.2 Android Glance widget + QS tile
- [ ] Glance AppWidget
- [ ] QuickSettings TileService
- [ ] Same deep link, launches foreground service
- **DoD**: start works from widget + tile.

### S2.3 iOS Back-Tap hook
- [ ] Ship Shortcuts action "Start Distress Session"
- [ ] Onboarding doc for user to bind to Back-Tap
- **DoD**: back-tap starts session.

### S2.4 Background timer + foreground service
- [ ] Android: `flutter_background_service` with persistent notification
- [ ] iOS: BGProcessingTask + local notif scheduled T+15min
- [ ] Timer survives app kill
- **DoD**: timer fires even when app force-closed.

### S2.5 Rich end notification
- [ ] Title "Has the wave passed?"
- [ ] Actions: `SAVE_TAG`, `EXTEND_5`
- [ ] Handle action tap in cold + background states
- [ ] `EXTEND_5` reschedules next firing, increments extensionCount
- **DoD**: actions route correctly from all app states.

## Deliverables
- Widget + tile installable.
- End-notification round-trip functional.
