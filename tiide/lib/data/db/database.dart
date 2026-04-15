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

// S4: Biometric tables
class BiometricSnapshots extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  RealColumn get hrAvgPre => real().nullable()();
  RealColumn get hrAvgDuring => real().nullable()();
  RealColumn get hrvAvgPre => real().nullable()();
  RealColumn get hrvAvgDuring => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class BiometricSamples extends Table {
  TextColumn get id => text()();
  TextColumn get snapshotId =>
      text().references(BiometricSnapshots, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get ts => dateTime()();
  TextColumn get metric => text()(); // hr|hrv
  RealColumn get value => real()();

  @override
  Set<Column> get primaryKey => {id};
}

// S4: Geo tables
class GeoPoints extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(Sessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()(); // start|end
  RealColumn get lat => real()();
  RealColumn get lng => real()();
  RealColumn get accuracyM => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class GeoClusters extends Table {
  TextColumn get id => text()();
  TextColumn get userLabel => text().nullable()();
  RealColumn get centroidLat => real()();
  RealColumn get centroidLng => real()();
  RealColumn get radiusM => real().withDefault(const Constant(200.0))();

  @override
  Set<Column> get primaryKey => {id};
}

const defaultTags = [
  ('relationship', 'relationship', 'context'),
  ('habit', 'habit', 'context'),
  ('social', 'social', 'context'),
  ('work', 'work', 'context'),
  ('other', 'other', 'context'),
];

@DriftDatabase(tables: [
  Sessions,
  Tags,
  SessionTags,
  BiometricSnapshots,
  BiometricSamples,
  GeoPoints,
  GeoClusters,
])
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
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedTags();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(biometricSnapshots);
            await m.createTable(biometricSamples);
            await m.createTable(geoPoints);
            await m.createTable(geoClusters);
          }
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
