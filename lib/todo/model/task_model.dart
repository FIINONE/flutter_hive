import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/data/task_hive.dart';
import 'package:flutter_lesson_1/todo/model/helper/box_manager.dart';
import 'package:flutter_lesson_1/todo/ui/navigation/main_navigation.dart';
import 'package:flutter_lesson_1/todo/ui/pages/task_pages.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskModel extends ChangeNotifier {
  final TaskPageConfig config;
  late final Future<Box<TaskHive>> _box;
  var _tasks = <TaskHive>[];
  ValueListenable<Object>? _listenable;

  List<TaskHive> get tasks => _tasks.toList();

  TaskModel({
    required this.config,
  }) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.pushNamed(context, MainNavigationRouteNames.taskForm,
        arguments: config.todoIndex);
  }

  Future<void> _readTaskFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(config.todoIndex);
    await _readTaskFromHive();
    _listenable = (await _box).listenable();
    _listenable?.addListener(_readTaskFromHive);
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> doneTask(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    task?.save();
  }

  @override
  Future<void> dispose() async {
    _listenable?.removeListener(_readTaskFromHive);
    BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}

class TaskModelProvider extends InheritedNotifier<TaskModel> {
  final TaskModel model;

  const TaskModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static TaskModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskModelProvider>();
  }

  static TaskModelProvider? read(BuildContext context) {
    final InheritedWidget? _widget = context
        .getElementForInheritedWidgetOfExactType<TaskModelProvider>()
        ?.widget;
    return _widget is TaskModelProvider ? _widget : null;
  }

  @override
  bool updateShouldNotify(TaskModelProvider oldWidget) {
    return true;
  }
}


// class TaskModel extends ChangeNotifier {
//   final TaskPageConfig config;
//   late final Future<Box<TaskHive>> _box;
//   var _tasks = <TaskHive>[];
//   ValueListenable<Object>? _listenable;

//   List<TaskHive> get tasks => _tasks.toList();

//   TaskModel({
//     required this.config,
//   }) {
//     _setup();
//   }

//   void showForm(BuildContext context) {
//     Navigator.pushNamed(context, MainNavigationRouteNames.taskForm,
//         arguments: config.todoIndex);
//   }

//   Future<void> _readTaskFromHive() async {
//     _tasks = (await _box).values.toList();
//     notifyListeners();
//   }

//   Future<void> _setup() async {
//     _box = BoxManager.instance.openTaskBox(config.todoIndex);
//     await _readTaskFromHive();
//     _listenable = (await _box).listenable();
//     _listenable?.addListener(_readTaskFromHive);
//   }

//   Future<void> deleteTask(int taskIndex) async {
//     await (await _box).deleteAt(taskIndex);
//   }

//   Future<void> doneTask(int taskIndex) async {
//     final task = (await _box).getAt(taskIndex);
//     task?.isDone = !task.isDone;
//     task?.save();
//   }

//   @override
//   Future<void> dispose() async {
//     _listenable?.removeListener(_readTaskFromHive);
//     BoxManager.instance.closeBox(await _box);
//     super.dispose();
//   }
// }