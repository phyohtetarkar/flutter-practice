// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DeveloperEntry extends DataClass implements Insertable<DeveloperEntry> {
  final int id;
  final String name;
  final int age;
  final String heading;
  DeveloperEntry(
      {@required this.id, this.name, @required this.age, this.heading});
  factory DeveloperEntry.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return DeveloperEntry(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      age: intType.mapFromDatabaseResponse(data['${effectivePrefix}age']),
      heading:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}heading']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || heading != null) {
      map['heading'] = Variable<String>(heading);
    }
    return map;
  }

  DevelopersCompanion toCompanion(bool nullToAbsent) {
    return DevelopersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      heading: heading == null && nullToAbsent
          ? const Value.absent()
          : Value(heading),
    );
  }

  factory DeveloperEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DeveloperEntry(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      age: serializer.fromJson<int>(json['age']),
      heading: serializer.fromJson<String>(json['heading']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'age': serializer.toJson<int>(age),
      'heading': serializer.toJson<String>(heading),
    };
  }

  DeveloperEntry copyWith({int id, String name, int age, String heading}) =>
      DeveloperEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        heading: heading ?? this.heading,
      );
  @override
  String toString() {
    return (StringBuffer('DeveloperEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('heading: $heading')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(age.hashCode, heading.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DeveloperEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.age == this.age &&
          other.heading == this.heading);
}

class DevelopersCompanion extends UpdateCompanion<DeveloperEntry> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> age;
  final Value<String> heading;
  const DevelopersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.age = const Value.absent(),
    this.heading = const Value.absent(),
  });
  DevelopersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    @required int age,
    this.heading = const Value.absent(),
  }) : age = Value(age);
  static Insertable<DeveloperEntry> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<int> age,
    Expression<String> heading,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (heading != null) 'heading': heading,
    });
  }

  DevelopersCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<int> age,
      Value<String> heading}) {
    return DevelopersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      heading: heading ?? this.heading,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (heading.present) {
      map['heading'] = Variable<String>(heading.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DevelopersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('age: $age, ')
          ..write('heading: $heading')
          ..write(')'))
        .toString();
  }
}

class $DevelopersTable extends Developers
    with TableInfo<$DevelopersTable, DeveloperEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $DevelopersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ageMeta = const VerificationMeta('age');
  GeneratedIntColumn _age;
  @override
  GeneratedIntColumn get age => _age ??= _constructAge();
  GeneratedIntColumn _constructAge() {
    return GeneratedIntColumn(
      'age',
      $tableName,
      false,
    );
  }

  final VerificationMeta _headingMeta = const VerificationMeta('heading');
  GeneratedTextColumn _heading;
  @override
  GeneratedTextColumn get heading => _heading ??= _constructHeading();
  GeneratedTextColumn _constructHeading() {
    return GeneratedTextColumn(
      'heading',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, age, heading];
  @override
  $DevelopersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'developers';
  @override
  final String actualTableName = 'developers';
  @override
  VerificationContext validateIntegrity(Insertable<DeveloperEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age'], _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('heading')) {
      context.handle(_headingMeta,
          heading.isAcceptableOrUnknown(data['heading'], _headingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeveloperEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DeveloperEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DevelopersTable createAlias(String alias) {
    return $DevelopersTable(_db, alias);
  }
}

abstract class _$DeveloperDatabase extends GeneratedDatabase {
  _$DeveloperDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $DevelopersTable _developers;
  $DevelopersTable get developers => _developers ??= $DevelopersTable(this);
  DeveloperDao _developerDao;
  DeveloperDao get developerDao =>
      _developerDao ??= DeveloperDao(this as DeveloperDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [developers];
}
