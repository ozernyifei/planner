import 'package:sqflite/sqflite.dart';

class Event {

  Event({
    this.id,
    required this.title,
    this.description = '',
    this.dueDate,
    required this.priorityId,
    required this.statusId,
    this.tagId,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']), 
      priorityId: map['priorityId'],
      statusId: map['statusId'],
      tagId: map['tagId'],
    );
  }
  final int? id;
  String title;
  String? description;
  DateTime? dueDate;
  int priorityId;
  int statusId;
  int? tagId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate?.toIso8601String(),
      'priorityId': priorityId,
      'statusId': statusId,
      'tagId': tagId,
    };
  }

  Future<void> addEventToDatabase(Database database) async {
    await database.insert(
      'Event', 
      toMap(), 
    );
  }

  static Future<List<Event>> getEventsFromDatabase(Database database) async {

    final eventsData = await database.query('Event'); 
    final events = <Event>[];
    for (final row in eventsData) {
      events.add(Event.fromMap(row));
    }

    return events;
  }

}
