import 'package:planner/models/tag.dart';
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
    this.tags
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: map['due_date'] != null ? DateTime.parse(map['due_date']) : null, 
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
  List<Tag>? tags;


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
    final taskId = await database.insert('task', toMap());
    //print(taskId);
    if (tags != null) {
      for (final tag in tags!) {
        //print("kek $tag.id:");
        print("taskId $taskId");
        final tgId = await database.insert('task_tag', {'task_id': taskId, 'tag_id': tag.id});
        print("TgId $tgId");
        print("TaskId $taskId");
      }
    }
  }

  static Future<List<Task>> getTasksFromDatabase(Database database) async {
  final tasksData = await database.rawQuery('''
    SELECT t.*, tg.tag_id, tg.title, tg.color
    FROM task t
    INNER JOIN task_tag tt ON t.id = tt.task_id
    INNER JOIN tag tg ON tt.tag_id = tg.id
  ''');


  final tasks = <Task>[];
  for (final row in tasksData) {
    final taskId = row['id']! as int;
    final existingTask = tasks.firstWhere((task) => task.id == taskId);

    existingTask.tags?.add(
      Tag(
        id: row['tag_id']! as int,
        title: row['title']! as String,
        color: row['color']! as int,
      ),
    );
    }

  return tasks;
  }
}
