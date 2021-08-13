import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zodiac_app/models/user_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
        'password': password,
      },
    ),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login.');
  }
}
