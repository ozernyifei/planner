class UserData {
  UserData({
    this.id,
    required this.fName,
    required this.sName,
    required this.username,
    required this.email,
    required this.password,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'] ?? 0,
      fName: map['fName'],
      sName: map['sName'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
    );
  }
  int? id;
  String fName;
  String sName;
  String username;
  String email;
  String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'sName': sName,
      'username': username,
      'email': email,
      'password': password,
    };
  }
}