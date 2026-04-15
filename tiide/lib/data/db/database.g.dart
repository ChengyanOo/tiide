// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SessionsTable extends Sessions with TableInfo<$SessionsTable, Session> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _plannedDurationMinMeta =
      const VerificationMeta('plannedDurationMin');
  @override
  late final GeneratedColumn<int> plannedDurationMin = GeneratedColumn<int>(
    'planned_duration_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _actualDurationMinMeta = const VerificationMeta(
    'actualDurationMin',
  );
  @override
  late final GeneratedColumn<int> actualDurationMin = GeneratedColumn<int>(
    'actual_duration_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _extensionCountMeta = const VerificationMeta(
    'extensionCount',
  );
  @override
  late final GeneratedColumn<int> extensionCount = GeneratedColumn<int>(
    'extension_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    plannedDurationMin,
    actualDurationMin,
    outcome,
    extensionCount,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Session> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('planned_duration_min')) {
      context.handle(
        _plannedDurationMinMeta,
        plannedDurationMin.isAcceptableOrUnknown(
          data['planned_duration_min']!,
          _plannedDurationMinMeta,
        ),
      );
    }
    if (data.containsKey('actual_duration_min')) {
      context.handle(
        _actualDurationMinMeta,
        actualDurationMin.isAcceptableOrUnknown(
          data['actual_duration_min']!,
          _actualDurationMinMeta,
        ),
      );
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    }
    if (data.containsKey('extension_count')) {
      context.handle(
        _extensionCountMeta,
        extensionCount.isAcceptableOrUnknown(
          data['extension_count']!,
          _extensionCountMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Session map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Session(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      plannedDurationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_duration_min'],
      )!,
      actualDurationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_duration_min'],
      ),
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      extensionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extension_count'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class Session extends DataClass implements Insertable<Session> {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int plannedDurationMin;
  final int? actualDurationMin;
  final String outcome;
  final int extensionCount;
  final String? note;
  const Session({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.plannedDurationMin,
    this.actualDurationMin,
    required this.outcome,
    required this.extensionCount,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['planned_duration_min'] = Variable<int>(plannedDurationMin);
    if (!nullToAbsent || actualDurationMin != null) {
      map['actual_duration_min'] = Variable<int>(actualDurationMin);
    }
    map['outcome'] = Variable<String>(outcome);
    map['extension_count'] = Variable<int>(extensionCount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      plannedDurationMin: Value(plannedDurationMin),
      actualDurationMin: actualDurationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDurationMin),
      outcome: Value(outcome),
      extensionCount: Value(extensionCount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Session.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Session(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      plannedDurationMin: serializer.fromJson<int>(json['plannedDurationMin']),
      actualDurationMin: serializer.fromJson<int?>(json['actualDurationMin']),
      outcome: serializer.fromJson<String>(json['outcome']),
      extensionCount: serializer.fromJson<int>(json['extensionCount']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'plannedDurationMin': serializer.toJson<int>(plannedDurationMin),
      'actualDurationMin': serializer.toJson<int?>(actualDurationMin),
      'outcome': serializer.toJson<String>(outcome),
      'extensionCount': serializer.toJson<int>(extensionCount),
      'note': serializer.toJson<String?>(note),
    };
  }

  Session copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? plannedDurationMin,
    Value<int?> actualDurationMin = const Value.absent(),
    String? outcome,
    int? extensionCount,
    Value<String?> note = const Value.absent(),
  }) => Session(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    plannedDurationMin: plannedDurationMin ?? this.plannedDurationMin,
    actualDurationMin: actualDurationMin.present
        ? actualDurationMin.value
        : this.actualDurationMin,
    outcome: outcome ?? this.outcome,
    extensionCount: extensionCount ?? this.extensionCount,
    note: note.present ? note.value : this.note,
  );
  Session copyWithCompanion(SessionsCompanion data) {
    return Session(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      plannedDurationMin: data.plannedDurationMin.present
          ? data.plannedDurationMin.value
          : this.plannedDurationMin,
      actualDurationMin: data.actualDurationMin.present
          ? data.actualDurationMin.value
          : this.actualDurationMin,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      extensionCount: data.extensionCount.present
          ? data.extensionCount.value
          : this.extensionCount,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Session(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationMin: $plannedDurationMin, ')
          ..write('actualDurationMin: $actualDurationMin, ')
          ..write('outcome: $outcome, ')
          ..write('extensionCount: $extensionCount, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    plannedDurationMin,
    actualDurationMin,
    outcome,
    extensionCount,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Session &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.plannedDurationMin == this.plannedDurationMin &&
          other.actualDurationMin == this.actualDurationMin &&
          other.outcome == this.outcome &&
          other.extensionCount == this.extensionCount &&
          other.note == this.note);
}

class SessionsCompanion extends UpdateCompanion<Session> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> plannedDurationMin;
  final Value<int?> actualDurationMin;
  final Value<String> outcome;
  final Value<int> extensionCount;
  final Value<String?> note;
  final Value<int> rowid;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.plannedDurationMin = const Value.absent(),
    this.actualDurationMin = const Value.absent(),
    this.outcome = const Value.absent(),
    this.extensionCount = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.plannedDurationMin = const Value.absent(),
    this.actualDurationMin = const Value.absent(),
    this.outcome = const Value.absent(),
    this.extensionCount = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt);
  static Insertable<Session> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? plannedDurationMin,
    Expression<int>? actualDurationMin,
    Expression<String>? outcome,
    Expression<int>? extensionCount,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (plannedDurationMin != null)
        'planned_duration_min': plannedDurationMin,
      if (actualDurationMin != null) 'actual_duration_min': actualDurationMin,
      if (outcome != null) 'outcome': outcome,
      if (extensionCount != null) 'extension_count': extensionCount,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? plannedDurationMin,
    Value<int?>? actualDurationMin,
    Value<String>? outcome,
    Value<int>? extensionCount,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      plannedDurationMin: plannedDurationMin ?? this.plannedDurationMin,
      actualDurationMin: actualDurationMin ?? this.actualDurationMin,
      outcome: outcome ?? this.outcome,
      extensionCount: extensionCount ?? this.extensionCount,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (plannedDurationMin.present) {
      map['planned_duration_min'] = Variable<int>(plannedDurationMin.value);
    }
    if (actualDurationMin.present) {
      map['actual_duration_min'] = Variable<int>(actualDurationMin.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (extensionCount.present) {
      map['extension_count'] = Variable<int>(extensionCount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('plannedDurationMin: $plannedDurationMin, ')
          ..write('actualDurationMin: $actualDurationMin, ')
          ..write('outcome: $outcome, ')
          ..write('extensionCount: $extensionCount, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, label, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String label;
  final String? category;
  const Tag({required this.id, required this.label, this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      label: Value(label),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      category: serializer.fromJson<String?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'category': serializer.toJson<String?>(category),
    };
  }

  Tag copyWith({
    String? id,
    String? label,
    Value<String?> category = const Value.absent(),
  }) => Tag(
    id: id ?? this.id,
    label: label ?? this.label,
    category: category.present ? category.value : this.category,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, label, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.label == this.label &&
          other.category == this.category);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> label;
  final Value<String?> category;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String label,
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       label = Value(label);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? label,
    Value<String?>? category,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionTagsTable extends SessionTags
    with TableInfo<$SessionTagsTable, SessionTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sessionId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId, tagId};
  @override
  SessionTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionTag(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $SessionTagsTable createAlias(String alias) {
    return $SessionTagsTable(attachedDatabase, alias);
  }
}

class SessionTag extends DataClass implements Insertable<SessionTag> {
  final String sessionId;
  final String tagId;
  const SessionTag({required this.sessionId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  SessionTagsCompanion toCompanion(bool nullToAbsent) {
    return SessionTagsCompanion(
      sessionId: Value(sessionId),
      tagId: Value(tagId),
    );
  }

  factory SessionTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionTag(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  SessionTag copyWith({String? sessionId, String? tagId}) => SessionTag(
    sessionId: sessionId ?? this.sessionId,
    tagId: tagId ?? this.tagId,
  );
  SessionTag copyWithCompanion(SessionTagsCompanion data) {
    return SessionTag(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionTag(')
          ..write('sessionId: $sessionId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionTag &&
          other.sessionId == this.sessionId &&
          other.tagId == this.tagId);
}

class SessionTagsCompanion extends UpdateCompanion<SessionTag> {
  final Value<String> sessionId;
  final Value<String> tagId;
  final Value<int> rowid;
  const SessionTagsCompanion({
    this.sessionId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionTagsCompanion.insert({
    required String sessionId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       tagId = Value(tagId);
  static Insertable<SessionTag> custom({
    Expression<String>? sessionId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionTagsCompanion copyWith({
    Value<String>? sessionId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return SessionTagsCompanion(
      sessionId: sessionId ?? this.sessionId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionTagsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BiometricSnapshotsTable extends BiometricSnapshots
    with TableInfo<$BiometricSnapshotsTable, BiometricSnapshot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BiometricSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _hrAvgPreMeta = const VerificationMeta(
    'hrAvgPre',
  );
  @override
  late final GeneratedColumn<double> hrAvgPre = GeneratedColumn<double>(
    'hr_avg_pre',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrAvgDuringMeta = const VerificationMeta(
    'hrAvgDuring',
  );
  @override
  late final GeneratedColumn<double> hrAvgDuring = GeneratedColumn<double>(
    'hr_avg_during',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrvAvgPreMeta = const VerificationMeta(
    'hrvAvgPre',
  );
  @override
  late final GeneratedColumn<double> hrvAvgPre = GeneratedColumn<double>(
    'hrv_avg_pre',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hrvAvgDuringMeta = const VerificationMeta(
    'hrvAvgDuring',
  );
  @override
  late final GeneratedColumn<double> hrvAvgDuring = GeneratedColumn<double>(
    'hrv_avg_during',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    hrAvgPre,
    hrAvgDuring,
    hrvAvgPre,
    hrvAvgDuring,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'biometric_snapshots';
  @override
  VerificationContext validateIntegrity(
    Insertable<BiometricSnapshot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('hr_avg_pre')) {
      context.handle(
        _hrAvgPreMeta,
        hrAvgPre.isAcceptableOrUnknown(data['hr_avg_pre']!, _hrAvgPreMeta),
      );
    }
    if (data.containsKey('hr_avg_during')) {
      context.handle(
        _hrAvgDuringMeta,
        hrAvgDuring.isAcceptableOrUnknown(
          data['hr_avg_during']!,
          _hrAvgDuringMeta,
        ),
      );
    }
    if (data.containsKey('hrv_avg_pre')) {
      context.handle(
        _hrvAvgPreMeta,
        hrvAvgPre.isAcceptableOrUnknown(data['hrv_avg_pre']!, _hrvAvgPreMeta),
      );
    }
    if (data.containsKey('hrv_avg_during')) {
      context.handle(
        _hrvAvgDuringMeta,
        hrvAvgDuring.isAcceptableOrUnknown(
          data['hrv_avg_during']!,
          _hrvAvgDuringMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BiometricSnapshot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BiometricSnapshot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      hrAvgPre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hr_avg_pre'],
      ),
      hrAvgDuring: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hr_avg_during'],
      ),
      hrvAvgPre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hrv_avg_pre'],
      ),
      hrvAvgDuring: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hrv_avg_during'],
      ),
    );
  }

  @override
  $BiometricSnapshotsTable createAlias(String alias) {
    return $BiometricSnapshotsTable(attachedDatabase, alias);
  }
}

class BiometricSnapshot extends DataClass
    implements Insertable<BiometricSnapshot> {
  final String id;
  final String sessionId;
  final double? hrAvgPre;
  final double? hrAvgDuring;
  final double? hrvAvgPre;
  final double? hrvAvgDuring;
  const BiometricSnapshot({
    required this.id,
    required this.sessionId,
    this.hrAvgPre,
    this.hrAvgDuring,
    this.hrvAvgPre,
    this.hrvAvgDuring,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || hrAvgPre != null) {
      map['hr_avg_pre'] = Variable<double>(hrAvgPre);
    }
    if (!nullToAbsent || hrAvgDuring != null) {
      map['hr_avg_during'] = Variable<double>(hrAvgDuring);
    }
    if (!nullToAbsent || hrvAvgPre != null) {
      map['hrv_avg_pre'] = Variable<double>(hrvAvgPre);
    }
    if (!nullToAbsent || hrvAvgDuring != null) {
      map['hrv_avg_during'] = Variable<double>(hrvAvgDuring);
    }
    return map;
  }

  BiometricSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return BiometricSnapshotsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      hrAvgPre: hrAvgPre == null && nullToAbsent
          ? const Value.absent()
          : Value(hrAvgPre),
      hrAvgDuring: hrAvgDuring == null && nullToAbsent
          ? const Value.absent()
          : Value(hrAvgDuring),
      hrvAvgPre: hrvAvgPre == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvAvgPre),
      hrvAvgDuring: hrvAvgDuring == null && nullToAbsent
          ? const Value.absent()
          : Value(hrvAvgDuring),
    );
  }

  factory BiometricSnapshot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BiometricSnapshot(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      hrAvgPre: serializer.fromJson<double?>(json['hrAvgPre']),
      hrAvgDuring: serializer.fromJson<double?>(json['hrAvgDuring']),
      hrvAvgPre: serializer.fromJson<double?>(json['hrvAvgPre']),
      hrvAvgDuring: serializer.fromJson<double?>(json['hrvAvgDuring']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'hrAvgPre': serializer.toJson<double?>(hrAvgPre),
      'hrAvgDuring': serializer.toJson<double?>(hrAvgDuring),
      'hrvAvgPre': serializer.toJson<double?>(hrvAvgPre),
      'hrvAvgDuring': serializer.toJson<double?>(hrvAvgDuring),
    };
  }

  BiometricSnapshot copyWith({
    String? id,
    String? sessionId,
    Value<double?> hrAvgPre = const Value.absent(),
    Value<double?> hrAvgDuring = const Value.absent(),
    Value<double?> hrvAvgPre = const Value.absent(),
    Value<double?> hrvAvgDuring = const Value.absent(),
  }) => BiometricSnapshot(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    hrAvgPre: hrAvgPre.present ? hrAvgPre.value : this.hrAvgPre,
    hrAvgDuring: hrAvgDuring.present ? hrAvgDuring.value : this.hrAvgDuring,
    hrvAvgPre: hrvAvgPre.present ? hrvAvgPre.value : this.hrvAvgPre,
    hrvAvgDuring: hrvAvgDuring.present ? hrvAvgDuring.value : this.hrvAvgDuring,
  );
  BiometricSnapshot copyWithCompanion(BiometricSnapshotsCompanion data) {
    return BiometricSnapshot(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      hrAvgPre: data.hrAvgPre.present ? data.hrAvgPre.value : this.hrAvgPre,
      hrAvgDuring: data.hrAvgDuring.present
          ? data.hrAvgDuring.value
          : this.hrAvgDuring,
      hrvAvgPre: data.hrvAvgPre.present ? data.hrvAvgPre.value : this.hrvAvgPre,
      hrvAvgDuring: data.hrvAvgDuring.present
          ? data.hrvAvgDuring.value
          : this.hrvAvgDuring,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BiometricSnapshot(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('hrAvgPre: $hrAvgPre, ')
          ..write('hrAvgDuring: $hrAvgDuring, ')
          ..write('hrvAvgPre: $hrvAvgPre, ')
          ..write('hrvAvgDuring: $hrvAvgDuring')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    hrAvgPre,
    hrAvgDuring,
    hrvAvgPre,
    hrvAvgDuring,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BiometricSnapshot &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.hrAvgPre == this.hrAvgPre &&
          other.hrAvgDuring == this.hrAvgDuring &&
          other.hrvAvgPre == this.hrvAvgPre &&
          other.hrvAvgDuring == this.hrvAvgDuring);
}

class BiometricSnapshotsCompanion extends UpdateCompanion<BiometricSnapshot> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<double?> hrAvgPre;
  final Value<double?> hrAvgDuring;
  final Value<double?> hrvAvgPre;
  final Value<double?> hrvAvgDuring;
  final Value<int> rowid;
  const BiometricSnapshotsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.hrAvgPre = const Value.absent(),
    this.hrAvgDuring = const Value.absent(),
    this.hrvAvgPre = const Value.absent(),
    this.hrvAvgDuring = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BiometricSnapshotsCompanion.insert({
    required String id,
    required String sessionId,
    this.hrAvgPre = const Value.absent(),
    this.hrAvgDuring = const Value.absent(),
    this.hrvAvgPre = const Value.absent(),
    this.hrvAvgDuring = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId);
  static Insertable<BiometricSnapshot> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<double>? hrAvgPre,
    Expression<double>? hrAvgDuring,
    Expression<double>? hrvAvgPre,
    Expression<double>? hrvAvgDuring,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (hrAvgPre != null) 'hr_avg_pre': hrAvgPre,
      if (hrAvgDuring != null) 'hr_avg_during': hrAvgDuring,
      if (hrvAvgPre != null) 'hrv_avg_pre': hrvAvgPre,
      if (hrvAvgDuring != null) 'hrv_avg_during': hrvAvgDuring,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BiometricSnapshotsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<double?>? hrAvgPre,
    Value<double?>? hrAvgDuring,
    Value<double?>? hrvAvgPre,
    Value<double?>? hrvAvgDuring,
    Value<int>? rowid,
  }) {
    return BiometricSnapshotsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      hrAvgPre: hrAvgPre ?? this.hrAvgPre,
      hrAvgDuring: hrAvgDuring ?? this.hrAvgDuring,
      hrvAvgPre: hrvAvgPre ?? this.hrvAvgPre,
      hrvAvgDuring: hrvAvgDuring ?? this.hrvAvgDuring,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (hrAvgPre.present) {
      map['hr_avg_pre'] = Variable<double>(hrAvgPre.value);
    }
    if (hrAvgDuring.present) {
      map['hr_avg_during'] = Variable<double>(hrAvgDuring.value);
    }
    if (hrvAvgPre.present) {
      map['hrv_avg_pre'] = Variable<double>(hrvAvgPre.value);
    }
    if (hrvAvgDuring.present) {
      map['hrv_avg_during'] = Variable<double>(hrvAvgDuring.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BiometricSnapshotsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('hrAvgPre: $hrAvgPre, ')
          ..write('hrAvgDuring: $hrAvgDuring, ')
          ..write('hrvAvgPre: $hrvAvgPre, ')
          ..write('hrvAvgDuring: $hrvAvgDuring, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BiometricSamplesTable extends BiometricSamples
    with TableInfo<$BiometricSamplesTable, BiometricSample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BiometricSamplesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotIdMeta = const VerificationMeta(
    'snapshotId',
  );
  @override
  late final GeneratedColumn<String> snapshotId = GeneratedColumn<String>(
    'snapshot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES biometric_snapshots (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<DateTime> ts = GeneratedColumn<DateTime>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, snapshotId, ts, metric, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'biometric_samples';
  @override
  VerificationContext validateIntegrity(
    Insertable<BiometricSample> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('snapshot_id')) {
      context.handle(
        _snapshotIdMeta,
        snapshotId.isAcceptableOrUnknown(data['snapshot_id']!, _snapshotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotIdMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BiometricSample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BiometricSample(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      snapshotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot_id'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ts'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $BiometricSamplesTable createAlias(String alias) {
    return $BiometricSamplesTable(attachedDatabase, alias);
  }
}

class BiometricSample extends DataClass implements Insertable<BiometricSample> {
  final String id;
  final String snapshotId;
  final DateTime ts;
  final String metric;
  final double value;
  const BiometricSample({
    required this.id,
    required this.snapshotId,
    required this.ts,
    required this.metric,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['snapshot_id'] = Variable<String>(snapshotId);
    map['ts'] = Variable<DateTime>(ts);
    map['metric'] = Variable<String>(metric);
    map['value'] = Variable<double>(value);
    return map;
  }

  BiometricSamplesCompanion toCompanion(bool nullToAbsent) {
    return BiometricSamplesCompanion(
      id: Value(id),
      snapshotId: Value(snapshotId),
      ts: Value(ts),
      metric: Value(metric),
      value: Value(value),
    );
  }

  factory BiometricSample.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BiometricSample(
      id: serializer.fromJson<String>(json['id']),
      snapshotId: serializer.fromJson<String>(json['snapshotId']),
      ts: serializer.fromJson<DateTime>(json['ts']),
      metric: serializer.fromJson<String>(json['metric']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'snapshotId': serializer.toJson<String>(snapshotId),
      'ts': serializer.toJson<DateTime>(ts),
      'metric': serializer.toJson<String>(metric),
      'value': serializer.toJson<double>(value),
    };
  }

  BiometricSample copyWith({
    String? id,
    String? snapshotId,
    DateTime? ts,
    String? metric,
    double? value,
  }) => BiometricSample(
    id: id ?? this.id,
    snapshotId: snapshotId ?? this.snapshotId,
    ts: ts ?? this.ts,
    metric: metric ?? this.metric,
    value: value ?? this.value,
  );
  BiometricSample copyWithCompanion(BiometricSamplesCompanion data) {
    return BiometricSample(
      id: data.id.present ? data.id.value : this.id,
      snapshotId: data.snapshotId.present
          ? data.snapshotId.value
          : this.snapshotId,
      ts: data.ts.present ? data.ts.value : this.ts,
      metric: data.metric.present ? data.metric.value : this.metric,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BiometricSample(')
          ..write('id: $id, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('ts: $ts, ')
          ..write('metric: $metric, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, snapshotId, ts, metric, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BiometricSample &&
          other.id == this.id &&
          other.snapshotId == this.snapshotId &&
          other.ts == this.ts &&
          other.metric == this.metric &&
          other.value == this.value);
}

class BiometricSamplesCompanion extends UpdateCompanion<BiometricSample> {
  final Value<String> id;
  final Value<String> snapshotId;
  final Value<DateTime> ts;
  final Value<String> metric;
  final Value<double> value;
  final Value<int> rowid;
  const BiometricSamplesCompanion({
    this.id = const Value.absent(),
    this.snapshotId = const Value.absent(),
    this.ts = const Value.absent(),
    this.metric = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BiometricSamplesCompanion.insert({
    required String id,
    required String snapshotId,
    required DateTime ts,
    required String metric,
    required double value,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       snapshotId = Value(snapshotId),
       ts = Value(ts),
       metric = Value(metric),
       value = Value(value);
  static Insertable<BiometricSample> custom({
    Expression<String>? id,
    Expression<String>? snapshotId,
    Expression<DateTime>? ts,
    Expression<String>? metric,
    Expression<double>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (snapshotId != null) 'snapshot_id': snapshotId,
      if (ts != null) 'ts': ts,
      if (metric != null) 'metric': metric,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BiometricSamplesCompanion copyWith({
    Value<String>? id,
    Value<String>? snapshotId,
    Value<DateTime>? ts,
    Value<String>? metric,
    Value<double>? value,
    Value<int>? rowid,
  }) {
    return BiometricSamplesCompanion(
      id: id ?? this.id,
      snapshotId: snapshotId ?? this.snapshotId,
      ts: ts ?? this.ts,
      metric: metric ?? this.metric,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (snapshotId.present) {
      map['snapshot_id'] = Variable<String>(snapshotId.value);
    }
    if (ts.present) {
      map['ts'] = Variable<DateTime>(ts.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BiometricSamplesCompanion(')
          ..write('id: $id, ')
          ..write('snapshotId: $snapshotId, ')
          ..write('ts: $ts, ')
          ..write('metric: $metric, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GeoPointsTable extends GeoPoints
    with TableInfo<$GeoPointsTable, GeoPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GeoPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    kind,
    lat,
    lng,
    accuracyM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'geo_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<GeoPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GeoPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GeoPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      ),
    );
  }

  @override
  $GeoPointsTable createAlias(String alias) {
    return $GeoPointsTable(attachedDatabase, alias);
  }
}

class GeoPoint extends DataClass implements Insertable<GeoPoint> {
  final String id;
  final String sessionId;
  final String kind;
  final double lat;
  final double lng;
  final double? accuracyM;
  const GeoPoint({
    required this.id,
    required this.sessionId,
    required this.kind,
    required this.lat,
    required this.lng,
    this.accuracyM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['kind'] = Variable<String>(kind);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    if (!nullToAbsent || accuracyM != null) {
      map['accuracy_m'] = Variable<double>(accuracyM);
    }
    return map;
  }

  GeoPointsCompanion toCompanion(bool nullToAbsent) {
    return GeoPointsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      kind: Value(kind),
      lat: Value(lat),
      lng: Value(lng),
      accuracyM: accuracyM == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyM),
    );
  }

  factory GeoPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GeoPoint(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      kind: serializer.fromJson<String>(json['kind']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      accuracyM: serializer.fromJson<double?>(json['accuracyM']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'kind': serializer.toJson<String>(kind),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'accuracyM': serializer.toJson<double?>(accuracyM),
    };
  }

  GeoPoint copyWith({
    String? id,
    String? sessionId,
    String? kind,
    double? lat,
    double? lng,
    Value<double?> accuracyM = const Value.absent(),
  }) => GeoPoint(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    kind: kind ?? this.kind,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    accuracyM: accuracyM.present ? accuracyM.value : this.accuracyM,
  );
  GeoPoint copyWithCompanion(GeoPointsCompanion data) {
    return GeoPoint(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      kind: data.kind.present ? data.kind.value : this.kind,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GeoPoint(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('kind: $kind, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('accuracyM: $accuracyM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, kind, lat, lng, accuracyM);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeoPoint &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.kind == this.kind &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.accuracyM == this.accuracyM);
}

class GeoPointsCompanion extends UpdateCompanion<GeoPoint> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> kind;
  final Value<double> lat;
  final Value<double> lng;
  final Value<double?> accuracyM;
  final Value<int> rowid;
  const GeoPointsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.kind = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GeoPointsCompanion.insert({
    required String id,
    required String sessionId,
    required String kind,
    required double lat,
    required double lng,
    this.accuracyM = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       kind = Value(kind),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<GeoPoint> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? kind,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<double>? accuracyM,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (kind != null) 'kind': kind,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GeoPointsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? kind,
    Value<double>? lat,
    Value<double>? lng,
    Value<double?>? accuracyM,
    Value<int>? rowid,
  }) {
    return GeoPointsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      kind: kind ?? this.kind,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      accuracyM: accuracyM ?? this.accuracyM,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GeoPointsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('kind: $kind, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GeoClustersTable extends GeoClusters
    with TableInfo<$GeoClustersTable, GeoCluster> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GeoClustersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userLabelMeta = const VerificationMeta(
    'userLabel',
  );
  @override
  late final GeneratedColumn<String> userLabel = GeneratedColumn<String>(
    'user_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _centroidLatMeta = const VerificationMeta(
    'centroidLat',
  );
  @override
  late final GeneratedColumn<double> centroidLat = GeneratedColumn<double>(
    'centroid_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _centroidLngMeta = const VerificationMeta(
    'centroidLng',
  );
  @override
  late final GeneratedColumn<double> centroidLng = GeneratedColumn<double>(
    'centroid_lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _radiusMMeta = const VerificationMeta(
    'radiusM',
  );
  @override
  late final GeneratedColumn<double> radiusM = GeneratedColumn<double>(
    'radius_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(200.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userLabel,
    centroidLat,
    centroidLng,
    radiusM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'geo_clusters';
  @override
  VerificationContext validateIntegrity(
    Insertable<GeoCluster> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_label')) {
      context.handle(
        _userLabelMeta,
        userLabel.isAcceptableOrUnknown(data['user_label']!, _userLabelMeta),
      );
    }
    if (data.containsKey('centroid_lat')) {
      context.handle(
        _centroidLatMeta,
        centroidLat.isAcceptableOrUnknown(
          data['centroid_lat']!,
          _centroidLatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_centroidLatMeta);
    }
    if (data.containsKey('centroid_lng')) {
      context.handle(
        _centroidLngMeta,
        centroidLng.isAcceptableOrUnknown(
          data['centroid_lng']!,
          _centroidLngMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_centroidLngMeta);
    }
    if (data.containsKey('radius_m')) {
      context.handle(
        _radiusMMeta,
        radiusM.isAcceptableOrUnknown(data['radius_m']!, _radiusMMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GeoCluster map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GeoCluster(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_label'],
      ),
      centroidLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}centroid_lat'],
      )!,
      centroidLng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}centroid_lng'],
      )!,
      radiusM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}radius_m'],
      )!,
    );
  }

  @override
  $GeoClustersTable createAlias(String alias) {
    return $GeoClustersTable(attachedDatabase, alias);
  }
}

class GeoCluster extends DataClass implements Insertable<GeoCluster> {
  final String id;
  final String? userLabel;
  final double centroidLat;
  final double centroidLng;
  final double radiusM;
  const GeoCluster({
    required this.id,
    this.userLabel,
    required this.centroidLat,
    required this.centroidLng,
    required this.radiusM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userLabel != null) {
      map['user_label'] = Variable<String>(userLabel);
    }
    map['centroid_lat'] = Variable<double>(centroidLat);
    map['centroid_lng'] = Variable<double>(centroidLng);
    map['radius_m'] = Variable<double>(radiusM);
    return map;
  }

  GeoClustersCompanion toCompanion(bool nullToAbsent) {
    return GeoClustersCompanion(
      id: Value(id),
      userLabel: userLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(userLabel),
      centroidLat: Value(centroidLat),
      centroidLng: Value(centroidLng),
      radiusM: Value(radiusM),
    );
  }

  factory GeoCluster.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GeoCluster(
      id: serializer.fromJson<String>(json['id']),
      userLabel: serializer.fromJson<String?>(json['userLabel']),
      centroidLat: serializer.fromJson<double>(json['centroidLat']),
      centroidLng: serializer.fromJson<double>(json['centroidLng']),
      radiusM: serializer.fromJson<double>(json['radiusM']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userLabel': serializer.toJson<String?>(userLabel),
      'centroidLat': serializer.toJson<double>(centroidLat),
      'centroidLng': serializer.toJson<double>(centroidLng),
      'radiusM': serializer.toJson<double>(radiusM),
    };
  }

  GeoCluster copyWith({
    String? id,
    Value<String?> userLabel = const Value.absent(),
    double? centroidLat,
    double? centroidLng,
    double? radiusM,
  }) => GeoCluster(
    id: id ?? this.id,
    userLabel: userLabel.present ? userLabel.value : this.userLabel,
    centroidLat: centroidLat ?? this.centroidLat,
    centroidLng: centroidLng ?? this.centroidLng,
    radiusM: radiusM ?? this.radiusM,
  );
  GeoCluster copyWithCompanion(GeoClustersCompanion data) {
    return GeoCluster(
      id: data.id.present ? data.id.value : this.id,
      userLabel: data.userLabel.present ? data.userLabel.value : this.userLabel,
      centroidLat: data.centroidLat.present
          ? data.centroidLat.value
          : this.centroidLat,
      centroidLng: data.centroidLng.present
          ? data.centroidLng.value
          : this.centroidLng,
      radiusM: data.radiusM.present ? data.radiusM.value : this.radiusM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GeoCluster(')
          ..write('id: $id, ')
          ..write('userLabel: $userLabel, ')
          ..write('centroidLat: $centroidLat, ')
          ..write('centroidLng: $centroidLng, ')
          ..write('radiusM: $radiusM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userLabel, centroidLat, centroidLng, radiusM);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GeoCluster &&
          other.id == this.id &&
          other.userLabel == this.userLabel &&
          other.centroidLat == this.centroidLat &&
          other.centroidLng == this.centroidLng &&
          other.radiusM == this.radiusM);
}

class GeoClustersCompanion extends UpdateCompanion<GeoCluster> {
  final Value<String> id;
  final Value<String?> userLabel;
  final Value<double> centroidLat;
  final Value<double> centroidLng;
  final Value<double> radiusM;
  final Value<int> rowid;
  const GeoClustersCompanion({
    this.id = const Value.absent(),
    this.userLabel = const Value.absent(),
    this.centroidLat = const Value.absent(),
    this.centroidLng = const Value.absent(),
    this.radiusM = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GeoClustersCompanion.insert({
    required String id,
    this.userLabel = const Value.absent(),
    required double centroidLat,
    required double centroidLng,
    this.radiusM = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       centroidLat = Value(centroidLat),
       centroidLng = Value(centroidLng);
  static Insertable<GeoCluster> custom({
    Expression<String>? id,
    Expression<String>? userLabel,
    Expression<double>? centroidLat,
    Expression<double>? centroidLng,
    Expression<double>? radiusM,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userLabel != null) 'user_label': userLabel,
      if (centroidLat != null) 'centroid_lat': centroidLat,
      if (centroidLng != null) 'centroid_lng': centroidLng,
      if (radiusM != null) 'radius_m': radiusM,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GeoClustersCompanion copyWith({
    Value<String>? id,
    Value<String?>? userLabel,
    Value<double>? centroidLat,
    Value<double>? centroidLng,
    Value<double>? radiusM,
    Value<int>? rowid,
  }) {
    return GeoClustersCompanion(
      id: id ?? this.id,
      userLabel: userLabel ?? this.userLabel,
      centroidLat: centroidLat ?? this.centroidLat,
      centroidLng: centroidLng ?? this.centroidLng,
      radiusM: radiusM ?? this.radiusM,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userLabel.present) {
      map['user_label'] = Variable<String>(userLabel.value);
    }
    if (centroidLat.present) {
      map['centroid_lat'] = Variable<double>(centroidLat.value);
    }
    if (centroidLng.present) {
      map['centroid_lng'] = Variable<double>(centroidLng.value);
    }
    if (radiusM.present) {
      map['radius_m'] = Variable<double>(radiusM.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GeoClustersCompanion(')
          ..write('id: $id, ')
          ..write('userLabel: $userLabel, ')
          ..write('centroidLat: $centroidLat, ')
          ..write('centroidLng: $centroidLng, ')
          ..write('radiusM: $radiusM, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $SessionTagsTable sessionTags = $SessionTagsTable(this);
  late final $BiometricSnapshotsTable biometricSnapshots =
      $BiometricSnapshotsTable(this);
  late final $BiometricSamplesTable biometricSamples = $BiometricSamplesTable(
    this,
  );
  late final $GeoPointsTable geoPoints = $GeoPointsTable(this);
  late final $GeoClustersTable geoClusters = $GeoClustersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessions,
    tags,
    sessionTags,
    biometricSnapshots,
    biometricSamples,
    geoPoints,
    geoClusters,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('biometric_snapshots', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'biometric_snapshots',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('biometric_samples', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('geo_points', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> plannedDurationMin,
      Value<int?> actualDurationMin,
      Value<String> outcome,
      Value<int> extensionCount,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> plannedDurationMin,
      Value<int?> actualDurationMin,
      Value<String> outcome,
      Value<int> extensionCount,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, Session> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionTagsTable, List<SessionTag>>
  _sessionTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionTags,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.sessionTags.sessionId),
  );

  $$SessionTagsTableProcessedTableManager get sessionTagsRefs {
    final manager = $$SessionTagsTableTableManager(
      $_db,
      $_db.sessionTags,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BiometricSnapshotsTable, List<BiometricSnapshot>>
  _biometricSnapshotsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.biometricSnapshots,
        aliasName: $_aliasNameGenerator(
          db.sessions.id,
          db.biometricSnapshots.sessionId,
        ),
      );

  $$BiometricSnapshotsTableProcessedTableManager get biometricSnapshotsRefs {
    final manager = $$BiometricSnapshotsTableTableManager(
      $_db,
      $_db.biometricSnapshots,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _biometricSnapshotsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GeoPointsTable, List<GeoPoint>>
  _geoPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.geoPoints,
    aliasName: $_aliasNameGenerator(db.sessions.id, db.geoPoints.sessionId),
  );

  $$GeoPointsTableProcessedTableManager get geoPointsRefs {
    final manager = $$GeoPointsTableTableManager(
      $_db,
      $_db.geoPoints,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_geoPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedDurationMin => $composableBuilder(
    column: $table.plannedDurationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualDurationMin => $composableBuilder(
    column: $table.actualDurationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extensionCount => $composableBuilder(
    column: $table.extensionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionTagsRefs(
    Expression<bool> Function($$SessionTagsTableFilterComposer f) f,
  ) {
    final $$SessionTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableFilterComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> biometricSnapshotsRefs(
    Expression<bool> Function($$BiometricSnapshotsTableFilterComposer f) f,
  ) {
    final $$BiometricSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.biometricSnapshots,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiometricSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.biometricSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> geoPointsRefs(
    Expression<bool> Function($$GeoPointsTableFilterComposer f) f,
  ) {
    final $$GeoPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.geoPoints,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeoPointsTableFilterComposer(
            $db: $db,
            $table: $db.geoPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedDurationMin => $composableBuilder(
    column: $table.plannedDurationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualDurationMin => $composableBuilder(
    column: $table.actualDurationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extensionCount => $composableBuilder(
    column: $table.extensionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get plannedDurationMin => $composableBuilder(
    column: $table.plannedDurationMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualDurationMin => $composableBuilder(
    column: $table.actualDurationMin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<int> get extensionCount => $composableBuilder(
    column: $table.extensionCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> sessionTagsRefs<T extends Object>(
    Expression<T> Function($$SessionTagsTableAnnotationComposer a) f,
  ) {
    final $$SessionTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> biometricSnapshotsRefs<T extends Object>(
    Expression<T> Function($$BiometricSnapshotsTableAnnotationComposer a) f,
  ) {
    final $$BiometricSnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.biometricSnapshots,
          getReferencedColumn: (t) => t.sessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BiometricSnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.biometricSnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> geoPointsRefs<T extends Object>(
    Expression<T> Function($$GeoPointsTableAnnotationComposer a) f,
  ) {
    final $$GeoPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.geoPoints,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GeoPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.geoPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          Session,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (Session, $$SessionsTableReferences),
          Session,
          PrefetchHooks Function({
            bool sessionTagsRefs,
            bool biometricSnapshotsRefs,
            bool geoPointsRefs,
          })
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> plannedDurationMin = const Value.absent(),
                Value<int?> actualDurationMin = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<int> extensionCount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedDurationMin: plannedDurationMin,
                actualDurationMin: actualDurationMin,
                outcome: outcome,
                extensionCount: extensionCount,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> plannedDurationMin = const Value.absent(),
                Value<int?> actualDurationMin = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<int> extensionCount = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                plannedDurationMin: plannedDurationMin,
                actualDurationMin: actualDurationMin,
                outcome: outcome,
                extensionCount: extensionCount,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sessionTagsRefs = false,
                biometricSnapshotsRefs = false,
                geoPointsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionTagsRefs) db.sessionTags,
                    if (biometricSnapshotsRefs) db.biometricSnapshots,
                    if (geoPointsRefs) db.geoPoints,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionTagsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          SessionTag
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._sessionTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (biometricSnapshotsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          BiometricSnapshot
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._biometricSnapshotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).biometricSnapshotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (geoPointsRefs)
                        await $_getPrefetchedData<
                          Session,
                          $SessionsTable,
                          GeoPoint
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._geoPointsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).geoPointsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      Session,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (Session, $$SessionsTableReferences),
      Session,
      PrefetchHooks Function({
        bool sessionTagsRefs,
        bool biometricSnapshotsRefs,
        bool geoPointsRefs,
      })
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      required String id,
      required String label,
      Value<String?> category,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      Value<String> label,
      Value<String?> category,
      Value<int> rowid,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SessionTagsTable, List<SessionTag>>
  _sessionTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.sessionTags.tagId),
  );

  $$SessionTagsTableProcessedTableManager get sessionTagsRefs {
    final manager = $$SessionTagsTableTableManager(
      $_db,
      $_db.sessionTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sessionTagsRefs(
    Expression<bool> Function($$SessionTagsTableFilterComposer f) f,
  ) {
    final $$SessionTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableFilterComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  Expression<T> sessionTagsRefs<T extends Object>(
    Expression<T> Function($$SessionTagsTableAnnotationComposer a) f,
  ) {
    final $$SessionTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool sessionTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                label: label,
                category: category,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String label,
                Value<String?> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                label: label,
                category: category,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({sessionTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sessionTagsRefs) db.sessionTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sessionTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, SessionTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences
                          ._sessionTagsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).sessionTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool sessionTagsRefs})
    >;
typedef $$SessionTagsTableCreateCompanionBuilder =
    SessionTagsCompanion Function({
      required String sessionId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$SessionTagsTableUpdateCompanionBuilder =
    SessionTagsCompanion Function({
      Value<String> sessionId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$SessionTagsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionTagsTable, SessionTag> {
  $$SessionTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.sessionTags.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.sessionTags.tagId, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SessionTagsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionTagsTable> {
  $$SessionTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionTagsTable,
          SessionTag,
          $$SessionTagsTableFilterComposer,
          $$SessionTagsTableOrderingComposer,
          $$SessionTagsTableAnnotationComposer,
          $$SessionTagsTableCreateCompanionBuilder,
          $$SessionTagsTableUpdateCompanionBuilder,
          (SessionTag, $$SessionTagsTableReferences),
          SessionTag,
          PrefetchHooks Function({bool sessionId, bool tagId})
        > {
  $$SessionTagsTableTableManager(_$AppDatabase db, $SessionTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionTagsCompanion(
                sessionId: sessionId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => SessionTagsCompanion.insert(
                sessionId: sessionId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$SessionTagsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$SessionTagsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$SessionTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$SessionTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SessionTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionTagsTable,
      SessionTag,
      $$SessionTagsTableFilterComposer,
      $$SessionTagsTableOrderingComposer,
      $$SessionTagsTableAnnotationComposer,
      $$SessionTagsTableCreateCompanionBuilder,
      $$SessionTagsTableUpdateCompanionBuilder,
      (SessionTag, $$SessionTagsTableReferences),
      SessionTag,
      PrefetchHooks Function({bool sessionId, bool tagId})
    >;
typedef $$BiometricSnapshotsTableCreateCompanionBuilder =
    BiometricSnapshotsCompanion Function({
      required String id,
      required String sessionId,
      Value<double?> hrAvgPre,
      Value<double?> hrAvgDuring,
      Value<double?> hrvAvgPre,
      Value<double?> hrvAvgDuring,
      Value<int> rowid,
    });
typedef $$BiometricSnapshotsTableUpdateCompanionBuilder =
    BiometricSnapshotsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<double?> hrAvgPre,
      Value<double?> hrAvgDuring,
      Value<double?> hrvAvgPre,
      Value<double?> hrvAvgDuring,
      Value<int> rowid,
    });

final class $$BiometricSnapshotsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BiometricSnapshotsTable,
          BiometricSnapshot
        > {
  $$BiometricSnapshotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.biometricSnapshots.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BiometricSamplesTable, List<BiometricSample>>
  _biometricSamplesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.biometricSamples,
    aliasName: $_aliasNameGenerator(
      db.biometricSnapshots.id,
      db.biometricSamples.snapshotId,
    ),
  );

  $$BiometricSamplesTableProcessedTableManager get biometricSamplesRefs {
    final manager = $$BiometricSamplesTableTableManager(
      $_db,
      $_db.biometricSamples,
    ).filter((f) => f.snapshotId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _biometricSamplesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BiometricSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $BiometricSnapshotsTable> {
  $$BiometricSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrAvgPre => $composableBuilder(
    column: $table.hrAvgPre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrAvgDuring => $composableBuilder(
    column: $table.hrAvgDuring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrvAvgPre => $composableBuilder(
    column: $table.hrvAvgPre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hrvAvgDuring => $composableBuilder(
    column: $table.hrvAvgDuring,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> biometricSamplesRefs(
    Expression<bool> Function($$BiometricSamplesTableFilterComposer f) f,
  ) {
    final $$BiometricSamplesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.biometricSamples,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiometricSamplesTableFilterComposer(
            $db: $db,
            $table: $db.biometricSamples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BiometricSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $BiometricSnapshotsTable> {
  $$BiometricSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrAvgPre => $composableBuilder(
    column: $table.hrAvgPre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrAvgDuring => $composableBuilder(
    column: $table.hrAvgDuring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrvAvgPre => $composableBuilder(
    column: $table.hrvAvgPre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hrvAvgDuring => $composableBuilder(
    column: $table.hrvAvgDuring,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BiometricSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BiometricSnapshotsTable> {
  $$BiometricSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get hrAvgPre =>
      $composableBuilder(column: $table.hrAvgPre, builder: (column) => column);

  GeneratedColumn<double> get hrAvgDuring => $composableBuilder(
    column: $table.hrAvgDuring,
    builder: (column) => column,
  );

  GeneratedColumn<double> get hrvAvgPre =>
      $composableBuilder(column: $table.hrvAvgPre, builder: (column) => column);

  GeneratedColumn<double> get hrvAvgDuring => $composableBuilder(
    column: $table.hrvAvgDuring,
    builder: (column) => column,
  );

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> biometricSamplesRefs<T extends Object>(
    Expression<T> Function($$BiometricSamplesTableAnnotationComposer a) f,
  ) {
    final $$BiometricSamplesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.biometricSamples,
      getReferencedColumn: (t) => t.snapshotId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiometricSamplesTableAnnotationComposer(
            $db: $db,
            $table: $db.biometricSamples,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BiometricSnapshotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BiometricSnapshotsTable,
          BiometricSnapshot,
          $$BiometricSnapshotsTableFilterComposer,
          $$BiometricSnapshotsTableOrderingComposer,
          $$BiometricSnapshotsTableAnnotationComposer,
          $$BiometricSnapshotsTableCreateCompanionBuilder,
          $$BiometricSnapshotsTableUpdateCompanionBuilder,
          (BiometricSnapshot, $$BiometricSnapshotsTableReferences),
          BiometricSnapshot,
          PrefetchHooks Function({bool sessionId, bool biometricSamplesRefs})
        > {
  $$BiometricSnapshotsTableTableManager(
    _$AppDatabase db,
    $BiometricSnapshotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BiometricSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BiometricSnapshotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BiometricSnapshotsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<double?> hrAvgPre = const Value.absent(),
                Value<double?> hrAvgDuring = const Value.absent(),
                Value<double?> hrvAvgPre = const Value.absent(),
                Value<double?> hrvAvgDuring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiometricSnapshotsCompanion(
                id: id,
                sessionId: sessionId,
                hrAvgPre: hrAvgPre,
                hrAvgDuring: hrAvgDuring,
                hrvAvgPre: hrvAvgPre,
                hrvAvgDuring: hrvAvgDuring,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                Value<double?> hrAvgPre = const Value.absent(),
                Value<double?> hrAvgDuring = const Value.absent(),
                Value<double?> hrvAvgPre = const Value.absent(),
                Value<double?> hrvAvgDuring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiometricSnapshotsCompanion.insert(
                id: id,
                sessionId: sessionId,
                hrAvgPre: hrAvgPre,
                hrAvgDuring: hrAvgDuring,
                hrvAvgPre: hrvAvgPre,
                hrvAvgDuring: hrvAvgDuring,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BiometricSnapshotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sessionId = false, biometricSamplesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (biometricSamplesRefs) db.biometricSamples,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sessionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sessionId,
                                    referencedTable:
                                        $$BiometricSnapshotsTableReferences
                                            ._sessionIdTable(db),
                                    referencedColumn:
                                        $$BiometricSnapshotsTableReferences
                                            ._sessionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (biometricSamplesRefs)
                        await $_getPrefetchedData<
                          BiometricSnapshot,
                          $BiometricSnapshotsTable,
                          BiometricSample
                        >(
                          currentTable: table,
                          referencedTable: $$BiometricSnapshotsTableReferences
                              ._biometricSamplesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BiometricSnapshotsTableReferences(
                                db,
                                table,
                                p0,
                              ).biometricSamplesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.snapshotId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BiometricSnapshotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BiometricSnapshotsTable,
      BiometricSnapshot,
      $$BiometricSnapshotsTableFilterComposer,
      $$BiometricSnapshotsTableOrderingComposer,
      $$BiometricSnapshotsTableAnnotationComposer,
      $$BiometricSnapshotsTableCreateCompanionBuilder,
      $$BiometricSnapshotsTableUpdateCompanionBuilder,
      (BiometricSnapshot, $$BiometricSnapshotsTableReferences),
      BiometricSnapshot,
      PrefetchHooks Function({bool sessionId, bool biometricSamplesRefs})
    >;
typedef $$BiometricSamplesTableCreateCompanionBuilder =
    BiometricSamplesCompanion Function({
      required String id,
      required String snapshotId,
      required DateTime ts,
      required String metric,
      required double value,
      Value<int> rowid,
    });
typedef $$BiometricSamplesTableUpdateCompanionBuilder =
    BiometricSamplesCompanion Function({
      Value<String> id,
      Value<String> snapshotId,
      Value<DateTime> ts,
      Value<String> metric,
      Value<double> value,
      Value<int> rowid,
    });

final class $$BiometricSamplesTableReferences
    extends
        BaseReferences<_$AppDatabase, $BiometricSamplesTable, BiometricSample> {
  $$BiometricSamplesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BiometricSnapshotsTable _snapshotIdTable(_$AppDatabase db) =>
      db.biometricSnapshots.createAlias(
        $_aliasNameGenerator(
          db.biometricSamples.snapshotId,
          db.biometricSnapshots.id,
        ),
      );

  $$BiometricSnapshotsTableProcessedTableManager get snapshotId {
    final $_column = $_itemColumn<String>('snapshot_id')!;

    final manager = $$BiometricSnapshotsTableTableManager(
      $_db,
      $_db.biometricSnapshots,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_snapshotIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BiometricSamplesTableFilterComposer
    extends Composer<_$AppDatabase, $BiometricSamplesTable> {
  $$BiometricSamplesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$BiometricSnapshotsTableFilterComposer get snapshotId {
    final $$BiometricSnapshotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.biometricSnapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiometricSnapshotsTableFilterComposer(
            $db: $db,
            $table: $db.biometricSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BiometricSamplesTableOrderingComposer
    extends Composer<_$AppDatabase, $BiometricSamplesTable> {
  $$BiometricSamplesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$BiometricSnapshotsTableOrderingComposer get snapshotId {
    final $$BiometricSnapshotsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.snapshotId,
      referencedTable: $db.biometricSnapshots,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BiometricSnapshotsTableOrderingComposer(
            $db: $db,
            $table: $db.biometricSnapshots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BiometricSamplesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BiometricSamplesTable> {
  $$BiometricSamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$BiometricSnapshotsTableAnnotationComposer get snapshotId {
    final $$BiometricSnapshotsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.snapshotId,
          referencedTable: $db.biometricSnapshots,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BiometricSnapshotsTableAnnotationComposer(
                $db: $db,
                $table: $db.biometricSnapshots,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BiometricSamplesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BiometricSamplesTable,
          BiometricSample,
          $$BiometricSamplesTableFilterComposer,
          $$BiometricSamplesTableOrderingComposer,
          $$BiometricSamplesTableAnnotationComposer,
          $$BiometricSamplesTableCreateCompanionBuilder,
          $$BiometricSamplesTableUpdateCompanionBuilder,
          (BiometricSample, $$BiometricSamplesTableReferences),
          BiometricSample,
          PrefetchHooks Function({bool snapshotId})
        > {
  $$BiometricSamplesTableTableManager(
    _$AppDatabase db,
    $BiometricSamplesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BiometricSamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BiometricSamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BiometricSamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> snapshotId = const Value.absent(),
                Value<DateTime> ts = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BiometricSamplesCompanion(
                id: id,
                snapshotId: snapshotId,
                ts: ts,
                metric: metric,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String snapshotId,
                required DateTime ts,
                required String metric,
                required double value,
                Value<int> rowid = const Value.absent(),
              }) => BiometricSamplesCompanion.insert(
                id: id,
                snapshotId: snapshotId,
                ts: ts,
                metric: metric,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BiometricSamplesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({snapshotId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (snapshotId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.snapshotId,
                                referencedTable:
                                    $$BiometricSamplesTableReferences
                                        ._snapshotIdTable(db),
                                referencedColumn:
                                    $$BiometricSamplesTableReferences
                                        ._snapshotIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BiometricSamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BiometricSamplesTable,
      BiometricSample,
      $$BiometricSamplesTableFilterComposer,
      $$BiometricSamplesTableOrderingComposer,
      $$BiometricSamplesTableAnnotationComposer,
      $$BiometricSamplesTableCreateCompanionBuilder,
      $$BiometricSamplesTableUpdateCompanionBuilder,
      (BiometricSample, $$BiometricSamplesTableReferences),
      BiometricSample,
      PrefetchHooks Function({bool snapshotId})
    >;
typedef $$GeoPointsTableCreateCompanionBuilder =
    GeoPointsCompanion Function({
      required String id,
      required String sessionId,
      required String kind,
      required double lat,
      required double lng,
      Value<double?> accuracyM,
      Value<int> rowid,
    });
typedef $$GeoPointsTableUpdateCompanionBuilder =
    GeoPointsCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> kind,
      Value<double> lat,
      Value<double> lng,
      Value<double?> accuracyM,
      Value<int> rowid,
    });

final class $$GeoPointsTableReferences
    extends BaseReferences<_$AppDatabase, $GeoPointsTable, GeoPoint> {
  $$GeoPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias(
        $_aliasNameGenerator(db.geoPoints.sessionId, db.sessions.id),
      );

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GeoPointsTableFilterComposer
    extends Composer<_$AppDatabase, $GeoPointsTable> {
  $$GeoPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GeoPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $GeoPointsTable> {
  $$GeoPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GeoPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GeoPointsTable> {
  $$GeoPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GeoPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GeoPointsTable,
          GeoPoint,
          $$GeoPointsTableFilterComposer,
          $$GeoPointsTableOrderingComposer,
          $$GeoPointsTableAnnotationComposer,
          $$GeoPointsTableCreateCompanionBuilder,
          $$GeoPointsTableUpdateCompanionBuilder,
          (GeoPoint, $$GeoPointsTableReferences),
          GeoPoint,
          PrefetchHooks Function({bool sessionId})
        > {
  $$GeoPointsTableTableManager(_$AppDatabase db, $GeoPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GeoPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GeoPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GeoPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GeoPointsCompanion(
                id: id,
                sessionId: sessionId,
                kind: kind,
                lat: lat,
                lng: lng,
                accuracyM: accuracyM,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String kind,
                required double lat,
                required double lng,
                Value<double?> accuracyM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GeoPointsCompanion.insert(
                id: id,
                sessionId: sessionId,
                kind: kind,
                lat: lat,
                lng: lng,
                accuracyM: accuracyM,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GeoPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$GeoPointsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$GeoPointsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GeoPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GeoPointsTable,
      GeoPoint,
      $$GeoPointsTableFilterComposer,
      $$GeoPointsTableOrderingComposer,
      $$GeoPointsTableAnnotationComposer,
      $$GeoPointsTableCreateCompanionBuilder,
      $$GeoPointsTableUpdateCompanionBuilder,
      (GeoPoint, $$GeoPointsTableReferences),
      GeoPoint,
      PrefetchHooks Function({bool sessionId})
    >;
typedef $$GeoClustersTableCreateCompanionBuilder =
    GeoClustersCompanion Function({
      required String id,
      Value<String?> userLabel,
      required double centroidLat,
      required double centroidLng,
      Value<double> radiusM,
      Value<int> rowid,
    });
typedef $$GeoClustersTableUpdateCompanionBuilder =
    GeoClustersCompanion Function({
      Value<String> id,
      Value<String?> userLabel,
      Value<double> centroidLat,
      Value<double> centroidLng,
      Value<double> radiusM,
      Value<int> rowid,
    });

class $$GeoClustersTableFilterComposer
    extends Composer<_$AppDatabase, $GeoClustersTable> {
  $$GeoClustersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userLabel => $composableBuilder(
    column: $table.userLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centroidLat => $composableBuilder(
    column: $table.centroidLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centroidLng => $composableBuilder(
    column: $table.centroidLng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get radiusM => $composableBuilder(
    column: $table.radiusM,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GeoClustersTableOrderingComposer
    extends Composer<_$AppDatabase, $GeoClustersTable> {
  $$GeoClustersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userLabel => $composableBuilder(
    column: $table.userLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centroidLat => $composableBuilder(
    column: $table.centroidLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centroidLng => $composableBuilder(
    column: $table.centroidLng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get radiusM => $composableBuilder(
    column: $table.radiusM,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GeoClustersTableAnnotationComposer
    extends Composer<_$AppDatabase, $GeoClustersTable> {
  $$GeoClustersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userLabel =>
      $composableBuilder(column: $table.userLabel, builder: (column) => column);

  GeneratedColumn<double> get centroidLat => $composableBuilder(
    column: $table.centroidLat,
    builder: (column) => column,
  );

  GeneratedColumn<double> get centroidLng => $composableBuilder(
    column: $table.centroidLng,
    builder: (column) => column,
  );

  GeneratedColumn<double> get radiusM =>
      $composableBuilder(column: $table.radiusM, builder: (column) => column);
}

class $$GeoClustersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GeoClustersTable,
          GeoCluster,
          $$GeoClustersTableFilterComposer,
          $$GeoClustersTableOrderingComposer,
          $$GeoClustersTableAnnotationComposer,
          $$GeoClustersTableCreateCompanionBuilder,
          $$GeoClustersTableUpdateCompanionBuilder,
          (
            GeoCluster,
            BaseReferences<_$AppDatabase, $GeoClustersTable, GeoCluster>,
          ),
          GeoCluster,
          PrefetchHooks Function()
        > {
  $$GeoClustersTableTableManager(_$AppDatabase db, $GeoClustersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GeoClustersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GeoClustersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GeoClustersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> userLabel = const Value.absent(),
                Value<double> centroidLat = const Value.absent(),
                Value<double> centroidLng = const Value.absent(),
                Value<double> radiusM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GeoClustersCompanion(
                id: id,
                userLabel: userLabel,
                centroidLat: centroidLat,
                centroidLng: centroidLng,
                radiusM: radiusM,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> userLabel = const Value.absent(),
                required double centroidLat,
                required double centroidLng,
                Value<double> radiusM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GeoClustersCompanion.insert(
                id: id,
                userLabel: userLabel,
                centroidLat: centroidLat,
                centroidLng: centroidLng,
                radiusM: radiusM,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GeoClustersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GeoClustersTable,
      GeoCluster,
      $$GeoClustersTableFilterComposer,
      $$GeoClustersTableOrderingComposer,
      $$GeoClustersTableAnnotationComposer,
      $$GeoClustersTableCreateCompanionBuilder,
      $$GeoClustersTableUpdateCompanionBuilder,
      (
        GeoCluster,
        BaseReferences<_$AppDatabase, $GeoClustersTable, GeoCluster>,
      ),
      GeoCluster,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$SessionTagsTableTableManager get sessionTags =>
      $$SessionTagsTableTableManager(_db, _db.sessionTags);
  $$BiometricSnapshotsTableTableManager get biometricSnapshots =>
      $$BiometricSnapshotsTableTableManager(_db, _db.biometricSnapshots);
  $$BiometricSamplesTableTableManager get biometricSamples =>
      $$BiometricSamplesTableTableManager(_db, _db.biometricSamples);
  $$GeoPointsTableTableManager get geoPoints =>
      $$GeoPointsTableTableManager(_db, _db.geoPoints);
  $$GeoClustersTableTableManager get geoClusters =>
      $$GeoClustersTableTableManager(_db, _db.geoClusters);
}
