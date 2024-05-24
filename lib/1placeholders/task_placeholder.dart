import 'package:flutter/material.dart';
import 'package:planner/screens/edit_task_dialog.dart';


class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваши задачи'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty task list placeholder
            Text('Задач пока нет.'),
            SizedBox(height: 24),
          ],
          
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
