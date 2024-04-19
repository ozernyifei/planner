import 'package:sqflite/sqflite.dart';

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
        reminderId INTEGER REFERENCES reminder(id)
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
