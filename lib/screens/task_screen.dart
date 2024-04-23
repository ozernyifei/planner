import 'package:flutter/material.dart';

import 'package:planner/screens/edit_task.dart';


class TaskScreen extends StatefulWidget {


  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... AppBar ...
      body: const SingleChildScrollView(
        // ... ваш список задач ...
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Нажмите на FAB, чтобы перейти к edit_task.dart
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class _TaskScreenState extends State<TaskScreen> {
//   int currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Scaffold(
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: ( index) {
//           setState(() {
//             currentPageIndex = index;
//           });
//         },
//         indicatorColor: Colors.amber,
//         selectedIndex: currentPageIndex,
//         destinations: const <Widget>[
//           NavigationDestination(
//             selectedIcon: Icon(Icons.home),
//             icon: Icon(Icons.home_outlined),
//             label: 'Главная',
//           ),
//           NavigationDestination(
//             icon: Badge(child: Icon(Icons.calendar_today)),
//             label: 'Календарь',
//           ),
//           NavigationDestination(
//             icon: Badge(
//               label: Text('2'),
//               child: Icon(Icons.settings),
//             ),
//             label: 'Настройки',
//           ),
//         ],
//       ),
//       body: <Widget>[
//         /// Task page
//         Card(
//           shadowColor: Colors.transparent,
//           margin: const EdgeInsets.all(8),
//           child: SizedBox.expand(
//             child: Center(
//               child: Text(
//                 'Task page',
//                 style: theme.textTheme.titleLarge,
//               ),
//             ),
//           ),
//         ),

//         /// Notifications page
//         const Padding(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             children: <Widget>[
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 1'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//               Card(
//                 child: ListTile(
//                   leading: Icon(Icons.notifications_sharp),
//                   title: Text('Notification 2'),
//                   subtitle: Text('This is a notification'),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         /// Messages page
//         ListView.builder(
//           reverse: true,
//           itemCount: 2,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   margin: const EdgeInsets.all(8),
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     'Hello',
//                     style: theme.textTheme.bodyLarge!
//                         .copyWith(color: theme.colorScheme.onPrimary),
//                   ),
//                 ),
//               );
//             }
//             return Align(
//               alignment: Alignment.centerLeft,
//               child: Container(
//                 margin: const EdgeInsets.all(8),
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'Hi!',
//                   style: theme.textTheme.bodyLarge!
//                       .copyWith(color: theme.colorScheme.onPrimary),
//                 ),
//               ),
//             );
//           },
//         ),
//       ][currentPageIndex],
//     );
//   }
// }
// class _TaskScreenState extends State<TaskScreen> {
//   int _selectedIndex = 0;
//   late Color _iconColor;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Студент+'),
//       ),
//       body: _bodyWidget,
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Главная',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Расписание',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Настройки',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }

//   Widget get _bodyWidget {
//     switch (_selectedIndex) {
//       case 0:
//         return const Center(
//           child: Text('Главная'),
//         );
//       case 1:
//         return const Center(
//           child: Text('Расписание'),
//         );
//       case 2:
//         return const Center(
//           child: Text('Настройки'),
//         );
//       default:
//         return const Center(
//           child: Text('Неизвестная страница'),
//         );
//     }
//   }
// }