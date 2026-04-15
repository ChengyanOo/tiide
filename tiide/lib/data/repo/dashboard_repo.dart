import 'package:drift/drift.dart';

import '../db/database.dart';

/// Data class for tag session counts.
class TagCount {
  final String label;
  final int count;
  TagCount(this.label, this.count);
}

/// Data class for heatmap cell (day × hour).
class HeatmapCell {
  final int dayOfWeek; // 1=Mon .. 7=Sun
  final int hour; // 0..23
  final int count;
  HeatmapCell(this.dayOfWeek, this.hour, this.count);
}

/// Data class for duration bucket.
class DurationBucket {
  final int minutes; // bucket label (5, 10, 15, 20, 25, 30)
  final int count;
  DurationBucket(this.minutes, this.count);
}

/// Data class for a trigger insight.
class Insight {
  final String type; // 'peak_time' | 'hrv_drop' | 'cluster_hot'
  final String title;
  final String body;
  Insight({required this.type, required this.title, required this.body});
}

/// Dashboard-specific queries.
class DashboardRepo {
  DashboardRepo(this.db);
  final AppDatabase db;

  // ---- S5.1 Summary metrics ----

  /// Stream of saved sessions count for current ISO week.
  Stream<int> watchWeeklyCount() {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final q = db.selectOnly(db.sessions)
      ..addColumns([db.sessions.id.count()])
      ..where(db.sessions.outcome.equals('saved'))
      ..where(db.sessions.startedAt
          .isBiggerOrEqualValue(startOfWeek));
    return q.watchSingle().map((r) => r.read(db.sessions.id.count()) ?? 0);
  }

  /// Stream of total sit-time across all saved sessions.
  Stream<int> watchTotalMinutes() {
    final q = db.selectOnly(db.sessions)
      ..addColumns([db.sessions.actualDurationMin.sum()])
      ..where(db.sessions.outcome.equals('saved'));
    return q.watchSingle().map(
        (r) => r.read(db.sessions.actualDurationMin.sum())?.toInt() ?? 0);
  }

  /// Stream of current streak (consecutive days with >= 1 saved session).
  Stream<int> watchStreak() {
    final q = db.select(db.sessions)
      ..where((s) => s.outcome.equals('saved'))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]);
    return q.watch().map(_computeStreak);
  }

  int _computeStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;
    // Collect unique session dates.
    final dates = <DateTime>{};
    for (final s in sessions) {
      final d = s.startedAt;
      dates.add(DateTime(d.year, d.month, d.day));
    }
    final sorted = dates.toList()..sort((a, b) => b.compareTo(a));

    // Count backwards from today.
    final today = DateTime.now();
    var check = DateTime(today.year, today.month, today.day);
    // Allow starting from today or yesterday.
    if (!sorted.contains(check)) {
      check = check.subtract(const Duration(days: 1));
      if (!sorted.contains(check)) return 0;
    }
    int streak = 0;
    while (sorted.contains(check)) {
      streak++;
      check = check.subtract(const Duration(days: 1));
    }
    return streak;
  }

  // ---- S5.2 Charts ----

  /// Sessions per tag.
  Stream<List<TagCount>> watchTagCounts() {
    final q = db.selectOnly(db.sessionTags).join([
      innerJoin(db.tags, db.tags.id.equalsExp(db.sessionTags.tagId)),
      innerJoin(db.sessions, db.sessions.id.equalsExp(db.sessionTags.sessionId)),
    ])
      ..addColumns([db.tags.label, db.sessionTags.sessionId.count()])
      ..where(db.sessions.outcome.equals('saved'))
      ..groupBy([db.tags.label])
      ..orderBy([OrderingTerm.desc(db.sessionTags.sessionId.count())]);

    return q.watch().map((rows) => rows.map((r) {
          return TagCount(
            r.read(db.tags.label)!,
            r.read(db.sessionTags.sessionId.count())!,
          );
        }).toList());
  }

  /// Time-of-day heatmap data (day × hour counts).
  Stream<List<HeatmapCell>> watchHeatmap() {
    final q = db.select(db.sessions)
      ..where((s) => s.outcome.equals('saved'));
    return q.watch().map((sessions) {
      final grid = <(int, int), int>{};
      for (final s in sessions) {
        final d = s.startedAt;
        final key = (d.weekday, d.hour);
        grid[key] = (grid[key] ?? 0) + 1;
      }
      return grid.entries
          .map((e) => HeatmapCell(e.key.$1, e.key.$2, e.value))
          .toList();
    });
  }

  /// Duration distribution in 5-min buckets.
  Stream<List<DurationBucket>> watchDurationDist() {
    final q = db.select(db.sessions)
      ..where((s) => s.outcome.equals('saved'));
    return q.watch().map((sessions) {
      final buckets = <int, int>{};
      for (final s in sessions) {
        final mins = s.actualDurationMin ?? s.plannedDurationMin;
        // Snap to 5-min bucket.
        final bucket = ((mins / 5).ceil() * 5).clamp(5, 30);
        buckets[bucket] = (buckets[bucket] ?? 0) + 1;
      }
      final sorted = buckets.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      return sorted.map((e) => DurationBucket(e.key, e.value)).toList();
    });
  }

  // ---- S5.4 Trigger Insights ----

  /// Compute rule-based insights from session data.
  Future<List<Insight>> computeInsights() async {
    final insights = <Insight>[];

    // 1. Most-frequent day × time-band.
    final sessions = await (db.select(db.sessions)
          ..where((s) => s.outcome.equals('saved')))
        .get();

    if (sessions.length >= 3) {
      final bands = <(int, String), int>{};
      for (final s in sessions) {
        final d = s.startedAt;
        final band = _timeBand(d.hour);
        final key = (d.weekday, band);
        bands[key] = (bands[key] ?? 0) + 1;
      }
      if (bands.isNotEmpty) {
        final top = bands.entries.reduce((a, b) => a.value > b.value ? a : b);
        insights.add(Insight(
          type: 'peak_time',
          title: 'peak time',
          body:
              '${_dayName(top.key.$1)}s, ${top.key.$2} — ${top.value} sessions',
        ));
      }
    }

    // 2. Tag-correlated HRV drop.
    final snapshots = await (db.select(db.biometricSnapshots)).get();
    if (snapshots.isNotEmpty) {
      // Map sessionId -> HRV drop.
      final hrvDrops = <String, double>{};
      for (final snap in snapshots) {
        if (snap.hrvAvgPre != null && snap.hrvAvgDuring != null) {
          hrvDrops[snap.sessionId] = snap.hrvAvgPre! - snap.hrvAvgDuring!;
        }
      }
      if (hrvDrops.isNotEmpty) {
        // Get tags for those sessions.
        final tagRows = await (db.select(db.sessionTags).join([
          innerJoin(db.tags, db.tags.id.equalsExp(db.sessionTags.tagId)),
        ])
              ..where(db.sessionTags.sessionId.isIn(hrvDrops.keys.toList())))
            .get();

        final tagDrops = <String, List<double>>{};
        for (final r in tagRows) {
          final sid = r.readTable(db.sessionTags).sessionId;
          final label = r.readTable(db.tags).label;
          final drop = hrvDrops[sid];
          if (drop != null) {
            tagDrops.putIfAbsent(label, () => []).add(drop);
          }
        }
        if (tagDrops.isNotEmpty) {
          final avgDrops = tagDrops.map(
              (k, v) => MapEntry(k, v.reduce((a, b) => a + b) / v.length));
          final worst =
              avgDrops.entries.reduce((a, b) => a.value > b.value ? a : b);
          if (worst.value > 0) {
            insights.add(Insight(
              type: 'hrv_drop',
              title: 'hrv impact',
              body:
                  '"${worst.key}" sessions show ${worst.value.round()} ms HRV drop on average',
            ));
          }
        }
      }
    }

    // 3. Cluster-correlated session count.
    final clusters = await (db.select(db.geoClusters)).get();
    if (clusters.isNotEmpty) {
      final clusterCounts = <String, int>{};
      final clusterLabels = <String, String>{};
      for (final c in clusters) {
        clusterLabels[c.id] = c.userLabel ?? 'unnamed area';
        clusterCounts[c.id] = 0;
      }
      final points = await (db.select(db.geoPoints)
            ..where((g) => g.kind.equals('start'))
            ..where((g) => g.clusterId.isNotNull()))
          .get();
      for (final p in points) {
        if (p.clusterId != null) {
          clusterCounts[p.clusterId!] =
              (clusterCounts[p.clusterId!] ?? 0) + 1;
        }
      }
      final entries =
          clusterCounts.entries.where((e) => e.value > 0).toList();
      if (entries.isNotEmpty) {
        final top = entries.reduce((a, b) => a.value > b.value ? a : b);
        insights.add(Insight(
          type: 'cluster_hot',
          title: 'hotspot',
          body:
              '${top.value} sessions near "${clusterLabels[top.key]}"',
        ));
      }
    }

    return insights;
  }

  String _timeBand(int hour) {
    if (hour < 6) return 'late night';
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    if (hour < 21) return 'evening';
    return 'night';
  }

  String _dayName(int weekday) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[weekday - 1];
  }

  // ---- S5.3 Geo clusters ----

  Future<List<GeoCluster>> allClusters() {
    return db.select(db.geoClusters).get();
  }

  Stream<List<GeoCluster>> watchClusters() {
    return db.select(db.geoClusters).watch();
  }

  Future<void> renameCluster(String id, String label) {
    return (db.update(db.geoClusters)..where((c) => c.id.equals(id)))
        .write(GeoClustersCompanion(userLabel: Value(label)));
  }
}
