import 'package:sqflite/sqflite.dart';

class Task {

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    required this.userId,
    required this.priorityId,
    required this.statusId,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['due_date']), 
      userId: map['user_id'],
      priorityId: map['priority_id'],
      statusId: map['status_id'],

    );
  }
  final int? id;
  String title;
  String? description;
  DateTime? dueDate;
  int userId;
  int priorityId;
  int statusId;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate?.toIso8601String(),
      'user_id': userId,
      'priority_id': priorityId,
      'status_id': statusId,

    };
  }

  Future<void> addTaskToDatabase(Database database) async {
    await database.insert(
      'task', 
      toMap(), 
    );
  }

  static Future<List<Task>> getTasksFromDatabase(Database database) async {

    final tasksData = await database.query('task'); 
    final tasks = <Task>[];
    for (final row in tasksData) {
      tasks.add(Task.fromMap(row));
    }

    return tasks;
  }

}
