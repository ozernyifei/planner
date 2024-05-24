import 'package:flutter/material.dart';
import 'package:planner/models/task.dart';

class TaskOptionsMenu extends StatelessWidget {

  const TaskOptionsMenu({
    super.key,
    required this.task,
    required this.onSelected,
  });
  final Task task;
  final Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'edit',
            child: Text('Изменить задачу'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Удалить задачу'),
          ),
          const PopupMenuItem<String>(
            value: 'mark_as_done',
            child: Text('Завершить задачу'),
          ),
        ];
      },
    );
  }
}