// Tiide — main App: builds a design canvas with phone frames + prototype mode.

function PhoneFrame({ children, dark = false, label }) {
  return (
    <div style={{
      width: 402, height: 874, borderRadius: 48, overflow: 'hidden',
      position: 'relative', background: dark ? '#000' : '#F2F2F7',
      boxShadow: '0 40px 80px rgba(0,0,0,0.18), 0 0 0 1px rgba(0,0,0,0.1)',
      fontFamily: TIIDE_FONT, WebkitFontSmoothing: 'antialiased',
    }}>
      <div style={{ position: 'absolute', top: 11, left: '50%', transform: 'translateX(-50%)',
        width: 126, height: 37, borderRadius: 24, background: '#000', zIndex: 50 }} />
      <div style={{ position: 'absolute', top: 0, left: 0, right: 0, zIndex: 10 }}>
        <IOSStatusBar dark={dark} />
      </div>
      <div style={{ height: '100%' }}>{children}</div>
      <div style={{
        position: 'absolute', bottom: 0, left: 0, right: 0, zIndex: 60,
        height: 34, display: 'flex', justifyContent: 'center', alignItems: 'flex-end',
        paddingBottom: 8, pointerEvents: 'none',
      }}>
        <div style={{ width: 139, height: 5, borderRadius: 100,
          background: dark ? 'rgba(255,255,255,0.7)' : 'rgba(0,0,0,0.25)' }} />
      </div>
    </div>
  );
}

// ── Tweaks (edit mode) ─────────────────────────────────────────────

const TWEAK_DEFAULTS = /*EDITMODE-BEGIN*/{
  "accent": "dusk",
  "visual": "tide",
  "theme": "light"
}/*EDITMODE-END*/;

function useTweaks() {
  const [t, setT] = React.useState(TWEAK_DEFAULTS);
  const [visible, setVisible] = React.useState(false);

  React.useEffect(() => {
    const handler = (e) => {
      if (!e.data || typeof e.data !== 'object') return;
      if (e.data.type === '__activate_edit_mode') setVisible(true);
      if (e.data.type === '__deactivate_edit_mode') setVisible(false);
    };
    window.addEventListener('message', handler);
    // signal availability AFTER listener registered
    window.parent.postMessage({ type: '__edit_mode_available' }, '*');
    return () => window.removeEventListener('message', handler);
  }, []);

  const update = (key, value) => {
    setT(prev => {
      const next = { ...prev, [key]: value };
      window.parent.postMessage({ type: '__edit_mode_set_keys', edits: { [key]: value } }, '*');
      return next;
    });
  };
  return { tweaks: t, update, visible };
}

function TweaksPanel({ tweaks, update, visible }) {
  if (!visible) return null;
  const row = { display: 'flex', gap: 6, flexWrap: 'wrap', marginTop: 6 };
  const swatch = (key, val, bg, label) => (
    <button key={val} onClick={() => update(key, val)} style={{
      padding: '6px 10px', borderRadius: 99, cursor: 'pointer',
      border: tweaks[key] === val ? '1.5px solid #1f1b17' : '1px solid rgba(0,0,0,0.15)',
      background: bg, color: label ? '#fff' : '#1f1b17', fontSize: 12,
      fontFamily: TIIDE_FONT, fontStyle: 'italic',
    }}>{label || val}</button>
  );
  return (
    <div style={{
      position: 'fixed', right: 20, bottom: 20, zIndex: 9999,
      background: '#fbf8f1', border: '1px solid rgba(31,27,23,0.15)',
      borderRadius: 14, padding: '14px 16px', width: 240,
      boxShadow: '0 12px 36px rgba(0,0,0,0.15)', fontFamily: TIIDE_FONT,
    }}>
      <div style={{ fontSize: 14, color: '#1f1b17', marginBottom: 10, fontStyle: 'italic' }}>Tweaks</div>
      <div>
        <div style={{ fontSize: 11, color: '#6a6158', textTransform: 'uppercase', letterSpacing: '0.14em' }}>accent</div>
        <div style={row}>
          {Object.entries(TIIDE_ACCENTS).map(([k, v]) =>
            <button key={k} onClick={() => update('accent', k)} title={v.name} style={{
              width: 26, height: 26, borderRadius: 99, cursor: 'pointer',
              background: v.light, border: tweaks.accent === k ? '2px solid #1f1b17' : '1px solid rgba(0,0,0,0.1)',
            }}/>
          )}
        </div>
      </div>
      <div style={{ marginTop: 12 }}>
        <div style={{ fontSize: 11, color: '#6a6158', textTransform: 'uppercase', letterSpacing: '0.14em' }}>visual</div>
        <div style={row}>
          {['tide', 'breath', 'ink'].map(v => swatch('visual', v, tweaks.visual === v ? '#4a6b7c' : '#ebe5d8', tweaks.visual === v))}
        </div>
      </div>
      <div style={{ marginTop: 12 }}>
        <div style={{ fontSize: 11, color: '#6a6158', textTransform: 'uppercase', letterSpacing: '0.14em' }}>theme</div>
        <div style={row}>
          {['light', 'dark'].map(v => swatch('theme', v, tweaks.theme === v ? '#1f1b17' : '#ebe5d8', tweaks.theme === v))}
        </div>
      </div>
    </div>
  );
}

// ── Main app ──────────────────────────────────────────────────────

function App() {
  const { tweaks, update, visible } = useTweaks();
  window.__TIIDE_VISUAL_KIND = tweaks.visual;

  const themeL = useTiideTheme('light', tweaks.accent);
  const themeD = useTiideTheme('dark', tweaks.accent);
  themeL.__accentKey = tweaks.accent;
  themeD.__accentKey = tweaks.accent;

  const tActive = tweaks.theme === 'dark' ? themeD : themeL;
  const accent = TIIDE_ACCENTS[tweaks.accent].light;

  return (
    <>
      <DesignCanvas>
        {/* ─── Hero flow ─── */}
        <DCSection id="flow" title="the core loop" subtitle="idle → active → notification → retro-edit">
          <DCArtboard id="lockscreen" label="01 · lockscreen entry" width={402} height={874}>
            <PhoneFrame dark={true}>
              <LockscreenMock theme={themeD} accent={accent} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="cc-tile" label="02 · control-center tile" width={402} height={874}>
            <PhoneFrame dark={true}>
              <ControlCenterMock theme={themeD} accent={accent} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="home-idle" label="03 · home · idle" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <HomeScreen theme={tActive} state="idle" />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="active" label="04 · active session" width={402} height={874}>
            <PhoneFrame dark={true}>
              <ActiveSession theme={themeD} progress={0.42} verseIndex={0} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="active-late" label="05 · active · verse 2" width={402} height={874}>
            <PhoneFrame dark={true}>
              <ActiveSession theme={themeD} progress={0.88} verseIndex={4} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="notif" label="06 · has the wave passed?" width={402} height={874}>
            <PhoneFrame dark={true}>
              <NotificationMock theme={themeD} accent={accent} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="tag-sheet" label="07 · post-session · tag" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <TagSheet theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="home-active" label="08 · home · active resume" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <HomeScreen theme={tActive} state="active" />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="home-orphan" label="09 · home · orphaned retro-edit" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <HomeScreen theme={tActive} state="orphaned" />
            </PhoneFrame>
          </DCArtboard>
        </DCSection>

        {/* ─── Looking back ─── */}
        <DCSection id="review" title="looking back" subtitle="dashboard, sessions, detail">
          <DCArtboard id="dashboard" label="dashboard" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <Dashboard theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="sessions" label="sessions list" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <SessionsList theme={tActive} onOpenDetail={() => {}} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="detail" label="session detail" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <SessionDetail theme={tActive} session={FAKE_SESSIONS[0]} />
            </PhoneFrame>
          </DCArtboard>
        </DCSection>

        {/* ─── First run + quiet ─── */}
        <DCSection id="firstrun" title="first run &amp; quiet surfaces" subtitle="onboarding, permissions, settings, verses">
          <DCArtboard id="onb-1" label="onboarding · 1" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <Onboarding theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="onb-2" label="onboarding · 2 · entry" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <OnboardingAt step={1} theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="onb-3" label="onboarding · 3 · verses" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <OnboardingAt step={2} theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="perm" label="permissions" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <Permissions theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="verses" label="verse library" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <VerseLibrary theme={tActive} />
            </PhoneFrame>
          </DCArtboard>

          <DCArtboard id="settings" label="settings" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <Settings theme={tActive} />
            </PhoneFrame>
          </DCArtboard>
        </DCSection>

        {/* ─── Prototype ─── */}
        <DCSection id="proto" title="interactive prototype" subtitle="tap to step through the loop">
          <DCArtboard id="proto-run" label="prototype · try it" width={402} height={874}>
            <PhoneFrame dark={tweaks.theme === 'dark'}>
              <Prototype accent={accent} tweaks={tweaks} />
            </PhoneFrame>
          </DCArtboard>
        </DCSection>
      </DesignCanvas>

      <TweaksPanel tweaks={tweaks} update={update} visible={visible} />
    </>
  );
}

// Step-jumped onboarding (helper so canvas can show the later panels)
function OnboardingAt({ step, theme }) {
  const ref = React.useRef(null);
  React.useEffect(() => {
    // can't easily drive internal setState from here; so render a static variant
  }, []);
  // Render the appropriate step body
  return <Onboarding theme={theme} initialStep={step} />;
}

// Prototype — clickable flow
function Prototype({ accent, tweaks }) {
  const [screen, setScreen] = React.useState('idle');
  const [orphan, setOrphan] = React.useState(false);
  const [verseIdx, setVerseIdx] = React.useState(0);
  const [progress, setProgress] = React.useState(0.1);
  const themeL = useTiideTheme('light', tweaks.accent);
  const themeD = useTiideTheme('dark', tweaks.accent);
  const tActive = tweaks.theme === 'dark' ? themeD : themeL;
  tActive.__accentKey = tweaks.accent;
  themeD.__accentKey = tweaks.accent;

  // Auto-advance progress + cycle verses while active
  React.useEffect(() => {
    if (screen !== 'active') return;
    const iv = setInterval(() => {
      setProgress(p => {
        const n = p + 0.015;
        if (n >= 1) { setScreen('notif'); return 1; }
        return n;
      });
    }, 500);
    return () => clearInterval(iv);
  }, [screen]);
  React.useEffect(() => {
    if (screen !== 'active') return;
    const iv = setInterval(() => setVerseIdx(i => i + 1), 4000);
    return () => clearInterval(iv);
  }, [screen]);

  if (screen === 'idle') {
    return (
      <HomeScreen theme={tActive} state={orphan ? 'orphaned' : 'idle'}
        onStart={() => { setProgress(0.1); setVerseIdx(0); setScreen('active'); }}
        onResolveOrphan={() => setOrphan(false)} />
    );
  }
  if (screen === 'active') {
    return <ActiveSession theme={themeD} progress={progress} verseIndex={verseIdx}
      onEnd={() => setScreen('notif')} />;
  }
  if (screen === 'notif') {
    // Overlay notification over active screen
    return (
      <div style={{ position: 'relative', height: '100%' }}>
        <ActiveSession theme={themeD} progress={1} verseIndex={verseIdx} onEnd={() => setScreen('tag')} />
        <div style={{
          position: 'absolute', inset: 0, background: 'rgba(0,0,0,0.35)',
          display: 'flex', alignItems: 'flex-start', justifyContent: 'center', paddingTop: 120,
        }}>
          <div onClick={() => setScreen('tag')} style={{
            width: 340, background: 'rgba(28,28,32,0.7)', backdropFilter: 'blur(28px)',
            WebkitBackdropFilter: 'blur(28px)', borderRadius: 17, overflow: 'hidden',
            border: '0.5px solid rgba(255,255,255,0.08)', cursor: 'pointer',
          }}>
            <div style={{ padding: '14px 16px', color: '#fff', display: 'flex', gap: 10 }}>
              <div style={{ width: 38, height: 38, borderRadius: 9, background: accent,
                display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                <div style={{ width: 10, height: 10, borderRadius: 99, background: '#fff' }}/>
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 12, fontWeight: 600, opacity: 0.9, fontFamily: '-apple-system' }}>TIIDE &middot; now</div>
                <div style={{ fontFamily: TIIDE_FONT, fontStyle: 'italic', marginTop: 2 }}>has the wave passed?</div>
                <div style={{ fontFamily: TIIDE_FONT, fontSize: 13, opacity: 0.75, marginTop: 2 }}>15 minutes. tap to save.</div>
              </div>
            </div>
            <div style={{ display: 'flex', borderTop: '0.5px solid rgba(255,255,255,0.1)', color: '#fff' }}>
              <div onClick={(e) => { e.stopPropagation(); setScreen('tag'); }} style={{ flex: 1, textAlign: 'center', padding: '11px 0', fontWeight: 500, fontFamily: '-apple-system' }}>save & tag</div>
              <div onClick={(e) => { e.stopPropagation(); setProgress(0.85); setScreen('active'); }} style={{ flex: 1, textAlign: 'center', padding: '11px 0', borderLeft: '0.5px solid rgba(255,255,255,0.1)', fontFamily: '-apple-system' }}>+5 min</div>
            </div>
          </div>
        </div>
      </div>
    );
  }
  if (screen === 'tag') {
    return <TagSheet theme={tActive} verse={TIIDE_VERSES[verseIdx % TIIDE_VERSES.length]}
      onSave={() => setScreen('idle')} onDismiss={() => setScreen('idle')} />;
  }
  return null;
}

// Mount
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
