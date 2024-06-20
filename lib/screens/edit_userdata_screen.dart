// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/classes/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditUserdataScreen extends StatefulWidget {
  @override
  _EditUserdataScreenState createState() => _EditUserdataScreenState();
}

class _EditUserdataScreenState extends State<EditUserdataScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  void initState() {
    super.initState();
    setEmailFromSharedPreferences(_emailController); // Replace emailController with your actual instance
  }
  

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменение данных'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      hintText: 'Введите email',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите email';
                      }
                      if (!RegExp(r'^[\w-]+@\w+\.[a-z]{2,}$').hasMatch(value)) {
                        return 'Неверный формат email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Password field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      hintText: 'Введите пароль',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      
                    validator: (value) {
                      if (value == null || value.isEmpty || value == '') {
                        return 'Введите пароль';
                      }
                      else if (value.length < 6) {
                        return 'Пароль должен быть не менее 6 символов';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  // Registration button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      await changePassword(_passwordController.text);
                    }
                    },
                    child: const Text('Сохранить'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('username');
    await prefs.remove('token');
    await prefs.remove('timestamp');

    // Navigate to AuthScreen
    if (mounted) {
      await Navigator.pushReplacementNamed(context, '/auth');
    } 
  }
    Future<void> changePassword(String newPassword) async {
    final userId = await UserService.fetchUserId();
    final dbHelper = DbHelper();
    final db = await dbHelper.database;

    await db.update('user_login', {'password': newPassword}, where: 'id = ?', whereArgs: [userId]);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully.')),
     );
    }
    await logout();
  }
}

Future<void> setEmailFromSharedPreferences(TextEditingController emailController) async {
  final userEmail = await UserService.getUserEmail();
  if (userEmail != null) {
    emailController.text = userEmail;
  }
}
