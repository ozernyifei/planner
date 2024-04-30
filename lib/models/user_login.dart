class UserLogin {
  UserLogin({
    this.userId,
    required this.username,
    required this.password,
  });

  factory UserLogin.fromMap(Map<String, dynamic> map) {
    return UserLogin(
      userId: map['user_id'] ?? 0,
      username: map['username'],
      password: map['password'],
    );
  }
  int? userId;
  String username;
  String password;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'password': password,
    };
  }
}
