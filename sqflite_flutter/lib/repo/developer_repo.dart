import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_flutter/model/developer.dart';

class DeveloperRepo {

  Future<Database> _database() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), "dev_database.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE developer(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, heading TEXT)");
      },
      version: 1,
    );
    return database;
  }

  Future<Developer> insert(Developer dev) async {
    final Database db = await _database();
    final id = await db.insert(
      "developer",
      dev.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return findById(id);
  }

  Future<Developer> findById(int id) async {
    final Database db = await _database();
    final maps = await db.query(
      "developer",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    final map = maps.first;

    if (map != null) {
      return Developer(
        id: map['id'],
        name: map['name'],
        heading: map['heading'],
        age: map['age'],
      );
    }

    return null;
  }

  Future<void> delete(int id) async {
    final Database db = await _database();
    await db.delete(
      "developer",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<Developer>> findAll() async {
    final Database db = await _database();
    final maps = await db.query("developer");

    return List.generate(maps.length, (index) {
      return Developer(
        id: maps[index]['id'],
        name: maps[index]['name'],
        age: maps[index]['age'],
        heading: maps[index]['heading'],
      );
    });
  }

}
