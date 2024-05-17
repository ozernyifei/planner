import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty task list placeholder
            const Text('No tasks yet'),
            const SizedBox(height: 24.0),

            // Floating action button (FAB) for creating new tasks
            ElevatedButton(
              onPressed: () {
                // Implement navigation to task creation screen
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}