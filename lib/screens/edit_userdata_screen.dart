// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
// import 'package:planner/classes/db_helper.dart';
// import 'package:planner/widgets/show_error.dart';
// import 'package:sqflite/sqflite.dart';

class EditUserdataScreen extends StatefulWidget {
  @override
  _EditUserdataScreenState createState() => _EditUserdataScreenState();
}

class _EditUserdataScreenState extends State<EditUserdataScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key for validation


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
}
