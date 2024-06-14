// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/classes/user_service.dart'; 
import 'package:planner/widgets/event_stat.dart';
import 'package:planner/widgets/task_stat.dart'; 

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DbHelper();
  int? taskCount;
  int? eventCount;
  int? userId;

  @override
  void initState() {
    super.initState();
    unawaited(_fetchData());
  }

  Future<void> _fetchData() async {
    // Get logged-in user ID (replace with your logic)
    final userId = await UserService.fetchUserId();
    final database = await dbHelper.database;

    taskCount = await dbHelper.getTaskCount(database, userId);
    eventCount = await dbHelper.getEventCount(database, userId);
    setState(() {}); // Update state to trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (taskCount == 0) Icon(
              Icons.assignment_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            // Conditionally display TaskStat
            if (taskCount != null) TaskStat(taskCount: taskCount!) else const Text(
                    'Список задач пуст.',
                    style: TextStyle(fontSize: 18),
                  ),
            const SizedBox(height: 16),
            // Conditionally display EventStat
            if (eventCount != null) EventStat(eventCount: eventCount!) 
            else const Text(
                    "You don't have any upcoming events.",
                    style: TextStyle(fontSize: 16),
                  ),
            //const SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigate to task creation screen
            //   },
            //   child: const Text('Создать задачу'),
            // ),
          ],
        ),
      ),
    );
  }
}
