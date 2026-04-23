import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../app/providers.dart';
import '../../core/theme.dart';
import '../../data/db/database.dart';

class PrivacyCenterScreen extends ConsumerStatefulWidget {
  const PrivacyCenterScreen({super.key});

  @override
  ConsumerState<PrivacyCenterScreen> createState() =>
      _PrivacyCenterScreenState();
}

class _PrivacyCenterScreenState extends ConsumerState<PrivacyCenterScreen> {
  bool _exporting = false;
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('privacy')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const _SectionLabel('storage'),
          _InkCard(
            children: [
              _StatusRow(
                icon: Icons.shield_outlined,
                label: 'database encryption',
                detail: 'sqlcipher · encrypted at rest',
                accent: TiideColors.accent,
              ),
              const _Divider(),
              _StatusRow(
                icon: Icons.cloud_outlined,
                label: 'cloud sync',
                detail: 'coming soon — all data stays local',
                accent: TiideColors.ink3,
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _SectionLabel('your data'),
          _InkCard(
            children: [
              _ActionRow(
                icon: Icons.download_outlined,
                label: 'export all data',
                detail: 'sessions, biometrics, location as json',
                loading: _exporting,
                onTap: _export,
              ),
              const _Divider(),
              _ActionRow(
                icon: Icons.delete_outline,
                label: 'delete all data',
                detail: 'permanently remove everything',
                destructive: true,
                loading: _deleting,
                onTap: () => _confirmDelete(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'nothing leaves this device unless you choose. exports save to the app documents folder.',
              style: TextStyle(
                fontFamily: tiideSerif,
                fontStyle: FontStyle.italic,
                fontSize: 12,
                color: TiideColors.ink4,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _export() async {
    setState(() => _exporting = true);
    try {
      final db = ref.read(databaseProvider);
      final data = await _buildExportData(db);
      final json = const JsonEncoder.withIndent('  ').convert(data);

      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'tiide_export.json'));
      await file.writeAsString(json);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('exported to ${file.path}'),
            backgroundColor: TiideColors.surface,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('export failed: $e'),
            backgroundColor: TiideColors.negative,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Future<Map<String, dynamic>> _buildExportData(AppDatabase db) async {
    final sessions = await db.select(db.sessions).get();
    final tags = await db.select(db.tags).get();
    final sessionTags = await db.select(db.sessionTags).get();
    final snapshots = await db.select(db.biometricSnapshots).get();
    final samples = await db.select(db.biometricSamples).get();
    final geoPoints = await db.select(db.geoPoints).get();
    final clusters = await db.select(db.geoClusters).get();

    return {
      'exportedAt': DateTime.now().toIso8601String(),
      'sessions': sessions
          .map((s) => {
                'id': s.id,
                'startedAt': s.startedAt.toIso8601String(),
                'endedAt': s.endedAt?.toIso8601String(),
                'plannedDurationMin': s.plannedDurationMin,
                'actualDurationMin': s.actualDurationMin,
                'outcome': s.outcome,
                'extensionCount': s.extensionCount,
                'note': s.note,
              })
          .toList(),
      'tags': tags
          .map((t) => {'id': t.id, 'label': t.label, 'category': t.category})
          .toList(),
      'sessionTags': sessionTags
          .map((st) => {'sessionId': st.sessionId, 'tagId': st.tagId})
          .toList(),
      'biometricSnapshots': snapshots
          .map((s) => {
                'id': s.id,
                'sessionId': s.sessionId,
                'hrAvgPre': s.hrAvgPre,
                'hrAvgDuring': s.hrAvgDuring,
                'hrvAvgPre': s.hrvAvgPre,
                'hrvAvgDuring': s.hrvAvgDuring,
              })
          .toList(),
      'biometricSamples': samples
          .map((s) => {
                'id': s.id,
                'snapshotId': s.snapshotId,
                'ts': s.ts.toIso8601String(),
                'metric': s.metric,
                'value': s.value,
              })
          .toList(),
      'geoPoints': geoPoints
          .map((g) => {
                'id': g.id,
                'sessionId': g.sessionId,
                'kind': g.kind,
                'lat': g.lat,
                'lng': g.lng,
                'accuracyM': g.accuracyM,
                'clusterId': g.clusterId,
              })
          .toList(),
      'geoClusters': clusters
          .map((c) => {
                'id': c.id,
                'userLabel': c.userLabel,
                'centroidLat': c.centroidLat,
                'centroidLng': c.centroidLng,
                'radiusM': c.radiusM,
              })
          .toList(),
    };
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: TiideColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TiideRadius.card),
        ),
        title: const Text(
          'delete all data?',
          style: TextStyle(
            fontFamily: tiideSerif,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: TiideColors.ink,
          ),
        ),
        content: const Text(
          'this will permanently remove all sessions, biometric data, and location data. this cannot be undone.',
          style: TextStyle(
              fontFamily: tiideSerif,
              fontSize: 14,
              color: TiideColors.ink3,
              height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('cancel',
                style: TextStyle(
                    fontFamily: tiideSerif, color: TiideColors.ink3)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('delete everything',
                style: TextStyle(
                    fontFamily: tiideSerif,
                    fontWeight: FontWeight.w500,
                    color: TiideColors.negative)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _deleting = true);
    try {
      final db = ref.read(databaseProvider);
      await db.delete(db.biometricSamples).go();
      await db.delete(db.biometricSnapshots).go();
      await db.delete(db.geoPoints).go();
      await db.delete(db.geoClusters).go();
      await db.delete(db.sessionTags).go();
      await db.delete(db.sessions).go();

      messenger.showSnackBar(
        const SnackBar(
          content: Text('all data deleted'),
          backgroundColor: TiideColors.surface,
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('delete failed: $e'),
          backgroundColor: TiideColors.negative,
        ),
      );
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 0, 10),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontFamily: tiideSerif,
          fontSize: 10,
          letterSpacing: 2.2,
          color: TiideColors.ink4,
        ),
      ),
    );
  }
}

class _InkCard extends StatelessWidget {
  const _InkCard({required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
        border: Border.all(color: TiideColors.hair2, width: 1),
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, thickness: 1, color: TiideColors.hair2);
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.icon,
    required this.label,
    required this.detail,
    required this.accent,
  });
  final IconData icon;
  final String label;
  final String detail;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      fontFamily: tiideSerif,
                      fontSize: 15,
                      color: TiideColors.ink,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 3),
                Text(detail,
                    style: TextStyle(
                      fontFamily: tiideSerif,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: accent,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.detail,
    required this.onTap,
    this.destructive = false,
    this.loading = false,
  });
  final IconData icon;
  final String label;
  final String detail;
  final VoidCallback onTap;
  final bool destructive;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? TiideColors.negative : TiideColors.ink2;
    return InkWell(
      borderRadius: BorderRadius.circular(TiideRadius.card),
      onTap: loading ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: loading
                  ? CircularProgressIndicator(strokeWidth: 1.5, color: color)
                  : Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 15,
                        color: destructive
                            ? TiideColors.negative
                            : TiideColors.ink,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 3),
                  Text(detail,
                      style: const TextStyle(
                        fontFamily: tiideSerif,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: TiideColors.ink3,
                      )),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                size: 18, color: TiideColors.ink4),
          ],
        ),
      ),
    );
  }
}
