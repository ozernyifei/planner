class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'],
      email: map['email'],
      password: map['password']
    );
  }
  int? id;
  String name;
  String email;
  String password;
  //String? photoUrl;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password
    };
  }
}
