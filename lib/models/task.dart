import 'package:sqflite/sqflite.dart';

class Task {

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    required this.priorityId,
    required this.statusId,
    this.tagId,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']), 
      priorityId: map['priorityId'],
      statusId: map['statusId'],
      tagId: map['tagId'],
    );
  }
  final int? id;
  String title;
  String? description;
  DateTime? dueDate;
  int priorityId;
  int statusId;
  int? tagId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'priorityId': priorityId,
      'statusId': statusId,
      'tagId': tagId,
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
