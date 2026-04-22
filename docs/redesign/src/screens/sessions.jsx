// Tiide — Sessions list + Session detail

const FAKE_SESSIONS = [
  { id: 's1', date: 'today', time: '10:42 pm', duration: 15, outcome: 'saved', tags: ['anxiety', 'sat with it'], place: 'home', verse: 0 },
  { id: 's2', date: 'today', time: '3:10 pm', duration: 10, outcome: 'saved', tags: ['boredom'], place: 'the blue car', verse: 5 },
  { id: 's3', date: 'yesterday', time: '11:28 pm', duration: 15, outcome: 'orphaned', tags: ['anxiety', 'craving'], place: 'home', verse: 1 },
  { id: 's4', date: 'yesterday', time: '2:04 am', duration: 20, outcome: 'saved', tags: ['loneliness'], place: 'home', verse: 4 },
  { id: 's5', date: 'mon, apr 21', time: '9:50 pm', duration: 15, outcome: 'saved', tags: ['craving', 'anger'], place: "mom's", verse: 6 },
  { id: 's6', date: 'mon, apr 21', time: '6:12 pm', duration: 5, outcome: 'saved', tags: ['anger'], place: 'the blue car', verse: 7 },
  { id: 's7', date: 'sun, apr 20', time: '11:15 pm', duration: 15, outcome: 'saved', tags: ['anxiety'], place: 'home', verse: 3 },
  { id: 's8', date: 'sun, apr 20', time: '10:02 am', duration: 10, outcome: 'saved', tags: ['practice'], place: 'home', verse: 2 },
];

function SessionsList({ theme: t, onOpenDetail, onBack }) {
  const grouped = {};
  FAKE_SESSIONS.forEach(s => { (grouped[s.date] ||= []).push(s); });
  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title="sessions"
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>} />
      </div>
      <div style={{ overflowY: 'auto', flex: 1, padding: '0 0 40px' }}>
        {Object.entries(grouped).map(([date, items]) => (
          <div key={date}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase',
              letterSpacing: '0.14em', padding: '18px 22px 8px' }}>{date}</div>
            {items.map((s, i) => (
              <div key={s.id} onClick={() => onOpenDetail(s)} style={{
                display: 'flex', alignItems: 'center', gap: 14,
                padding: '14px 22px', cursor: 'pointer',
                borderBottom: i < items.length - 1 ? `1px solid ${t.hair2}` : 'none',
              }}>
                {/* time ring */}
                <div style={{
                  width: 38, height: 38, borderRadius: 9999,
                  border: `1px solid ${s.outcome === 'orphaned' ? t.hair : t.accent}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  position: 'relative',
                }}>
                  <div style={{
                    width: 8, height: 8, borderRadius: 9999,
                    background: s.outcome === 'orphaned' ? t.ink4 : t.accent,
                    opacity: s.outcome === 'orphaned' ? 0.4 : 1,
                  }} />
                </div>
                <div style={{ flex: 1 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 7, marginBottom: 2 }}>
                    <span style={{ ...tType('body'), color: t.ink }}>{s.time}</span>
                    <span style={{ ...tType('caption'), color: t.ink4 }}>&middot; {s.duration} min</span>
                    {s.outcome === 'orphaned' && (
                      <span style={{ ...tType('caption'), color: t.ink4, fontStyle: 'italic', marginLeft: 4 }}>orphaned</span>
                    )}
                  </div>
                  <div style={{ display: 'flex', gap: 5, flexWrap: 'wrap', alignItems: 'center' }}>
                    {s.tags.map(tag => (
                      <span key={tag} style={{ ...tType('caption'), color: t.ink3,
                        padding: '2px 7px', borderRadius: 99, background: t.hair2,
                        display: 'inline-flex', alignItems: 'center', gap: 4 }}>
                        {TAG_COLORS[tag] && <span style={{ width: 5, height: 5, borderRadius: 99, background: TAG_COLORS[tag] }}/>}
                        {tag}
                      </span>
                    ))}
                    <span style={{ ...tType('caption'), color: t.ink4, fontStyle: 'italic' }}>&middot; {s.place}</span>
                  </div>
                </div>
                <div style={{ color: t.ink4 }}>{TI.chevRight(14, t.ink4)}</div>
              </div>
            ))}
          </div>
        ))}
      </div>
    </div>
  );
}

function SessionDetail({ theme: t, session, onBack }) {
  const s = session || FAKE_SESSIONS[0];
  const verse = TIIDE_VERSES[s.verse || 0];
  const verse2 = TIIDE_VERSES[(s.verse || 0) + 2];
  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title={s.date}
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>}
          right={<span style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>edit</span>} />
      </div>
      <div style={{ overflowY: 'auto', flex: 1, padding: '6px 20px 40px' }}>
        {/* Hero summary */}
        <div style={{ textAlign: 'center', padding: '14px 0 22px' }}>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.18em' }}>{s.time}</div>
          <div style={{ ...tType('displayL'), color: t.ink, fontWeight: 300, marginTop: 6 }}>
            {s.duration}<span style={{ ...tType('body'), color: t.ink3 }}> min</span>
          </div>
          <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic', marginTop: 2 }}>
            {s.outcome === 'orphaned' ? 'retroactively saved' : 'ended at 10:57 pm'}
          </div>
        </div>

        {/* Replay */}
        <TCard theme={t} style={{ padding: 0, overflow: 'hidden', marginBottom: 14 }}>
          <div style={{ position: 'relative', height: 140, background: t.mode === 'dark' ? '#0e1217' : '#e9e2d2' }}>
            <div style={{ position: 'absolute', inset: 0, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <div style={{ transform: 'scale(0.55)', transformOrigin: 'center' }}>
                <TiideVisual kind={window.__TIIDE_VISUAL_KIND || 'tide'} size={300} accent={t.accent} dark={t.mode === 'dark'} />
              </div>
            </div>
            <div style={{ position: 'absolute', bottom: 10, left: 14, right: 14,
              display: 'flex', alignItems: 'center', gap: 10 }}>
              <div style={{ ...tType('caption'), color: t.mode === 'dark' ? t.ink3 : t.ink2 }}>0:00</div>
              <div style={{ flex: 1, height: 2, background: 'rgba(255,255,255,0.2)', borderRadius: 99, position: 'relative' }}>
                <div style={{ position: 'absolute', left: 0, top: 0, bottom: 0, width: '38%', background: t.accent, borderRadius: 99 }} />
                <div style={{ position: 'absolute', left: '38%', top: -3, width: 8, height: 8, borderRadius: 99, background: t.accent, transform: 'translateX(-4px)' }} />
              </div>
              <div style={{ ...tType('caption'), color: t.mode === 'dark' ? t.ink3 : t.ink2 }}>{s.duration}:00</div>
            </div>
          </div>
        </TCard>

        {/* Biometric */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em' }}>heart &middot; hrv</div>
            <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>10 min pre &middot; during</div>
          </div>
          <HRChart theme={t} />
          <div style={{ display: 'flex', gap: 16, marginTop: 10 }}>
            <Stat theme={t} label="HR pre" v="94" u="bpm" />
            <Stat theme={t} label="HR during" v="78" u="bpm" />
            <Stat theme={t} label="HRV gain" v="+11" u="ms" good />
          </div>
        </TCard>

        {/* Tags + note */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 10 }}>tags</div>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
            {s.tags.map(tag => (
              <TiideChip key={tag} label={tag} selected theme={t} color={TAG_COLORS[tag]} size="s" />
            ))}
          </div>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginTop: 16, marginBottom: 8 }}>note</div>
          <div style={{ ...tType('body'), color: t.ink, fontStyle: 'italic', lineHeight: 1.55 }}>
            hit me after reading the text from him. stood at the window. it got smaller.
          </div>
        </TCard>

        {/* Place */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 12 }}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em' }}>place</div>
            <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>{s.place}</div>
          </div>
          <MapCluster theme={t} />
        </TCard>

        {/* Verses that accompanied */}
        <TCard theme={t} style={{ padding: '16px 18px' }}>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 12 }}>verses that accompanied</div>
          {[verse, verse2].map((v, i) => (
            <div key={i} style={{ paddingBottom: i === 0 ? 16 : 0, borderBottom: i === 0 ? `1px solid ${t.hair2}` : 'none', paddingTop: i === 1 ? 14 : 0 }}>
              <div style={{ ...tType('verseS'), color: t.ink, whiteSpace: 'pre-line' }}>{v.text}</div>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 8 }}>
                <div style={{ ...tType('caption'), color: t.ink4, fontStyle: 'italic' }}>— {v.attr}</div>
                <div style={{ color: t.ink3 }}>{TI.bookmark(12, t.ink3)}</div>
              </div>
            </div>
          ))}
        </TCard>
      </div>
    </div>
  );
}

function Stat({ theme: t, label, v, u, good }) {
  return (
    <div style={{ flex: 1 }}>
      <div style={{ ...tType('caption'), color: t.ink4 }}>{label}</div>
      <div style={{ ...tType('title'), color: good ? t.accent : t.ink, marginTop: 2, fontWeight: 400 }}>
        {v}<span style={{ ...tType('caption'), color: t.ink4, marginLeft: 3 }}>{u}</span>
      </div>
    </div>
  );
}

function HRChart({ theme: t }) {
  const pre = [92,94,90,96,98,94,92,90,94,95];
  const dur = [92,88,86,82,80,78,76,75,76,74,73,75,74,72,74];
  const max = 110, min = 60;
  const h = 70;
  const toY = (v) => h - ((v - min) / (max - min)) * h;
  const w1 = 140, w2 = 180;
  const pre_pts = pre.map((v, i) => `${(i/(pre.length-1)) * w1},${toY(v)}`).join(' ');
  const dur_pts = dur.map((v, i) => `${w1 + (i/(dur.length-1)) * w2},${toY(v)}`).join(' ');
  return (
    <svg width="100%" height={h + 10} viewBox={`0 0 ${w1 + w2} ${h + 10}`} style={{ marginTop: 10 }}>
      <line x1={w1} x2={w1} y1={0} y2={h} stroke={t.hair} strokeDasharray="2 3" />
      <polyline points={pre_pts} fill="none" stroke={t.ink4} strokeWidth="1.2" opacity="0.7"/>
      <polyline points={dur_pts} fill="none" stroke={t.accent} strokeWidth="1.6"/>
      <text x={w1 / 2} y={h + 8} fill={t.ink4} fontSize="9" textAnchor="middle" fontFamily={t.font}>pre</text>
      <text x={w1 + w2 / 2} y={h + 8} fill={t.ink4} fontSize="9" textAnchor="middle" fontFamily={t.font}>during</text>
    </svg>
  );
}

Object.assign(window, { SessionsList, SessionDetail, FAKE_SESSIONS });
