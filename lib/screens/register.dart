import 'package:flutter/material.dart';
import 'profile_creator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<User> createUser(String firstName, String lastName, String birthday,
    String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first name': firstName,
      'last name': lastName,
      'birthday': birthday,
      'username': username,
      'password': password
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create user.');
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String birthday;
  final String username;
  final String password;

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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // String first_name;
  // String last_name;
  // String username;
  // String email;
  // String password;

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerBirthday = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'getting started',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.purple,
              fontWeight: FontWeight.w400,
              fontFamily: 'Open Sans',
              fontSize: 36,
            ),
          ),
          TextField(
            controller: _controllerFirstName,
            decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'first name'),
          ),
          TextField(
            controller: _controllerLastName,
            decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'last name'),
          ),
          TextField(
            controller: _controllerBirthday,
            decoration: InputDecoration(
                icon: Icon(Icons.calendar_view_month_rounded,
                    color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'birthday MM/DD/YYY'),
          ),
          // TextField(
          //   decoration: InputDecoration(
          //       icon: Icon(Icons.person, color: Colors.purple),
          //       border: OutlineInputBorder(),
          //       hintText: 'email'),
          // ),
          TextField(
            controller: _controllerUsername,
            decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.purple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'username'),
          ),
          TextField(
            controller: _controllerPassword,
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.purple),
                suffixIcon: Icon(Icons.visibility),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: 'create a password'),
          ),
          // TextField(
          //   obscureText: true,
          //   decoration: InputDecoration(
          //       icon: Icon(Icons.lock, color: Colors.purple),
          //       suffixIcon: Icon(Icons.visibility),
          //       border: OutlineInputBorder(),
          //       hintText: 'Re-enter password'),
          // ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.purple,
            ),
            child: Text('submit'),
            onPressed: () {
              setState(
                () {
                  _futureUser = createUser(
                    _controllerFirstName.text,
                    _controllerLastName.text,
                    _controllerBirthday.text,
                    _controllerUsername.text,
                    _controllerPassword.text,
                  );
                },
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileCreator()),
              // );
            },
          ),
        ],
      ),
    );
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.username);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
