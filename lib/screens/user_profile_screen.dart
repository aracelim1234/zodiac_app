import 'package:flutter/material.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.firstName);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,

        //   children: [
        //     // Text('Name'),
        //     // Text('    '),
        //     // Text('Zodiac Sign'),
        //     TextField(
        //       decoration: InputDecoration(
        //         contentPadding: EdgeInsets.all(15),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(20.0),
        //         ),
        //         hintText: 'name',
        //       ),
        //     ),
        //     TextField(
        //       decoration: InputDecoration(
        //         contentPadding: EdgeInsets.all(15),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(20.0),
        //         ),
        //         hintText: 'zodiac sign',
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }

  Future<User> getUser() async {
    // VARIABLE RESPONSE THAT GETS DATA FROM API
    final response = await http.get(
      Uri.parse('http://localhost:5000/users/15'),
      // Uri.parse('http://localhost:5000/users/<user_id>'),
    );

    if (response.statusCode == 200) {
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
}

String getZodicaSign(DateTime date) {
  var days = date.day;
  var months = date.month;
  if (months == 1) {
    if (days >= 21) {
      return "Aquarius";
    } else {
      return "Capricorn";
    }
  } else if (months == 2) {
    if (days >= 20) {
      return "Pisces";
    } else {
      return "Aquarius";
    }
  } else if (months == 3) {
    if (days >= 21) {
      return "Aries";
    } else {
      return "Pisces";
    }
  } else if (months == 4) {
    if (days >= 21) {
      return "Taurus";
    } else {
      return "Aries";
    }
  } else if (months == 5) {
    if (days >= 22) {
      return "Gemini";
    } else {
      return "Taurus";
    }
  } else if (months == 6) {
    if (days >= 22) {
      return "Cancer";
    } else {
      return "Gemini";
    }
  } else if (months == 7) {
    if (days >= 23) {
      return "Leo";
    } else {
      return "Cancer";
    }
  } else if (months == 8) {
    if (days >= 23) {
      return "Virgo";
    } else {
      return "Leo";
    }
  } else if (months == 9) {
    if (days >= 24) {
      return "Libra";
    } else {
      return "Virgo";
    }
  } else if (months == 10) {
    if (days >= 24) {
      return "Scorpio";
    } else {
      return "Libra";
    }
  } else if (months == 11) {
    if (days >= 23) {
      return "Sagittarius";
    } else {
      return "Scorpio";
    }
  } else if (months == 12) {
    if (days >= 22) {
      return "Capricorn";
    } else {
      return "Sagittarius";
    }
  }
  return "";
}
