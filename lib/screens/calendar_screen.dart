import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// class CalendarScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Календарь'),
//     );
//   }
// }

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
      appBar: AppBar(
        title: const Text('Calendar Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SfCalendar(
              controller: _calendarController,
            ),
            // ElevatedButton(
            //   onPressed: () => print('Button pressed'),
            //   child: const Text('Добавить событие'),
            // ),
          ],
        ),
      ),
    );
  }
}
