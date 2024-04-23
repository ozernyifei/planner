import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart';
import 'package:planner/screens/edit_task.dart';
import 'package:sqflite/sqflite.dart';








class TaskScreen extends StatefulWidget {

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final DbHelper dbHelper = DbHelper();

  Future<List<Task>> _loadTasks() async {
  
  final database = await dbHelper.database;
  final tasksData = await database.query('tasks'); // Замените 'tasks' на имя вашей таблицы задач
  final tasks = <Task>[];
  for (final row in tasksData) {
    tasks.add(Task.fromMap(row)); // Предполагая, что у вас есть метод fromMap в классе Task
  }
  return tasks;
}

  @override
  Future<void> initState() async {
    super.initState();
    await dbHelper.initDatabase(); // Инициализация базы данных
    await _loadTasks().then((loadedTasks) {
      setState(() {
        final tasks = loadedTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar ...
      body: const SingleChildScrollView(
        // ... ваш список задач ...
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Нажмите на FAB, чтобы перейти к edit_task.dart
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
