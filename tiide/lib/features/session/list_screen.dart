import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/repo/session_repo.dart';
import '../../shared/empty_state.dart';

class SessionListScreen extends ConsumerWidget {
  const SessionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(sessionListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('history')),
      body: async.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
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
          return ListView.separated(
            padding: const EdgeInsets.all(TiideSpacing.m),
            itemCount: rows.length,
            separatorBuilder: (_, _) => const SizedBox(height: TiideSpacing.s),
            itemBuilder: (_, i) => _SessionTile(
              row: rows[i],
              onTap: () => context.push('/sessions/${rows[i].session.id}'),
            ),
          );
        },
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.row, required this.onTap});
  final SessionWithTags row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final s = row.session;
    final d = s.startedAt;
    final dateStr =
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
    final mins = s.actualDurationMin ?? s.plannedDurationMin;

    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                        color: TiideColors.white, fontWeight: FontWeight.w700)),
                Text('${mins}m',
                    style: const TextStyle(color: TiideColors.accent)),
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
      ),
    );
  }
}
