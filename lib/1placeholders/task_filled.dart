import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/screens/edit_task_dialog.dart';

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task details with border
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row( // Row for task name and edit button
                              children: [
                                Expanded( // Expand task name
                                  child: Text(
                                    task.name,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 16), // Spacing between name and button
                                IconButton(
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
                            
                          },
                        ),
                        ListTile(
                          title: const Text('Завершить'),
                          onTap: () {
                            
                          },
                        ),
                        ListTile(
                          title: const Text('Удалить'),
                          onTap: () {
                           
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
                                  icon: const Icon(Icons.more_vert), // 3-dot icon
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              task.description,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                             const SizedBox(height: 16),

                            // Time and tags on separate lines
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align vertically
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded),
                                    const SizedBox(width: 8),
                                    Text(DateFormat('d MMM yyyy HH:mm').format(task.endTime)),
                                  ],
                                ),
                                const SizedBox(width: 16), // Add spacing between time and tags
                                if (task.tags?.isNotEmpty ?? false) 
                                Wrap(
                                  spacing: 5,
                                  children: task.tags!.map((tag) => Chip(
                                    avatar: const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.yellow, // Get color based on tag name
                                      child: Text(''), // Empty text
                                    ),
                                    label: Text(tag, style: const TextStyle(fontSize: 12)), // Smaller font size
                                  )).toList(),
                                ) else const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24), // Add spacing between tasks
                  ],
                ),
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
