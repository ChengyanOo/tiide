import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';

/// Screen for viewing and renaming geo clusters (S5.3).
class ClusterScreen extends ConsumerWidget {
  const ClusterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(geoClustersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('clusters')),
      body: data.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (clusters) {
          if (clusters.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(TiideSpacing.l),
                child: Text(
                  'no clusters yet.\nclusters form after enough sessions with location data.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TiideColors.silver, height: 1.5),
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(TiideSpacing.m),
            itemCount: clusters.length,
            separatorBuilder: (_, _) => const SizedBox(height: TiideSpacing.s),
            itemBuilder: (_, i) => _ClusterTile(cluster: clusters[i]),
          );
        },
      ),
    );
  }
}

class _ClusterTile extends ConsumerWidget {
  const _ClusterTile({required this.cluster});
  final GeoCluster cluster;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = cluster.userLabel ?? 'unnamed area';

    return Card(
      child: ListTile(
        leading: const Icon(Icons.location_on, color: TiideColors.accent),
        title: Text(label,
            style: const TextStyle(color: TiideColors.white)),
        subtitle: Text(
          '${cluster.centroidLat.toStringAsFixed(4)}, ${cluster.centroidLng.toStringAsFixed(4)}  •  ${cluster.radiusM.round()}m',
          style: const TextStyle(color: TiideColors.silver, fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined, color: TiideColors.silver, size: 20),
          onPressed: () => _showRename(context, ref),
        ),
      ),
    );
  }

  void _showRename(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: cluster.userLabel ?? '');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: TiideSpacing.m,
          right: TiideSpacing.m,
          top: TiideSpacing.l,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + TiideSpacing.l,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('rename cluster',
                style: TextStyle(
                    color: TiideColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: TiideSpacing.m),
            TextField(
              controller: controller,
              autofocus: true,
              style: const TextStyle(color: TiideColors.white),
              decoration: InputDecoration(
                hintText: 'e.g. home, office',
                hintStyle: const TextStyle(color: TiideColors.borderGray),
                filled: true,
                fillColor: TiideColors.midDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TiideRadius.card),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: TiideSpacing.m),
            ElevatedButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  ref
                      .read(dashboardRepoProvider)
                      .renameCluster(cluster.id, text);
                }
                Navigator.pop(ctx);
              },
              child: const Text('SAVE'),
            ),
          ],
        ),
      ),
    );
  }
}
