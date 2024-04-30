import 'package:flutter/material.dart';
import 'package:planner/classes/user_service.dart';
import 'package:planner/screens/reg_screen.dart';



class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _formKey = GlobalKey<FormState>(); // Form key for validation
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Студент+'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Студент+',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Логин',
                hintText: 'Введите свой логин',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите имя пользователя';
                }
                return null;
              }
            ),
            const SizedBox(height: 20),
             TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите свой пароль',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите пароль';
                }
                return null;
              }
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await UserService.isUserLoggedIn(
                    _usernameController.text,
                    _passwordController.text); // Call the login function
                }
              
              },
              child: const Text('Войти'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                // Переход на RegScreen()
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegScreen()),
                );
              },
              child: Text(
                'Регистрация',
                style: TextStyle(color: Colors.blue[200], decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
