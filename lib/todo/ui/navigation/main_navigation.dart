import 'package:flutter/material.dart';
import 'package:flutter_lesson_1/todo/ui/pages/task_form.dart';
import 'package:flutter_lesson_1/todo/ui/pages/task_pages.dart';
import 'package:flutter_lesson_1/todo/ui/pages/todo_form.dart';
import 'package:flutter_lesson_1/todo/ui/pages/todo_pages.dart';

abstract class MainNavigationRouteNames {
  // static const String todo = 'todo';
  // static const String todoForm = 'todo/form';
  // static const String task = 'todo/task';
  // static const String taskForm = 'todo/task/form';

  static const String todo = '/';
  static const String todoForm = '/todoForm';
  static const String task = '/task';
  static const String taskForm = '/task/form';
}

class MainNavigation {
  final String initialRoute = MainNavigationRouteNames.todo;

  final Map<String, Widget Function(BuildContext context)> routes =
      <String, Widget Function(BuildContext context)>{
    MainNavigationRouteNames.todo: (BuildContext context) => const TodoPage(),
    MainNavigationRouteNames.todoForm: (BuildContext context) =>
        const TodoForm(),
    // MainNavigationRouteNames.task: (BuildContext context) => const TaskPage(),
    // MainNavigationRouteNames.taskForm: (BuildContext context) =>
    //     const TaskForm(),
  };

  Route<Object> onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.task:
        final TaskPageConfig config = settings.arguments as TaskPageConfig;
        return MaterialPageRoute<Object>(
          builder: (BuildContext context) => TaskPage(config: config),
        );
      case MainNavigationRouteNames.taskForm:
        final int taskIndex = settings.arguments as int;
        return MaterialPageRoute<Object>(
          builder: (BuildContext context) => TaskForm(taskIndex: taskIndex),
        );
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Не существующая страница',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                          context, MainNavigationRouteNames.todo),
                      child: const Text('Вернуться на главный экран'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    }
  }
}
