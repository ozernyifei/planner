import 'package:sqflite/sqflite.dart';
import 'package:planner/models/task.dart';

class DbHelper {
  static String get _databaseName => 'planner.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  final databasePath = '$dbPath/$_databaseName';

    print('kekdont');
    final database = await openDatabase(databasePath);
    await _createPlannerDatabase(database);
    return database;


  }



  Future<void> _createPlannerDatabase(Database database) async {
    await _createTablePeriod(database);
    await _createTablePriority(database);
    await _createTableStatus(database);
    // await _createTableSubtask(database);
    await _createTableTask(database);
    await _createTableTaskTag(database);
    await _createTableTag(database);
    //await _createTableTaskReminder(database);
  }

  Future<void> _createTableStatus(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS status (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT
    )
  ''');
  Future<void> _createTablePriority(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS priority (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT
    )
  ''');
  Future<void> _createTablePeriod(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS status (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT
    )
  ''');
  Future<void> _createTableTaskTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS taskTag (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      taskId INTEGER NOT NULL REFERENCES task(id),
      tagId INTEGER NOT NULL REFERENCES tag(id)
    )
  ''');
  Future<void> _createTableTask(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS task (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      dueDate DATETIME,
      priorityId INTEGER NOT NULL REFERENCES priority(id),
      statusId INTEGER NOT NULL REFERENCES status(id),
      tagId INTEGER REFERENCES tag(id)
    )
  ''');
  // Future<void> _createTableSubtask(Database database) async => database.execute('''
  //   CREATE TABLE IF NOT EXISTS Subtask (
  //     id INTEGER PRIMARY KEY AUTOINCREMENT,
  //     title TEXT NOT NULL,
  //     description TEXT,
  //     dueDate DATETIME,
  //   )
  // ''');
  Future<void> _createTableTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS priority (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name INTEGER NOT NULL REFERENCES task(id),
      color TEXT NOT NULL
    )
  ''');
  // ... методы для добавления, получения, обновления и удаления данных из каждой таблицы


}
