import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/data/todo_hive_model.dart';
import 'package:flutter_lesson_1/todo/model/helper/box_manager.dart';
import 'package:hive/hive.dart';

class TodoFormModel {
  String todoName = '';

  Future<void> saveTodo(BuildContext context) async {
    if (todoName.isEmpty) {
      return;
    }

    final Box<TodoHiveModel> box = await BoxManager.instance.openTodoBox();
    final TodoHiveModel name = TodoHiveModel(name: todoName);
    await box.add(name);

    await BoxManager.instance.closeBox(box);
    Navigator.pop(context);
  }
}
