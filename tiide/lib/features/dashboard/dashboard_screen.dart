import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/repo/dashboard_repo.dart';
import '../../shared/empty_state.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final total = ref.watch(totalMinutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            tooltip: 'clusters',
            onPressed: () => context.push('/clusters'),
          ),
        ],
      ),
      body: total.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (mins) {
          if (mins == 0) {
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
            padding: const EdgeInsets.all(TiideSpacing.m),
            children: const [
              _SummaryRow(),
              SizedBox(height: TiideSpacing.l),
              _TagBarChart(),
              SizedBox(height: TiideSpacing.l),
              _Heatmap(),
              SizedBox(height: TiideSpacing.l),
              _DurationDist(),
              SizedBox(height: TiideSpacing.l),
              _InsightCards(),
            ],
          );
        },
      ),
    );
  }
}

// ──────────────────────────────────────────
// S5.1 – Summary metrics row
// ──────────────────────────────────────────

class _SummaryRow extends ConsumerWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekly = ref.watch(weeklyCountProvider);
    final total = ref.watch(totalMinutesProvider);
    final streak = ref.watch(streakProvider);

    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: 'this week',
            value: weekly.valueOrNull?.toString() ?? '—',
            unit: 'sessions',
          ),
        ),
        const SizedBox(width: TiideSpacing.s),
        Expanded(
          child: _MetricCard(
            label: 'total sit-time',
            value: total.valueOrNull?.toString() ?? '—',
            unit: 'min',
          ),
        ),
        const SizedBox(width: TiideSpacing.s),
        Expanded(
          child: _MetricCard(
            label: 'streak',
            value: streak.valueOrNull?.toString() ?? '—',
            unit: 'days',
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.unit,
  });
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: TiideSpacing.m, vertical: TiideSpacing.m),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    color: TiideColors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(unit,
                style: const TextStyle(
                    color: TiideColors.silver, fontSize: 11)),
            const SizedBox(height: TiideSpacing.xs),
            Text(label,
                style: const TextStyle(
                    color: TiideColors.silver,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────
// S5.2 – Sessions per tag (bar chart)
// ──────────────────────────────────────────

class _TagBarChart extends ConsumerWidget {
  const _TagBarChart();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(tagCountsProvider);

    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (tags) {
        if (tags.isEmpty) return const SizedBox.shrink();
        final maxY = tags.map((t) => t.count).reduce(math.max).toDouble();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('sessions per tag',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TiideSpacing.m),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  maxY: maxY + 1,
                  barTouchData: BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (v, _) {
                          final idx = v.toInt();
                          if (idx < 0 || idx >= tags.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(tags[idx].label,
                              style: const TextStyle(
                                  color: TiideColors.silver, fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < tags.length; i++)
                      BarChartGroupData(x: i, barRods: [
                        BarChartRodData(
                          toY: tags[i].count.toDouble(),
                          color: TiideColors.accent,
                          width: 24,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                      ]),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ──────────────────────────────────────────
// S5.2 – Time-of-day heatmap (7×24)
// ──────────────────────────────────────────

class _Heatmap extends ConsumerWidget {
  const _Heatmap();

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(heatmapProvider);

    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (cells) {
        if (cells.isEmpty) return const SizedBox.shrink();
        // Build 7×24 grid.
        final grid = List.generate(7, (_) => List.filled(24, 0));
        int maxCount = 0;
        for (final c in cells) {
          grid[c.dayOfWeek - 1][c.hour] = c.count;
          if (c.count > maxCount) maxCount = c.count;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('time-of-day heatmap',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TiideSpacing.m),
            SizedBox(
              height: 7 * 20.0 + 24, // 7 rows + hour labels
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day labels.
                    Column(
                      children: [
                        const SizedBox(height: 16), // offset for hour labels
                        for (int d = 0; d < 7; d++)
                          SizedBox(
                            height: 20,
                            width: 30,
                            child: Text(_days[d],
                                style: const TextStyle(
                                    color: TiideColors.silver, fontSize: 9)),
                          ),
                      ],
                    ),
                    // Grid cells.
                    for (int h = 0; h < 24; h++)
                      Column(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 20,
                            child: h % 4 == 0
                                ? Text('$h',
                                    style: const TextStyle(
                                        color: TiideColors.silver, fontSize: 8),
                                    textAlign: TextAlign.center)
                                : const SizedBox.shrink(),
                          ),
                          for (int d = 0; d < 7; d++)
                            Container(
                              width: 18,
                              height: 18,
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: _heatColor(grid[d][h], maxCount),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _heatColor(int count, int maxCount) {
    if (count == 0 || maxCount == 0) return TiideColors.midDark;
    final t = count / maxCount;
    return Color.lerp(
      TiideColors.midDark,
      TiideColors.accent,
      t,
    )!;
  }
}

// ──────────────────────────────────────────
// S5.2 – Duration distribution
// ──────────────────────────────────────────

class _DurationDist extends ConsumerWidget {
  const _DurationDist();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(durationDistProvider);

    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (buckets) {
        if (buckets.isEmpty) return const SizedBox.shrink();
        final maxY = buckets.map((b) => b.count).reduce(math.max).toDouble();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('duration distribution',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TiideSpacing.m),
            SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  maxY: maxY + 1,
                  barTouchData: BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 20,
                        getTitlesWidget: (v, _) {
                          final idx = v.toInt();
                          if (idx < 0 || idx >= buckets.length) {
                            return const SizedBox.shrink();
                          }
                          return Text('${buckets[idx].minutes}m',
                              style: const TextStyle(
                                  color: TiideColors.silver, fontSize: 10));
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < buckets.length; i++)
                      BarChartGroupData(x: i, barRods: [
                        BarChartRodData(
                          toY: buckets[i].count.toDouble(),
                          color: TiideColors.accent.withAlpha(180),
                          width: 28,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                        ),
                      ]),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ──────────────────────────────────────────
// S5.4 – Trigger insight cards
// ──────────────────────────────────────────

class _InsightCards extends ConsumerWidget {
  const _InsightCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(insightsProvider);

    return data.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (insights) {
        if (insights.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('insights',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TiideSpacing.m),
            for (final insight in insights) ...[
              _InsightCard(insight: insight),
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

  IconData get _icon => switch (insight.type) {
        'peak_time' => Icons.schedule,
        'hrv_drop' => Icons.favorite,
        'cluster_hot' => Icons.location_on,
        _ => Icons.lightbulb_outline,
      };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TiideSpacing.m),
        child: Row(
          children: [
            Icon(_icon, color: TiideColors.accent, size: 24),
            const SizedBox(width: TiideSpacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(insight.title,
                      style: const TextStyle(
                          color: TiideColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(insight.body,
                      style: const TextStyle(
                          color: TiideColors.silver, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
