import 'package:planner/models/event.dart';
import 'package:planner/models/priority.dart';
import 'package:planner/models/status.dart';
import 'package:planner/models/tag.dart';
import 'package:planner/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static String get _databaseName => 'release.db';

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

  Future<int> getTaskCount(Database database, int userId) async {
    final tasksData = await database.rawQuery('''
      SELECT COUNT(*)
      FROM task
      WHERE user_id = ?
      ''', [userId]);

    final count = tasksData.first['COUNT(*)']! as int;
    return count;
  }

  Future<int> getEventCount(Database database, int userId) async {
    final eventsData = await database.rawQuery('''
      SELECT COUNT(*)
      FROM event
      WHERE user_id = ? AND start_date >= ?
      ''', [userId, DateTime.now().toString()]);

    final count = eventsData.first['COUNT(*)']! as int;
    return count;
  }

  

  Future<void> _createPlannerDatabase(Database database) async {
    // await _createTablePeriod(database);
    await _createTablePriority(database);
    await _createTableStatus(database);
    await _createTableSubtask(database);
    await _createTableTask(database);
    await _createTableTaskTag(database);
    await _createTableUserTag(database);
    await _createTableTag(database);
    await _initTableTag(database);
    await _createTableUserData(database);
    await _createTableUserLogin(database);
    await _createTableEvent(database);
    
    //await _createTableTaskReminder(database);
  }

  final List<Priority> predefinedPriorities = [
  Priority(title: 'Высокий', description: 'Задачи, которая является важной и которой следует уделять приоритетное внимание по сравнению с менее срочными делами.'),
  Priority(title: 'Средний', description: 'Задачи, которые является умеренно важной и может быть запланирована соответствующим образом'),
  Priority(title: 'Низкий', description: 'Задача, которые менее важны и может быть решена, когда позволит время'),
  // Add more priorities here
  ];

  final List<Tag> predefinedTags = [
    Tag(title: 'Личное', color: 0xFF0000FF),
    Tag(title: 'Работа', color: 0xFFFFD700), 
    Tag(title: 'Здоровье', color: 0xFF00FF00),
    Tag(title: 'Учеба', color: 0xFF7CFC00),
    Tag(title: 'Финансы', color: 0xFF00FFFF),
    Tag(title: 'Домашние дела', color: 0xC0C0C0),
    // Add more tags here
  ];

  final List<Status> predefinedStatuses = [
    Status(title: 'В процессе', description: 'Задача еще не выполнена'),
    Status(title: 'Выполнена', description: 'Задача выполнена'),
    Status(title: 'Заброшена', description: 'Задача была заброшена'),
  ];

  Future<void> _initTableTag(Database database) async  {
    final existingTag = await database.rawQuery('SELECT * FROM tag WHERE title = "Учеба"');
    if (existingTag.isEmpty) {
      await database.rawInsert('INSERT INTO tag(title, color) VALUES ("Учеба", 0x00000000)');
    await database.rawInsert('INSERT INTO tag(title, color) VALUES ("Работа", 0xFFFFC000)');
    await database.rawInsert('INSERT INTO tag(title, color) VALUES ("Здоровье", 0x00008000)');
    }
    else {
      
    }
    
  }

  Future<List<Event>> getEventsForUser(int userId) async {
    final db = await database;
    final events = await db.query('event',
        where: 'userId = ?',
        whereArgs: [userId],
        orderBy: 'startTime ASC');
    return events.map(Event.fromMap).toList();
  }

  Future<void> addEvent(Event event) async {
    final db = await database;
    await db.insert('event', event.toMap());
  }

  Future<void> addTask (Task task) async {
    final db = await database;
    await db.insert('task', task.toMap());
  }
  
  Future<void> _createTableEvent(Database database) async => database.execute('''
      CREATE TABLE IF NOT EXISTS event (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        color INTEGER,
        is_all_day BOOL NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES user_data(id) ON DELETE CASCADE
      )
    ''');

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
      title TEXT NOT NULL UNIQUE,
      description TEXT
    )
  ''');
  Future<void> _createTablePriority(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS priority (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL UNIQUE,
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
      task_id INTEGER NOT NULL REFERENCES task(id),
      tag_id INTEGER NOT NULL REFERENCES tag(id)
    )
  ''');
  Future<void> _createTableUserTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS user_tag (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL REFERENCES user_login(id),
      tag_id INTEGER NOT NULL REFERENCES tag(id)
    )
  ''');
  Future<void> _createTableTask(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS task (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      due_date TEXT,
      user_id INTEGER NOT NULL,
      priority_id INTEGER NOT NULL REFERENCES priority(id),
      status_id INTEGER NOT NULL REFERENCES status(id),
      tag_id INTEGER REFERENCES tag(id),
      FOREIGN KEY (user_id) REFERENCES user_data(id) ON DELETE CASCADE
    )
  ''');
  Future<void> _createTableSubtask(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS subtask (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT,
      due_date DATETIME
    )
  ''');
  Future<void> _createTableTag(Database database) async => database.execute('''
    CREATE TABLE IF NOT EXISTS tag (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL UNIQUE,
      color TEXT NOT NULL
    )
  ''');
  // ... методы для добавления, получения, обновления и удаления данных из каждой таблицы
}
