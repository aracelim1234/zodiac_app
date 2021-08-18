import 'package:flutter/material.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zodiac_app/screens/users_list_screen.dart';
import 'package:zodiac_app/screens/welcome_screen.dart';
import 'package:zodiac_app/widgets/navigation_bar.dart';
import 'package:zodiac_app/widgets/search_widget.dart';

import 'messages_screen.dart';

class Profile extends StatefulWidget {
  // in the constructor, require a User
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    // now we have the data, we just need to display it
    futureUser = fetchUserProfile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'profile',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.purple,
                fontWeight: FontWeight.w300,
                fontFamily: 'Open Sans',
                fontSize: 36,
              ),
            ),
            SizedBox(height: 45.0),
            // Container(
            //   child: FutureBuilder<User>(
            //     future: futureUser,
            //     // snapshot is what is holding the data
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         return Text(snapshot.data!.username);
            //       } else if (snapshot.hasError) {
            //         return Text('${snapshot.error}');
            //       } else {
            //         // By default, show a loading spinner.
            //         return const CircularProgressIndicator();
            //       }
            //     },
            //   ),

            //   // returns list of users
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Users(),
                        ),
                      );
                    },
                    child: Text('view users'),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Messages(),
                        ),
                      );
                    },
                    child: Text('mesages'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 45.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.purple,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                    child: Text('logout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<User> fetchUserProfile() async {
    // VARIABLE RESPONSE THAT GETS DATA FROM API
    final response = await http.get(
      Uri.parse("http://localhost:5000/users/8"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 response,
      // then parse the JSON.

      // print(jsonDecode(response.body));

      // returns all the users
      // return jsonDecode(response.body);

      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      throw Exception('Failed to load user profile');
    }
  }
}
