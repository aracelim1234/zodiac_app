import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'package:zodiac_app/screens/profile_creator.dart';

Future<User> createUser(
  String firstName,
  String lastName,
  String birthday,
  String username,
  String password,
) async {
  // VARIABLE RESPONSE THAT GETS DATA FROM API
  final response = await http.post(
    Uri.parse('http://localhost:5000/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
      <String, String>{
        'first name': firstName,
        'last name': lastName,
        'birthday': birthday,
        'username': username,
        'password': password
      },
    ),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => ProfileCreator()));

    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.

    throw Exception('Failed to create user.');
  }
}
