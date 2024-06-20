import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserService {

  static Future<bool> isUserExists(String username, String password) async {
    final dbHelper = DbHelper();
    final database = await dbHelper.database;

    final result = await database.query(
      'user_login',
      where: 'username = ? AND password = ?',
      whereArgs: [username,password],
      limit: 1
    );
   // print('$username, $password, $result');

    if (result.isNotEmpty) {
    //  print('is in database');
      return true;
    }
    //print('not in db nor sp');

    return false; 
  }

  static Future<bool> isUserLoggedIn(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final storedToken = prefs.getString('token');
    final timestamp = prefs.getInt('timestamp');

    if (storedUsername != null && storedToken != null && timestamp != null) {
      final sessionDuration = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (sessionDuration < 3600000) {
       // print('was logged in SP');
        return true; 
        
      }
    }
    return false;
  } 

  static Future<void> saveLoggedInUser(String username, String token) async {

    final prefs = await SharedPreferences.getInstance();
    final dbHelper = DbHelper();
    final database = await dbHelper.database;

    final result = await database.query(
      'user_data',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1
      );

    final userId = result.first['id']! as int;
    
    await prefs.setInt('user_id', userId);
    await prefs.setString('username', username);
    await prefs.setString('token', token);
    await prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<String> getLoggedInUsername() async {
    final prefs = SharedPreferences.getInstance() as SharedPreferences;
    final username = prefs.getString('username');
    return username ?? ''; //
  }

  static Future<List<Task>> getTasksForUser(int userId) async {
    final dbHelper = DbHelper();
    final database = await dbHelper.database;

    final result = await database.query(
      'task',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return result.map(Task.fromMap).toList();
    } else {
      return [];
    }
  }
  
  static Future<int> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id')!;
  }

  static Future<String?> getUserEmail() async {
  final dbHelper = DbHelper();
  final database = await dbHelper.database;
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId');

  if (userId == null) {
    return null; // Handle case where userId is not found in SharedPreferences
  }

  final List<Map<String, dynamic>> maps = await database.query(
    'user_data', // Replace 'users' with your actual table name
    columns: ['email'], // Select only the 'email' column
    where: 'user_id = ?', // Filter by 'id' column
    whereArgs: [userId], // Use the retrieved userId as the argument
  );

  if (maps.isEmpty) {
    return null; // Handle case where no user found with the userId
  }

  final user = maps.first;
  return user['email'] as String;
}

}
