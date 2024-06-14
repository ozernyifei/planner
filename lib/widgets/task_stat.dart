import 'package:flutter/material.dart';

class TaskStat extends StatefulWidget { // Number of tasks to display

  const TaskStat({super.key, required this.taskCount});
  final int taskCount;

  @override
  _TaskStatState createState() => _TaskStatState();
}

class _TaskStatState extends State<TaskStat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          if (widget.taskCount > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'There are ${widget.taskCount} tasks for you today.',
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to task list screen
                    await Navigator.pushNamed(context, '/tasks'); // Replace '/tasks' with your actual route name
                  },
                  child: const Text('View Tasks'),
                ),
              ],
            ),
          if (widget.taskCount == 0)
            Column(
              children: [
                const Text(
                  'Add a task to plan your day.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    // Navigate to task creation screen
                    await Navigator.pushNamed(context, '/create-task'); // Replace '/create-task' with your actual route name
                  },
                  child: const Text('Create Task'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
