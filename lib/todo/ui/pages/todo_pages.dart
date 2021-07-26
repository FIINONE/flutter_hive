import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/data/todo_hive_model.dart';
import 'package:flutter_lesson_1/todo/model/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  static const String routeName = '/main';

  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoModel _model = TodoModel();

  // @override
  // void initState() {
  //   super.initState();

  //   _model = TodoModel();
  // }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoModel>.value(
      value: _model,
      builder: (BuildContext context, Widget? widget) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Группы'),
          ),
          body: const SafeArea(child: _TodoList()),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 1,
                child: const Icon(Icons.add),
                onPressed: () => context.read<TodoModel>().showForm(context),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                heroTag: 2,
                child: const Icon(Icons.delete),
                onPressed: () => context.read<TodoModel>().clearBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int todoCounter = context.watch<TodoModel>().groups.length;
    return ListView.separated(
      itemCount: todoCounter,
      itemBuilder: (BuildContext context, int index) {
        return _TodoListItem(index: index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 5);
      },
    );
  }
}

class _TodoListItem extends StatelessWidget {
  final int index;
  const _TodoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoHiveModel todo = context.read<TodoModel>().groups[index];
    return Slidable(
      actionPane: const SlidableBehindActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: const Color(0xFF616161),
          onTap: () => context.read<TodoModel>().deleteTodo(index),
        ),
      ],
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          leading: Text(todo.name),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.read<TodoModel>().showTask(context, index),
        ),
      ),
    );
  }
}
