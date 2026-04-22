# Tiide Design System

## 1. Visual Theme & Atmosphere

Tiide is a quiet, serif-first companion app for sitting with cravings and difficult waves. The interface treats the screen as parchment, not glass — warm, matte, and restrained. Every surface leans warm (`#f3efe6` parchment light, `#0e1217` deep-dusk dark) so that the one saturated move — a tide-metaphor accent — feels intentional. The design philosophy is "content recedes, attention rests": the UI stays low-contrast and literary so the user can breathe.

Typography is a single humanist serif throughout — Source Serif 4, with Iowan Old Style / Palatino / Georgia fallbacks. Verse gets italic and generous leading; UI stays compact and quiet. There is no separate display face, no uppercase button voice, no sans-serif accents. The serif carries everything.

Geometry is soft and rounded but never glossy. Buttons are full pills (9999px), cards use 16px radius with hairline borders (`rgba(31,27,23,0.09)`) rather than shadows, and the only circular elements are the identity pulse dot and the ambient progress ring around the session visual. Motion is tidal: a custom `cubic-bezier(0.42, 0, 0.58, 1)` sine curve that matches slow breath cadence, used on wave visuals (9–11s) and breath rings (19s, 4-7-8 pattern).

**Key Characteristics:**
- Warm parchment light (`#f3efe6`) and deep-dusk dark (`#0e1217`) — no pure white, no pure black
- Single serif family (Source Serif 4) for all text; verse gets italic
- Restrained tide-adjacent accent palette (dusk, clay, moss, sand, tide, amber) — one accent per session
- Hairline borders (`rgba(31,27,23,0.09)`) instead of shadows for elevation
- Pill buttons (9999px) and 16px rounded cards; no square corners
- Ambient animated visuals (tide, breath, ink) as the emotional anchor
- Tidal motion curve (`cubic-bezier(0.42, 0, 0.58, 1)`) on slow ambient elements
- Lowercase "tiide" wordmark with a pulsing accent dot

## 2. Color Palette & Roles

### Light (Parchment)
- **Background** (`#f3efe6`): Warm parchment, the base surface
- **Elevated Background** (`#ebe5d8`): Cards / grouped backgrounds
- **Surface** (`#fbf8f1`): Raised surfaces over bg (modals, cards)
- **Ink** (`#1f1b17`): Primary text
- **Ink 2** (`#3d3630`): Secondary text
- **Ink 3** (`#6a6158`): Tertiary text
- **Ink 4** (`#8f8479`): Quaternary / captions
- **Hair** (`rgba(31,27,23,0.09)`): Hairline borders
- **Hair 2** (`rgba(31,27,23,0.05)`): Softest divider
- **Overlay** (`rgba(31,27,23,0.5)`): Modal scrim

### Dark (Dusk)
- **Background** (`#0e1217`): Deep dusk
- **Elevated Background** (`#151a21`): Cards
- **Surface** (`#1b2028`): Raised surface
- **Ink** (`#e8e3d7`): Primary text (warm off-white)
- **Ink 2** (`#bfb8a8`): Secondary
- **Ink 3** (`#8b8376`): Tertiary
- **Ink 4** (`#5e574c`): Quaternary
- **Hair** (`rgba(232,227,215,0.10)`): Hairline borders
- **Hair 2** (`rgba(232,227,215,0.05)`): Softest divider
- **Overlay** (`rgba(0,0,0,0.55)`): Modal scrim

### Accent (choose one per session)
| Key | Light | Dark | Name |
|-----|-------|------|------|
| `clay` | `#b8865f` | `#d29c77` | Warm clay **(default)** |
| `dusk` | `#4a6b7c` | `#7fa0b2` | Dusk blue |
| `moss` | `#5a6b5a` | `#8ba18b` | Moss |
| `sand` | `#c89b7b` | `#e0b896` | Dawn sand |
| `tide` | `#406670` | `#7ea0aa` | Deep tide |
| `amber` | `#9e7238` | `#d4a574` | Lamp amber |

Accent is functional: primary button, active state, progress ring, chip fill, identity pulse. Never decorative.

### Tag Category Colors
Fixed semantic palette for session tags (emotional categories):
- Craving `#b8865f`, Anger `#a05a45`, Anxiety `#6b7c8a`, Loneliness `#7a6b8a`
- Boredom `#8a8467`, Grief `#4a5866`, Relapse `#3d4a4f`, Practice `#5a6b5a`

## 3. Typography Rules

### Font Family
`"Source Serif 4", "Source Serif Pro", "Iowan Old Style", "Palatino", Georgia, serif`

One face. All text. No sans-serif anywhere in the UI.

### Hierarchy

| Role | Size | Line Height | Tracking | Weight | Notes |
|------|------|-------------|----------|--------|-------|
| caption | 12px | 1.40 | 0.02em | 400 | Smallest UI label |
| meta | 13px | 1.45 | 0.01em | 400 | Metadata, secondary meta rows |
| body | 15px | 1.50 | 0em | 400 | Default body |
| bodyM | 16px | 1.55 | 0em | 400 | Larger body |
| title | 18px | 1.35 | -0.005em | 500 | Section title, header |
| titleL | 22px | 1.30 | -0.01em | 500 | Stat numbers, feature head |
| display | 28px | 1.25 | -0.015em | 400 | Display |
| displayL | 36px | 1.20 | -0.02em | 400 | Large display |
| verseS | 18px | 1.55 | 0.005em | 400 *italic* | Verse small |
| verseM | 22px | 1.60 | 0.005em | 400 *italic* | Verse default |
| verseL | 26px | 1.60 | 0.005em | 400 *italic* | Verse large |

### Principles
- **Single face, weight-light**: 400 is the default, 500 only for titles. No bold UI. Emphasis comes from size and italic, not weight.
- **Verse is italic with generous leading**: `line-height: 1.6`, italic, tiny positive tracking. The one place the type relaxes.
- **Lowercase by default**: Labels, wordmark, most titles stay lowercase. Uppercase reserved for section eyebrow labels (`caption` with 0.14–0.18em tracking).
- **Compact UI range**: Most UI sits 12–22px. Verse reaches 26px. Display 28–36px only for hero moments.
- **Negative tracking on larger sizes** (`-0.005em` to `-0.02em`) — serif tightens as it scales.

## 4. Component Stylings

### Primary Pill Button
- Background: `theme.accent`
- Text: `#fff`
- Padding: `14px 34px`
- Radius: `9999px`
- Font: `bodyM` (16px / 1.55 / 400)
- No shadow, no uppercase, no letter-spacing tricks

### Ghost Button
- Background: `transparent`
- Text: `theme.ink3`
- No border
- Font: `meta` (13px / 400)
- Use for "End now", dismiss-like secondary actions

### Chip (tag)
- Padding: `6px 11px` (`m`) or `4px 9px` (`s`)
- Radius: `9999px`
- Selected: `background: color || accent`, white text, no shadow
- Unselected: transparent background, `inset 0 0 0 1px hair` border, `ink2` text, optional 6px color dot prefix
- Transition: `all .25s ease`

### Card (TCard)
- Background: `theme.surface`
- Radius: `16px`
- Border: `1px solid theme.hair2`
- Shadow (light only): `0 1px 0 rgba(0,0,0,0.02)` — barely there
- Dark mode: no shadow

### List Row (TRow)
- Padding: `14px 18px`
- Gap: `14px`
- Border-bottom: `1px solid theme.hair2` (none on last)
- Icon color: `theme.ink3` (stroke 1.2–1.4, currentColor)
- Label: `body`, `theme.ink`
- Sub-label: `meta`, `theme.ink3`, 2px top margin
- Right side: `meta`, `theme.ink3`

### Section Label
- Font: `caption` (12px / 400)
- Color: `theme.ink4`
- `text-transform: uppercase`
- Letter-spacing: `0.14em`
- Padding: `22px 22px 8px`

### Header (TiideHeader)
- Min-height: `44px`, padding: `14px 20px 10px` (or `10px 20px 8px` small)
- Center title: `title` (18px / 500), `theme.ink`
- Left/right slots: 44px wide, `theme.ink2`

### Icons
Hairline SVG, stroke width `1.2–1.4`, `currentColor`, `stroke-linecap: round`, `stroke-linejoin: round`. No filled icons except tiny badges. Sizes typically 14, 16, 18, 20, 22.

### Identity Wordmark
- Lowercase `tiide` + pulsing accent dot
- Italic, weight 400, tracking `-0.01em`
- Sizes: sm 16, md 19, lg 24
- Dot: `size * 0.28`, `animation: tiidePulse 4.5s ease-in-out infinite`

## 5. Layout Principles

### Spacing
No strict 8-point grid. Padding values in use: 2, 4, 6, 8, 10, 11, 14, 16, 18, 20, 22, 28, 30, 34, 58 px. Rhythmic, not rigid.

### Screen Frame
- Target device: iPhone, 402×874 artboard
- Top status bar inset handled by container (`padding-top: 58px` on first content)
- Bottom home-indicator: 34px reserved, 8px bottom padding, 139×5 pill

### Container
- Full-screen screens: flex column, background = `theme.bg`
- Nav header: top row with logo left, icon cluster right (18px gap, `ink3` color)
- Bottom strip: border-top `hair2`, `margin-top: auto` for stats

### Border Radius Scale
- Hairline / chip: `9999` (full pill)
- Button: `9999` (full pill)
- Card: `16`
- Notification / iOS tile: `17`
- Phone frame: `48`
- Dot / identity pulse: `9999`

### Whitespace Philosophy
- **Parchment breathes**: Warm backgrounds plus hairline dividers do the visual separation work — no heavy padding or shadows needed.
- **Content over chrome**: Visuals (tide, breath, ink) are the focal point on active screens; UI sits quietly around them.

## 6. Depth & Elevation

Tiide does not use shadow-based elevation. Depth comes from:

| Level | Treatment |
|-------|-----------|
| Base | `theme.bg` (`#f3efe6` / `#0e1217`) |
| Grouped / card backing | `theme.bgElev` |
| Raised surface | `theme.surface` + `1px solid theme.hair2` |
| Modal / sheet | `theme.surface` + `theme.overlay` scrim behind |
| iOS notification (vibrancy) | `rgba(28,28,32,0.7)` + `backdrop-filter: blur(28px)` + `0.5px solid rgba(255,255,255,0.08)` |

The only shadow in the system is the phone-frame mockup shadow (`0 40px 80px rgba(0,0,0,0.18)`) used in the design canvas, not in the product.

## 7. Motion

Curves:
- `tide`: `cubic-bezier(0.42, 0, 0.58, 1)` — slow sine, used on ambient visuals
- `ease`: `cubic-bezier(0.25, 0.1, 0.25, 1)` — standard
- `snap`: `cubic-bezier(0.2, 0.9, 0.3, 1)` — brief, for controls

Durations:
- Wave cycles: 9s, 11s (tide visual)
- Breath ring: 19s total (4-7-8 inhale-hold-exhale cadence, keyTimes `0; 0.21; 0.58; 0.79; 1`)
- Ink drift: 14–21s
- Identity pulse: 4.5s
- Progress ring update: `transition: stroke-dashoffset 1.6s linear`
- UI transitions: `0.25s ease`

**Motion philosophy**: Slow, tidal, never attention-seeking. Nothing snaps or bounces. The app is a companion for difficult moments — motion should feel like breath, not notification.

## 8. Ambient Visuals

Three interchangeable metaphor visuals (`__TIIDE_VISUAL_KIND`), all SVG + SMIL, no libraries:

- **TideVisual**: Horizon with sun/moon + two animated wave paths. Radial sky gradient, linear sea gradient. Mix-blend `multiply` (light) or `screen` (dark).
- **BreathVisual**: 4 concentric rings + inner disc, pulsing on a 4-7-8 cadence (19s). Stroke widths 0.8 + stepped.
- **InkVisual**: 3 blurred radial-gradient clouds drifting (14–21s) on a gaussian-blur filter.

All accept `size`, `accent`, `dark`, `paused`. All pause animations when `paused=true`.

**ProgressRing**: Ambient, no tick marks. Thin stroke (1.5–2px), `stroke-linecap: round`, rotates -90°. Used around the session visual on Active screen — the only UI progress indicator in the app.

## 9. Do's and Don'ts

### Do
- Use warm parchment / deep dusk — never pure white (`#fff`) or pure black (`#000`) for surfaces
- Keep one serif family everywhere — verse gets italic
- Pill (9999px) all buttons, 16px radius cards
- Use hairline borders (`hair`, `hair2`) for separation — not shadows
- Keep motion tidal: long durations, sine curves, no snaps
- Reserve accent for function (primary button, progress, selected state)
- Write lowercase labels; uppercase only for `caption` section eyebrows with wide tracking

### Don't
- Don't add a sans-serif anywhere — no system font, no Helvetica, no SF fallbacks in body/UI
- Don't use bold weights for UI — 400 default, 500 for titles only
- Don't use shadows for elevation — hairlines and surface tones do the work
- Don't make motion quick or bouncy — the app is calming, not energetic
- Don't introduce new accent colors — the six-accent palette is the full set
- Don't use uppercase on buttons or tracking > 0.02em on body text
- Don't use iOS-style nav bars — TiideHeader is the house chrome

## 10. Agent Prompt Guide

### Quick Color Reference (light / clay accent)
- Background: Parchment (`#f3efe6`)
- Surface: `#fbf8f1`
- Text: Ink (`#1f1b17`)
- Secondary: Ink 3 (`#6a6158`)
- Accent: Warm clay (`#b8865f`)
- Hairline: `rgba(31,27,23,0.09)`

### Example Component Prompts
- "Create a Tiide card: `#fbf8f1` background, 16px radius, `1px solid rgba(31,27,23,0.05)` border, no shadow. Title at 18px Source Serif 4 weight 500, ink `#1f1b17`. Sub at 13px weight 400, ink3 `#6a6158`."
- "Design a pill button: `#b8865f` (clay) background, white text, 9999px radius, 14px 34px padding. 16px Source Serif 4 weight 400, no uppercase."
- "Build a tag chip: 9999px radius, 6px 11px padding. Unselected: transparent bg, inset 1px `rgba(31,27,23,0.09)` border, ink2 text, 6px color dot. Selected: accent fill, white text, no border."
- "Create a list row: 14px 18px padding, 14px gap, border-bottom `1px solid rgba(31,27,23,0.05)`. Icon stroke 1.2 in ink3. Label 15px serif. Transition 0.25s ease."
- "Verse typography: Source Serif 4 italic, 22px, line-height 1.6, tracking 0.005em, weight 400, ink color."

### Iteration Guide
1. Start parchment (`#f3efe6`) or dusk (`#0e1217`) — never pure neutrals
2. One serif, mostly 400 weight, italic for verse
3. Pill buttons, 16px cards, hairline borders — no shadows
4. Pick one accent per session (clay `#b8865f` default) — functional only
5. Motion tidal and long (9–19s ambient, 0.25–1.6s UI)
6. Ambient visual (tide/breath/ink) is the emotional anchor — UI stays quiet around it
