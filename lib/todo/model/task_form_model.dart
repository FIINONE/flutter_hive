import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/model/helper/box_manager.dart';
import 'package:hive/hive.dart';

import 'package:flutter_lesson_1/todo/data/task_hive.dart';

class TaskFormModel {
  String taskName = '';
  int todoIndex;

  TaskFormModel({
    required this.todoIndex,
  });

  Future<void> saveTask(BuildContext context) async {
    if (taskName.isEmpty) {
      return;
    }

    final TaskHive task = TaskHive(text: taskName, isDone: false);
    final Box<TaskHive> box = await BoxManager.instance.openTaskBox(todoIndex);
    box.add(task);
    await BoxManager.instance.closeBox(box);
    Navigator.pop(context);
  }
}
