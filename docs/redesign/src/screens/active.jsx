// Tiide — Active session (full-bleed, dark by default) + post-session tag sheet

function ActiveSession({ theme, progress = 0.42, verseIndex = 0, onEnd }) {
  const VisualKind = window.__TIIDE_VISUAL_KIND || 'tide';
  const [vIdx, setVIdx] = React.useState(verseIndex);
  const verse = TIIDE_VERSES[vIdx % TIIDE_VERSES.length];

  // Dark theme for active session — always
  const t = window.useTiideTheme('dark', theme.__accentKey || 'dusk');

  return (
    <div style={{
      height: '100%', background: t.bg, color: t.ink,
      position: 'relative', overflow: 'hidden',
    }}>
      {/* full-bleed visual */}
      <div style={{
        position: 'absolute', inset: 0, display: 'flex',
        alignItems: 'center', justifyContent: 'center',
      }}>
        <div style={{ transform: 'scale(1.6)' }}>
          <TiideVisual kind={VisualKind} size={402} accent={t.accent} dark={true} />
        </div>
      </div>

      {/* ambient progress ring (centered) */}
      <div style={{
        position: 'absolute', top: '50%', left: '50%',
        transform: 'translate(-50%, -50%)', pointerEvents: 'none',
      }}>
        <ProgressRing size={320} stroke={1} progress={progress} accent="rgba(255,255,255,0.85)" track="rgba(255,255,255,0.08)" />
      </div>

      {/* vignette */}
      <div style={{
        position: 'absolute', inset: 0,
        background: 'radial-gradient(ellipse at 50% 55%, transparent 30%, rgba(0,0,0,0.55) 100%)',
        pointerEvents: 'none',
      }} />

      {/* status bar bg scrim */}
      <div style={{
        position: 'absolute', top: 0, left: 0, right: 0, height: 60,
        background: 'linear-gradient(180deg, rgba(0,0,0,0.35) 0%, transparent 100%)',
      }} />

      {/* Minimal top chrome: close, logo */}
      <div style={{
        position: 'absolute', top: 58, left: 20, right: 20, zIndex: 2,
        display: 'flex', justifyContent: 'space-between', alignItems: 'center',
      }}>
        <button onClick={onEnd} style={{
          border: 'none', background: 'rgba(255,255,255,0.1)',
          backdropFilter: 'blur(12px)', WebkitBackdropFilter: 'blur(12px)',
          width: 32, height: 32, borderRadius: 9999, color: t.ink,
          display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer',
        }}>{TI.close(16, t.ink)}</button>
        <TiideLogo theme={t} size="sm" />
        <div style={{ width: 32, opacity: 0.6, color: t.ink2 }}>{TI.wave(16, t.ink2)}</div>
      </div>

      {/* Verse (centered below visual) */}
      <div style={{
        position: 'absolute', bottom: 140, left: 28, right: 28,
        textAlign: 'center', zIndex: 2,
        animation: 'verseFadeIn 2.5s ease-out',
      }}>
        <div style={{ ...tType('verseM'), color: t.ink, whiteSpace: 'pre-line',
          textShadow: '0 1px 24px rgba(0,0,0,0.4)' }}>
          {verse.text}
        </div>
        <div style={{ ...tType('caption'), color: 'rgba(232,227,215,0.55)', marginTop: 16,
          letterSpacing: '0.08em', fontStyle: 'italic' }}>
          — {verse.attr}
        </div>
      </div>

      {/* Bottom hint */}
      <div style={{
        position: 'absolute', bottom: 56, left: 0, right: 0,
        textAlign: 'center', ...tType('caption'), color: 'rgba(232,227,215,0.4)',
        letterSpacing: '0.14em', textTransform: 'uppercase',
      }}>
        you'll be notified when the wave passes
      </div>
    </div>
  );
}

// Post-session tag sheet
function TagSheet({ theme, onSave, onDismiss, verse }) {
  const [selected, setSelected] = React.useState(new Set(['anxiety', 'sat with it']));
  const [note, setNote] = React.useState('');
  const toggle = (t) => {
    const s = new Set(selected);
    if (s.has(t)) s.delete(t); else s.add(t);
    setSelected(s);
  };
  const v = verse || TIIDE_VERSES[1];
  return (
    <div style={{ height: '100%', background: theme.bg, color: theme.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ padding: '58px 22px 10px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <button onClick={onDismiss} style={{ background: 'none', border: 'none', color: theme.ink3, cursor: 'pointer', padding: 4 }}>
          skip
        </button>
        <div style={{ ...tType('caption'), color: theme.ink4, textTransform: 'uppercase', letterSpacing: '0.16em' }}>
          session saved &middot; 15 min
        </div>
        <div style={{ width: 40 }} />
      </div>

      <div style={{ padding: '8px 24px 18px', overflowY: 'auto', flex: 1 }}>
        {/* Verse card that accompanied */}
        <div style={{
          background: theme.surface, borderRadius: 16, padding: '18px 20px',
          border: `1px solid ${theme.hair2}`,
          marginBottom: 22,
        }}>
          <div style={{ ...tType('caption'), color: theme.ink4, textTransform: 'uppercase',
            letterSpacing: '0.14em', marginBottom: 10 }}>accompanying verse</div>
          <div style={{ ...tType('verseS'), color: theme.ink, whiteSpace: 'pre-line' }}>{v.text}</div>
          <div style={{ ...tType('caption'), color: theme.ink4, marginTop: 10, fontStyle: 'italic' }}>— {v.attr}</div>
          <div style={{ display: 'flex', gap: 14, marginTop: 14, color: theme.ink3 }}>
            <button style={iconBtn(theme)}>{TI.bookmark(14, theme.ink3)} <span style={{ fontSize: 12 }}>save</span></button>
            <button style={iconBtn(theme)}>{TI.shuffle(14, theme.ink3)} <span style={{ fontSize: 12 }}>shuffle</span></button>
          </div>
        </div>

        {Object.entries(TAG_CATS).map(([cat, tags]) => (
          <div key={cat} style={{ marginBottom: 18 }}>
            <div style={{ ...tType('caption'), color: theme.ink4, textTransform: 'uppercase',
              letterSpacing: '0.14em', marginBottom: 10 }}>{cat}</div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: 7 }}>
              {tags.map(t => (
                <TiideChip key={t} label={t} selected={selected.has(t)} onClick={() => toggle(t)}
                  color={TAG_COLORS[t]} theme={theme} />
              ))}
            </div>
          </div>
        ))}

        <div style={{ marginTop: 18 }}>
          <div style={{ ...tType('caption'), color: theme.ink4, textTransform: 'uppercase',
            letterSpacing: '0.14em', marginBottom: 10 }}>note (optional)</div>
          <div style={{
            background: theme.surface, borderRadius: 14, padding: '14px 16px',
            border: `1px solid ${theme.hair2}`,
            ...tType('body'), color: theme.ink, fontStyle: 'italic',
            minHeight: 56,
          }}>
            {note || <span style={{ color: theme.ink4 }}>what do you want to remember about this one…</span>}
          </div>
        </div>
      </div>

      <div style={{ padding: '14px 22px 34px', borderTop: `1px solid ${theme.hair2}` }}>
        <button onClick={onSave} style={{
          width: '100%', border: 'none', background: theme.accent, color: '#fff',
          fontFamily: theme.font, fontSize: 16, padding: '14px 0', borderRadius: 14,
          cursor: 'pointer',
        }}>Save session</button>
      </div>
    </div>
  );
}

const iconBtn = (theme) => ({
  display: 'inline-flex', alignItems: 'center', gap: 5,
  border: 'none', background: 'transparent', color: theme.ink3,
  cursor: 'pointer', fontFamily: theme.font, padding: 0,
});

Object.assign(window, { ActiveSession, TagSheet, iconBtn });
