import 'package:sqflite_flutter/model/developer.dart';

abstract class DeveloperRepo {

  Future<Developer> insert(Developer dev);

  Future<void> update(Developer dev);

  Future<Developer> findById(int id);

  Future<void> delete(int id);

  Future<List<Developer>> findAll({String name, String heading});

}



