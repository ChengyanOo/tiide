// Tiide — design tokens
// Single humanist serif throughout. Verse gets italic + generous leading.
// Quiet palette. Accent is the one saturated move — tide-metaphor.

const TIIDE_FONT = '"Source Serif 4", "Source Serif Pro", "Iowan Old Style", "Palatino", Georgia, serif';

// Base palette — parchment light, slate-ink dark
const TIIDE_LIGHT = {
  bg: '#f3efe6',         // warm parchment
  bgElev: '#ebe5d8',     // card / grouped bg
  surface: '#fbf8f1',    // raised surface (cards over bg)
  ink: '#1f1b17',        // primary text
  ink2: '#3d3630',       // secondary
  ink3: '#6a6158',       // tertiary
  ink4: '#8f8479',       // quaternary / captions
  hair: 'rgba(31,27,23,0.09)', // hairlines
  hair2: 'rgba(31,27,23,0.05)',
  overlay: 'rgba(31,27,23,0.5)',
};

const TIIDE_DARK = {
  bg: '#0e1217',          // deep dusk
  bgElev: '#151a21',
  surface: '#1b2028',
  ink: '#e8e3d7',
  ink2: '#bfb8a8',
  ink3: '#8b8376',
  ink4: '#5e574c',
  hair: 'rgba(232,227,215,0.10)',
  hair2: 'rgba(232,227,215,0.05)',
  overlay: 'rgba(0,0,0,0.55)',
};

// Accent options — all restrained, tide-adjacent
const TIIDE_ACCENTS = {
  dusk:   { light: '#4a6b7c', dark: '#7fa0b2', name: 'Dusk blue' },
  clay:   { light: '#b8855f', dark: '#d29c77', name: 'Warm clay' },
  moss:   { light: '#5a6b5a', dark: '#8ba18b', name: 'Moss' },
  sand:   { light: '#c89b7b', dark: '#e0b896', name: 'Dawn sand' },
  tide:   { light: '#406670', dark: '#7ea0aa', name: 'Deep tide' },
  amber:  { light: '#9e7238', dark: '#d4a574', name: 'Lamp amber' },
};

// Type scale — UI stays small & quiet. Verse is the one exception.
const TIIDE_TYPE = {
  // UI
  caption: { size: 12, lh: 1.4, tracking: 0.02, weight: 400 },
  meta:    { size: 13, lh: 1.45, tracking: 0.01, weight: 400 },
  body:    { size: 15, lh: 1.5, tracking: 0, weight: 400 },
  bodyM:   { size: 16, lh: 1.55, tracking: 0, weight: 400 },
  title:   { size: 18, lh: 1.35, tracking: -0.005, weight: 500 },
  titleL:  { size: 22, lh: 1.3, tracking: -0.01, weight: 500 },
  display: { size: 28, lh: 1.25, tracking: -0.015, weight: 400 },
  displayL:{ size: 36, lh: 1.2, tracking: -0.02, weight: 400 },
  // Verse (italic, generous)
  verseS:  { size: 18, lh: 1.55, tracking: 0.005, weight: 400, italic: true },
  verseM:  { size: 22, lh: 1.6, tracking: 0.005, weight: 400, italic: true },
  verseL:  { size: 26, lh: 1.6, tracking: 0.005, weight: 400, italic: true },
};

// Motion
const TIIDE_MOTION = {
  tide: 'cubic-bezier(0.42, 0, 0.58, 1)',       // slow sine
  ease: 'cubic-bezier(0.25, 0.1, 0.25, 1)',
  snap: 'cubic-bezier(0.2, 0.9, 0.3, 1)',
};

// Helper to apply type token
function tType(name) {
  const t = TIIDE_TYPE[name] || TIIDE_TYPE.body;
  return {
    fontFamily: TIIDE_FONT,
    fontSize: t.size,
    lineHeight: t.lh,
    letterSpacing: `${t.tracking}em`,
    fontWeight: t.weight,
    fontStyle: t.italic ? 'italic' : 'normal',
  };
}

function useTiideTheme(mode, accentKey) {
  return React.useMemo(() => {
    const pal = mode === 'dark' ? TIIDE_DARK : TIIDE_LIGHT;
    const acc = TIIDE_ACCENTS[accentKey] || TIIDE_ACCENTS.dusk;
    return {
      ...pal,
      accent: mode === 'dark' ? acc.dark : acc.light,
      accentName: acc.name,
      mode,
      font: TIIDE_FONT,
      motion: TIIDE_MOTION,
    };
  }, [mode, accentKey]);
}

Object.assign(window, {
  TIIDE_FONT, TIIDE_LIGHT, TIIDE_DARK, TIIDE_ACCENTS, TIIDE_TYPE, TIIDE_MOTION,
  tType, useTiideTheme,
});
