class TaskTag {
  TaskTag({
    required this.id,
    required this.taskID,
    required this.tagID,   
  });

  factory TaskTag.fromMap(Map<String, dynamic> map) {
    return TaskTag(
      id: map['id'] ?? 0,
      taskID: map['taskID'],
      tagID: map['tagID'],
    );
  }
  int id;
  String taskID;
  String tagID;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskID': taskID,
      'tagID':tagID,
    };
  }
}
