import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:flutter_lesson_1/todo/model/task_model.dart';

class TaskPageConfig {
  final int todoIndex;
  final String title;

  TaskPageConfig({
    required this.todoIndex,
    required this.title,
  });
}

class TaskPage extends StatefulWidget {
  final TaskPageConfig config;

  const TaskPage({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TaskModel _taskModel;

  @override
  void initState() {
    super.initState();

    _taskModel = TaskModel(config: widget.config);
  }

  @override
  void dispose() {
    _taskModel.dispose().whenComplete(() => print('object destroid'));
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (_taskModel == null) {
  //     final int taskIndex = ModalRoute.of(context)?.settings.arguments as int;
  //     _taskModel = TaskModel(taskIndex: taskIndex);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return TaskModelProvider(
      model: _taskModel,
      child: const _TaskPageBody(),
    );
    // return ChangeNotifierProvider<TaskModel>.value(
    // value: _taskModel,
    // child: const _TaskPageBody(),

    // );
  }
}

class _TaskPageBody extends StatelessWidget {
  const _TaskPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final model =
    // final String title = context.watch<TaskModel>().config.title; //?? 'Задачи';
    final String title =
        TaskModelProvider.watch(context)!.model.config.title; //?? 'Задачи';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const _TaskList(),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => context.read<TaskModel>().showForm(context),
        onPressed: () =>
            TaskModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TaskList extends StatelessWidget {
  const _TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final taskCounter = context.watch<TaskModel>().tasks.length;
    final taskCounter = TaskModelProvider.watch(context)!.model.tasks.length;
    return ListView.separated(
      itemCount: taskCounter,
      itemBuilder: (BuildContext context, int index) {
        return _TaskListItem(index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 5);
      },
    );
  }
}

class _TaskListItem extends StatelessWidget {
  final int index;
  const _TaskListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskModelProvider.read(context)!.model;
    // final task = context.read<TaskModel>().tasks[index];
    final task = model.tasks[index];

    // final icon = context.read<TaskModel>().tasks[index].isDone
    final icon = model.tasks[index].isDone
        ? Icons.check_box
        : Icons.check_box_outline_blank;

    final textstyle = model.tasks[index].isDone
        ? TextDecoration.lineThrough
        : TextDecoration.none;
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: const Color(0xFF616161),
          onTap: () => model.deleteTask(index),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          leading: Text(
            task.text,
            style: TextStyle(decoration: textstyle),
          ),
          trailing: Icon(icon),
          onTap: () => model.doneTask(index),
        ),
      ),
    );
  }
}
