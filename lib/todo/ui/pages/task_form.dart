import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_lesson_1/todo/model/task_form_model.dart';

class TaskForm extends StatefulWidget {
  static const String routeName = '/main/task/form';
  final int taskIndex;

  const TaskForm({
    Key? key,
    required this.taskIndex,
  }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late final TaskFormModel _taskModel;

  @override
  void initState() {
    super.initState();

    _taskModel = TaskFormModel(todoIndex: widget.taskIndex);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_taskModel == null) {
  //     final int taskIndex = ModalRoute.of(context)?.settings.arguments as int;
  //     _taskModel = TaskFormModel(todoIndex: taskIndex);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<TaskFormModel>.value(
        value: _taskModel,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Добавить задачу'),
            ),
            body: const Center(
              child: _TaskFormNameField(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<TaskFormModel>().saveTask(context),
              child: const Icon(Icons.add_task),
            ),
          );
        });
  }
}

class _TaskFormNameField extends StatelessWidget {
  const _TaskFormNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        autofocus: true,
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Добавьте задачу',
        ),
        onChanged: (String text) =>
            context.read<TaskFormModel>().taskName = text,
        onEditingComplete: () =>
            context.read<TaskFormModel>().saveTask(context),
      ),
    );
  }
}
