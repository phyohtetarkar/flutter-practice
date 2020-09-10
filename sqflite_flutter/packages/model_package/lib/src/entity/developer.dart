import 'package:moor/moor.dart';

@DataClassName("DeveloperEntry")
class Developers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get age => integer()();
  TextColumn get heading => text().nullable()();
}