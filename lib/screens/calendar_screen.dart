import 'package:flutter/material.dart';
import 'package:planner/classes/db_helper.dart';
import 'package:planner/models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _calendarController = CalendarController();
  
  final _eventList = <Event>[]; // Store events in a state variable

  Future<void> _updateCalendar() async {
    final events = await getEvents(); // Call getEvents asynchronously

    // Update the state variable with the fetched events
    setState(() {
      _eventList..clear()
      ..addAll(events);
    });
// Use the awaited list
    // ... update SfCalendar with dataSource
    print(_eventList[1].startDate);
  }

  @override
  void initState() {
    super.initState();
    _updateCalendar();
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
          final result = await Navigator.pushNamed(
            context,
            '/create-event',
          );
          if (result != null) {
            final newEvent = result as Event;
            setState(() {
              _eventList.add(newEvent);
            });
          }
        },
        child: const Icon(Icons.add),
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
              dataSource: EventDataSource(_eventList) ,
              ),
            ],
          ),
        ),
      );
    }
  }

Future<CalendarView> loadCalendarView() async {
  final prefs = await SharedPreferences.getInstance();
  final storedCalendarViewString = prefs.getString('calendarView');
  if (storedCalendarViewString != null) {
    return CalendarView.values.firstWhere((mode) => mode.toString() == storedCalendarViewString);
  }
  else {
    return CalendarView.week;
  }
}

Future<List<Event>> getEvents() async {
  final dbHelper = DbHelper();
  final db = await dbHelper.database;
  final List<Map<String, dynamic>> maps = await db.query('event');
  return List.generate(maps.length, (i) => Event.fromMap(maps[i]));
}

class EventDataSource extends CalendarDataSource {

  EventDataSource(this.events);
  final List<Event> events;

  List<Appointment> getAppointments(DateTime startDate, DateTime endDate) {
    final appointments = <Appointment>[];
    for (final event in events) {
      // Assuming your Event model has start and end date properties
      if (event.startDate.isAfter(startDate) && event.endDate.isBefore(endDate)) {
        appointments.add(Appointment(
          startTime: event.startDate,
          endTime: event.endDate,
          subject: event.title, // Assuming a title property in Event
          isAllDay: event.isAllDay,
          color: event.color,
        ));
      }
    }
    return appointments;
  }
}
