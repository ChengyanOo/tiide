import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/tag_colors.dart';
import '../../core/theme.dart';
import '../../data/repo/dashboard_repo.dart';
import '../../data/repo/session_repo.dart';
import '../../shared/empty_state.dart';
import '../../shared/eyebrow.dart';
import '../../shared/ink_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 22),
          onPressed: () => context.pop(),
        ),
        title: const Text('dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: TiideSpacing.m),
            child: Center(
              child: Text('this week',
                  style: TextStyle(
                      color: TiideColors.ink3,
                      fontStyle: FontStyle.italic,
                      fontSize: 13)),
            ),
          ),
        ],
      ),
      body: sessions.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (rows) {
          final saved =
              rows.where((r) => r.session.outcome == 'saved').toList();
          if (saved.isEmpty) {
            return EmptyState(
              icon: Icons.insights,
              title: 'no data yet',
              subtitle:
                  'complete your first session to unlock insights and charts',
              actionLabel: 'START',
              onAction: () => context.go('/'),
            );
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(
                TiideSpacing.l, TiideSpacing.s, TiideSpacing.l, TiideSpacing.xl),
            children: [
              const _KpiRow(),
              const SizedBox(height: TiideSpacing.m),
              _StreakGrid(saved: saved),
              const SizedBox(height: TiideSpacing.m),
              const _HeatmapCard(),
              const SizedBox(height: TiideSpacing.m),
              const _InsightList(),
              const _TagBarCard(),
              const SizedBox(height: TiideSpacing.m),
              const _DurationCard(),
              const SizedBox(height: TiideSpacing.m),
              _PlacesCard(onEdit: () => context.push('/clusters')),
            ],
          );
        },
      ),
    );
  }
}

// ─── KPI row ────────────────────────────────────────────────

class _KpiRow extends ConsumerWidget {
  const _KpiRow();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekly = ref.watch(weeklyCountProvider).valueOrNull;
    final total = ref.watch(totalMinutesProvider).valueOrNull ?? 0;
    final streak = ref.watch(streakProvider).valueOrNull;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Expanded(
            child: _KpiTile(
                value: weekly?.toString() ?? '—', label: 'sessions')),
        const SizedBox(width: TiideSpacing.s + 2),
        Expanded(
            child: _KpiTile(
                value: formatDurationShort(total), label: 'sit-time')),
        const SizedBox(width: TiideSpacing.s + 2),
        Expanded(
            child: _KpiTile(
                value: streak?.toString() ?? '—', label: 'day streak')),
        ],
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkCard(
      padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: TiideSpacing.m),
      child: Column(
        children: [
          Text(value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: tiideSerif,
                fontSize: 30,
                fontWeight: FontWeight.w300,
                color: TiideColors.ink,
                height: 1.1,
              )),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  color: TiideColors.ink4, fontSize: 11, letterSpacing: 0.2)),
        ],
      ),
    );
  }
}

// ─── 28-day streak grid ─────────────────────────────────────

class _StreakGrid extends StatelessWidget {
  const _StreakGrid({required this.saved});
  final List<SessionWithTags> saved;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final days = List.generate(
        28, (i) => today.subtract(Duration(days: 27 - i)));
    final daysWithSession = <DateTime>{};
    for (final r in saved) {
      final d = r.session.startedAt;
      daysWithSession.add(DateTime(d.year, d.month, d.day));
    }
    // Compute current streak + longest.
    int current = 0;
    var cursor = today;
    while (daysWithSession.contains(cursor)) {
      current++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    if (current == 0 &&
        daysWithSession.contains(today.subtract(const Duration(days: 1)))) {
      cursor = today.subtract(const Duration(days: 1));
      while (daysWithSession.contains(cursor)) {
        current++;
        cursor = cursor.subtract(const Duration(days: 1));
      }
    }
    int longest = 0;
    if (daysWithSession.isNotEmpty) {
      final sorted = daysWithSession.toList()..sort();
      int run = 1;
      longest = 1;
      for (int i = 1; i < sorted.length; i++) {
        if (sorted[i].difference(sorted[i - 1]).inDays == 1) {
          run++;
          if (run > longest) longest = run;
        } else {
          run = 1;
        }
      }
    }

    return InkCard(
      padding: const EdgeInsets.fromLTRB(
          TiideSpacing.m + 2, TiideSpacing.m, TiideSpacing.m + 2, TiideSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Eyebrow('days sat with it',
              trailing: const Text('last 4 weeks',
                  style: TextStyle(
                      color: TiideColors.ink3,
                      fontStyle: FontStyle.italic,
                      fontSize: 12))),
          const SizedBox(height: TiideSpacing.m - 2),
          LayoutBuilder(builder: (context, c) {
            const gap = 4.0;
            final cellW = (c.maxWidth - gap * 27) / 28;
            return Row(
              children: [
                for (int i = 0; i < 28; i++) ...[
                  if (i > 0) const SizedBox(width: gap),
                  SizedBox(
                    width: cellW,
                    height: cellW,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: daysWithSession.contains(days[i])
                            ? TiideColors.accent.withValues(
                                alpha: (0.55 + i * 0.015).clamp(0.55, 1.0))
                            : TiideColors.hair2,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ],
            );
          }),
          const SizedBox(height: TiideSpacing.s + 2),
          Center(
            child: Text(
              '$current consecutive days. longest: $longest.',
              style: const TextStyle(
                  color: TiideColors.ink4, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 7x24 heatmap ───────────────────────────────────────────

class _HeatmapCard extends ConsumerWidget {
  const _HeatmapCard();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(heatmapProvider);
    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (cells) {
        if (cells.isEmpty) return const SizedBox.shrink();
        final grid = List.generate(7, (_) => List.filled(24, 0));
        int maxCount = 0;
        for (final c in cells) {
          grid[c.dayOfWeek - 1][c.hour] = c.count;
          if (c.count > maxCount) maxCount = c.count;
        }
        const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
        return InkCard(
          padding: const EdgeInsets.fromLTRB(
              TiideSpacing.m - 2, TiideSpacing.m, TiideSpacing.m, TiideSpacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                child: Eyebrow('time of day'),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Column(
                      children: [
                        for (final d in days)
                          Container(
                            height: 14,
                            width: 14,
                            alignment: Alignment.centerLeft,
                            child: Text(d,
                                style: const TextStyle(
                                    color: TiideColors.ink4, fontSize: 10)),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              _AxisTick('12a'),
                              _AxisTick('6a'),
                              _AxisTick('12p'),
                              _AxisTick('6p'),
                              _AxisTick('12a'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        for (int d = 0; d < 7; d++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3),
                            child: Row(
                              children: [
                                for (int h = 0; h < 24; h++) ...[
                                  if (h > 0) const SizedBox(width: 2),
                                  Expanded(
                                    child: Container(
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: _heatColor(
                                            grid[d][h], maxCount),
                                        borderRadius:
                                            BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TiideSpacing.s + 2),
              const Center(
                child: Text('late-night peaks. mornings are quiet.',
                    style: TextStyle(
                        color: TiideColors.ink4,
                        fontSize: 12,
                        fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _heatColor(int count, int maxCount) {
    if (count == 0 || maxCount == 0) return TiideColors.hair2;
    final t = (count / maxCount).clamp(0.15, 1.0);
    return TiideColors.accent.withValues(alpha: t);
  }
}

class _AxisTick extends StatelessWidget {
  const _AxisTick(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(color: TiideColors.ink4, fontSize: 10));
  }
}

// ─── Insight cards ──────────────────────────────────────────

class _InsightList extends ConsumerWidget {
  const _InsightList();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(insightsProvider);
    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (insights) {
        if (insights.isEmpty) return const SizedBox.shrink();
        return Column(
          children: [
            for (final i in insights) ...[
              _InsightCard(insight: i),
              const SizedBox(height: TiideSpacing.s),
            ],
          ],
        );
      },
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({required this.insight});
  final Insight insight;
  String get _eyebrow => switch (insight.type) {
        'peak_time' => 'pattern',
        'hrv_drop' => 'biometric',
        'cluster_hot' => 'place',
        _ => 'insight',
      };
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          TiideSpacing.m + 2, TiideSpacing.m, TiideSpacing.m + 2, TiideSpacing.m),
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: const Border(
            left: BorderSide(color: TiideColors.accent, width: 2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_eyebrow.toUpperCase(),
              style: const TextStyle(
                  color: TiideColors.accent,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(insight.title,
              style: const TextStyle(
                  color: TiideColors.ink,
                  fontFamily: tiideSerif,
                  fontSize: 17,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(insight.body,
              style: const TextStyle(
                  color: TiideColors.ink3,
                  fontSize: 14,
                  height: 1.55,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

// ─── Tag bar chart ──────────────────────────────────────────

class _TagBarCard extends ConsumerWidget {
  const _TagBarCard();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tagCountsProvider);
    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (tags) {
        if (tags.isEmpty) return const SizedBox.shrink();
        final max = tags.map((t) => t.count).reduce((a, b) => a > b ? a : b);
        return InkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Eyebrow('by tag'),
              const SizedBox(height: TiideSpacing.m - 2),
              for (final t in tags)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 86,
                          child: Text(t.label,
                              style: const TextStyle(
                                  color: TiideColors.ink2, fontSize: 13))),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: Stack(
                            children: [
                              Container(
                                  height: 7, color: TiideColors.hair2),
                              FractionallySizedBox(
                                widthFactor: (t.count / max).clamp(0.02, 1.0),
                                child: Container(
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: (colorForTag(t.label) ??
                                            TiideColors.accent)
                                        .withValues(alpha: 0.85),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 24,
                        child: Text('${t.count}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                color: TiideColors.ink4, fontSize: 12)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Duration histogram ─────────────────────────────────────

class _DurationCard extends ConsumerWidget {
  const _DurationCard();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(durationDistProvider);
    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (buckets) {
        if (buckets.isEmpty) return const SizedBox.shrink();
        final fullLabels = const [5, 10, 15, 20, 25, 30];
        final byLabel = {for (final b in buckets) b.minutes: b.count};
        final filled = [
          for (final m in fullLabels) DurationBucket(m, byLabel[m] ?? 0)
        ];
        final maxCount =
            filled.map((b) => b.count).reduce((a, b) => a > b ? a : b);
        final mode = filled.reduce((a, b) => a.count >= b.count ? a : b);
        return InkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Eyebrow('duration',
                  trailing: Text('${mode.minutes} min, most often',
                      style: const TextStyle(
                          color: TiideColors.ink3,
                          fontSize: 12,
                          fontStyle: FontStyle.italic))),
              const SizedBox(height: TiideSpacing.m),
              SizedBox(
                height: 86,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < filled.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: maxCount == 0
                                  ? 0
                                  : (filled[i].count / maxCount) * 68,
                              decoration: BoxDecoration(
                                color: filled[i].minutes == mode.minutes
                                    ? TiideColors.accent
                                        .withValues(alpha: 0.9)
                                    : TiideColors.hair,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text('${filled[i].minutes}',
                                style: TextStyle(
                                  color: filled[i].minutes == mode.minutes
                                      ? TiideColors.ink2
                                      : TiideColors.ink4,
                                  fontSize: 11,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Places card ────────────────────────────────────────────

class _PlacesCard extends ConsumerWidget {
  const _PlacesCard({required this.onEdit});
  final VoidCallback onEdit;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clusters = ref.watch(geoClustersProvider);
    return clusters.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (list) {
        if (list.isEmpty) return const SizedBox.shrink();
        return InkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Eyebrow('places',
                  trailing: GestureDetector(
                    onTap: onEdit,
                    child: const Text('edit names',
                        style: TextStyle(
                            color: TiideColors.ink3,
                            fontStyle: FontStyle.italic,
                            fontSize: 12)),
                  )),
              const SizedBox(height: TiideSpacing.s + 4),
              const _MiniMap(),
              const SizedBox(height: TiideSpacing.s + 4),
              for (int i = 0; i < list.length; i++) ...[
                if (i > 0)
                  const Divider(
                      height: 1, thickness: 1, color: TiideColors.hair2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.place_outlined,
                          size: 14, color: TiideColors.ink3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(list[i].userLabel ?? 'unnamed area',
                            style: const TextStyle(
                                color: TiideColors.ink,
                                fontSize: 15,
                                fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _MiniMap extends StatelessWidget {
  const _MiniMap();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: TiideColors.mapCanvas,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: TiideColors.hair2),
      ),
      child: CustomPaint(painter: _MiniMapPainter()),
    );
  }
}

class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = TiideColors.hair
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final s = size;
    final path = Path()
      ..moveTo(0, s.height * 0.55)
      ..quadraticBezierTo(
          s.width * 0.3, s.height * 0.4, s.width * 0.6, s.height * 0.55)
      ..lineTo(s.width, s.height * 0.5);
    canvas.drawPath(path, stroke);

    final faint = Paint()..color = TiideColors.hair2;
    canvas.drawRect(
        Rect.fromLTWH(s.width * 0.13, 0, 0.5, s.height), faint);
    canvas.drawRect(
        Rect.fromLTWH(s.width * 0.46, 0, 0.5, s.height), faint);
    canvas.drawRect(
        Rect.fromLTWH(s.width * 0.73, 0, 0.5, s.height), faint);

    void cluster(Offset o, double r, double a1, double a2) {
      final ring = Paint()
        ..color = TiideColors.accent.withValues(alpha: a1);
      final core = Paint()
        ..color = TiideColors.accent.withValues(alpha: a2);
      canvas.drawCircle(o, r, ring);
      canvas.drawCircle(o, r * 0.45, core);
    }

    cluster(Offset(s.width * 0.27, s.height * 0.5), 22, 0.12, 0.6);
    cluster(Offset(s.width * 0.6, s.height * 0.68), 16, 0.12, 0.55);
    cluster(Offset(s.width * 0.8, s.height * 0.36), 8, 0.25, 0.5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
