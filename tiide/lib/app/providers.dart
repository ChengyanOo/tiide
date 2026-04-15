import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/database.dart';
import '../data/repo/enrichment_repo.dart';
import '../data/repo/session_repo.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final sessionRepoProvider = Provider<SessionRepo>((ref) {
  return SessionRepo(ref.watch(databaseProvider));
});

final enrichmentRepoProvider = Provider<EnrichmentRepo>((ref) {
  return EnrichmentRepo(ref.watch(databaseProvider));
});

final activeSessionProvider = StreamProvider<Session?>((ref) {
  return ref.watch(sessionRepoProvider).watchActive();
});

final sessionListProvider = StreamProvider<List<SessionWithTags>>((ref) {
  return ref.watch(sessionRepoProvider).watchAll();
});

final tagsProvider = FutureProvider<List<Tag>>((ref) {
  return ref.watch(sessionRepoProvider).allTags();
});

// S4: Session detail providers (by session ID).

final sessionDetailProvider =
    FutureProvider.family<SessionWithTags?, String>((ref, id) async {
  final repo = ref.watch(sessionRepoProvider);
  final session = await repo.byId(id);
  if (session == null) return null;
  final tags = await repo.tagsForSession(id);
  return SessionWithTags(session, tags);
});

final biometricSnapshotProvider =
    FutureProvider.family<BiometricSnapshot?, String>((ref, sessionId) {
  return ref.watch(enrichmentRepoProvider).snapshotForSession(sessionId);
});

final biometricSamplesProvider =
    FutureProvider.family<List<BiometricSample>, String>((ref, snapshotId) {
  return ref.watch(enrichmentRepoProvider).samplesForSnapshot(snapshotId);
});

final geoPointsProvider =
    FutureProvider.family<List<GeoPoint>, String>((ref, sessionId) {
  return ref.watch(enrichmentRepoProvider).geoPointsForSession(sessionId);
});
