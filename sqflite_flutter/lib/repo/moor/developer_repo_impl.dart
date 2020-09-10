import 'package:model_package/developer_model.dart';
import 'package:sqflite_flutter/model/developer.dart';
import 'package:sqflite_flutter/repo/developer_repo.dart';

class DeveloperRepoImpl extends DeveloperRepo {
  final DeveloperDao dao;

  DeveloperRepoImpl(this.dao);

  @override
  Future<Developer> findById(int id) {
    return dao.findById(id).then((e) => Developer.entry(entry: e));
  }

  @override
  Future<Developer> insert(Developer dev) {
    final entry = DeveloperEntry(
      id: dev.id,
      name: dev.name,
      age: dev.age,
      heading: dev.heading,
    );
    return dao.insert(entry).then((value) => findById(value));
  }

  @override
  Future<void> update(Developer dev) {
    final entry = DeveloperEntry(
      id: dev.id,
      name: dev.name,
      age: dev.age,
      heading: dev.heading,
    );
    return dao.updateDeveloper(entry);
  }

  @override
  Future<void> delete(int id) {
    return dao.findById(id).then((value) => dao.deleteDeveloper(value));
  }

  @override
  Future<List<Developer>> findAll({String name, String heading}) {
    return dao.findAll(name: name, heading: heading).then((list) {
      return list.map((e) => Developer.entry(entry: e)).toList();
    });
  }
}
