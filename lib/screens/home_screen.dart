import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Домашний экран'),
      ),
      body: _bodyWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Расписание',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget get _bodyWidget {
    switch (_selectedIndex) {
      case 0:
        return const Center(
          child: Text('Главная'),
        );
      case 1:
        return const Center(
          child: Text('Расписание'),
        );
      case 2:
        return const Center(
          child: Text('Настройки'),
        );
      default:
        return const Center(
          child: Text('Неизвестная страница'),
        );
    }
  }
}
