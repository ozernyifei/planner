class Tag {
    Tag({
    required this.id,
    required this.title,
    required this.color,   
  });

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] ?? 0,
      title: map['title'],
      color: map['color'],
    );
  }
  int id;
  String title;
  String color;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
    };
  }
}
