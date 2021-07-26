// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoHiveModelAdapter extends TypeAdapter<TodoHiveModel> {
  @override
  final int typeId = 0;

  @override
  TodoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoHiveModel(
      name: fields[0] as String,
    )..task = (fields[1] as HiveList?)?.castHiveList();
  }

  @override
  void write(BinaryWriter writer, TodoHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.task);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
