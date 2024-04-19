class Task {

  Task({
    required this.id,
    required this.title,
    this.description = '',
    required this.dueDate,
    required this.priorityId,
    required this.statusId,
    required this.tagId,
    this.reminderId,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      dueDate: DateTime.parse(map['dueDate']),
      priorityId: map['priorityId'],
      statusId: map['statusId'],
      tagId: map['tagId'],
      reminderId: map['reminderId'],
    );
  }
  int id;
  String title;
  String? description;
  DateTime dueDate;
  int priorityId;
  int statusId;
  int tagId;
  int? reminderId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priorityId': priorityId,
      'statusId': statusId,
      'tagId': tagId,
      'reminderId': reminderId,
    };
  }
}
