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

  @override
  void initState()  {
    super.initState();
     dbHelper.initDatabase(); 
     _loadTasks().then((loadedTasks) {
      setState(() {
        tasks = loadedTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar ...
       body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task.title),
            // ... другие элементы ListTile ...
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
