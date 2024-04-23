import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:planner/screens/edit_event.dart';


class Event {
  Event(this.title);

  final String title;
}

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _events[DateTime.now()] = [
      Event('Событие 1'),
      Event('Событие 2'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Нажмите на FAB, чтобы перейти к edit_task.dart
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditEventScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCalendar(
  controller: _calendarController,
  view: CalendarView.month,
  firstDayOfWeek: 1, 
  monthViewSettings: const MonthViewSettings(
    numberOfWeeksInView: 5,
    showAgenda: true,
    // appointmentTextStyle: TextStyle(
    //   color: Colors.black,
    //   fontSize: 16,
    // ),
  ),
  // headerTitleBuilder: (date) {
  //   return Text(
  //     '${date.year} - ${date.month}',
  //     style: TextStyle(fontSize: 18),
  //   );
  // },
  // sources: [
  //   // Ваш источник данных (CalendarDataSource)
  // ],
  onLongPress: (details) {
    // Обработка долгого нажатия на ячейку
    print('Долгое нажатие на: ${details.date}');
             },
            ),
          ],
        ),
      ),
    );
  }
}
