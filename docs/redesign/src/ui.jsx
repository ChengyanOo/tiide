// Tiide — small UI primitives shared across screens.
// Tiny status bar, chrome rows, icons, tag chips, etc.

// --- Icons (hairline, low-contrast) ---
const TI = {
  dashboard: (s=20, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 14a9 9 0 1 1 18 0" /><path d="M12 14l5-4" /><circle cx="12" cy="14" r="1.4" fill={c} stroke="none" />
    </svg>
  ),
  list: (s=20, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2" strokeLinecap="round">
      <path d="M4 7h16M4 12h16M4 17h10" />
    </svg>
  ),
  settings: (s=20, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2">
      <circle cx="12" cy="12" r="3" /><path d="M12 2v2M12 20v2M2 12h2M20 12h2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4" strokeLinecap="round"/>
    </svg>
  ),
  back: (s=22, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
      <path d="M15 5l-7 7 7 7" />
    </svg>
  ),
  close: (s=20, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round">
      <path d="M6 6l12 12M18 6L6 18" />
    </svg>
  ),
  chevRight: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round">
      <path d="M9 6l6 6-6 6" />
    </svg>
  ),
  check: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round">
      <path d="M5 12l4 4 10-10" />
    </svg>
  ),
  plus: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.4" strokeLinecap="round">
      <path d="M12 5v14M5 12h14" />
    </svg>
  ),
  drop: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2">
      <path d="M12 3c4 5 6 8 6 11a6 6 0 0 1-12 0c0-3 2-6 6-11z"/>
    </svg>
  ),
  leaf: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 4c-8 0-14 4-14 12 0 2 1 4 4 4 8 0 14-6 14-14 0 0-1-2-4-2z"/>
      <path d="M6 20c2-6 7-11 13-14"/>
    </svg>
  ),
  pin: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinejoin="round" strokeLinecap="round">
      <path d="M12 22s7-7 7-12a7 7 0 0 0-14 0c0 5 7 12 7 12z"/><circle cx="12" cy="10" r="2"/>
    </svg>
  ),
  heart: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinejoin="round" strokeLinecap="round">
      <path d="M12 20s-7-5-7-11a4 4 0 0 1 7-2.5A4 4 0 0 1 19 9c0 6-7 11-7 11z"/>
    </svg>
  ),
  book: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2" strokeLinejoin="round">
      <path d="M4 5c3 0 5 1 8 3 3-2 5-3 8-3v14c-3 0-5 1-8 3-3-2-5-3-8-3V5z"/>
      <path d="M12 8v14"/>
    </svg>
  ),
  bookmark: (s=14, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinejoin="round">
      <path d="M6 3h12v19l-6-4-6 4z"/>
    </svg>
  ),
  shuffle: (s=14, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round" strokeLinejoin="round">
      <path d="M3 6h4l10 12h4M3 18h4l3-4M14 10l3-4h4M20 3l2 3-2 3M20 15l2 3-2 3"/>
    </svg>
  ),
  wave: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round">
      <path d="M2 12c2-3 4-3 6 0s4 3 6 0 4-3 6 0M2 17c2-3 4-3 6 0s4 3 6 0 4-3 6 0"/>
    </svg>
  ),
  moon: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round" strokeLinejoin="round">
      <path d="M20 14a8 8 0 1 1-10-10 6 6 0 0 0 10 10z"/>
    </svg>
  ),
  sun: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round">
      <circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M2 12h2M20 12h2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M4.9 19.1l1.4-1.4M17.7 6.3l1.4-1.4"/>
    </svg>
  ),
  download: (s=16, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.3" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 4v12M6 12l6 6 6-6M4 20h16"/>
    </svg>
  ),
  heart2: (s=18, c='currentColor') => (
    <svg width={s} height={s} viewBox="0 0 24 24" fill="none" stroke={c} strokeWidth="1.2" strokeLinejoin="round">
      <path d="M3 12h3l2-5 3 10 2-7 2 4h6"/>
    </svg>
  ),
};

// Header chrome for an in-app screen — not using IOSNavBar (too Apple)
function TiideHeader({ title, left, right, theme, small = false }) {
  return (
    <div style={{
      display: 'flex', alignItems: 'center',
      padding: small ? '10px 20px 8px' : '14px 20px 10px',
      gap: 14, minHeight: 44,
    }}>
      <div style={{ width: 44, display: 'flex', justifyContent: 'flex-start', color: theme.ink2 }}>{left}</div>
      <div style={{
        flex: 1, textAlign: 'center', color: theme.ink,
        ...tType(small ? 'title' : 'title'),
      }}>{title}</div>
      <div style={{ width: 44, display: 'flex', justifyContent: 'flex-end', color: theme.ink2 }}>{right}</div>
    </div>
  );
}

// Identity bar — used on Home
function TiideLogo({ theme, size = 'lg' }) {
  const fs = size === 'lg' ? 24 : size === 'md' ? 19 : 16;
  return (
    <div style={{
      display: 'inline-flex', alignItems: 'baseline',
      fontFamily: theme.font, fontSize: fs, fontWeight: 400,
      letterSpacing: '-0.01em', color: theme.ink, fontStyle: 'italic',
    }}>
      tiide<IdentityPulse color={theme.accent} size={Math.round(fs * 0.28)} />
    </div>
  );
}

// Tag chip
function TiideChip({ label, color, selected, onClick, theme, size = 'm' }) {
  const pad = size === 's' ? '4px 9px' : '6px 11px';
  const fs = size === 's' ? 12 : 13;
  return (
    <button onClick={onClick} style={{
      border: 'none', background: selected ? (color || theme.accent) : 'transparent',
      color: selected ? '#fff' : theme.ink2,
      fontFamily: theme.font, fontSize: fs, fontWeight: 400,
      padding: pad, borderRadius: 9999, cursor: 'pointer',
      boxShadow: selected ? 'none' : `inset 0 0 0 1px ${theme.hair}`,
      transition: 'all .25s ease', letterSpacing: '0.005em',
      display: 'inline-flex', alignItems: 'center', gap: 6,
    }}>
      {color && !selected && <span style={{ width: 6, height: 6, borderRadius: 9999, background: color }} />}
      {label}
    </button>
  );
}

// List row
function TRow({ theme, icon, label, right, onClick, children, last }) {
  return (
    <div onClick={onClick} style={{
      display: 'flex', alignItems: 'center', gap: 14,
      padding: '14px 18px', borderBottom: last ? 'none' : `1px solid ${theme.hair2}`,
      cursor: onClick ? 'pointer' : 'default',
    }}>
      {icon && <div style={{ color: theme.ink3, display: 'flex' }}>{icon}</div>}
      <div style={{ flex: 1, color: theme.ink, ...tType('body') }}>
        {label}
        {children && <div style={{ color: theme.ink3, ...tType('meta'), marginTop: 2 }}>{children}</div>}
      </div>
      {right && <div style={{ color: theme.ink3, ...tType('meta'), display: 'flex', alignItems: 'center', gap: 6 }}>{right}</div>}
    </div>
  );
}

// Section label (parchment divider)
function TSectionLabel({ children, theme }) {
  return (
    <div style={{
      ...tType('caption'), color: theme.ink4,
      textTransform: 'uppercase', letterSpacing: '0.14em',
      padding: '22px 22px 8px',
    }}>{children}</div>
  );
}

// Card
function TCard({ theme, children, style }) {
  return (
    <div style={{
      background: theme.surface, borderRadius: 16,
      boxShadow: theme.mode === 'dark' ? 'none' : '0 1px 0 rgba(0,0,0,0.02)',
      border: `1px solid ${theme.hair2}`,
      ...style,
    }}>{children}</div>
  );
}

// Tag palette (category color coded)
const TAG_COLORS = {
  craving:   '#b8855f',
  anger:     '#a05a45',
  anxiety:   '#6b7c8a',
  loneliness:'#7a6b8a',
  boredom:   '#8a8467',
  grief:     '#4a5866',
  relapse:   '#3d4a4f',
  practice:  '#5a6b5a',
};

const TAG_CATS = {
  'How it felt':   ['anger', 'anxiety', 'loneliness', 'boredom', 'grief', 'craving'],
  'What I did':    ['walked', 'breathed', 'called someone', 'sat with it', 'prayed'],
  'Where':         ['home', 'work', 'car', 'bar', 'family'],
  'Trigger':       ['tiredness', 'conflict', 'news', 'memory'],
};

Object.assign(window, {
  TI, TiideHeader, TiideLogo, TiideChip, TRow, TSectionLabel, TCard,
  TAG_COLORS, TAG_CATS,
});
