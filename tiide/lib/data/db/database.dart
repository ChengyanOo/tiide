import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Sessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get plannedDurationMin => integer().withDefault(const Constant(15))();
  IntColumn get actualDurationMin => integer().nullable()();
  TextColumn get outcome =>
      text().withDefault(const Constant('active'))(); // active|saved|orphaned
  IntColumn get extensionCount => integer().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Tags extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get category => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class SessionTags extends Table {
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get tagId =>
      text().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {sessionId, tagId};
}

const defaultTags = [
  ('relationship', 'relationship', 'context'),
  ('habit', 'habit', 'context'),
  ('social', 'social', 'context'),
  ('work', 'work', 'context'),
  ('other', 'other', 'context'),
];

@DriftDatabase(tables: [Sessions, Tags, SessionTags])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e])
      : super(e ??
            driftDatabase(
              name: 'tiide_db',
              web: DriftWebOptions(
                sqlite3Wasm: Uri.parse('sqlite3.wasm'),
                driftWorker: Uri.parse('drift_worker.js'),
              ),
            ));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedTags();
        },
      );

  Future<void> _seedTags() async {
    for (final t in defaultTags) {
      await into(tags).insert(
        TagsCompanion.insert(
          id: t.$1,
          label: t.$2,
          category: Value(t.$3),
        ),
        mode: InsertMode.insertOrIgnore,
      );
    }
  }
}
