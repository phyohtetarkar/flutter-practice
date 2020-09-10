import 'package:model_package/src/developer_database.dart';
import 'package:model_package/src/entity/developer.dart';
import 'package:moor/moor.dart';

part 'developer_dao.g.dart';

@UseDao(tables: [Developers])
class DeveloperDao extends DatabaseAccessor<DeveloperDatabase> with _$DeveloperDaoMixin {

  DeveloperDao(DeveloperDatabase db) : super(db);

  Future<int> insert(DeveloperEntry entry) {
    return into(developers).insert(entry);
  }

  Future updateDeveloper(DeveloperEntry entry) {
    return update(developers).replace(entry);
  }

  Future deleteDeveloper(DeveloperEntry entry) {
    return delete(developers).delete(entry);
  }

  Future<DeveloperEntry> findById(int id) {
    return (select(developers)..where((tb) => tb.id.equals(id))).getSingle();
  }

  Future<List<DeveloperEntry>> findAll({String name, String heading}) {
    final query = select(developers);

    if (name != null && name.isNotEmpty) {
      query.where((tb) => tb.name.like("$name%"));
    }

    if (heading != null && heading.isNotEmpty) {
      query.where((tb) => tb.heading.equals(heading));
    }

    return query.get();
  }

}