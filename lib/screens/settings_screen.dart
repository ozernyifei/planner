import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            onTap: () {
              // Handle change data logic
              print('Changing data...');
              // You might navigate to a data editing screen
            },
          ),
          ListTile(
            title: const Text('Выйти из аккаунта'),
            onTap: () {
              // Handle exit app logic
              print('Exiting app...');
              // You might want to use Navigator.pop() to close the app
            },
          ),
        ],
      ),
    );
  }
}
