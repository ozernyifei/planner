import 'package:flutter/material.dart';
import 'package:planner/screens/edit_userdata_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Поменять отображение календаря'),
            onTap: () {
              // Handle change display logic
              print('Changing display...');
              // You might update theme or display settings
            },
          ),
          ListTile(
            title: const Text('Поменять данные для входа'),
            onTap: () async {
              // Переход на RegScreen()
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditUserdataScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Выйти из аккаунта'),
            onTap: () async {
              await logout(); // Call the logout function
            },
          ),
        ],
      ),
    );
  }
}
