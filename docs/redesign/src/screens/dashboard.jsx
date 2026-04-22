// Tiide — Dashboard (full depth)

function Dashboard({ theme, onBack }) {
  const t = theme;
  // 7x24 heatmap data — morning valleys, 10pm + 2am spikes
  const heat = [];
  for (let d = 0; d < 7; d++) {
    const row = [];
    for (let h = 0; h < 24; h++) {
      let v = 0;
      if (h >= 22 || h <= 2) v = 0.6 + Math.random() * 0.4;
      else if (h >= 17 && h <= 20) v = 0.25 + Math.random() * 0.35;
      else if (h >= 8 && h <= 10) v = 0.15 + Math.random() * 0.25;
      else v = Math.random() * 0.18;
      row.push(v);
    }
    heat.push(row);
  }
  const days = ['M','T','W','T','F','S','S'];

  // Duration histogram — 5/10/15/20/25/30
  const hist = [4, 8, 22, 11, 3, 2];

  // Tag counts
  const tags = [
    { label: 'anxiety', n: 18, c: TAG_COLORS.anxiety },
    { label: 'craving', n: 14, c: TAG_COLORS.craving },
    { label: 'loneliness', n: 9, c: TAG_COLORS.loneliness },
    { label: 'boredom', n: 7, c: TAG_COLORS.boredom },
    { label: 'anger', n: 4, c: TAG_COLORS.anger },
    { label: 'grief', n: 2, c: TAG_COLORS.grief },
  ];

  return (
    <div style={{ height: '100%', background: t.bg, color: t.ink, display: 'flex', flexDirection: 'column' }}>
      <div style={{ paddingTop: 50 }}>
        <TiideHeader theme={t} title="dashboard"
          left={<button onClick={onBack} style={{ background: 'none', border: 'none', color: t.ink2, padding: 4, cursor: 'pointer' }}>{TI.back(22, t.ink2)}</button>}
          right={<span style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>this week</span>} />
      </div>

      <div style={{ overflowY: 'auto', flex: 1, padding: '8px 20px 40px' }}>
        {/* Top KPIs */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 20 }}>
          {[
            { v: '14', l: 'sessions' },
            { v: '3h 42m', l: 'sit-time' },
            { v: '23', l: 'day streak' },
          ].map((k,i) => (
            <TCard key={i} theme={t} style={{ padding: '14px 12px', textAlign: 'center' }}>
              <div style={{ ...tType('displayL'), color: t.ink, fontWeight: 300 }}>{k.v}</div>
              <div style={{ ...tType('caption'), color: t.ink4, marginTop: 2 }}>{k.l}</div>
            </TCard>
          ))}
        </div>

        {/* Streak — days sat with it */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'baseline' }}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em' }}>days sat with it</div>
            <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>last 4 weeks</div>
          </div>
          <div style={{ display: 'flex', gap: 4, marginTop: 14 }}>
            {Array.from({length: 28}).map((_, i) => {
              const hasSession = [0,1,3,4,5,7,8,9,11,12,14,15,17,18,19,20,21,22,23,25,26,27].includes(i);
              return (
                <div key={i} style={{
                  flex: 1, aspectRatio: '1 / 1', borderRadius: 4,
                  background: hasSession ? t.accent : t.hair2,
                  opacity: hasSession ? (i > 20 ? 1 : 0.55 + i * 0.02) : 1,
                }}/>
              );
            })}
          </div>
          <div style={{ ...tType('caption'), color: t.ink4, marginTop: 10, textAlign: 'center' }}>
            23 consecutive days. longest: 31.
          </div>
        </TCard>

        {/* 7x24 heatmap */}
        <TCard theme={t} style={{ padding: '16px 14px', marginBottom: 14 }}>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', padding: '0 4px 10px' }}>
            time of day
          </div>
          <div style={{ display: 'flex', gap: 6 }}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: 3, paddingTop: 12 }}>
              {days.map((d,i) => <div key={i} style={{ ...tType('caption'), color: t.ink4, height: 14, lineHeight: '14px' }}>{d}</div>)}
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', ...tType('caption'), color: t.ink4, padding: '0 1px 4px' }}>
                <span>12a</span><span>6a</span><span>12p</span><span>6p</span><span>12a</span>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', gap: 3 }}>
                {heat.map((row, ri) => (
                  <div key={ri} style={{ display: 'flex', gap: 2, height: 14 }}>
                    {row.map((v, hi) => (
                      <div key={hi} style={{
                        flex: 1, borderRadius: 2,
                        background: v < 0.05 ? t.hair2 : t.accent,
                        opacity: v < 0.05 ? 1 : Math.min(1, v + 0.15),
                      }}/>
                    ))}
                  </div>
                ))}
              </div>
            </div>
          </div>
          <div style={{ ...tType('caption'), color: t.ink4, marginTop: 12, textAlign: 'center', fontStyle: 'italic' }}>
            late-night peaks. mornings are quiet.
          </div>
        </TCard>

        {/* Insight cards */}
        <div style={{ marginBottom: 14 }}>
          <InsightCard theme={t}
            eyebrow="pattern"
            title="waves tend to come after 10pm"
            body="68% of your sessions start between 10pm and 2am. the average wave lasts about 14 minutes — then passes."
          />
          <InsightCard theme={t}
            eyebrow="biometric"
            title="HRV recovers by end of session"
            body="during sit-time, HRV drops 8ms on average, then recovers above baseline within ~6 min after. shown in session detail."
          />
          <InsightCard theme={t}
            eyebrow="place"
            title="home is your quiet place"
            body="sessions at home are shorter on average (11 min) than elsewhere (19 min). driving sessions tend to extend."
          />
        </div>

        {/* Tag bar */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em', marginBottom: 14 }}>by tag</div>
          {tags.map((tag, i) => (
            <div key={i} style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 10 }}>
              <div style={{ width: 86, ...tType('meta'), color: t.ink2 }}>{tag.label}</div>
              <div style={{ flex: 1, height: 7, background: t.hair2, borderRadius: 99, overflow: 'hidden' }}>
                <div style={{ width: `${tag.n * 4}%`, height: '100%', background: tag.c, opacity: 0.85, borderRadius: 99 }} />
              </div>
              <div style={{ width: 24, textAlign: 'right', ...tType('caption'), color: t.ink4 }}>{tag.n}</div>
            </div>
          ))}
        </TCard>

        {/* Duration histogram */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between' }}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em' }}>duration</div>
            <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>15 min, most often</div>
          </div>
          <div style={{ display: 'flex', alignItems: 'flex-end', gap: 8, height: 80, marginTop: 16 }}>
            {hist.map((h, i) => {
              const max = Math.max(...hist);
              return (
                <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6 }}>
                  <div style={{
                    width: '100%', height: `${(h/max)*100}%`,
                    background: i === 2 ? t.accent : t.hair, borderRadius: 3,
                    opacity: i === 2 ? 0.9 : 1,
                  }}/>
                  <div style={{ ...tType('caption'), color: i === 2 ? t.ink2 : t.ink4 }}>{[5,10,15,20,25,30][i]}</div>
                </div>
              );
            })}
          </div>
        </TCard>

        {/* Geo clusters */}
        <TCard theme={t} style={{ padding: '16px 18px', marginBottom: 14 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 12 }}>
            <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase', letterSpacing: '0.14em' }}>places</div>
            <div style={{ ...tType('meta'), color: t.ink3, fontStyle: 'italic' }}>edit names</div>
          </div>
          <MapCluster theme={t} />
          <div style={{ marginTop: 12 }}>
            {[
              { name: 'home', count: 42, pct: 0.52 },
              { name: 'the blue car', count: 18, pct: 0.22 },
              { name: "mom's", count: 9, pct: 0.11 },
              { name: 'bar on 6th', count: 5, pct: 0.06 },
            ].map((g, i) => (
              <div key={i} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                padding: '8px 0', borderBottom: i < 3 ? `1px solid ${t.hair2}` : 'none' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  {TI.pin(14, t.ink3)}
                  <span style={{ ...tType('body'), color: t.ink, fontStyle: 'italic' }}>{g.name}</span>
                </div>
                <span style={{ ...tType('meta'), color: t.ink3 }}>{g.count} sessions</span>
              </div>
            ))}
          </div>
        </TCard>

        {/* Most saved verses */}
        <div style={{ ...tType('caption'), color: t.ink4, textTransform: 'uppercase',
          letterSpacing: '0.14em', padding: '6px 4px 10px' }}>most saved verses</div>
        <div style={{ display: 'flex', gap: 10, overflowX: 'auto', margin: '0 -20px', padding: '0 20px' }}>
          {TIIDE_VERSES.slice(0, 4).map((v, i) => (
            <div key={i} style={{
              minWidth: 200, padding: '16px 16px', borderRadius: 14,
              background: t.surface, border: `1px solid ${t.hair2}`,
            }}>
              <div style={{ ...tType('verseS'), color: t.ink, whiteSpace: 'pre-line',
                overflow: 'hidden', display: '-webkit-box', WebkitLineClamp: 3, WebkitBoxOrient: 'vertical' }}>
                {v.text}
              </div>
              <div style={{ ...tType('caption'), color: t.ink4, marginTop: 10,
                fontStyle: 'italic' }}>— {v.attr} &middot; saved {[8,6,5,4][i]}×</div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

function InsightCard({ theme: t, eyebrow, title, body }) {
  return (
    <div style={{
      background: t.surface, borderRadius: 14, padding: '16px 18px',
      border: `1px solid ${t.hair2}`, marginBottom: 8,
      borderLeft: `2px solid ${t.accent}`,
    }}>
      <div style={{ ...tType('caption'), color: t.accent, textTransform: 'uppercase',
        letterSpacing: '0.14em', marginBottom: 6 }}>{eyebrow}</div>
      <div style={{ ...tType('title'), color: t.ink, marginBottom: 4 }}>{title}</div>
      <div style={{ ...tType('body'), color: t.ink3, fontStyle: 'italic', lineHeight: 1.55 }}>{body}</div>
    </div>
  );
}

function MapCluster({ theme: t }) {
  return (
    <div style={{
      position: 'relative', height: 140, borderRadius: 10, overflow: 'hidden',
      background: t.mode === 'dark' ? '#181e26' : '#e9e2d2',
      border: `1px solid ${t.hair2}`,
    }}>
      {/* abstract map strokes */}
      <svg width="100%" height="100%" viewBox="0 0 300 140" style={{ position: 'absolute', inset: 0 }}>
        <path d="M0 80 Q50 60 100 78 T200 78 T300 70" stroke={t.hair} strokeWidth="1" fill="none"/>
        <path d="M0 100 L80 100 L90 85 L160 85 L170 110 L300 110" stroke={t.hair} strokeWidth="1" fill="none"/>
        <path d="M40 0 L40 140" stroke={t.hair2} strokeWidth="0.5"/>
        <path d="M140 0 L140 140" stroke={t.hair2} strokeWidth="0.5"/>
        <path d="M220 0 L220 140" stroke={t.hair2} strokeWidth="0.5"/>
        {/* clusters */}
        <circle cx="80" cy="70" r="22" fill={t.accent} opacity="0.12"/>
        <circle cx="80" cy="70" r="10" fill={t.accent} opacity="0.6"/>
        <circle cx="180" cy="95" r="16" fill={t.accent} opacity="0.12"/>
        <circle cx="180" cy="95" r="7" fill={t.accent} opacity="0.55"/>
        <circle cx="240" cy="50" r="8" fill={t.accent} opacity="0.5"/>
        <circle cx="120" cy="40" r="6" fill={t.accent} opacity="0.4"/>
      </svg>
    </div>
  );
}

Object.assign(window, { Dashboard, InsightCard, MapCluster });
