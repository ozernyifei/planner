import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserService {
  static Future<bool> 
  isUserLoggedIn(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedToken = prefs.getString('token');
    final timestamp = prefs.getInt('timestamp');

    if (storedUsername != null && storedToken != null && timestamp != null) {
      final sessionDuration = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (sessionDuration < 3600000) {
        print('was logged in SP');
        return true; 
        
      }
    }

    final dbHelper = DbHelper();
    final database = await dbHelper.database;

    final result = await database.query(
      'user_login',
      where: 'username = ? AND password = ?',
      whereArgs: [username,password],
      limit: 1
    );
    print('$username, $password, $result');

    if (result.isNotEmpty) {
      print('is in database');
      return true;
    }
    print('not in db nor sp');

    return false; 
  } 

  static Future<void> saveLoggedInUser(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    await prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<String> getLoggedInUsername() async {
    final prefs = SharedPreferences.getInstance() as SharedPreferences;
    final username = prefs.getString('username');
    return username ?? ''; //
  }

  static Future<List<Task>> getTasksForUser(String username) async {
    final dbHelper = DbHelper();
    final database = await dbHelper.database;

    final result = await database.query(
      'tasks',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.map(Task.fromMap).toList();
    } else {
      return [];
    }
  }
}
