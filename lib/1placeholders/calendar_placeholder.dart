import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Event {
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  const Event({
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Sample event data
    final event = Event(
      title: 'Meeting with Client',
      startTime: DateTime(2024, 05, 18, 10), // May 18, 2024, 10:00 AM
      endTime: DateTime(2024, 05, 18, 11), // May 18, 2024, 11:00 AM
    );

    // Create an EventDataSource instance
    final eventDataSource = EventDataSource([event]);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to edit event screen (implementation needed)
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
              ),
              dataSource: eventDataSource,
              onLongPress: (details) {
                // Handle long press on calendar cell (implementation needed)
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Custom EventDataSource class
class EventDataSource extends CalendarDataSource {
  final List<Event> events;

  EventDataSource(this.events);

  List<Appointment> getAppointments(String title, DateTime startDate, DateTime endDate) {
    // Logic to convert Event data to Appointment format
    // ... your implementation here
    return events
        .map((event) => Appointment(
              subject: event.title,
              startTime: event.startTime,
              endTime: event.endTime,
            ))
        .toList();
  }
}