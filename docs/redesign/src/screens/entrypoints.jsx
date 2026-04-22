// Tiide — external entry points: lockscreen widget, QS tile, notification

// iOS lockscreen mockup with tiide widget
function LockscreenMock({ theme: t, accent }) {
  return (
    <div style={{
      height: '100%', position: 'relative',
      background: 'linear-gradient(160deg, #0b0d12 0%, #1a1820 40%, #2a1f1a 100%)',
      color: '#fff', overflow: 'hidden',
    }}>
      {/* Soft glow */}
      <div style={{ position: 'absolute', top: -60, left: -40, width: 240, height: 240, borderRadius: 999,
        background: `radial-gradient(circle, ${accent}66 0%, transparent 70%)`, filter: 'blur(20px)' }}/>
      <div style={{ position: 'absolute', bottom: -80, right: -60, width: 280, height: 280, borderRadius: 999,
        background: 'radial-gradient(circle, #8a5a3a44 0%, transparent 70%)', filter: 'blur(30px)' }}/>

      <div style={{ position: 'relative', zIndex: 1, padding: '54px 24px 0', textAlign: 'center', color: '#fff' }}>
        <div style={{ fontSize: 17, fontWeight: 500, opacity: 0.9, marginTop: 8 }}>Tuesday, April 22</div>
        <div style={{ fontSize: 86, fontWeight: 200, lineHeight: 1, letterSpacing: '-0.03em', marginTop: 4 }}>9:41</div>
      </div>

      <div style={{ position: 'relative', zIndex: 1, padding: '40px 16px 0' }}>
        {/* Tiide widget */}
        <div style={{
          background: 'rgba(255,255,255,0.12)',
          backdropFilter: 'blur(20px)', WebkitBackdropFilter: 'blur(20px)',
          borderRadius: 18, padding: '14px 16px',
          border: '0.5px solid rgba(255,255,255,0.15)',
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <div style={{
              width: 40, height: 40, borderRadius: 999, background: accent,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: `0 0 22px ${accent}88`,
            }}>
              <div style={{ width: 12, height: 12, borderRadius: 999, background: '#fff', opacity: 0.95 }}/>
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: t.font, fontSize: 15, fontStyle: 'italic', color: '#fff', letterSpacing: '-0.01em' }}>
                tiide
              </div>
              <div style={{ fontFamily: t.font, fontSize: 12, color: 'rgba(255,255,255,0.65)', marginTop: 1 }}>
                sit with it · 15 min
              </div>
            </div>
            <div style={{
              padding: '6px 14px', borderRadius: 999, background: 'rgba(255,255,255,0.18)',
              fontFamily: t.font, fontSize: 13, color: '#fff',
            }}>start</div>
          </div>
        </div>
      </div>

      {/* flashlight / camera */}
      <div style={{ position: 'absolute', bottom: 60, left: 0, right: 0, display: 'flex', justifyContent: 'space-between', padding: '0 36px' }}>
        {[0,1].map(i => (
          <div key={i} style={{ width: 50, height: 50, borderRadius: 999, background: 'rgba(0,0,0,0.4)',
            display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#fff' }}>
            {i === 0 ? TI.sun(20, '#fff') : TI.wave(20, '#fff')}
          </div>
        ))}
      </div>
    </div>
  );
}

// Notification mockup ("has the wave passed?")
function NotificationMock({ theme: t, accent }) {
  return (
    <div style={{
      height: '100%', position: 'relative',
      background: 'linear-gradient(180deg, #0b0d12 0%, #1a1820 100%)',
      overflow: 'hidden',
    }}>
      <div style={{ position: 'relative', zIndex: 1, padding: '54px 24px 0', textAlign: 'center', color: '#fff' }}>
        <div style={{ fontSize: 15, opacity: 0.75 }}>Tuesday, April 22</div>
        <div style={{ fontSize: 72, fontWeight: 200, lineHeight: 1, letterSpacing: '-0.03em', marginTop: 4 }}>9:56</div>
      </div>

      <div style={{ padding: '32px 10px 0', display: 'flex', flexDirection: 'column', gap: 6 }}>
        {/* Main notification */}
        <div style={{
          background: 'rgba(28,28,32,0.55)',
          backdropFilter: 'blur(28px) saturate(180%)',
          WebkitBackdropFilter: 'blur(28px) saturate(180%)',
          borderRadius: 17, overflow: 'hidden',
          border: '0.5px solid rgba(255,255,255,0.08)',
        }}>
          <div style={{ padding: '12px 14px 8px', display: 'flex', alignItems: 'flex-start', gap: 10 }}>
            <div style={{ width: 38, height: 38, borderRadius: 9, background: accent,
              display: 'flex', alignItems: 'center', justifyContent: 'center', flexShrink: 0 }}>
              <div style={{ width: 10, height: 10, borderRadius: 99, background: '#fff' }}/>
            </div>
            <div style={{ flex: 1, color: '#fff' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ fontSize: 12, fontWeight: 600, letterSpacing: 0.2, opacity: 0.9, fontFamily: '-apple-system' }}>TIIDE</div>
                <div style={{ fontSize: 12, opacity: 0.6, fontFamily: '-apple-system' }}>now</div>
              </div>
              <div style={{ fontFamily: t.font, fontSize: 15, fontStyle: 'italic', marginTop: 2 }}>
                has the wave passed?
              </div>
              <div style={{ fontFamily: t.font, fontSize: 13, opacity: 0.75, marginTop: 2, lineHeight: 1.4 }}>
                15 minutes. your session is ready to close.
              </div>
            </div>
          </div>
          {/* Actions */}
          <div style={{ display: 'flex', borderTop: '0.5px solid rgba(255,255,255,0.08)' }}>
            {[
              { l: 'save & tag', primary: true },
              { l: '+5 min' },
            ].map((a, i) => (
              <div key={i} style={{
                flex: 1, textAlign: 'center', padding: '11px 0',
                fontSize: 15, fontWeight: a.primary ? 500 : 400,
                color: '#fff', borderLeft: i > 0 ? '0.5px solid rgba(255,255,255,0.08)' : 'none',
                fontFamily: '-apple-system, system-ui',
              }}>{a.l}</div>
            ))}
          </div>
        </div>

        {/* Stacked earlier */}
        <div style={{
          background: 'rgba(28,28,32,0.35)',
          backdropFilter: 'blur(20px)', WebkitBackdropFilter: 'blur(20px)',
          borderRadius: 14, padding: '10px 14px',
          border: '0.5px solid rgba(255,255,255,0.06)',
          opacity: 0.7,
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8, color: '#fff' }}>
            <div style={{ width: 22, height: 22, borderRadius: 5, background: accent }} />
            <div style={{ fontSize: 13, opacity: 0.85, fontFamily: '-apple-system' }}>a verse for you</div>
            <div style={{ fontSize: 11, opacity: 0.55, marginLeft: 'auto', fontFamily: '-apple-system' }}>9:50</div>
          </div>
        </div>
      </div>
    </div>
  );
}

// Quick Settings tile (Android-style) — but since user picked iOS,
// show the iOS Control Center "tile" variant + Back-Tap trigger
function ControlCenterMock({ theme: t, accent }) {
  return (
    <div style={{ height: '100%', position: 'relative',
      background: 'linear-gradient(180deg, #15121a 0%, #1f1824 100%)', overflow: 'hidden' }}>
      <div style={{ position: 'absolute', inset: 0, backdropFilter: 'blur(22px)',
        background: 'rgba(30,26,36,0.4)' }} />

      <div style={{ position: 'relative', zIndex: 1, padding: '56px 12px 0' }}>
        <div style={{ color: '#fff', fontFamily: '-apple-system', fontSize: 15, fontWeight: 500, padding: '0 10px 12px', opacity: 0.95 }}>
          Control Center
        </div>
        {/* Tile rows */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
          {/* Connectivity cluster */}
          <div style={{ gridColumn: '1 / 2', background: 'rgba(255,255,255,0.12)', borderRadius: 18, padding: 10,
            display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8, aspectRatio: '1', backdropFilter: 'blur(20px)' }}>
            {[0,1,2,3].map(i => (
              <div key={i} style={{ borderRadius: 99, background: i === 0 ? '#22a8ff' : 'rgba(255,255,255,0.15)', aspectRatio: 1 }} />
            ))}
          </div>
          <div style={{ background: 'rgba(255,255,255,0.12)', borderRadius: 18, padding: 12, aspectRatio: '1', backdropFilter: 'blur(20px)' }}>
            <div style={{ width: 12, height: 4, borderRadius: 99, background: '#fff', opacity: 0.6 }} />
            <div style={{ marginTop: 26, height: 3, background: '#fff', opacity: 0.6, borderRadius: 99, width: '70%' }} />
          </div>
          {/* Volume + brightness */}
          <div style={{ background: 'rgba(255,255,255,0.12)', borderRadius: 18, padding: 8, aspectRatio: '0.5', backdropFilter: 'blur(20px)', position: 'relative' }}>
            <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, top: '40%', background: '#fff', opacity: 0.9, borderRadius: '0 0 12px 12px' }}/>
          </div>
          <div style={{ background: 'rgba(255,255,255,0.12)', borderRadius: 18, padding: 8, aspectRatio: '0.5', backdropFilter: 'blur(20px)', position: 'relative' }}>
            <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, top: '30%', background: '#fff', opacity: 0.85, borderRadius: '0 0 12px 12px' }}/>
          </div>

          {/* TIIDE tile — custom */}
          <div style={{
            gridColumn: '1 / 3', background: `linear-gradient(135deg, ${accent}cc, ${accent}66)`,
            borderRadius: 18, padding: '16px 18px',
            display: 'flex', alignItems: 'center', gap: 14,
            border: '0.5px solid rgba(255,255,255,0.15)',
          }}>
            <div style={{ width: 44, height: 44, borderRadius: 99, background: 'rgba(255,255,255,0.9)',
              display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
              <div style={{ width: 14, height: 14, borderRadius: 99, background: accent }}/>
            </div>
            <div style={{ flex: 1, color: '#fff' }}>
              <div style={{ fontFamily: t.font, fontSize: 18, fontStyle: 'italic' }}>sit with it</div>
              <div style={{ fontFamily: t.font, fontSize: 12, opacity: 0.85, fontStyle: 'italic' }}>start a 15-min tiide session</div>
            </div>
            <div style={{ fontFamily: t.font, fontSize: 11, opacity: 0.8, color: '#fff',
              border: '0.5px solid rgba(255,255,255,0.5)', borderRadius: 99, padding: '4px 10px' }}>
              tap
            </div>
          </div>
        </div>

        <div style={{ color: 'rgba(255,255,255,0.55)', fontSize: 11, textAlign: 'center',
          fontFamily: t.font, fontStyle: 'italic', padding: '22px 20px 0', lineHeight: 1.5 }}>
          also: double-tap the back of your phone (settings → touch → back tap)
        </div>
      </div>
    </div>
  );
}

Object.assign(window, { LockscreenMock, NotificationMock, ControlCenterMock });
