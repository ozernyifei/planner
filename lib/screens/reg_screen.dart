// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/widgets/show_error.dart';
import 'package:sqflite/sqflite.dart';

class RegScreen extends StatefulWidget {
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _usernameController = TextEditingController();
  final _fNameController = TextEditingController();
  final _sNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _fNameController.dispose();
    _sNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Username field
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Имя пользователя'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя пользователя (username)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Name field
                  TextFormField(
                    controller: _fNameController,
                    decoration: const InputDecoration(labelText: 'Имя'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Surname field
                  TextFormField(
                    controller: _sNameController,
                    decoration: const InputDecoration(labelText: 'Фамилия'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите фамилию';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
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
                    decoration: const InputDecoration(labelText: 'Пароль'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите пароль';
                      }
                      if (value.length < 6) {
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
                        await _registerUser(); // Call the registration function
                      }
                    },
                    child: const Text('Зарегистрироваться'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Future<void> _registerUser() async {
  final username = _usernameController.text;
  final fName = _fNameController.text;
  final sName = _sNameController.text;
  final email = _emailController.text;
  final password = _passwordController.text;

  final dbHelper = DbHelper();
  final database = await dbHelper.database;


  // Insert data into user_login table (for authentication)
  try {
  await _insertUser(database, username, password, fName, sName, email);
} on DatabaseException catch (e) {
  if (e.isUniqueConstraintError()) {
    await _showUsernameExistsError();
  }
}

  await database.close();

  if (mounted) {
    Navigator.pop(context);
  }
}

Future<void> _insertUser(Database database, String username, String password, String fName, String sName, String email) async {
  await database.insert(
    'user_login',
    {
      'username': username,
      'password': password,
    },
  );
  print('data inserted to user_login: $username, $password');
  
  // Insert data into user_data table (for user information)
  await database.insert(
    'user_data',
    {
      'username': username, // Use the same username for association
      'first_name': fName,
      'second_name': sName,
      'email': email,
    },
  );
  print('data inserted to user_login: $username, $fName, $sName, $email');
}

  Future<void> _showUsernameExistsError() async {
    // Display error message using appropriate UI element
    // For example, using a dialog box:
   await showError('Пользователь с такими данными уже существует', context);
  }
}
