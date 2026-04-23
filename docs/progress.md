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
[redesign/src](redesign/src). Palette: warm cream bg, **ink** accent
(`#1C2936` — deep sumi blue-black), serif italic wordmark, lowercase.
All screens now migrated; the clay accent is gone.

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

### Done (redesign pass 2 — "ink")
- **Palette shift** — accent flipped from warm clay to ink `#1C2936`. Whole app
  reads as black ink on warm parchment now. `TiideColors.accent` /
  `accentSoft` are the only touch points.
- **Home** — [lib/features/home/home_screen.dart](../tiide/lib/features/home/home_screen.dart).
  `TiideLogo` + nav icons row, big 240px "sit" circle with nested hairlines +
  soft accent radial gradient, bottom strip pulls streak / today / avg from
  session list. Resume state shows "session in progress" + elapsed +
  resume pill.
- **Active session** — [lib/features/session/active_screen.dart](../tiide/lib/features/session/active_screen.dart).
  Full-bleed dark `#0E1217` bg, breathing ambient glow with faint progress
  ring, verse + attribution at bottom, glass close button top-left, "tiide"
  wordmark centered, wave icon right. Long-press anywhere reveals remaining
  time. `+5 min` ghost button + `end now` filled pill.
- **Retro-edit sheet** — [lib/features/session/retro_edit_sheet.dart](../tiide/lib/features/session/retro_edit_sheet.dart).
  `DurationSnap` 5/10/15 rail with big serif value on top, discard / save row.
- **Tag picker sheet** — [lib/features/tag/tag_picker_sheet.dart](../tiide/lib/features/tag/tag_picker_sheet.dart).
  Categorised sections (uppercase label), pill chips with colored dot +
  selected-state tint from `tag_colors.dart`.
- **Privacy center** — [lib/features/settings/privacy_center_screen.dart](../tiide/lib/features/settings/privacy_center_screen.dart).
  Sectioned ink cards (storage · your data), status rows with italic detail,
  action rows with chevrons, italic footer.
- **Cluster screen** — [lib/features/dashboard/cluster_screen.dart](../tiide/lib/features/dashboard/cluster_screen.dart).
  Now "places" — intro line, ink cards with circle place icon, rename sheet
  restyled to match.

### Looking-back surfaces (dashboard · sessions · detail)
- **Dashboard** — [lib/features/dashboard/dashboard_screen.dart](../tiide/lib/features/dashboard/dashboard_screen.dart).
  KPI row (sessions · sit-time · day streak), 28-day "days sat with it" grid, 7×24
  time-of-day heatmap, insight cards (clay left rule), tag bar with dots, duration
  histogram highlighting the mode, places card with mini map + cluster list.
  Most-saved verses strip deferred until verses are persisted.
- **Sessions list** — [lib/features/session/list_screen.dart](../tiide/lib/features/session/list_screen.dart).
  Grouped by today/yesterday/weekday bucket, accent/muted time ring, tag pills with
  colored dots, italic place label from geo cluster, orphaned inline tag.
- **Session detail** — [lib/features/session/session_detail_screen.dart](../tiide/lib/features/session/session_detail_screen.dart).
  Hero summary (time caps, big serif duration, ended-at line), tappable breathing
  replay card with progress scrubber, HR·HRV chart (pre vs during) + HR pre/during
  + HRV gain stats, filled tag chips with note, place card with cluster label. Edit
  opens the retro-edit sheet.
- Shared helpers — `lib/core/tag_colors.dart` and `lib/core/format.dart`
  (lowercase date buckets, 12h time, short duration, MM:SS countdown).

### Refactor pass (clarity)
- Pulled the repeated "ink-card-with-hair2-border" container into
  [lib/shared/ink_card.dart](../tiide/lib/shared/ink_card.dart); same for the
  uppercase section label ([eyebrow.dart](../tiide/lib/shared/eyebrow.dart))
  and the bottom-sheet drag handle ([sheet_drag_handle.dart](../tiide/lib/shared/sheet_drag_handle.dart)).
  Dashboard, session detail, privacy center, settings, retro-edit, tag picker,
  and cluster rename all consume the shared widgets now.
- `TiideColors.mapCanvas` token replaces the scattered `0xFFE9E2D2` literal.
- `ProgressIndicatorTheme` defaults the spinner to the accent, so loading
  states no longer pass `color:` per call.
- `formatMMSS` lives in `core/format.dart` and is reused by the active-screen
  remaining-time overlay and the session-detail replay scrubber.

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
- Replace `TiideColors.accentSoft` hardcoded alpha with proper swatch system if
  more accent choices added.
- Dashboard "most saved verses" + session detail "verses that accompanied" strip:
  skipped until per-session verse persistence lands.
- Session detail place card shows a stub map dot — swap for a real cluster plot
  once clustering geometry is available client-side.
- Active-screen verse list is hard-coded in the file — swap for per-session verse
  from verse library once persisted.
- `BreathingCircle` widget now only used by session detail replay; if replay ever
  matures to full ink aesthetic, consider folding it into the ambient painter.
