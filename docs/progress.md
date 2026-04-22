# Tiide — Progress Log

Running state of the app. Update as redesign rolls out.

## Shipped (MVP — S1–S6)
- Core session loop: start → active → notif → save/extend → retro-edit.
- Zero-friction entry: lockscreen widget, deep-links, background service.
- Calming visual (breathing circle) + 15-min progress.
- Biometric (HealthKit / Health Connect) + coarse geo opt-in, session-only.
- Dashboard + cluster screen.
- Privacy center (export JSON, delete-all).
- Onboarding (legacy 4-step flow — now replaced, see below).

## Redesign (in progress)

Mockups live in [redesign/Tiide.html](redesign/Tiide.html). Source JSX in
[redesign/src](redesign/src). Palette: warm cream bg, clay accent, serif
italic wordmark, lowercase.

### Done
- **Theme** — [lib/core/theme.dart](../tiide/lib/core/theme.dart). New cream/clay palette,
  serif italic text styles, `TiideLogo` widget. Legacy dark-mode aliases removed;
  all screens migrated to new tokens (`ink`/`ink2–4`, `bg`, `surface`, `surfaceElev`,
  `hair`, `hair2`, `accent`, `accentSoft`).
- **Onboarding** — 3 steps (philosophy · entry-points · verse picker) per mockup.
  Routes to `/permissions` on finish when platform supports enrichment.
- **Permissions explainer** — per-permission cards (heart-rate/HRV + location) with
  italic body + meta note + `not now`/`allow` buttons.
- **Settings** — sectioned cards (session · data & privacy · appearance · your data)
  with inline toggles, swatches, chevrons, footer note.
- **Verse library** — new screen at `/verses`. Tabs (browse/saved/custom), preview
  card, category toggles, cadence picker (off/slow/default), browse list.

### Not yet redesigned (still use new palette but old layouts)
- Home screen — mockup has big circular "sit" button + bottom stats strip (streak /
  today / avg) + nav row (dashboard / list / settings icons). See
  [redesign/src/screens/home.jsx](redesign/src/screens/home.jsx).
- Active session screen — mockup in [redesign/src/screens/active.jsx](redesign/src/screens/active.jsx).
- Dashboard / cluster — [redesign/src/screens/dashboard.jsx](redesign/src/screens/dashboard.jsx).
- Session list + detail — [redesign/src/screens/sessions.jsx](redesign/src/screens/sessions.jsx).
- Retro-edit sheet — currently uses old layout; redesign has `DurationSnap` 5/10/15.
- Privacy center screen — still functional but not restyled beyond palette.
- Tag picker sheet — palette only.

### External surfaces (separate from Flutter)
- iOS lockscreen widget, notification, Control Center tile — see
  [redesign/src/screens/entrypoints.jsx](redesign/src/screens/entrypoints.jsx).
  Native widget code lives in the iOS project; redesign not applied yet.

## Open questions
- Serif font: using system `Georgia` fallback. Bundle a real serif (e.g. Newsreader,
  EB Garamond) before store submission?
- Dark-mode / "dusk · auto" toggle in settings is wired to a stub; no actual
  dark theme implemented yet.
- Verse library data is hard-coded sample strings — not yet persisted.
- Cloud sync toggle in settings is UI-only.

## Known TODOs after redesign
- Wire home screen nav icons → dashboard / list / settings (mockup shows them
  inline, not in AppBar).
- Home "bottom strip" stats need real data from session repo.
- Replace `TiideColors.accentSoft` hardcoded alpha with proper swatch system if
  more accent choices added.
