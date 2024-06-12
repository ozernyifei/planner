import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/screens/edit_task_dialog.dart';
import 'package:planner/widgets/task_box.dart';

class Task {

  const Task({
    required this.name,
    required this.description,
    required this.endTime,
    this.tags,
  });
  final String name;
  final String description;
  final DateTime endTime;
  final List<String>? tags;
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key,});

  @override
  // ignore: library_private_types_in_public_api
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // ... Your task list and build method remain the same
  final List<Task> tasks = [
    Task(
      name: 'Сдача диплома',
      description: 'Закончить диплом до его срока сдачи',
      endTime: DateTime(2024, 05, 19, 12), // Example end time
    ),

  ];
  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши задачи'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final task in tasks)
                TaskBox(task: task),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () async{
         await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      )
  );
  }
}
