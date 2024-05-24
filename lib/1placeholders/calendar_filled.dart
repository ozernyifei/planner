import 'package:flutter/material.dart';
import 'package:planner/screens/edit_event_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}


class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Календарь'),
    ),
    body: SingleChildScrollView(
        child: Column(
          children: [
            SfCalendar(
              
              view: CalendarView.month,
              firstDayOfWeek: 1,
              
              monthViewSettings: const MonthViewSettings(
                //appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                numberOfWeeksInView: 4,
                showAgenda: true,
              ),
              dataSource: MeetingDataSource(_getDataSource()),
              onLongPress: (details) {
                // Handle long press on calendar cell (implementation needed)
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        
        onPressed: () async {
          // Нажмите на FAB, чтобы перейти к edit_task.dart
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EditEventScreen()),
          );
          
        },
        child: const Icon(Icons.add),
      )
  );
}

}


List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, 10, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 8));
  meetings.add(Meeting(
      'Пары', startTime, endTime, Colors.lightBlue, false));
  return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
