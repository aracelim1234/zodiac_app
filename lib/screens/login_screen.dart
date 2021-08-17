import 'package:flutter/material.dart';
import 'package:zodiac_app/screens/users_list_screen.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// defines a custom Form widget for logging in
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  // String _inputUsername = '';
  // String _inputPassword = '';

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  Future<User>? _futureLogin;

  // creates a scaffol key that uniquely identifies the Scaffold widget
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  // creates a form key that uniquely idenifies the Form widget and allows validation of the form
  // final _formKey = GlobalKey<FormState>();

  // SharedPreferences? _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Form(
          // key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'log in to your account',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.purple,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Open Sans',
                    fontSize: 30,
                  ),
                ),

                SizedBox(height: 30.0),

                // use TextFormField instead of TextField to validate user input before you save it
                Container(
                  width: 300.0,
                  child: TextFormField(
                    autofocus: true,
                    key: Key('username'),
                    decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Colors.purple),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        hintText: 'username'),
                    controller: _controllerUsername,
                  ),
                ),

                SizedBox(height: 15.0),

                Container(
                  width: 300.0,
                  child: TextFormField(
                    autofocus: true,
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
                  ),
                ),

                // OutlinedButton.icon(
                //   onPressed: () {},
                //   icon: Icon(Icons.login, size: 18),
                //   label: Text('login'),
                // ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.purple,
                  ),
                  child: Text('login'),
                  onPressed: () {
                    setState(
                      () {
                        _futureLogin = userLogin(
                          _controllerUsername.text,
                          _controllerPassword.text,
                        );
                      },
                    );
                    buildFutureBuilder();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User> userLogin(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'username': username,
          'password1': password,
        },
      ),
    );

    // if (_controllerUsername.text.isEmpty || _controllerPassword.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('input fields cannot be empty')));

    if (response.statusCode == 200) {
      // If the server did return a 200 response,
      // then parse the JSON.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Users(),
        ),
      );
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('invalid credentials')),
      );
      throw Exception('Failed to login.');
    }
  }

  FutureBuilder<User> buildFutureBuilder() {
    return FutureBuilder<User>(
      future: _futureLogin,
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
