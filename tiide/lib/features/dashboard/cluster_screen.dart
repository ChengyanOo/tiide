import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';

class ClusterScreen extends ConsumerWidget {
  const ClusterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(geoClustersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('places')),
      body: data.when(
        loading: () => const Center(
            child: CircularProgressIndicator(color: TiideColors.accent)),
        error: (e, _) => Center(child: Text('$e')),
        data: (clusters) {
          if (clusters.isEmpty) {
            return const _EmptyState();
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            itemCount: clusters.length + 1,
            separatorBuilder: (_, i) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              if (i == 0) return const _Intro();
              return _ClusterTile(cluster: clusters[i - 1]);
            },
          );
        },
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 16),
      child: Text(
        'give your places a name. they help surface where the wave tends to rise.',
        style: TextStyle(
          fontFamily: tiideSerif,
          fontStyle: FontStyle.italic,
          fontSize: 13,
          color: TiideColors.ink3,
          height: 1.55,
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(TiideSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.place_outlined,
                size: 38, color: TiideColors.ink4),
            SizedBox(height: 12),
            Text(
              'no places yet',
              style: TextStyle(
                fontFamily: tiideSerif,
                fontSize: 17,
                fontStyle: FontStyle.italic,
                color: TiideColors.ink2,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'clusters form after a few sessions with location.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: tiideSerif,
                fontSize: 13,
                color: TiideColors.ink4,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClusterTile extends ConsumerWidget {
  const _ClusterTile({required this.cluster});
  final GeoCluster cluster;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = cluster.userLabel;
    final unnamed = label == null || label.isEmpty;

    return Container(
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(TiideRadius.card),
        onTap: () => _showRename(context, ref),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: TiideColors.accentSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.place,
                    size: 16, color: TiideColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unnamed ? 'unnamed place' : label,
                      style: TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 16,
                        fontStyle:
                            unnamed ? FontStyle.italic : FontStyle.normal,
                        color: unnamed
                            ? TiideColors.ink3
                            : TiideColors.ink,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${cluster.centroidLat.toStringAsFixed(4)}, ${cluster.centroidLng.toStringAsFixed(4)} · ${cluster.radiusM.round()}m',
                      style: const TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 11,
                        color: TiideColors.ink4,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.edit_outlined,
                  size: 16, color: TiideColors.ink4),
            ],
          ),
        ),
      ),
    );
  }

  void _showRename(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: cluster.userLabel ?? '');
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: TiideColors.surface,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 22,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: TiideColors.hair,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            const Text(
              'name this place',
              style: TextStyle(
                fontFamily: tiideSerif,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: TiideColors.ink,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              autofocus: true,
              style: const TextStyle(
                fontFamily: tiideSerif,
                fontSize: 16,
                color: TiideColors.ink,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. home, office',
                hintStyle: const TextStyle(
                  fontFamily: tiideSerif,
                  fontStyle: FontStyle.italic,
                  color: TiideColors.ink4,
                ),
                filled: true,
                fillColor: TiideColors.bg,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TiideRadius.card),
                  borderSide: const BorderSide(color: TiideColors.hair),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TiideRadius.card),
                  borderSide: const BorderSide(color: TiideColors.hair),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(TiideRadius.card),
                  borderSide:
                      const BorderSide(color: TiideColors.accent, width: 1.2),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: TiideColors.accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(TiideRadius.card),
                ),
              ),
              child: const Text('save',
                  style: TextStyle(
                    fontFamily: tiideSerif,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
