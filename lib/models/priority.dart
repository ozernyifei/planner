class Priority {
  Priority({
    this.id,
    required this.title,
    this.description = '',   
  });

  factory Priority.fromMap(Map<String, dynamic> map) {
    return Priority(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
    );
  }
  int? id;
  String title;
  String? description;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
