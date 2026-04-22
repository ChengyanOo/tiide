// Tiide — Verse library, Onboarding, Permissions, Settings

function VerseLibrary({ theme: t, onBack }) {
  const [tab, setTab] = React.useState('browse');
  const [enabled, setEnabled] = React.useState(new Set(['Psalms', 'Gospels', 'Wisdom']));
  const [cadence, setCadence] = React.useState('default');

  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title="verse library"
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>}
          right={<div style={{ color: t.ink3 }}>{TI.plus(18, t.ink3)}</div>} />
      </div>
      {/* Tabs */}
      <div style={{ display: 'flex', padding: '0 22px 6px', gap: 18 }}>
        {['browse', 'saved', 'custom'].map(x => (
          <button key={x} onClick={() => setTab(x)} style={{
            background: 'none', border: 'none', cursor: 'pointer',
            ...tType('meta'), color: tab === x ? t.ink : t.ink4,
            fontStyle: tab === x ? 'italic' : 'normal',
            padding: '6px 0', borderBottom: tab === x ? `1px solid ${t.accent}` : '1px solid transparent',
          }}>{x}</button>
        ))}
      </div>
      <div style={{ overflowY: 'auto', flex: 1, padding: '12px 20px 40px' }}>
        {/* Preview card */}
        <div style={{
          position: 'relative', borderRadius: 16, overflow: 'hidden',
          marginBottom: 18, height: 200, background: t.mode === 'dark' ? '#0e1217' : '#ebe5d8',
        }}>
          <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <div style={{ transform: 'scale(0.75)' }}>
              <TiideVisual kind={window.__TIIDE_VISUAL_KIND || 'tide'} size={300} accent={t.accent} dark={t.mode === 'dark'} />
            </div>
          </div>
          <div style={{
            position: 'absolute', inset: 0,
            background: 'radial-gradient(ellipse at center, transparent 20%, rgba(0,0,0,0.5) 100%)',
          }} />
          <div style={{ position: 'absolute', bottom: 14, left: 16, right: 16, textAlign: 'center' }}>
            <div style={{ ...tType('verseS'), color: '#f3efe6', whiteSpace: 'pre-line' }}>{TIIDE_VERSES[0].text}</div>
            <div style={{ ...tType('caption'), color: 'rgba(243,239,230,0.6)', marginTop: 6, fontStyle: 'italic' }}>— {TIIDE_VERSES[0].attr}</div>
          </div>
          <div style={{ position: 'absolute', top: 10, left: 14, ...tType('caption'), color: 'rgba(243,239,230,0.6)', letterSpacing: '0.14em', textTransform: 'uppercase' }}>preview</div>
        </div>

        {/* Categories */}
        <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 10 }}>categories</div>
        <TCard theme={t} style={{ marginBottom: 18 }}>
          {TIIDE_VERSE_CATS.map((c, i) => (
            <div key={c} style={{ display: 'flex', alignItems: 'center', padding: '12px 16px',
              borderBottom: i < TIIDE_VERSE_CATS.length - 1 ? `1px solid ${t.hair2}` : 'none' }}>
              <div style={{ flex: 1, ...tType('body'), color: t.ink }}>{c}</div>
              <div style={{ ...tType('caption'), color: t.ink4, marginRight: 10 }}>{[42, 28, 14, 19, 9, 3][i]}</div>
              <Toggle theme={t} on={enabled.has(c)} onChange={() => {
                const s = new Set(enabled);
                if (s.has(c)) s.delete(c); else s.add(c);
                setEnabled(s);
              }}/>
            </div>
          ))}
        </TCard>

        {/* Cadence */}
        <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 10 }}>cadence during session</div>
        <TCard theme={t} style={{ padding: 4, marginBottom: 18 }}>
          <div style={{ display: 'flex', gap: 4 }}>
            {[
              { k: 'off', l: 'off' },
              { k: 'slow', l: 'slow', sub: 'one verse, held' },
              { k: 'default', l: 'default', sub: 'new every 2 min' },
            ].map(o => (
              <button key={o.k} onClick={() => setCadence(o.k)} style={{
                flex: 1, border: 'none', background: cadence === o.k ? t.bgElev : 'transparent',
                borderRadius: 12, padding: '12px 6px', cursor: 'pointer', color: t.ink,
              }}>
                <div style={{ ...tType('meta'), color: cadence === o.k ? t.ink : t.ink3,
                  fontStyle: cadence === o.k ? 'italic' : 'normal' }}>{o.l}</div>
                {o.sub && <div style={{ ...tType('caption'), color: t.ink4, marginTop: 2 }}>{o.sub}</div>}
              </button>
            ))}
          </div>
        </TCard>

        {/* List */}
        <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 10 }}>browse</div>
        {TIIDE_VERSES.slice(0, 6).map((v, i) => (
          <div key={i} style={{
            padding: '14px 0', borderBottom: i < 5 ? `1px solid ${t.hair2}` : 'none',
          }}>
            <div style={{ ...tType('verseS'), color: t.ink, whiteSpace: 'pre-line' }}>{v.text}</div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 8 }}>
              <div style={{ ...tType('caption'), color: t.ink4, fontStyle: 'italic' }}>— {v.attr} &middot; {v.cat}</div>
              <div style={{ color: i < 3 ? t.accent : t.ink4 }}>{TI.bookmark(12, 'currentColor')}</div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function Toggle({ theme: t, on, onChange }) {
  return (
    <button onClick={onChange} style={{
      width: 38, height: 22, borderRadius: 9999, padding: 0, border: 'none',
      background: on ? t.accent : t.hair, cursor: 'pointer',
      position: 'relative', transition: 'background .2s ease',
    }}>
      <div style={{
        position: 'absolute', top: 2, left: on ? 18 : 2,
        width: 18, height: 18, borderRadius: 9999,
        background: '#fff', transition: 'left .2s ease',
        boxShadow: '0 1px 3px rgba(0,0,0,0.2)',
      }} />
    </button>
  );
}

function Onboarding({ theme: t, onDone, initialStep = 0 }) {
  const [step, setStep] = React.useState(initialStep);
  const steps = [
    {
      title: 'make your effort seen.',
      body: 'tiide is a passive timer for the moments you choose not to act. it keeps a quiet record, so you can notice what passes.',
      cta: 'begin',
    },
    {
      title: 'start in one tap.',
      body: 'most sessions begin outside the app — from your lockscreen widget, a back-tap, or a quick-settings tile.',
      cta: 'next',
      visual: 'entry',
    },
    {
      title: 'pick what keeps you company.',
      body: 'during a session, a short verse fades in. you can always change this later.',
      cta: 'next',
      visual: 'cats',
    },
    {
      title: 'your data stays on your phone.',
      body: 'sessions are encrypted locally. biometric and location are off until you turn them on.',
      cta: 'finish',
    },
  ];
  const s = steps[step];

  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      {/* Dots */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 6, padding: '62px 0 0' }}>
        {steps.map((_, i) => (
          <div key={i} style={{
            width: i === step ? 18 : 5, height: 5, borderRadius: 99,
            background: i === step ? t.accent : t.hair, transition: 'all .3s ease',
          }}/>
        ))}
      </div>
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '20px 32px' }}>
        <div style={{ marginBottom: 28 }}>
          <TiideLogo theme={t} size="lg" />
        </div>
        <div style={{ ...tType('display'), color: t.ink, textAlign: 'center', fontStyle: 'italic', fontWeight: 300, marginBottom: 18, textWrap: 'balance' }}>
          {s.title}
        </div>
        <div style={{ ...tType('body'), color: t.ink3, textAlign: 'center', lineHeight: 1.6, maxWidth: 300, textWrap: 'pretty' }}>
          {s.body}
        </div>

        {s.visual === 'entry' && (
          <div style={{ marginTop: 34, display: 'flex', flexDirection: 'column', gap: 10, width: '100%' }}>
            {[
              { name: 'lockscreen widget', sub: 'hold lockscreen → add widget' },
              { name: 'back-tap', sub: 'settings → touch → back-tap' },
              { name: 'quick-settings tile', sub: 'edit tiles → add tiide' },
            ].map((e, i) => (
              <div key={i} style={{
                display: 'flex', alignItems: 'center', gap: 14, padding: '12px 14px',
                background: t.surface, borderRadius: 12, border: `1px solid ${t.hair2}`,
              }}>
                <div style={{ width: 30, height: 30, borderRadius: 7, background: t.accent, opacity: 0.18,
                  display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                  <div style={{ width: 10, height: 10, borderRadius: 999, background: t.accent }} />
                </div>
                <div style={{ flex: 1 }}>
                  <div style={{ ...tType('body'), color: t.ink }}>{e.name}</div>
                  <div style={{ ...tType('caption'), color: t.ink4, fontStyle: 'italic' }}>{e.sub}</div>
                </div>
                <div style={{ color: t.ink4 }}>{TI.chevRight(14, t.ink4)}</div>
              </div>
            ))}
          </div>
        )}

        {s.visual === 'cats' && (
          <div style={{ marginTop: 28, display: 'flex', flexWrap: 'wrap', gap: 7, justifyContent: 'center' }}>
            {TIIDE_VERSE_CATS.slice(0,5).map((c, i) => (
              <TiideChip key={c} label={c} selected={i < 3} theme={t} />
            ))}
          </div>
        )}
      </div>
      <div style={{ padding: '14px 24px 34px' }}>
        <button onClick={() => step < steps.length - 1 ? setStep(step + 1) : onDone()} style={{
          width: '100%', border: 'none', background: t.accent, color: '#fff',
          fontFamily: t.font, fontSize: 16, padding: '14px 0', borderRadius: 14, cursor: 'pointer',
        }}>{s.cta}</button>
      </div>
    </div>
  );
}

function Permissions({ theme: t, onBack }) {
  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title="permissions"
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>} />
      </div>
      <div style={{ overflowY: 'auto', flex: 1, padding: '6px 20px 40px' }}>
        <div style={{ ...tType('body'), color: t.ink3, fontStyle: 'italic', lineHeight: 1.6, padding: '6px 4px 22px' }}>
          tiide uses these only during a session, and stores samples locally. off by default.
        </div>

        {[
          {
            icon: TI.heart2(22, t.accent),
            name: 'heart rate & HRV',
            body: 'we read heart rate and HRV from the 10 minutes before a session and during. this surfaces patterns — not diagnoses.',
            note: 'healthkit &middot; session-only',
          },
          {
            icon: TI.pin(22, t.accent),
            name: 'location',
            body: 'we take a single fix at session start, kept locally, to form quiet place-clusters you can name.',
            note: 'coarse &middot; no trail, no sharing',
          },
        ].map((p, i) => (
          <TCard key={i} theme={t} style={{ padding: '18px 18px', marginBottom: 12 }}>
            <div style={{ display: 'flex', alignItems: 'flex-start', gap: 14 }}>
              <div style={{ width: 36, height: 36, borderRadius: 9, background: t.accent + '22',
                display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
                {p.icon}
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ ...tType('title'), color: t.ink, marginBottom: 6 }}>{p.name}</div>
                <div style={{ ...tType('meta'), color: t.ink3, lineHeight: 1.55, fontStyle: 'italic' }}>{p.body}</div>
                <div style={{ ...tType('caption'), color: t.ink4, letterSpacing: '0.08em', marginTop: 8, textTransform: 'uppercase' }} dangerouslySetInnerHTML={{__html: p.note}} />
              </div>
            </div>
            <div style={{ display: 'flex', gap: 10, marginTop: 16 }}>
              <button style={{ flex: 1, border: `1px solid ${t.hair}`, background: 'transparent',
                color: t.ink2, fontFamily: t.font, fontSize: 14, padding: '10px 0',
                borderRadius: 12, cursor: 'pointer' }}>not now</button>
              <button style={{ flex: 1, border: 'none', background: t.accent, color: '#fff',
                fontFamily: t.font, fontSize: 14, padding: '10px 0',
                borderRadius: 12, cursor: 'pointer' }}>allow</button>
            </div>
          </TCard>
        ))}

        <div style={{ ...tType('caption'), color: t.ink4, padding: '16px 4px',
          fontStyle: 'italic', lineHeight: 1.55 }}>
          you can revoke either at any time. sessions still work without them — you just won't see biometric or place insights.
        </div>
      </div>
    </div>
  );
}

function Settings({ theme: t, onBack, onOpenPerm, onOpenVerse }) {
  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title="settings"
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>} />
      </div>
      <div style={{ overflowY: 'auto', flex: 1, padding: '0 0 40px' }}>

        <TSectionLabel theme={t}>session</TSectionLabel>
        <TCard theme={t} style={{ margin: '0 16px' }}>
          <TRow theme={t} icon={TI.drop(18, t.ink3)} label="default duration" right={<>15 min {TI.chevRight(14, t.ink4)}</>} />
          <TRow theme={t} icon={TI.leaf(18, t.ink3)} label="calming visual" right={<>tide {TI.chevRight(14, t.ink4)}</>} />
          <TRow theme={t} icon={TI.book(18, t.ink3)} label="verse library" right={TI.chevRight(14, t.ink4)} onClick={onOpenVerse} last />
        </TCard>

        <TSectionLabel theme={t}>data &amp; privacy</TSectionLabel>
        <TCard theme={t} style={{ margin: '0 16px' }}>
          <TRow theme={t} icon={TI.heart2(18, t.ink3)} label="biometrics" right={<>on <Toggle theme={t} on={true} /></>} />
          <TRow theme={t} icon={TI.pin(18, t.ink3)} label="location" right={<>off <Toggle theme={t} on={false} /></>} />
          <TRow theme={t} icon={TI.drop(18, t.ink3)} label="cloud sync" right={<>off <Toggle theme={t} on={false} /></>}>
            opt-in, off by default
          </TRow>
          <TRow theme={t} icon={TI.settings(18, t.ink3)} label="permissions" right={TI.chevRight(14, t.ink4)} onClick={onOpenPerm} last />
        </TCard>

        <TSectionLabel theme={t}>appearance</TSectionLabel>
        <TCard theme={t} style={{ margin: '0 16px' }}>
          <TRow theme={t} icon={TI.moon(18, t.ink3)} label="theme" right={<>dusk · auto {TI.chevRight(14, t.ink4)}</>} />
          <TRow theme={t} icon={TI.drop(18, t.ink3)} label="accent" right={<><span style={{width:10,height:10,borderRadius:99,background:t.accent,display:'inline-block',marginRight:6}}/>{t.accentName} {TI.chevRight(14, t.ink4)}</>} last />
        </TCard>

        <TSectionLabel theme={t}>your data</TSectionLabel>
        <TCard theme={t} style={{ margin: '0 16px' }}>
          <TRow theme={t} icon={TI.download(18, t.ink3)} label="export as JSON" right={TI.chevRight(14, t.ink4)} />
          <TRow theme={t} icon={TI.close(18, t.ink3)} label="delete all data" right={TI.chevRight(14, t.ink4)} last />
        </TCard>

        <div style={{ ...tType('caption'), color: t.ink4, textAlign: 'center',
          padding: '32px 24px 0', fontStyle: 'italic', lineHeight: 1.6 }}>
          tiide is offline by default. every session stays on this device until you say otherwise.
        </div>
      </div>
    </div>
  );
}

Object.assign(window, { VerseLibrary, Onboarding, Permissions, Settings, Toggle });
