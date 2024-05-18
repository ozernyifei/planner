// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/classes/user_service.dart';
import 'package:planner/models/task.dart';
import 'package:planner/screens/edit_task_dialog.dart';
//import 'package:planner/widgets/task_box.dart';


class TaskScreen extends StatefulWidget {

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DbHelper dbHelper = DbHelper();
  int? _userId;

  List<Task> tasks = [];

  Future<void> _fetchTasks() async {
    _userId = await UserService.fetchUserId();
    if (_userId != null) {
      final loadedTasks = await UserService.getTasksForUser(_userId!);
      setState(() {
        tasks = loadedTasks;
      });
    } else {
      // Handle the case where user ID is not found (optional)
      print('User ID not found in SharedPreferences');
    }
  }


  Future<void> _deleteTask(int taskId) async {
  final dbHelper = DbHelper();
  final database = await dbHelper.database;
  await dbHelper.deleteTask(database, taskId);

  setState(() {
    tasks.removeWhere((task) => task.id == taskId);
  });
}

  @override
  void initState()  {
    super.initState();
     unawaited(dbHelper.initDatabase()); 
     unawaited(_fetchTasks()); {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description!),
            trailing: IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Настройки задачи'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('Редактировать'),
                          onTap: () {
                            _editTask(context, task);
                          },
                        ),
                        ListTile(
                          title: const Text('Удалить'),
                          onTap: () {
                            _deleteTask(task.id!);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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

// TODO(lebowskd): create edit task

Future<void> _editTask(BuildContext context, Task task) async { 
  await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(task: task)
              ),
          );
}
