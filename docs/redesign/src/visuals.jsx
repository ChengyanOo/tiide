// Tiide — calming abstract visuals. SVG + CSS animation, no libs.
// Three metaphors: tide (horizon/wave), breath (pulsing ring), ink (soft wash).
// All respect ~4-7-8 / tidal cadence. `size` controls canvas px.

function TideVisual({ size = 300, accent = '#4a6b7c', dark = false, paused = false }) {
  // Horizon + two tidal waves breathing in/out
  const id = React.useId();
  return (
    <svg width={size} height={size} viewBox="0 0 300 300" style={{ display: 'block' }}>
      <defs>
        <radialGradient id={`${id}-sky`} cx="0.5" cy="0.35" r="0.75">
          <stop offset="0" stopColor={dark ? '#2a3644' : '#e9e2d2'} />
          <stop offset="1" stopColor={dark ? '#0e1217' : '#f3efe6'} />
        </radialGradient>
        <linearGradient id={`${id}-sea`} x1="0" y1="0" x2="0" y2="1">
          <stop offset="0" stopColor={accent} stopOpacity={dark ? 0.55 : 0.35} />
          <stop offset="1" stopColor={accent} stopOpacity={dark ? 0.85 : 0.55} />
        </linearGradient>
      </defs>
      <rect width="300" height="300" fill={`url(#${id}-sky)`} />
      {/* sun/moon */}
      <circle cx="150" cy="120" r="34" fill={dark ? '#e8e3d7' : '#f4e9d2'} opacity={dark ? 0.12 : 0.55}>
        <animate attributeName="r" values="34;36;34" dur="11s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
      </circle>
      {/* horizon */}
      <rect x="0" y="180" width="300" height="120" fill={`url(#${id}-sea)`} />
      {/* waves */}
      <g style={{ mixBlendMode: dark ? 'screen' : 'multiply' }}>
        <path d="M0 200 Q75 188 150 200 T300 200 L300 210 L0 210 Z" fill={accent} opacity="0.25">
          <animate attributeName="d"
            values="M0 200 Q75 188 150 200 T300 200 L300 210 L0 210 Z;
                    M0 200 Q75 212 150 200 T300 200 L300 210 L0 210 Z;
                    M0 200 Q75 188 150 200 T300 200 L300 210 L0 210 Z"
            dur="11s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </path>
        <path d="M0 220 Q60 215 150 222 T300 220 L300 240 L0 240 Z" fill={accent} opacity="0.3">
          <animate attributeName="d"
            values="M0 220 Q60 215 150 222 T300 220 L300 240 L0 240 Z;
                    M0 220 Q60 228 150 218 T300 220 L300 240 L0 240 Z;
                    M0 220 Q60 215 150 222 T300 220 L300 240 L0 240 Z"
            dur="9s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </path>
        <path d="M0 250 Q75 246 150 252 T300 250 L300 300 L0 300 Z" fill={accent} opacity="0.45" />
      </g>
    </svg>
  );
}

function BreathVisual({ size = 300, accent = '#4a6b7c', dark = false, paused = false }) {
  // Concentric rings breathing on a 4-7-8 cadence (~19s cycle)
  const rings = [110, 90, 70, 50];
  return (
    <svg width={size} height={size} viewBox="0 0 300 300" style={{ display: 'block' }}>
      <rect width="300" height="300" fill={dark ? '#0e1217' : '#f3efe6'} />
      <g transform="translate(150 150)">
        {rings.map((r, i) => (
          <circle key={i} cx="0" cy="0" r={r} fill="none" stroke={accent}
            strokeWidth={0.8 + (rings.length - i) * 0.4}
            opacity={0.15 + i * 0.12}>
            <animate attributeName="r"
              values={`${r};${r * 1.18};${r * 1.18};${r * 0.92};${r}`}
              keyTimes="0;0.21;0.58;0.79;1"
              dur="19s" repeatCount="indefinite" begin={paused ? 'indefinite' : `${-i * 0.4}s`} />
            <animate attributeName="opacity"
              values={`${0.2 + i * 0.1};${0.4 + i * 0.12};${0.35 + i * 0.1};${0.15 + i * 0.08};${0.2 + i * 0.1}`}
              keyTimes="0;0.21;0.58;0.79;1"
              dur="19s" repeatCount="indefinite" begin={paused ? 'indefinite' : `${-i * 0.4}s`} />
          </circle>
        ))}
        <circle cx="0" cy="0" r="22" fill={accent} opacity={dark ? 0.5 : 0.35}>
          <animate attributeName="r" values="22;26;26;20;22"
            keyTimes="0;0.21;0.58;0.79;1"
            dur="19s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </circle>
      </g>
    </svg>
  );
}

function InkVisual({ size = 300, accent = '#4a6b7c', dark = false, paused = false }) {
  // Soft ink-wash clouds that drift
  const id = React.useId();
  return (
    <svg width={size} height={size} viewBox="0 0 300 300" style={{ display: 'block' }}>
      <defs>
        <radialGradient id={`${id}-p`} cx="0.5" cy="0.5" r="0.5">
          <stop offset="0" stopColor={accent} stopOpacity="0.5" />
          <stop offset="0.6" stopColor={accent} stopOpacity="0.2" />
          <stop offset="1" stopColor={accent} stopOpacity="0" />
        </radialGradient>
        <filter id={`${id}-f`}><feGaussianBlur stdDeviation="6" /></filter>
      </defs>
      <rect width="300" height="300" fill={dark ? '#0e1217' : '#efe9dc'} />
      <g filter={`url(#${id}-f)`}>
        <circle cx="110" cy="140" r="80" fill={`url(#${id}-p)`}>
          <animate attributeName="cx" values="110;135;110" dur="17s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
          <animate attributeName="r" values="80;95;80" dur="17s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </circle>
        <circle cx="190" cy="170" r="70" fill={`url(#${id}-p)`}>
          <animate attributeName="cx" values="190;170;190" dur="21s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
          <animate attributeName="cy" values="170;185;170" dur="21s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </circle>
        <circle cx="150" cy="200" r="55" fill={`url(#${id}-p)`} opacity="0.8">
          <animate attributeName="r" values="55;70;55" dur="14s" repeatCount="indefinite" begin={paused ? 'indefinite' : '0s'} />
        </circle>
      </g>
    </svg>
  );
}

// Progress ring — ambient, no tick marks, slow
function ProgressRing({ size = 260, stroke = 2, progress = 0, accent = '#4a6b7c', track = 'rgba(255,255,255,0.12)' }) {
  const r = size / 2 - stroke * 2;
  const c = 2 * Math.PI * r;
  const off = c * (1 - progress);
  return (
    <svg width={size} height={size} viewBox={`0 0 ${size} ${size}`} style={{ display: 'block' }}>
      <circle cx={size/2} cy={size/2} r={r} fill="none" stroke={track} strokeWidth={stroke} />
      <circle cx={size/2} cy={size/2} r={r} fill="none" stroke={accent} strokeWidth={stroke + 0.5}
        strokeDasharray={c} strokeDashoffset={off} strokeLinecap="round"
        transform={`rotate(-90 ${size/2} ${size/2})`}
        style={{ transition: 'stroke-dashoffset 1.6s linear' }} />
    </svg>
  );
}

// Identity pulse — the tiny dot next to "tiide"
function IdentityPulse({ color = '#4a6b7c', size = 6 }) {
  return (
    <span style={{
      display: 'inline-block', width: size, height: size, borderRadius: 9999,
      background: color, marginLeft: 6, marginBottom: 2,
      animation: 'tiidePulse 4.5s ease-in-out infinite',
      verticalAlign: 'middle',
    }} />
  );
}

function TiideVisual({ kind = 'tide', ...props }) {
  if (kind === 'breath') return <BreathVisual {...props} />;
  if (kind === 'ink') return <InkVisual {...props} />;
  return <TideVisual {...props} />;
}

Object.assign(window, { TideVisual, BreathVisual, InkVisual, ProgressRing, IdentityPulse, TiideVisual });
