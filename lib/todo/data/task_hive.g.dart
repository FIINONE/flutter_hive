// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskHiveAdapter extends TypeAdapter<TaskHive> {
  @override
  final int typeId = 1;

  @override
  TaskHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskHive(
      text: fields[0] as String,
      isDone: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
