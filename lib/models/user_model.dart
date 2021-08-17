class User {
  final int id;
  final String firstName;
  final String lastName;
  final String birthday;
  final String aboutMe;
  final String username;
  final String password1;
  final String password2;

  // CONSTRUCTOR
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.aboutMe,
    required this.username,
    required this.password1,
    required this.password2,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first name'],
      lastName: json['last name'],
      birthday: json['birthday'],
      aboutMe: json['about me'],
      username: json['username'],
      password1: json['password1'],
      password2: json['password2'],
    );
  }
}
