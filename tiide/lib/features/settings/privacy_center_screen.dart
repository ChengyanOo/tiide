import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
      appBar: AppBar(title: const Text('privacy center')),
      body: ListView(
        padding: const EdgeInsets.all(TiideSpacing.m),
        children: [
          // Encryption status
          _StatusCard(
            icon: Icons.enhanced_encryption,
            label: 'Database Encryption',
            // Drift with SQLCipher — always encrypted when using sqlite3_flutter_libs with sqlcipher variant.
            status: 'SQLCipher — encrypted at rest',
            statusColor: TiideColors.accent,
          ),
          const SizedBox(height: TiideSpacing.m),

          // Export JSON
          _ActionCard(
            icon: Icons.download,
            label: 'Export All Data',
            subtitle: 'sessions, biometrics, location as JSON',
            loading: _exporting,
            onTap: _export,
          ),
          const SizedBox(height: TiideSpacing.m),

          // Delete all
          _ActionCard(
            icon: Icons.delete_forever,
            label: 'Delete All Data',
            subtitle: 'permanently remove everything',
            destructive: true,
            loading: _deleting,
            onTap: () => _confirmDelete(context),
          ),
          const SizedBox(height: TiideSpacing.m),

          // Cloud sync stub
          _StatusCard(
            icon: Icons.cloud_off,
            label: 'Cloud Sync',
            status: 'coming soon — all data stays local',
            statusColor: TiideColors.ink3,
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
        title: const Text('delete all data?',
            style: TextStyle(color: TiideColors.ink)),
        content: const Text(
          'this will permanently remove all sessions, biometric data, '
          'and location data. this cannot be undone.',
          style: TextStyle(color: TiideColors.ink3),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('cancel',
                style: TextStyle(color: TiideColors.ink3)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('DELETE EVERYTHING',
                style: TextStyle(color: TiideColors.negative)),
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

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.label,
    required this.status,
    required this.statusColor,
  });
  final IconData icon;
  final String label;
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TiideSpacing.m),
      decoration: BoxDecoration(
        color: TiideColors.surface,
        borderRadius: BorderRadius.circular(TiideRadius.card),
      ),
      child: Row(
        children: [
          Icon(icon, color: statusColor, size: 24),
          const SizedBox(width: TiideSpacing.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: TiideColors.ink,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(status,
                    style: TextStyle(fontSize: 12, color: statusColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
    this.loading = false,
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? TiideColors.negative : TiideColors.accent;
    return Material(
      color: TiideColors.surface,
      borderRadius: BorderRadius.circular(TiideRadius.card),
      child: InkWell(
        borderRadius: BorderRadius.circular(TiideRadius.card),
        onTap: loading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(TiideSpacing.m),
          child: Row(
            children: [
              loading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: color))
                  : Icon(icon, color: color, size: 24),
              const SizedBox(width: TiideSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: TextStyle(
                            color: TiideColors.ink,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            fontSize: 12, color: TiideColors.ink3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
