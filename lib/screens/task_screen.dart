import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart';
import 'package:planner/screens/edit_task.dart';


class TaskScreen extends StatefulWidget {

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final DbHelper dbHelper = DbHelper();

  List<Task> tasks = [];
  Future<List<Task>> _loadTasks() async {
  
  final database = await dbHelper.database;
  final tasksData = await database.query('task'); 
  final tasks = <Task>[];
  for (final row in tasksData) {
    tasks.add(Task.fromMap(row)); 
  }
  return tasks;
}
  Future<void> _deleteTask(int taskId) async {
  final dbHelper = DbHelper();
  final database = await dbHelper.database;
  await dbHelper.deleteTask(database, taskId);

  // Update the tasks list and rebuild the widget
  setState(() {
    tasks.removeWhere((task) => task.id == taskId);
  });
}

  @override
  void initState()  {
    super.initState();
     unawaited(dbHelper.initDatabase()); 
     unawaited(_loadTasks().then((loadedTasks) {
      setState(() {
        tasks = loadedTasks;
      });
    }));
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
                            //editTask(task.id);
                            Navigator.pop(context);
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
