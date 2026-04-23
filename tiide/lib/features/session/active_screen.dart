import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/session_controller.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../tag/tag_picker_sheet.dart';

const kMaxExtensions = 3;

// Dark ink palette used only on the active screen (full-bleed immersion).
const _darkBg = Color(0xFF0E1217);
const _darkInk = Color(0xFFE8E3D7);
const _darkInk2 = Color(0xFFBFB8A8);
const _darkInk3 = Color(0xFF8B8376);
const _darkInk4 = Color(0x8FBFB8A8);

const _verses = [
  ('be still, and know', 'psalm 46:10'),
  ('this too shall pass', 'proverb'),
  ('the wave that rises also falls', '—'),
  ('my grace is sufficient', '2 cor 12:9'),
];

class ActiveScreen extends ConsumerStatefulWidget {
  const ActiveScreen({super.key});

  @override
  ConsumerState<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends ConsumerState<ActiveScreen> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final active = ref.watch(activeSessionProvider);
    return Scaffold(
      backgroundColor: _darkBg,
      body: active.when(
        loading: () => const Center(
          child:
              CircularProgressIndicator(color: _darkInk2, strokeWidth: 1.5),
        ),
        error: (e, _) => Center(
          child: Text('$e', style: const TextStyle(color: _darkInk2)),
        ),
        data: (s) {
          if (s == null) {
            return const Center(
              child: Text('no active session',
                  style: TextStyle(color: _darkInk3)),
            );
          }
          return _ActiveBody(session: s);
        },
      ),
    );
  }
}

class _ActiveBody extends ConsumerStatefulWidget {
  const _ActiveBody({required this.session});
  final Session session;

  @override
  ConsumerState<_ActiveBody> createState() => _ActiveBodyState();
}

class _ActiveBodyState extends ConsumerState<_ActiveBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breathe;
  bool _showTime = false;

  @override
  void initState() {
    super.initState();
    _breathe = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.session;
    final planned = Duration(minutes: s.plannedDurationMin);
    final elapsed = DateTime.now().difference(s.startedAt);
    final progress =
        (elapsed.inMilliseconds / planned.inMilliseconds).clamp(0.0, 1.0);
    final canExtend = s.extensionCount < kMaxExtensions;
    final verse = _verses[s.id.hashCode.abs() % _verses.length];

    return SafeArea(
      child: Column(
        children: [
          // Top chrome.
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _GlassButton(
                  icon: Icons.close,
                  onTap: () => context.go('/'),
                ),
                const Text(
                  'tiide',
                  style: TextStyle(
                    fontFamily: tiideSerif,
                    fontStyle: FontStyle.italic,
                    fontSize: 17,
                    color: _darkInk,
                  ),
                ),
                const Icon(Icons.waves,
                    color: _darkInk3, size: 18),
              ],
            ),
          ),

          // Ambient visual.
          Expanded(
            child: GestureDetector(
              onLongPressStart: (_) => setState(() => _showTime = true),
              onLongPressEnd: (_) => setState(() => _showTime = false),
              behavior: HitTestBehavior.opaque,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _breathe,
                      builder: (_, _) {
                        return CustomPaint(
                          size: Size.infinite,
                          painter: _AmbientPainter(
                            progress: progress,
                            breathe:
                                Curves.easeInOut.transform(_breathe.value),
                          ),
                        );
                      },
                    ),
                  ),
                  const Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment(0, 0.1),
                            radius: 1.2,
                            colors: [
                              Colors.transparent,
                              Color(0x66000000),
                            ],
                            stops: [0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_showTime)
                    Center(
                      child: Text(
                        formatMMSS(planned - elapsed, padMinutes: true),
                        style: const TextStyle(
                          fontFamily: tiideSerif,
                          fontStyle: FontStyle.italic,
                          fontSize: 56,
                          fontWeight: FontWeight.w300,
                          color: _darkInk,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Bottom: verse + hint + actions.
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  verse.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: tiideSerif,
                    fontStyle: FontStyle.italic,
                    fontSize: 22,
                    color: _darkInk,
                    height: 1.55,
                    shadows: [
                      Shadow(color: Color(0xB3000000), blurRadius: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '— ${verse.$2}',
                  style: const TextStyle(
                    fontFamily: tiideSerif,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    letterSpacing: 1.2,
                    color: _darkInk4,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'YOU’LL BE NOTIFIED WHEN THE WAVE PASSES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: tiideSerif,
                    fontSize: 10,
                    letterSpacing: 2.4,
                    color: _darkInk4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (canExtend)
                      _GhostButton(
                        label: '+5 min',
                        onTap: () => _extend(s),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'max time reached',
                          style: TextStyle(
                            fontFamily: tiideSerif,
                            fontStyle: FontStyle.italic,
                            color: _darkInk3,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    _GhostButton(
                      label: 'end now',
                      filled: true,
                      onTap: () => _stop(s, elapsed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _extend(Session s) async {
    await ref.read(sessionControllerProvider).extend(s.id, minutes: 5);
  }

  Future<void> _stop(Session s, Duration elapsed) async {
    final picked = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: TiideColors.surface,
      builder: (_) => const TagPickerSheet(),
    );
    if (picked == null) return;

    final minutes = elapsed.inSeconds <= 0
        ? 1
        : (elapsed.inSeconds / 60).ceil().clamp(1, s.plannedDurationMin);
    await ref.read(sessionControllerProvider).finalize(
          id: s.id,
          actualDurationMin: minutes,
          tagIds: picked,
        );
    if (mounted) context.go('/');
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: _darkInk, size: 18),
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton(
      {required this.label, required this.onTap, this.filled = false});
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
        decoration: BoxDecoration(
          color: filled
              ? Colors.white.withValues(alpha: 0.14)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: Colors.white.withValues(alpha: filled ? 0 : 0.25),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontFamily: tiideSerif,
            fontSize: 14,
            color: _darkInk,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

class _AmbientPainter extends CustomPainter {
  _AmbientPainter({required this.progress, required this.breathe});
  final double progress;
  final double breathe;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;
    final center = Offset(size.width / 2, size.height / 2);
    final scale = 0.94 + 0.06 * breathe;
    final baseR = math.min(size.width, size.height) * 0.34 * scale;

    // Soft glow.
    final glowR = baseR + 40;
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.08 + 0.06 * breathe),
          Colors.white.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: glowR));
    canvas.drawCircle(center, glowR, glow);

    // Faint track ring.
    final track = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, baseR, track);

    // Progress ring.
    if (progress > 0) {
      final arc = Paint()
        ..color = Colors.white.withValues(alpha: 0.85)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: baseR),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        arc,
      );
    }
  }

  @override
  bool shouldRepaint(_AmbientPainter old) =>
      old.progress != progress || old.breathe != breathe;
}
