class UserTag {
  UserTag({
    this.id,
    required this.userId,
    required this.tagId,   
  });

  factory UserTag.fromMap(Map<String, dynamic> map) {
    return UserTag(
      id: map['id'] ?? 0,
      userId: map['user_id'],
      tagId: map['tag_id'],
    );
  }
  int? id;
  String userId;
  String tagId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'tag_id':tagId,
    };
  }
}
