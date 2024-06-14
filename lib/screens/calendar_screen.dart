import 'package:flutter/material.dart';
import 'package:planner/screens/edit_event_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


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
  //final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
      ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Нажмите на FAB, чтобы перейти к edit_task.dart
          await Navigator.pushNamed(
            context,
            '/create-event',
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCalendar(
  controller: _calendarController,
  view: CalendarView.week,
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
             },
            ),
          ],
        ),
      ),
    );
  }
}
