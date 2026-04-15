# Acceptance Criteria (BDD)

## Zero-Friction Initiation
- **Given** phone locked or on home screen
- **When** user taps Lock Screen Widget / triggers Back-Tap
- **Then** a new Distress Session starts in background without navigating the app

## Timeboxed Session
- **Given** a session just started
- **When** user opens the app
- **Then** they see a calming abstract visual (knot / breathing circle) and a 15-min progress bar — no numeric stopwatch

## Passive End-State
- **Given** an active session hits 15 min
- **When** timer finishes
- **Then** app stops recording and pushes a rich notification *"Has the wave passed?"* with actions **[Save & Tag]** and **[+5 Minutes]**

## Forgiving Edit
- **Given** user ignored the notification and opens the app hours later
- **When** app prompts to save the earlier session
- **Then** user sees a slider snapping to 5 / 10 / 15 min to retroactively estimate the hardest part
