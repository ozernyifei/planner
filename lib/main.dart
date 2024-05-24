import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:planner/1placeholders/calendar_placeholder.dart';
import 'package:planner/1placeholders/calendar_filled.dart';
//import 'package:planner/1placeholders/task_filled.dart';
import 'package:planner/1placeholders/task_placeholder.dart';
import 'package:planner/screens/auth_screen.dart';
// import 'package:planner/screens/calendar_screen.dart';
import 'package:planner/screens/home_screen.dart';
import 'package:planner/screens/settings_screen.dart';
// import 'package:planner/screens/task_screen.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      locale: const Locale('ru'),
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => AuthScreen(),
        '/home': (context) => MyHomePage(),
      },
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
                ],
      title: 'To-do list',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
        ),

      ),
			debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(),
      TaskScreen(),
      CalendarScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          }
          );
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: _selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined),
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.task_alt_outlined),
            icon: Icon(Icons.task_alt_outlined),
            label: 'Задачи',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Календарь',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}




        
