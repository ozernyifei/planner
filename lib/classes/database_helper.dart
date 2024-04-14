import 'package:sqflite/sqflite.dart';

class Task {

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.priorityId,
    required this.statusId,
    required this.tagId,
    required this.reminderId,
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
      reminderId: map['reminderId'],
    );
  }
  int id;
  String title;
  String description;
  DateTime dueDate;
  int priorityId;
  int statusId;
  int tagId;
  int reminderId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priorityId': priorityId,
      'statusId': statusId,
      'tagId': tagId,
      'reminderId': reminderId,
    };
  }
}

class Status {

}

class Tag {
  
}

class Priority {
  
}

class Subtask {
  
}

class Period {
  
}

class TaskTag {
  
}

class DatabaseHelper {
  static const String _databaseName = 'task_manager.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final database = await openDatabase(_databaseName);
    await database.execute('''
      CREATE TABLE task (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        priorityId INTEGER NOT NULL REFERENCES priority(id),
        statusId INTEGER NOT NULL REFERENCES status(id),
        tagId INTEGER NOT NULL REFERENCES tag(id),
        reminderId INTEGER NOT NULL
      )
    ''');
    // Добавить методы для создания остальных таблиц
    await database.execute('''
      CREATE TABLE taskTag (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskId INTEGER NOT NULL REFERENCES task(id),
        tagId INTEGER NOT NULL REFERENCES tag(id)
      )
    ''');
    return database;
  }

  // ... методы для добавления, получения, обновления и удаления данных из каждой таблицы
}
