class UserData {
  UserData({
    this.id,
    required this.fName,
    required this.sName,
    required this.username,
    required this.email,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? 0,
      fName: map['first_name'],
      sName: map['second_name'],
      username: map['username'],
      email: map['email'],
    );
  }
  int? id;
  String fName;
  String sName;
  String username;
  String email;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': fName,
      'second_name': sName,
      'username': username,
      'email': email,
    };
  }
}
