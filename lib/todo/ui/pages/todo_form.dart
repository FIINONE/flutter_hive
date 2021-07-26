import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/model/todo_form_model.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatelessWidget {
  static const String routeName = '/main/form';

  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TodoFormModel>(
        create: (BuildContext context) => TodoFormModel(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Добавить форму'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _FormNameField(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.read<TodoFormModel>().saveTodo(context),
              child: const Icon(Icons.add_task),
            ),
          );
        });
  }
}

class _FormNameField extends StatelessWidget {
  const _FormNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Имя группы',
        ),
        onChanged: (String text) =>
            context.read<TodoFormModel>().todoName = text,
        onEditingComplete: () =>
            context.read<TodoFormModel>().saveTodo(context),
      ),
    );
  }
}
