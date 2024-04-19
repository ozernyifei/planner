class Status {
  Status({
    required this.id,
    required this.title,
    this.description = '',
  });

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'] ?? 0,
      title: map['title'],
      description: map['description'] ?? '',
    );
  }
  int id;
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
