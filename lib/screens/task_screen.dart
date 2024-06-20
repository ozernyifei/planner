// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/classes/user_service.dart';
import 'package:planner/models/task.dart';
import 'package:planner/screens/edit_task_dialog.dart';
import 'package:planner/widgets/task_box.dart';


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
          return TaskBox(
            task: task,
            onDelete: _handleDeleteTask,
            onEdit: _handleEditTask
            ,);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditTaskScreen()),
          );

          if (result != null) {
            setState(() {
              tasks.add(result);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Future<void> _handleDeleteTask(Task task) async {
    final dbHelper = DbHelper();
    final database = await dbHelper.database;
    await dbHelper.deleteTask(database, task.id!);

    setState(() {
      tasks.remove(task);
    });
    
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _handleEditTask(Task task) async {
    final editedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: task),
      ),
    );
    if (editedTask != null) {
      // Update the task in the state list
      setState(() {
        final index = tasks.indexOf(task);
        if (index != -1) {
          tasks[index] = editedTask;
        }
      });
    }
  }
}

// TODO(lebowskd): create edit task


