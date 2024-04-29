import 'package:flutter/material.dart';
import 'package:planner/screens/reg_screen.dart';


class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Логин',
                hintText: 'Введите свой логин',
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите свой пароль',
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // Переход на HomeScreen()
              await Navigator.pushReplacementNamed(context, '/home');
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
