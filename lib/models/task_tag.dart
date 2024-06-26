class TaskTag {
  TaskTag({
    this.id,
    required this.taskId,
    required this.tagId,   
  });

  factory TaskTag.fromMap(Map<String, dynamic> map) {
    return TaskTag(
      id: map['id'] ?? 0,
      taskId: map['task_id'],
      tagId: map['tag_id'],
    );
  }
  int? id;
  String taskId;
  String tagId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_id': taskId,
      'tag_id':tagId,
    };
  }
}
