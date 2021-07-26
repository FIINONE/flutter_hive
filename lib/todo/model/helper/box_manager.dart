import 'package:flutter_lesson_1/todo/data/task_hive.dart';
import 'package:flutter_lesson_1/todo/data/todo_hive_model.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};

  BoxManager._();

  Future<Box<TodoHiveModel>> openTodoBox() {
    return _openBox('todo_box', 0, TodoHiveModelAdapter());
  }

  Future<Box<TaskHive>> openTaskBox(int taskKey) {
    return _openBox(createTaskBoxName(taskKey), 1, TaskHiveAdapter());
  }

  String createTaskBoxName(int taskKey) => 'task_box_$taskKey';

  Future<Box<T>> _openBox<T>(
      String boxName, int typeId, TypeAdapter<T> adapter) async {
    if (Hive.isBoxOpen(boxName)) {
      final int counter = _boxCounter[boxName] ?? 1;
      _boxCounter[boxName] = counter + 1;
      return Hive.box(boxName);
    }
    _boxCounter[boxName] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(boxName);
  }

  Future<void> closeBox<B>(Box<B> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    int counter = _boxCounter[box.name] ?? 1;
    counter -= 1;
    _boxCounter[box.name] = counter;
    if (counter > 0) {
      return;
    }

    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }
}
