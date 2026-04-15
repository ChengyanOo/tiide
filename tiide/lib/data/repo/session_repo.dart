import 'package:drift/drift.dart';

import '../db/database.dart';

class SessionWithTags {
  final Session session;
  final List<Tag> tags;
  SessionWithTags(this.session, this.tags);
}

class SessionRepo {
  SessionRepo(this.db);
  final AppDatabase db;

  String _genId() {
    final us = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final ms = (DateTime.now().millisecondsSinceEpoch % 100000).toRadixString(36);
    return '$us-$ms';
  }

  Future<Session> create({
    int plannedDurationMin = 15,
    DateTime? startedAt,
  }) async {
    final id = _genId();
    final row = SessionsCompanion.insert(
      id: id,
      startedAt: startedAt ?? DateTime.now(),
      plannedDurationMin: Value(plannedDurationMin),
    );
    await db.into(db.sessions).insert(row);
    return (db.select(db.sessions)..where((s) => s.id.equals(id)))
        .getSingle();
  }

  Future<Session> finalize({
    required String id,
    required int actualDurationMin,
    List<String> tagIds = const [],
    String? note,
    String outcome = 'saved',
    DateTime? endedAt,
  }) async {
    final end = endedAt ?? DateTime.now();
    await (db.update(db.sessions)..where((s) => s.id.equals(id))).write(
      SessionsCompanion(
        endedAt: Value(end),
        actualDurationMin: Value(actualDurationMin),
        outcome: Value(outcome),
        note: Value(note),
      ),
    );
    if (tagIds.isNotEmpty) {
      await db.batch((b) {
        b.insertAll(
          db.sessionTags,
          [for (final t in tagIds) SessionTagsCompanion.insert(sessionId: id, tagId: t)],
          mode: InsertMode.insertOrIgnore,
        );
      });
    }
    return (db.select(db.sessions)..where((s) => s.id.equals(id)))
        .getSingle();
  }

  Future<Session?> activeSession() {
    return (db.select(db.sessions)
          ..where((s) => s.outcome.equals('active'))
          ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<Session?> watchActive() {
    return (db.select(db.sessions)
          ..where((s) => s.outcome.equals('active'))
          ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<List<SessionWithTags>> watchAll() {
    final q = db.select(db.sessions)
      ..where((s) => s.outcome.equals('active').not())
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]);
    return q.watch().asyncMap(_hydrateTags);
  }

  Future<List<SessionWithTags>> list() async {
    final rows = await (db.select(db.sessions)
          ..where((s) => s.outcome.equals('active').not())
          ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]))
        .get();
    return _hydrateTags(rows);
  }

  Future<List<SessionWithTags>> _hydrateTags(List<Session> rows) async {
    if (rows.isEmpty) return [];
    final ids = rows.map((r) => r.id).toList();
    final joinRows = await (db.select(db.sessionTags).join([
      innerJoin(db.tags, db.tags.id.equalsExp(db.sessionTags.tagId)),
    ])
          ..where(db.sessionTags.sessionId.isIn(ids)))
        .get();

    final byId = <String, List<Tag>>{};
    for (final r in joinRows) {
      final sid = r.readTable(db.sessionTags).sessionId;
      final tag = r.readTable(db.tags);
      byId.putIfAbsent(sid, () => []).add(tag);
    }
    return [for (final s in rows) SessionWithTags(s, byId[s.id] ?? const [])];
  }

  Future<List<Tag>> allTags() {
    return (db.select(db.tags)..orderBy([(t) => OrderingTerm.asc(t.label)]))
        .get();
  }
}
