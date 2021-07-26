import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// part 'task_hive.g.dart';

// @HiveType(typeId: 1)
class TaskHive extends HiveObject {
  // @HiveField(0)
  String text;
  
  // @HiveField(1)
  bool isDone;

  TaskHive({
    required this.text,
    required this.isDone,
  });

  @override
  String toString() => 'TaskHive(text: $text, isDone: $isDone)';
}

class TaskHiveAdapter extends TypeAdapter<TaskHive> {
  @override
  int get typeId => 1;

  @override
  TaskHive read(BinaryReader reader) {
    return TaskHive(
      text: reader.readString(),
      isDone: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskHive obj) {
    writer.writeString(obj.text);
    writer.writeBool(obj.isDone);
  }
}
