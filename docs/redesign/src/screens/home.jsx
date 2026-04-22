// Tiide — Home screen (Idle, Active-resume, Orphaned states)

function HomeScreen({ theme, state = 'idle', onStart, onOpenActive, onResolveOrphan, verse }) {
  const ink = theme.ink;
  const VisualKind = window.__TIIDE_VISUAL_KIND || 'tide';

  // Nav
  const nav = (
    <div style={{
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      padding: '58px 22px 0',
    }}>
      <TiideLogo theme={theme} size="md" />
      <div style={{ display: 'flex', gap: 18, color: theme.ink3 }}>
        {TI.dashboard(20, 'currentColor')}
        {TI.list(20, 'currentColor')}
        {TI.settings(20, 'currentColor')}
      </div>
    </div>
  );

  // Bottom strip — streak / today / avg
  const bottom = (
    <div style={{
      display: 'flex', justifyContent: 'space-around', alignItems: 'flex-end',
      padding: '14px 22px 30px', borderTop: `1px solid ${theme.hair2}`,
      marginTop: 'auto',
    }}>
      {[
        { v: '23', l: 'days sat with it' },
        { v: '2', l: 'today' },
        { v: '17m', l: 'avg' },
      ].map((m, i) => (
        <div key={i} style={{ textAlign: 'center' }}>
          <div style={{ ...tType('titleL'), color: theme.ink }}>{m.v}</div>
          <div style={{ ...tType('caption'), color: theme.ink4, marginTop: 2, letterSpacing: '0.02em' }}>{m.l}</div>
        </div>
      ))}
    </div>
  );

  if (state === 'active') {
    // Resume card
    return (
      <div style={{ height: '100%', display: 'flex', flexDirection: 'column', background: theme.bg, color: ink }}>
        {nav}
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '0 28px' }}>
          <div style={{ ...tType('caption'), color: theme.ink4, textTransform: 'uppercase', letterSpacing: '0.18em', marginBottom: 10 }}>session in progress</div>
          <div style={{ position: 'relative', width: 200, height: 200, marginBottom: 22 }}>
            <TiideVisual kind={VisualKind} size={200} accent={theme.accent} dark={theme.mode === 'dark'} />
            <div style={{ position: 'absolute', inset: 0 }}>
              <ProgressRing size={200} stroke={1.5} progress={0.52} accent={theme.accent} track={theme.hair} />
            </div>
          </div>
          <div style={{ ...tType('body'), color: theme.ink3, fontStyle: 'italic', textAlign: 'center', marginBottom: 28, maxWidth: 260 }}>
            started 7 min ago<br/>on the way home
          </div>
          <button onClick={onOpenActive} style={{
            ...tType('bodyM'), fontFamily: theme.font, background: theme.accent, color: '#fff',
            border: 'none', borderRadius: 9999, padding: '14px 34px', cursor: 'pointer',
            boxShadow: 'none',
          }}>Resume</button>
          <button style={{
            ...tType('meta'), fontFamily: theme.font, background: 'transparent', color: theme.ink3,
            border: 'none', marginTop: 14, cursor: 'pointer',
          }}>End now</button>
        </div>
        {bottom}
      </div>
    );
  }

  if (state === 'orphaned') {
    // Non-dismissible retro-edit sheet overlaid on dimmed home
    return (
      <div style={{ height: '100%', display: 'flex', flexDirection: 'column', background: theme.bg, color: ink, position: 'relative' }}>
        {/* ghosted idle */}
        <div style={{ opacity: 0.35, pointerEvents: 'none', display: 'flex', flexDirection: 'column', flex: 1 }}>
          {nav}
          <div style={{ flex: 1 }}/>
        </div>
        <div style={{ position: 'absolute', inset: 0, background: theme.overlay }} />
        {/* sheet */}
        <div style={{
          position: 'absolute', left: 0, right: 0, bottom: 0,
          background: theme.surface, borderTopLeftRadius: 28, borderTopRightRadius: 28,
          padding: '22px 24px 30px', boxShadow: '0 -10px 40px rgba(0,0,0,0.18)',
        }}>
          <div style={{ width: 36, height: 4, background: theme.hair, borderRadius: 9999, margin: '0 auto 18px' }} />
          <div style={{ ...tType('title'), color: theme.ink, textAlign: 'center' }}>
            a session was running
          </div>
          <div style={{ ...tType('meta'), color: theme.ink3, textAlign: 'center', marginTop: 6, lineHeight: 1.5 }}>
            started 2:14pm &middot; no end was saved.<br/>
            how long did the hardest part last?
          </div>
          {/* snap slider */}
          <DurationSnap theme={theme} value={15} />
          <div style={{ display: 'flex', gap: 10, marginTop: 24 }}>
            <button onClick={onResolveOrphan} style={{
              flex: 1, border: `1px solid ${theme.hair}`, background: 'transparent',
              color: theme.ink2, fontFamily: theme.font, fontSize: 15, padding: '13px 0',
              borderRadius: 14, cursor: 'pointer',
            }}>Discard</button>
            <button onClick={onResolveOrphan} style={{
              flex: 2, border: 'none', background: theme.accent, color: '#fff',
              fontFamily: theme.font, fontSize: 15, padding: '13px 0',
              borderRadius: 14, cursor: 'pointer',
            }}>Save</button>
          </div>
        </div>
      </div>
    );
  }

  // Idle
  return (
    <div style={{ height: '100%', display: 'flex', flexDirection: 'column', background: theme.bg, color: ink }}>
      {nav}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '0 28px' }}>
        <div style={{ ...tType('meta'), color: theme.ink3, textAlign: 'center', marginBottom: 32, maxWidth: 240, lineHeight: 1.55, fontStyle: 'italic' }}>
          make your effort seen.
        </div>
        <button onClick={onStart} style={{
          width: 240, height: 240, borderRadius: 9999,
          border: `1px solid ${theme.hair}`, background: 'transparent',
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          cursor: 'pointer', position: 'relative',
        }}>
          <div style={{ position: 'absolute', inset: 14, borderRadius: 9999, border: `0.5px solid ${theme.hair}` }} />
          <div style={{ position: 'absolute', inset: 28, borderRadius: 9999,
            background: `radial-gradient(circle at 50% 60%, ${theme.accent}28, transparent 70%)` }} />
          <div style={{ textAlign: 'center', color: theme.ink }}>
            <div style={{ ...tType('displayL'), fontStyle: 'italic', fontWeight: 300 }}>sit</div>
            <div style={{ ...tType('caption'), color: theme.ink4, letterSpacing: '0.2em', textTransform: 'uppercase', marginTop: 4 }}>
              15 min
            </div>
          </div>
        </button>
        <div style={{ ...tType('caption'), color: theme.ink4, marginTop: 26, textAlign: 'center', lineHeight: 1.6 }}>
          or tap the lockscreen widget,<br/>back-tap, or quick settings tile
        </div>
      </div>
      {bottom}
    </div>
  );
}

// Duration snap slider — 5 / 10 / 15 (retro-edit)
function DurationSnap({ theme, value = 15 }) {
  const [v, setV] = React.useState(value);
  const marks = [5, 10, 15];
  return (
    <div style={{ marginTop: 22 }}>
      <div style={{ textAlign: 'center', ...tType('display'), fontWeight: 300, color: theme.ink }}>
        {v}<span style={{ ...tType('body'), color: theme.ink3 }}> min</span>
      </div>
      <div style={{ position: 'relative', margin: '16px 6px 0', height: 36 }}>
        <div style={{ position: 'absolute', top: 16, left: 6, right: 6, height: 2, background: theme.hair, borderRadius: 9999 }} />
        <div style={{ position: 'absolute', top: 16, left: 6, width: `${(v-5)/10 * 100}%`, height: 2, background: theme.accent, borderRadius: 9999 }} />
        {marks.map((m) => {
          const left = ((m-5)/10) * 100;
          return (
            <button key={m} onClick={() => setV(m)} style={{
              position: 'absolute', left: `calc(${left}% - 14px)`, top: 3,
              width: 28, height: 28, border: 'none', background: 'transparent',
              cursor: 'pointer', padding: 0,
            }}>
              <div style={{
                width: v === m ? 18 : 10, height: v === m ? 18 : 10,
                borderRadius: 9999, margin: '0 auto',
                background: v === m ? theme.accent : theme.ink4,
                transition: 'all .2s ease',
                border: v === m ? `3px solid ${theme.bg}` : 'none',
                boxShadow: v === m ? `0 0 0 1px ${theme.accent}` : 'none',
              }} />
              <div style={{ ...tType('caption'), color: v === m ? theme.accent : theme.ink4,
                marginTop: 4, textAlign: 'center', fontWeight: v === m ? 500 : 400 }}>{m}</div>
            </button>
          );
        })}
      </div>
    </div>
  );
}

Object.assign(window, { HomeScreen, DurationSnap });
