import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

// class HttpService {
//   static final _client = http.Client();

//   static var _loginUrl = Uri.parse('http://localhost:5000/login');

//   static var _registerUrl = Uri.parse('http://localhost:5000/register');

//   static login(username, password, context) async {
//     http.Response response = await _client.post(_loginUrl, body: {
//       'username': username,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       print(jsonDecode(response.body));
//       var json = jsonDecode(response.body);

//       if (json['status'] == 'Login Sucessfully') {
//         await EasyLoading.showSuccess(json['status']);
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => DashboardScreen()));
//       } else {
//         EasyLoading.showError(json['status']);
//       }
//     } else {
//       await EasyLoading.showError(
//           "Error Code : ${response.statusCode.toString()}");
//     }
//   }

//   static register(username, password, context) async {
//     http.Response response = await _client.post(_registerUrl, body: {
//       'username': username,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       var json = jsonDecode(response.body);
//       if (json['status'] == 'username already exist') {
//         await EasyLoading.showError(json['status']);
//       } else {
//         await EasyLoading.showSuccess(json['status']);
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => DashboardScreen()));
//       }
//     } else {
//       await EasyLoading.showError(
//           "Error Code : ${response.statusCode.toString()}");
//     }
//   }
// }

// Future<User> createUser(
//     String firstName, String lastName, String username, String password) async {
//   final response = await http.post(
//     Uri.parse('http://localhost:5000/users'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'first name': firstName,
//       'last name': lastName,
//       'username': username,
//       'password': password
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.

//     return User.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.


//     throw Exception('Failed to create user.');
//   }
// }

// class User {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final String username;
//   final String password;

//   User(
//       {required this.id,
//       required this.firstName,
//       required this.lastName,
//       required this.username,
//       required this.password});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         id: json['id'],
//         firstName: json['first name'],
//         lastName: json['last name'],
//         username: json['username'],
//         password: json['password']);
//   }
// }
