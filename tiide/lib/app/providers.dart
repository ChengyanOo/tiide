import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/db/database.dart';
import '../data/repo/session_repo.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final sessionRepoProvider = Provider<SessionRepo>((ref) {
  return SessionRepo(ref.watch(databaseProvider));
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
