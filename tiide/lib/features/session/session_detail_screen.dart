import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/tag_colors.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../../data/repo/session_repo.dart';
import '../../shared/eyebrow.dart';
import '../../shared/ink_card.dart';
import 'breathing_circle.dart';
import 'retro_edit_sheet.dart';

class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionDetailProvider(sessionId));
    final snapshotAsync = ref.watch(biometricSnapshotProvider(sessionId));
    final geoAsync = ref.watch(geoPointsProvider(sessionId));
    final place =
        ref.watch(sessionPlacesProvider).valueOrNull?[sessionId];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 22),
          onPressed: () => context.pop(),
        ),
        title: sessionAsync.when(
          loading: () => const Text(''),
          error: (_, _) => const Text(''),
          data: (row) => Text(row == null
              ? ''
              : formatSessionDateBucket(
                  row.session.startedAt, DateTime.now())),
        ),
        actions: [
          sessionAsync.maybeWhen(
            data: (row) => row == null
                ? const SizedBox.shrink()
                : TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) =>
                            RetroEditSheet(session: row.session),
                      );
                    },
                    child: const Text('edit',
                        style: TextStyle(
                            color: TiideColors.ink3,
                            fontStyle: FontStyle.italic,
                            fontSize: 14)),
                  ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (row) {
          if (row == null) {
            return const Center(
              child: Text('session not found',
                  style: TextStyle(color: TiideColors.ink3)),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(
                TiideSpacing.l, TiideSpacing.s, TiideSpacing.l, TiideSpacing.xl),
            children: [
              _Hero(row: row),
              const SizedBox(height: TiideSpacing.s),
              _ReplayCard(session: row.session),
              const SizedBox(height: TiideSpacing.m),
              snapshotAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (snap) => snap == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding:
                            const EdgeInsets.only(bottom: TiideSpacing.m),
                        child: _BiometricCard(snapshot: snap),
                      ),
              ),
              _TagsAndNoteCard(row: row),
              const SizedBox(height: TiideSpacing.m),
              geoAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
                data: (points) => points.isEmpty
                    ? const SizedBox.shrink()
                    : _PlaceCard(place: place, points: points),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Hero ───────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero({required this.row});
  final SessionWithTags row;

  @override
  Widget build(BuildContext context) {
    final s = row.session;
    final mins = s.actualDurationMin ?? s.plannedDurationMin;
    final trailing = s.endedAt == null
        ? (s.outcome == 'orphaned' ? 'retroactively saved' : '')
        : 'ended at ${formatTimeOfDay(s.endedAt!)}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TiideSpacing.m),
      child: Column(
        children: [
          Text(formatTimeOfDay(s.startedAt).toUpperCase(),
              style: const TextStyle(
                  color: TiideColors.ink4,
                  fontSize: 11,
                  letterSpacing: 2.2)),
          const SizedBox(height: 6),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontFamily: tiideSerif,
                fontSize: 48,
                fontWeight: FontWeight.w300,
                color: TiideColors.ink,
                height: 1.1,
              ),
              children: [
                TextSpan(text: '$mins'),
                const TextSpan(
                  text: ' min',
                  style: TextStyle(
                      fontSize: 18,
                      color: TiideColors.ink3,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          if (trailing.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(trailing,
                style: const TextStyle(
                    color: TiideColors.ink3,
                    fontSize: 13,
                    fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}

// ─── Replay (breathing circle animation) ───────────────────

class _ReplayCard extends StatefulWidget {
  const _ReplayCard({required this.session});
  final Session session;
  @override
  State<_ReplayCard> createState() => _ReplayCardState();
}

class _ReplayCardState extends State<_ReplayCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _playing = false;

  int get _durationMin =>
      widget.session.actualDurationMin ?? widget.session.plannedDurationMin;

  @override
  void initState() {
    super.initState();
    final replaySeconds = (_durationMin / 5 * 60).clamp(10, 360).round();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: replaySeconds),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _playing = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      if (_playing) {
        _controller.stop();
        _playing = false;
      } else {
        if (_controller.isCompleted) _controller.reset();
        _controller.forward();
        _playing = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: InkCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(TiideRadius.card),
          child: Container(
            height: 160,
            color: TiideColors.mapCanvas,
            child: Stack(
              children: [
                Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, _) => Transform.scale(
                      scale: 0.55,
                      child: BreathingCircle(
                        progress: _controller.value,
                        elapsedMinutes: _controller.value * _durationMin,
                        plannedMinutes: _durationMin,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 10,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, _) {
                      final frac = _controller.value;
                      return Row(
                        children: [
                          const Text('0:00',
                              style: TextStyle(
                                  color: TiideColors.ink2, fontSize: 11)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(
                                        alpha: 0.15),
                                    borderRadius:
                                        BorderRadius.circular(99),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: frac.clamp(0.0, 1.0),
                                  child: Container(
                                    height: 2,
                                    decoration: BoxDecoration(
                                      color: TiideColors.accent,
                                      borderRadius:
                                          BorderRadius.circular(99),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                              formatMMSS(Duration(seconds: _durationMin * 60)),
                              style: const TextStyle(
                                  color: TiideColors.ink2, fontSize: 11)),
                          const SizedBox(width: 6),
                          Icon(_playing ? Icons.pause : Icons.play_arrow,
                              size: 14, color: TiideColors.ink2),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Biometrics ────────────────────────────────────────────

class _BiometricCard extends ConsumerWidget {
  const _BiometricCard({required this.snapshot});
  final BiometricSnapshot snapshot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final samplesAsync =
        ref.watch(biometricSamplesProvider(snapshot.id));
    final pre = snapshot.hrAvgPre;
    final dur = snapshot.hrAvgDuring;
    final hrvGain = (snapshot.hrvAvgDuring != null &&
            snapshot.hrvAvgPre != null)
        ? (snapshot.hrvAvgDuring! - snapshot.hrvAvgPre!)
        : null;

    return InkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Eyebrow('heart · hrv',
              trailing: const Text('10 min pre · during',
                  style: TextStyle(
                      color: TiideColors.ink3,
                      fontSize: 12,
                      fontStyle: FontStyle.italic))),
          const SizedBox(height: 10),
          samplesAsync.when(
            loading: () => const SizedBox(height: 80),
            error: (_, _) => const SizedBox(height: 80),
            data: (samples) {
              final hr = samples.where((s) => s.metric == 'hr').toList();
              if (hr.isEmpty) return const SizedBox(height: 80);
              final startedAt = samples
                  .map((s) => s.ts)
                  .reduce((a, b) => a.isBefore(b) ? a : b);
              return SizedBox(
                height: 90,
                child: CustomPaint(
                  painter: _HrChartPainter(
                    samples: hr,
                    sessionStart: startedAt,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: _Stat(
                      label: 'HR pre',
                      value: pre?.round().toString() ?? '—',
                      unit: 'bpm')),
              Expanded(
                  child: _Stat(
                      label: 'HR during',
                      value: dur?.round().toString() ?? '—',
                      unit: 'bpm')),
              Expanded(
                  child: _Stat(
                      label: 'HRV gain',
                      value: hrvGain == null
                          ? '—'
                          : '${hrvGain > 0 ? '+' : ''}${hrvGain.round()}',
                      unit: 'ms',
                      good: hrvGain != null && hrvGain > 0)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.value,
    required this.unit,
    this.good = false,
  });
  final String label;
  final String value;
  final String unit;
  final bool good;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: TiideColors.ink4, fontSize: 11)),
        const SizedBox(height: 2),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: good ? TiideColors.accent : TiideColors.ink,
                fontFamily: tiideSerif,
                fontSize: 18,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(text: value),
              TextSpan(
                text: ' $unit',
                style: const TextStyle(
                    color: TiideColors.ink4,
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HrChartPainter extends CustomPainter {
  _HrChartPainter({required this.samples, required this.sessionStart});
  final List<BiometricSample> samples;
  final DateTime sessionStart;

  @override
  void paint(Canvas canvas, Size size) {
    if (samples.length < 2) return;
    final pre = <BiometricSample>[];
    final during = <BiometricSample>[];
    for (final s in samples) {
      if (s.ts.isBefore(sessionStart)) {
        pre.add(s);
      } else {
        during.add(s);
      }
    }
    final values = samples.map((s) => s.value).toList();
    final minV = values.reduce((a, b) => a < b ? a : b) - 2;
    final maxV = values.reduce((a, b) => a > b ? a : b) + 2;
    final range = (maxV - minV).clamp(1.0, 1000.0);
    final h = size.height - 12;
    // Split width — 40% pre, 60% during (or proportional to counts).
    final total = pre.length + during.length;
    final splitX = total == 0
        ? size.width * 0.4
        : size.width * (pre.length / total).clamp(0.2, 0.8);

    Path pathFor(List<BiometricSample> list, double x0, double x1) {
      final p = Path();
      if (list.isEmpty) return p;
      for (int i = 0; i < list.length; i++) {
        final frac =
            list.length == 1 ? 0.5 : i / (list.length - 1);
        final x = x0 + (x1 - x0) * frac;
        final y = h - ((list[i].value - minV) / range) * h;
        if (i == 0) {
          p.moveTo(x, y);
        } else {
          p.lineTo(x, y);
        }
      }
      return p;
    }

    final prePaint = Paint()
      ..color = TiideColors.ink4.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final durPaint = Paint()
      ..color = TiideColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final divider = Paint()
      ..color = TiideColors.hair
      ..strokeWidth = 1;

    canvas.drawPath(pathFor(pre, 0, splitX), prePaint);
    canvas.drawPath(pathFor(during, splitX, size.width), durPaint);

    // Dashed divider.
    double y = 0;
    while (y < h) {
      canvas.drawLine(Offset(splitX, y), Offset(splitX, y + 2), divider);
      y += 5;
    }

    void tp(String s, double x) {
      final painter = TextPainter(
        text: TextSpan(
            text: s,
            style: const TextStyle(
                color: TiideColors.ink4, fontSize: 9)),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(canvas,
          Offset(x - painter.width / 2, size.height - painter.height));
    }
    tp('pre', splitX / 2);
    tp('during', splitX + (size.width - splitX) / 2);
  }

  @override
  bool shouldRepaint(covariant _HrChartPainter old) =>
      old.samples != samples;
}

// ─── Tags + note ───────────────────────────────────────────

class _TagsAndNoteCard extends StatelessWidget {
  const _TagsAndNoteCard({required this.row});
  final SessionWithTags row;
  @override
  Widget build(BuildContext context) {
    final note = row.session.note;
    return InkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('tags'),
          const SizedBox(height: 10),
          if (row.tags.isEmpty)
            const Text('—',
                style: TextStyle(color: TiideColors.ink4))
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final t in row.tags) _FilledTag(label: t.label),
              ],
            ),
          if (note != null && note.isNotEmpty) ...[
            const SizedBox(height: TiideSpacing.m),
            const Eyebrow('note'),
            const SizedBox(height: 8),
            Text(note,
                style: const TextStyle(
                    color: TiideColors.ink,
                    fontSize: 15,
                    height: 1.55,
                    fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}

class _FilledTag extends StatelessWidget {
  const _FilledTag({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = colorForTag(label) ?? TiideColors.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}

// ─── Place ─────────────────────────────────────────────────

class _PlaceCard extends StatelessWidget {
  const _PlaceCard({required this.place, required this.points});
  final String? place;
  final List<GeoPoint> points;

  @override
  Widget build(BuildContext context) {
    return InkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Eyebrow('place',
              trailing: Text(place ?? 'unnamed',
                  style: const TextStyle(
                      color: TiideColors.ink3,
                      fontSize: 12,
                      fontStyle: FontStyle.italic))),
          const SizedBox(height: 10),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: TiideColors.mapCanvas,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: TiideColors.hair2),
            ),
            child: Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: TiideColors.accent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
