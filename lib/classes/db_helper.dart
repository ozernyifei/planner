import 'package:sqflite/sqflite.dart';

class DbHelper {
  static String get _databaseName => 'taskPlanner1.db';

  Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  final databasePath = '$dbPath/$_databaseName';

  final database = await openDatabase(databasePath);
  await _createPlannerDatabase(database);

  return database;


  }

  Future<void> deleteTask(Database database, int id) async => database.delete('task', where: 'id = ?', whereArgs: [id]);
  Future<void> deleteEvent(Database database, int id) async => database.delete('event', where: 'id = ?', whereArgs: [id]);



  Future<void> _createPlannerDatabase(Database database) async {
    // await _createTablePeriod(database);
    await _createTablePriority(database);
    await _createTableStatus(database);
    await _createTableSubtask(database);
    await _createTableTask(database);
    await _createTableTaskTag(database);
    await _createTableTag(database);
    await _createTableUserData(database);
    await _createTableUserLogin(database);
    //await _createTableTaskReminder(database);
  }

  
  Future<void> _createTableUserData(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS user_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_name TEXT NOT NULL,
      second_name TEXT NOT NULL,
      email TEXT UNIQUE NOT NULL,
      username TEXT UNIQUE NOT NULL
    )
  ''');

  Future<void> _createTableUserLogin(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS user_login (
      user_id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT UNIQUE NOT NULL,
      password TEXT NOT NULL
    )
  ''');

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
  // Future<void> _createTablePeriod(Database database) async => database.execute('''
  //   CREATE TABLE IF NOT EXISTS status (
  //     id INTEGER PRIMARY KEY AUTOINCREMENT,
  //     name TEXT NOT NULL,
  //     description TEXT
  //   )
  // ''');
  Future<void> _createTableTaskTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS task_tag (
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
      user_id INTEGER NOT NULL,
      priority_id INTEGER NOT NULL REFERENCES priority(id),
      status_id INTEGER NOT NULL REFERENCES status(id),
      tag_id INTEGER REFERENCES tag(id),
      FOREIGN KEY (user_id) REFERENCES user_data(user_id) ON DELETE CASCADE
    )
  ''');
  Future<void> _createTableSubtask(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS subtask (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      dueDate DATETIME
    )
  ''');
  Future<void> _createTableTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS tag (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      color TEXT NOT NULL
    )
  ''');
  // ... методы для добавления, получения, обновления и удаления данных из каждой таблицы


}
