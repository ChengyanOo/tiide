import 'package:drift/drift.dart';

import '../../core/health_service.dart' as hs;
import '../../core/location_service.dart' as ls;
import '../db/database.dart';

/// Persists biometric snapshots + samples and geo points for sessions.
class EnrichmentRepo {
  EnrichmentRepo(this.db);
  final AppDatabase db;

  String _genId() {
    final us = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final ms = (DateTime.now().millisecondsSinceEpoch % 100000).toRadixString(36);
    return '$us-$ms';
  }

  // ---- Biometric ----

  /// Create or update a biometric snapshot for a session,
  /// persisting raw samples.
  Future<BiometricSnapshot> saveSnapshot({
    required String sessionId,
    hs.HealthSnapshot? pre,
    hs.HealthSnapshot? during,
  }) async {
    // Check for existing snapshot for this session.
    final existing = await (db.select(db.biometricSnapshots)
          ..where((s) => s.sessionId.equals(sessionId))
          ..limit(1))
        .getSingleOrNull();

    final id = existing?.id ?? _genId();

    if (existing != null) {
      // Update with "during" data.
      await (db.update(db.biometricSnapshots)
            ..where((s) => s.id.equals(id)))
          .write(BiometricSnapshotsCompanion(
        hrAvgDuring: Value(during?.hrAvg),
        hrvAvgDuring: Value(during?.hrvAvg),
      ));
    } else {
      await db.into(db.biometricSnapshots).insert(
            BiometricSnapshotsCompanion.insert(
              id: id,
              sessionId: sessionId,
              hrAvgPre: Value(pre?.hrAvg),
              hrAvgDuring: Value(during?.hrAvg),
              hrvAvgPre: Value(pre?.hrvAvg),
              hrvAvgDuring: Value(during?.hrvAvg),
            ),
          );
    }

    // Persist raw samples.
    final allSamples = <BiometricSamplesCompanion>[];
    for (final s in pre?.hrSamples ?? <hs.HealthSample>[]) {
      allSamples.add(BiometricSamplesCompanion.insert(
        id: _genId(),
        snapshotId: id,
        ts: s.ts,
        metric: 'hr',
        value: s.value,
      ));
    }
    for (final s in pre?.hrvSamples ?? <hs.HealthSample>[]) {
      allSamples.add(BiometricSamplesCompanion.insert(
        id: _genId(),
        snapshotId: id,
        ts: s.ts,
        metric: 'hrv',
        value: s.value,
      ));
    }
    for (final s in during?.hrSamples ?? <hs.HealthSample>[]) {
      allSamples.add(BiometricSamplesCompanion.insert(
        id: _genId(),
        snapshotId: id,
        ts: s.ts,
        metric: 'hr',
        value: s.value,
      ));
    }
    for (final s in during?.hrvSamples ?? <hs.HealthSample>[]) {
      allSamples.add(BiometricSamplesCompanion.insert(
        id: _genId(),
        snapshotId: id,
        ts: s.ts,
        metric: 'hrv',
        value: s.value,
      ));
    }

    if (allSamples.isNotEmpty) {
      await db.batch((b) {
        b.insertAll(db.biometricSamples, allSamples,
            mode: InsertMode.insertOrIgnore);
      });
    }

    return (db.select(db.biometricSnapshots)
          ..where((s) => s.id.equals(id)))
        .getSingle();
  }

  /// Get the snapshot for a session (if any).
  Future<BiometricSnapshot?> snapshotForSession(String sessionId) {
    return (db.select(db.biometricSnapshots)
          ..where((s) => s.sessionId.equals(sessionId))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get all raw samples for a snapshot.
  Future<List<BiometricSample>> samplesForSnapshot(String snapshotId) {
    return (db.select(db.biometricSamples)
          ..where((s) => s.snapshotId.equals(snapshotId))
          ..orderBy([(s) => OrderingTerm.asc(s.ts)]))
        .get();
  }

  // ---- Geo ----

  /// Save a geo point for a session.
  Future<void> saveGeoPoint({
    required String sessionId,
    required String kind, // 'start' | 'end'
    required ls.GeoPoint point,
  }) async {
    await db.into(db.geoPoints).insert(
          GeoPointsCompanion.insert(
            id: _genId(),
            sessionId: sessionId,
            kind: kind,
            lat: point.lat,
            lng: point.lng,
            accuracyM: Value(point.accuracyM),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// Get geo points for a session, keyed by kind.
  Future<List<GeoPoint>> geoPointsForSession(String sessionId) {
    return (db.select(db.geoPoints)
          ..where((g) => g.sessionId.equals(sessionId)))
        .get();
  }

  /// Resolve a human place label (cluster.userLabel) for each session id
  /// via its `start` geo point. Returns a map of sessionId → label.
  Future<Map<String, String>> placesForSessions(List<String> sessionIds) async {
    if (sessionIds.isEmpty) return const {};
    final rows = await (db.select(db.geoPoints).join([
      innerJoin(db.geoClusters,
          db.geoClusters.id.equalsExp(db.geoPoints.clusterId)),
    ])
          ..where(db.geoPoints.sessionId.isIn(sessionIds))
          ..where(db.geoPoints.kind.equals('start')))
        .get();
    final out = <String, String>{};
    for (final r in rows) {
      final sid = r.readTable(db.geoPoints).sessionId;
      final label = r.readTable(db.geoClusters).userLabel;
      if (label != null && label.isNotEmpty) out[sid] = label;
    }
    return out;
  }
}
