import 'package:model_package/developer_model.dart';

class Developer {
  final int id;
  final String name;
  final int age;
  final String heading;

  Developer({this.id, this.name, this.age, this.heading});

  Developer.entry({DeveloperEntry entry})
      : this(
          id: entry.id,
          name: entry.name,
          age: entry.age,
          heading: entry.heading,
        );

  Map<String, dynamic> toMap() {
    return {"name": name, "age": age, "heading": heading};
  }
}
