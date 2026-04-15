import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';
import '../../data/repo/session_repo.dart';

/// Detail screen for a completed session, showing tags + biometric data.
class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionDetailProvider(sessionId));
    final snapshotAsync = ref.watch(biometricSnapshotProvider(sessionId));
    final geoAsync = ref.watch(geoPointsProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: const Text('session detail')),
      body: sessionAsync.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (row) {
          if (row == null) {
            return const Center(
                child: Text('session not found',
                    style: TextStyle(color: TiideColors.silver)));
          }
          return ListView(
            padding: const EdgeInsets.all(TiideSpacing.m),
            children: [
              _SessionHeader(row: row),
              const SizedBox(height: TiideSpacing.l),
              snapshotAsync.when(
                data: (snap) => snap != null
                    ? _BiometricSection(
                        snapshot: snap,
                        sessionId: sessionId,
                      )
                    : const _EmptyBiometric(),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
              const SizedBox(height: TiideSpacing.m),
              geoAsync.when(
                data: (points) =>
                    points.isNotEmpty ? _GeoSection(points: points) : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ----- Session header -----

class _SessionHeader extends StatelessWidget {
  const _SessionHeader({required this.row});
  final SessionWithTags row;

  @override
  Widget build(BuildContext context) {
    final s = row.session;
    final d = s.startedAt;
    final dateStr =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    final mins = s.actualDurationMin ?? s.plannedDurationMin;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TiideSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dateStr,
                    style: const TextStyle(
                        color: TiideColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                Text('${mins}m',
                    style:
                        const TextStyle(color: TiideColors.accent, fontSize: 18)),
              ],
            ),
            if (row.tags.isNotEmpty) ...[
              const SizedBox(height: TiideSpacing.s),
              Wrap(
                spacing: TiideSpacing.xs,
                runSpacing: TiideSpacing.xs,
                children: [
                  for (final t in row.tags)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: TiideColors.midDark,
                        borderRadius:
                            BorderRadius.circular(TiideRadius.pill),
                      ),
                      child: Text(t.label,
                          style: const TextStyle(
                              fontSize: 12, color: TiideColors.silver)),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ----- Biometric section -----

class _BiometricSection extends ConsumerWidget {
  const _BiometricSection({required this.snapshot, required this.sessionId});
  final BiometricSnapshot snapshot;
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final samplesAsync = ref.watch(biometricSamplesProvider(snapshot.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('biometrics',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: TiideSpacing.m),
        _HrComparisonCard(snapshot: snapshot),
        const SizedBox(height: TiideSpacing.m),
        samplesAsync.when(
          data: (samples) {
            final hrvSamples =
                samples.where((s) => s.metric == 'hrv').toList();
            if (hrvSamples.isEmpty) return const SizedBox.shrink();
            return _HrvSparkline(samples: hrvSamples);
          },
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _EmptyBiometric extends StatelessWidget {
  const _EmptyBiometric();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TiideSpacing.l),
      decoration: BoxDecoration(
        color: TiideColors.darkSurface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
      ),
      child: const Column(
        children: [
          Icon(Icons.favorite_outline, color: TiideColors.borderGray, size: 32),
          SizedBox(height: TiideSpacing.s),
          Text('no biometric data for this session',
              style: TextStyle(color: TiideColors.silver, fontSize: 13)),
        ],
      ),
    );
  }
}

// ----- HR comparison card -----

class _HrComparisonCard extends StatelessWidget {
  const _HrComparisonCard({required this.snapshot});
  final BiometricSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(TiideSpacing.m),
        child: Row(
          children: [
            Expanded(
              child: _MetricCol(
                label: 'HR before',
                value: snapshot.hrAvgPre != null
                    ? '${snapshot.hrAvgPre!.round()} bpm'
                    : '—',
              ),
            ),
            Container(width: 1, height: 40, color: TiideColors.borderGray),
            Expanded(
              child: _MetricCol(
                label: 'HR during',
                value: snapshot.hrAvgDuring != null
                    ? '${snapshot.hrAvgDuring!.round()} bpm'
                    : '—',
              ),
            ),
            Container(width: 1, height: 40, color: TiideColors.borderGray),
            Expanded(
              child: _MetricCol(
                label: 'HRV before',
                value: snapshot.hrvAvgPre != null
                    ? '${snapshot.hrvAvgPre!.round()} ms'
                    : '—',
              ),
            ),
            Container(width: 1, height: 40, color: TiideColors.borderGray),
            Expanded(
              child: _MetricCol(
                label: 'HRV during',
                value: snapshot.hrvAvgDuring != null
                    ? '${snapshot.hrvAvgDuring!.round()} ms'
                    : '—',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCol extends StatelessWidget {
  const _MetricCol({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: TiideColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(color: TiideColors.silver, fontSize: 11)),
      ],
    );
  }
}

// ----- HRV sparkline -----

class _HrvSparkline extends StatelessWidget {
  const _HrvSparkline({required this.samples});
  final List<BiometricSample> samples;

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < samples.length; i++) {
      spots.add(FlSpot(i.toDouble(), samples[i].value));
    }

    return Container(
      padding: const EdgeInsets.all(TiideSpacing.m),
      decoration: BoxDecoration(
        color: TiideColors.darkSurface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('HRV trend',
              style: TextStyle(
                  color: TiideColors.silver,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: TiideSpacing.s),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: TiideColors.accent,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: TiideColors.accent.withAlpha(30),
                    ),
                  ),
                ],
                lineTouchData: const LineTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----- Geo section -----

class _GeoSection extends StatelessWidget {
  const _GeoSection({required this.points});
  final List<GeoPoint> points;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('location', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: TiideSpacing.s),
        for (final p in points)
          Padding(
            padding: const EdgeInsets.only(bottom: TiideSpacing.xs),
            child: Container(
              padding: const EdgeInsets.all(TiideSpacing.m),
              decoration: BoxDecoration(
                color: TiideColors.darkSurface,
                borderRadius: BorderRadius.circular(TiideRadius.card),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      color: TiideColors.silver, size: 18),
                  const SizedBox(width: TiideSpacing.s),
                  Text(
                    '${p.kind}: ${p.lat.toStringAsFixed(4)}, ${p.lng.toStringAsFixed(4)}',
                    style: const TextStyle(
                        color: TiideColors.silver, fontSize: 13),
                  ),
                  const Spacer(),
                  if (p.accuracyM != null)
                    Text('±${p.accuracyM!.round()}m',
                        style: const TextStyle(
                            color: TiideColors.borderGray, fontSize: 11)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
