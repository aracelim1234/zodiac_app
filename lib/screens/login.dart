import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'user_profile.dart';
// import 'package:zodiac_app/backend_connect/backend_connect.dart';
import 'package:http/http.dart' as http;
import 'package:zodiac_app/screens/user_profile.dart';

Future<LoginInfo> createLogin(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{'username': username, 'password': password},
    ),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.

    return LoginInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login.');
  }
}

class LoginInfo {
  final int id;
  final String username;
  final String password;

  LoginInfo({
    required this.id,
    required this.username,
    required this.password,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

// defines a custom Form widget for logging in
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  // String username = '';
  // String password = '';
  // String final_response = '';

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<LoginInfo>? _futureLogin;

  // creates a scaffol key that uniquely identifies the Scaffold widget
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // creates a form key that uniquely idenifies the Form widget and allows validation of the form
  // final _formKey = GlobalKey<FormState>();

  // SharedPreferences? _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Form(
          // key: _formKey,
          child: Column(
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
              // use TextFormField instead of TextField to validate user input before you save it
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.person, color: Colors.purple),
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'username'),
                controller: _controllerUsername,
                //   onChanged: (text) {
                //     username = text;
                //   },
              ),

              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock, color: Colors.purple),
                    contentPadding: EdgeInsets.all(15),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'password'),
                controller: _controllerPassword,
                //   onChanged: (text) {
                //     password = text;
                //   },
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.purple,
                ),
                child: Text('login'),
                onPressed: () {
                  setState(
                    () {
                      _futureLogin = createLogin(
                        _controllerUsername.text,
                        _controllerPassword.text,
                      );
                    },
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfile(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
