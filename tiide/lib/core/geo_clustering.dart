import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../data/db/database.dart';

/// Simple DBSCAN over geo points to cluster session start locations.
///
/// epsilon: max distance in meters (default 150).
/// minPoints: minimum points to form a cluster (default 2).
class GeoClusteringService {
  GeoClusteringService(this.db);
  final AppDatabase db;

  static const double _defaultEpsilon = 150.0;
  static const int _minPoints = 2;

  /// Run DBSCAN over all 'start' geo points and persist clusters.
  Future<void> runClustering() async {
    final points = await (db.select(db.geoPoints)
          ..where((g) => g.kind.equals('start')))
        .get();

    if (points.length < _minPoints) return;

    // DBSCAN.
    final labels = List<int>.filled(points.length, -1); // -1 = unvisited
    int clusterId = 0;

    for (int i = 0; i < points.length; i++) {
      if (labels[i] != -1) continue;
      final neighbors = _regionQuery(points, i, _defaultEpsilon);
      if (neighbors.length < _minPoints) {
        labels[i] = 0; // noise
        continue;
      }
      clusterId++;
      labels[i] = clusterId;
      final seed = List<int>.from(neighbors);
      int j = 0;
      while (j < seed.length) {
        final q = seed[j];
        if (labels[q] == 0) labels[q] = clusterId; // noise -> border point
        if (labels[q] != -1) {
          j++;
          continue;
        }
        labels[q] = clusterId;
        final qNeighbors = _regionQuery(points, q, _defaultEpsilon);
        if (qNeighbors.length >= _minPoints) {
          for (final n in qNeighbors) {
            if (!seed.contains(n)) seed.add(n);
          }
        }
        j++;
      }
    }

    if (clusterId == 0) return;

    // Group points by cluster.
    final clusterPoints = <int, List<GeoPoint>>{};
    for (int i = 0; i < points.length; i++) {
      if (labels[i] > 0) {
        clusterPoints.putIfAbsent(labels[i], () => []).add(points[i]);
      }
    }

    // Load existing clusters to preserve user labels.
    final existing = await db.select(db.geoClusters).get();
    final existingByLabel = <String, GeoCluster>{};
    for (final c in existing) {
      existingByLabel[c.id] = c;
    }

    // Delete old clusters and re-insert.
    await db.delete(db.geoClusters).go();

    // Clear all clusterId assignments.
    await (db.update(db.geoPoints)..where((g) => g.kind.equals('start')))
        .write(const GeoPointsCompanion(clusterId: Value(null)));

    for (final entry in clusterPoints.entries) {
      final pts = entry.value;
      final centroidLat = pts.map((p) => p.lat).reduce((a, b) => a + b) / pts.length;
      final centroidLng = pts.map((p) => p.lng).reduce((a, b) => a + b) / pts.length;

      // Radius = max distance from centroid.
      double maxDist = 0;
      for (final p in pts) {
        final d = _haversine(centroidLat, centroidLng, p.lat, p.lng);
        if (d > maxDist) maxDist = d;
      }

      final cId = 'cluster_${entry.key}';

      // Preserve user label if centroid is close to an old cluster.
      String? userLabel;
      for (final old in existingByLabel.values) {
        if (_haversine(centroidLat, centroidLng, old.centroidLat, old.centroidLng) < _defaultEpsilon) {
          userLabel = old.userLabel;
          break;
        }
      }

      await db.into(db.geoClusters).insert(GeoClustersCompanion.insert(
        id: cId,
        userLabel: Value(userLabel),
        centroidLat: centroidLat,
        centroidLng: centroidLng,
        radiusM: Value(maxDist.clamp(50, 2000)),
      ));

      // Assign points to cluster.
      for (final p in pts) {
        await (db.update(db.geoPoints)..where((g) => g.id.equals(p.id)))
            .write(GeoPointsCompanion(clusterId: Value(cId)));
      }
    }
  }

  /// Find all point indices within epsilon meters of points[index].
  List<int> _regionQuery(List<GeoPoint> points, int index, double epsilon) {
    final result = <int>[];
    final p = points[index];
    for (int i = 0; i < points.length; i++) {
      if (_haversine(p.lat, p.lng, points[i].lat, points[i].lng) <= epsilon) {
        result.add(i);
      }
    }
    return result;
  }

  /// Haversine distance in meters.
  static double _haversine(double lat1, double lng1, double lat2, double lng2) {
    const earthRadius = 6371000.0;
    final dLat = _toRad(lat2 - lat1);
    final dLng = _toRad(lng2 - lng1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRad(lat1)) *
            math.cos(_toRad(lat2)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    return earthRadius * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  static double _toRad(double deg) => deg * math.pi / 180;
}
