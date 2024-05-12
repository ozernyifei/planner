class Subtask {

  Subtask({
    this.id,
    required this.title,
    this.description = '',
    required this.taskId,
  });

  factory Subtask.fromMap(Map<String, dynamic> map) {
    return Subtask(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
      taskId: map['taskId'],
    );
  }
  int? id;
  String title;
  String? description;
  int taskId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskId': taskId,
    };
  }
}
