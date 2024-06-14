import 'dart:ui';
// import 'package:sqflite/sqflite.dart';

class Event {

  Event({
    this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.isAllDay,
    required this.userId
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? 0,
      title: map['title'],
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']), 
      color: Color(map['color'] as int),
      isAllDay: map['is_all_day'],
      userId: map['user_id'],
    );
  }
  int? id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  final bool isAllDay;
  final int userId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'color': color.value,
      'is_all_day': isAllDay,
      'user_id': userId,
    };
  }

  // Future<void> addToDatabase(Database database) async {
  //   await database.insert(
  //     'event', 
  //     toMap(), 
  //   );
  // }

  // static Future<List<Event>> getEventsFromDatabase(Database database) async {
  //   final eventsData = await database.query('Event'); 
  //   final events = <Event>[];
  //   for (final row in eventsData) {
  //     events.add(Event.fromMap(row));
  //   }
  //   return events;
  // }

}
