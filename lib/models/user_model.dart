class User {
  final int id;
  final String firstName;
  final String lastName;
  final String birthday;
  final String username;
  final String password;

  // CONSTRUCTOR
  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.birthday,
      required this.username,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['first name'],
        lastName: json['last name'],
        birthday: json['birthday'],
        username: json['username'],
        password: json['password']);
  }
}
