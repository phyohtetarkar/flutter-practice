import 'dart:io';

import 'package:model_package/src/dao/developer_dao.dart';
import 'package:model_package/src/entity/developer.dart';
import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'developer_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dev_database.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Developers], daos: [DeveloperDao])
class DeveloperDatabase extends _$DeveloperDatabase {

  DeveloperDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}