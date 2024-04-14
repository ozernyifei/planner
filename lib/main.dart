import 'package:flutter/material.dart';
import 'package:planner/screens/calendar_screen.dart';
import 'package:planner/screens/home_screen.dart';
import 'package:planner/screens/settings_screen.dart';


void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-do list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(),
      CalendarScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar App'),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: ( index) {
          setState(() {
            _selectedIndex = index;
          }
        );
        },
        indicatorColor: Colors.amber,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.calendar_today)),
            label: 'Календарь',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.settings),
            ),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}




        
