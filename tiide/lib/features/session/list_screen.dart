import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/format.dart';
import '../../core/tag_colors.dart';
import '../../core/theme.dart';
import '../../data/repo/session_repo.dart';
import '../../shared/empty_state.dart';

class SessionListScreen extends ConsumerWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(sessionListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 22),
          onPressed: () => context.pop(),
        ),
        title: const Text('sessions'),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (rows) {
          if (rows.isEmpty) {
            return EmptyState(
              icon: Icons.waves,
              title: 'no sessions yet',
              subtitle: 'each wave counted when you are ready',
              actionLabel: 'START',
              onAction: () => context.go('/'),
            );
          }
          final now = DateTime.now();
          final grouped = <String, List<SessionWithTags>>{};
          final order = <String>[];
          for (final r in rows) {
            final bucket =
                formatSessionDateBucket(r.session.startedAt, now);
            if (!grouped.containsKey(bucket)) {
              grouped[bucket] = [];
              order.add(bucket);
            }
            grouped[bucket]!.add(r);
          }
          final places =
              ref.watch(sessionPlacesProvider).valueOrNull ?? const {};

          return ListView(
            padding: const EdgeInsets.only(bottom: TiideSpacing.xl),
            children: [
              for (final bucket in order) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      TiideSpacing.l + 2, TiideSpacing.m + 2,
                      TiideSpacing.l, TiideSpacing.s),
                  child: Text(bucket.toUpperCase(),
                      style: const TextStyle(
                        color: TiideColors.ink4,
                        fontSize: 11,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                for (int i = 0; i < grouped[bucket]!.length; i++)
                  _SessionTile(
                    row: grouped[bucket]![i],
                    place: places[grouped[bucket]![i].session.id],
                    showDivider: i < grouped[bucket]!.length - 1,
                    onTap: () => context
                        .push('/sessions/${grouped[bucket]![i].session.id}'),
                  ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.row,
    required this.place,
    required this.showDivider,
    required this.onTap,
  });
  final SessionWithTags row;
  final String? place;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = row.session;
    final mins = s.actualDurationMin ?? s.plannedDurationMin;
    final orphaned = s.outcome == 'orphaned';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: TiideSpacing.l + 2, vertical: 14),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(
                  bottom: BorderSide(color: TiideColors.hair2, width: 1))
              : null,
        ),
        child: Row(
          children: [
            _TimeRing(orphaned: orphaned),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(formatTimeOfDay(s.startedAt),
                          style: const TextStyle(
                              color: TiideColors.ink, fontSize: 15)),
                      const SizedBox(width: 6),
                      Text('· $mins min',
                          style: const TextStyle(
                              color: TiideColors.ink4, fontSize: 12)),
                      if (orphaned) ...[
                        const SizedBox(width: 6),
                        const Text('orphaned',
                            style: TextStyle(
                                color: TiideColors.ink4,
                                fontSize: 12,
                                fontStyle: FontStyle.italic)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final t in row.tags) _TagPill(label: t.label),
                      if (place != null)
                        Text('· $place',
                            style: const TextStyle(
                                color: TiideColors.ink4,
                                fontSize: 12,
                                fontStyle: FontStyle.italic)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 16, color: TiideColors.ink4),
          ],
        ),
      ),
    );
  }
}

class _TimeRing extends StatelessWidget {
  const _TimeRing({required this.orphaned});
  final bool orphaned;
  @override
  Widget build(BuildContext context) {
    final edge = orphaned ? TiideColors.hair : TiideColors.accent;
    final core = orphaned
        ? TiideColors.ink4.withValues(alpha: 0.4)
        : TiideColors.accent;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: edge),
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: core),
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final dot = colorForTag(label);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: TiideColors.hair2,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot != null) ...[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
          ],
          Text(label,
              style: const TextStyle(
                  color: TiideColors.ink3, fontSize: 12)),
        ],
      ),
    );
  }
}
