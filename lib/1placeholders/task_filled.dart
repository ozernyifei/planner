import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {

  const Task({
    required this.name,
    required this.description,
    required this.endTime,
    required this.tags,
  });
  final String name;
  final String description;
  final DateTime endTime;
  final List<String> tags;
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
      name: 'Implement Task Data Persistence',
      description: 'Choose a suitable storage solution (local storage, database) to persist task data.',
      endTime: DateTime(2024, 05, 23, 15), // Example end time
      tags: ['Development', 'Data Storage'],
    ),
    Task(
      name: 'Complete UI Design for Task Screen',
      description: 'Finalize the design for the task management screen, including task list, details, and editing.',
      endTime: DateTime(2024, 05, 21, 10), // Example end time
      tags: ['UI Design', 'Task Management'],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
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
                                  onPressed: () {
                                    // Handle edit action for the task
                                    print('Edit task: ${task.name}');
                                  },
                                  icon: const Icon(Icons.more_vert), // 3-dot icon
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              task.description,
                              style: const TextStyle(fontSize: 16),
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
                                Wrap(spacing: 5,
                                  children: task.tags.map((tag) => Chip(
                                    avatar: const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.yellow, // Get color based on tag name
                                      child: Text(''), // Empty text
                                    ),
                                    label: Text(tag, style: const TextStyle(fontSize: 12)), // Smaller font size
                                  )).toList(),
                                ),
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
    );
  }
}
