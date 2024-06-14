import 'package:flutter/material.dart';
import 'package:planner/classes/encrypt.dart';
import 'package:planner/classes/user_service.dart';
import 'package:planner/screens/reg_screen.dart';
import 'package:planner/widgets/show_error.dart';



class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

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
            SizedBox(
              width: 0.9 * MediaQuery.of(context).size.width,
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Логин',
                  labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                  hintText: 'Введите свой логин',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите имя пользователя';
                  }
                  return null;
                }
              ),
            ),
            const SizedBox(height: 20),
             SizedBox(
              width: 0.9 * MediaQuery.of(context).size.width,
               child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                  labelText: 'Пароль',
                  hintText: 'Введите свой пароль',
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
                  return null;
                }
               ),
             ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;
                final isLoggedIn = await UserService.isUserExists(
                  username,
                  password);
                if (mounted && isLoggedIn) {
                  await UserService.saveLoggedInUser(username, await Encrypt.generateToken());
                  // ignore: use_build_context_synchronously
                  await Navigator.pushReplacementNamed(context, '/home');
                }
                else {
                await _showUserNotLoggedInError();
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
                style: TextStyle(color: Colors.blue[700], decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showUserNotLoggedInError() async {
    await showError('Такого пользователя не существует', context);
  }

  
}
