import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// part 'todo_hive_model.g.dart';

// @HiveType(typeId: 0)
class TodoHiveModel extends HiveObject {
  // @HiveField(0)
  String name;

  // @HiveField(1)

  TodoHiveModel({
    required this.name,
  });
}

class TodoHiveModelAdapter extends TypeAdapter<TodoHiveModel> {
  @override
  int get typeId => 0;

  @override
  TodoHiveModel read(BinaryReader reader) {
    return TodoHiveModel(name: reader.readString());
  }

  @override
  void write(BinaryWriter writer, TodoHiveModel obj) {
    writer.writeString(obj.name);
  }
}
