import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme.dart';

/// Calming breathing-circle visual that replaces the plain stopwatch.
///
/// The circle slowly pulses (inhale/exhale) while a soft arc encodes
/// session progress. Haptic ticks fire at 5 / 10 / 15 min marks.
class BreathingCircle extends StatefulWidget {
  const BreathingCircle({
    super.key,
    required this.progress,
    required this.elapsedMinutes,
    required this.plannedMinutes,
  });

  /// 0.0 → 1.0 session progress.
  final double progress;

  /// Elapsed minutes (fractional).
  final double elapsedMinutes;

  /// Planned session length in minutes.
  final int plannedMinutes;

  @override
  State<BreathingCircle> createState() => _BreathingCircleState();

  /// Accessibility label describing current state.
  String get semanticLabel {
    final pct = (progress * 100).round();
    final remaining = (plannedMinutes - elapsedMinutes).clamp(0, 999).round();
    return 'Breathing circle, $pct percent complete, '
        'approximately $remaining minutes remaining';
  }
}

class _BreathingCircleState extends State<BreathingCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breathe;
  final _firedTicks = <int>{};

  @override
  void initState() {
    super.initState();
    // 4-second breathing cycle: 2s inhale, 2s exhale.
    _breathe = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant BreathingCircle old) {
    super.didUpdateWidget(old);
    _checkHapticTicks();
  }

  void _checkHapticTicks() {
    for (final mark in [5, 10, 15]) {
      if (mark > widget.plannedMinutes) continue;
      if (widget.elapsedMinutes >= mark && !_firedTicks.contains(mark)) {
        _firedTicks.add(mark);
        HapticFeedback.mediumImpact();
      }
    }
  }

  @override
  void dispose() {
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Semantics(
      label: widget.semanticLabel,
      child: ExcludeSemantics(
        child: reduceMotion
            ? _StaticCircle(progress: widget.progress)
            : AnimatedBuilder(
                animation: _breathe,
                builder: (context, child) {
                  // Breathe scale oscillates between 0.92 and 1.0.
                  final t = Curves.easeInOut.transform(_breathe.value);
                  final scale = 0.92 + 0.08 * t;
                  // Opacity pulse for the glow.
                  final glowOpacity = 0.08 + 0.12 * t;

                  return Transform.scale(
                    scale: scale,
                    child: SizedBox(
                      width: 240,
                      height: 240,
                      child: CustomPaint(
                        painter: _BreathingPainter(
                          progress: widget.progress,
                          glowOpacity: glowOpacity,
                        ),
                        child: const Center(
                          child: Text(
                            'ride it out',
                            style: TextStyle(
                              color: TiideColors.ink3,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

/// S6.3: Reduced-motion fallback — static circle with progress arc, no animation.
class _StaticCircle extends StatelessWidget {
  const _StaticCircle({required this.progress});
  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: CustomPaint(
        painter: _BreathingPainter(progress: progress, glowOpacity: 0.15),
        child: const Center(
          child: Text(
            'ride it out',
            style: TextStyle(
              color: TiideColors.ink3,
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _BreathingPainter extends CustomPainter {
  _BreathingPainter({required this.progress, required this.glowOpacity});

  final double progress;
  final double glowOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    // Background glow ring.
    final glowPaint = Paint()
      ..color = TiideColors.accent.withValues(alpha: glowOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(center, radius, glowPaint);

    // Track ring.
    final trackPaint = Paint()
      ..color = TiideColors.surfaceElev
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc (soft % ring).
    if (progress > 0) {
      final arcPaint = Paint()
        ..color = TiideColors.accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;
      final sweepAngle = 2 * math.pi * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // start at top
        sweepAngle,
        false,
        arcPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_BreathingPainter old) =>
      old.progress != progress || old.glowOpacity != glowOpacity;
}
