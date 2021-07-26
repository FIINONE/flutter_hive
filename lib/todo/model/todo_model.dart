import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/data/todo_hive_model.dart';
import 'package:flutter_lesson_1/todo/model/helper/box_manager.dart';
import 'package:flutter_lesson_1/todo/ui/navigation/main_navigation.dart';
import 'package:flutter_lesson_1/todo/ui/pages/task_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoModel extends ChangeNotifier {
  late final Future<Box<TodoHiveModel>> _box;
  ValueListenable<Object>? _listenable;

  var _groups = <TodoHiveModel>[];

  List<TodoHiveModel> get groups => _groups.toList();


  TodoModel() {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.pushNamed(context, MainNavigationRouteNames.todoForm);
  }

  Future<void> showTask(BuildContext context, int index) async {
    final TodoHiveModel? todo = (await _box).getAt(index);

    if (todo != null) {
      final TaskPageConfig config =
          TaskPageConfig(todoIndex: todo.key as int, title: todo.name);
      Navigator.pushNamed(context, MainNavigationRouteNames.task,
          arguments: config);
    }
  }

  Future<void> _readTodoFromHive() async {
    _groups = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTodoBox();
    await _readTodoFromHive();
    _listenable = (await _box).listenable();
    _listenable?.addListener(_readTodoFromHive);
  }

  Future<void> deleteTodo(int index) async {
    final boxTodo = await _box;
    final int taskKey = (await _box).keyAt(index) as int;
    final String taskBoxName = BoxManager.instance.createTaskBoxName(taskKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    await boxTodo.deleteAt(index);
  }

  Future<void> clearBox() async {
    final boxTask = await BoxManager.instance.openTodoBox();
    boxTask.clear();
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    _listenable?.removeListener(_readTodoFromHive);
    BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
