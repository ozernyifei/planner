import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner/models/task.dart';
//import 'package:planner/1placeholders/task_filled.dart';

class TaskBox extends StatelessWidget {
  const TaskBox({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        task.title,
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
                    if (task.description != null)
                      Text(
                        task.description!,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    const SizedBox(height: 16),
    
                    // Time and tags on separate lines
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align vertically
                  children: [
                    if (task.dueDate != null)
                      Row(
                        children: [
                          const Icon(Icons.access_time_rounded),
                          const SizedBox(width: 8),
                          Text(DateFormat('d MMM yyyy HH:mm').format(task.dueDate!)),
                        ],
                      ),
                    const SizedBox(width: 16), // Add spacing between time and tags
                    if (task.tags?.isNotEmpty ?? false) 
                    Wrap(
                      spacing: 5,
                      children: task.tags!.map((tag) => Chip(
                        avatar: CircleAvatar(
                          radius: 5,
                          backgroundColor: Color(tag.color), // Get color based on tag name
                          child: const Text(''), // Empty text
                        ),
                        label: Text(tag.title, style: const TextStyle(fontSize: 12)), // Smaller font size
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
    );
  }
}
