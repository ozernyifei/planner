import 'package:flutter/material.dart';

class TaskStat extends StatelessWidget {

  const TaskStat({super.key, required this.taskCount});
  final int taskCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1/3, // Take 1/3 of screen height
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: Colors.black26,
          width: 1.5
        )
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Сегодняшнее количество задач:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            taskCount.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: taskCount == 0 ? Colors.green : Colors.blue,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            taskCount == 0 ? 'Можно отдохнуть' : 'Есть над чем поработать',
            style: const TextStyle(
              
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              await Navigator.pushNamed(context, '/tasks');
            },
            child: const Text('Перейти к задачам'),
          ),
        ],
      ),
    );
  }
}
