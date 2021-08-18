import 'package:flutter/material.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zodiac_app/screens/messages_screen.dart';
import 'package:zodiac_app/screens/new_message.dart';
import 'package:zodiac_app/screens/user_profile_screen.dart';
import 'package:zodiac_app/widgets/search_widget.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late Future<User> futureUser;
  var userId;
  String query = '';

  TextEditingController? _controllerFilter = TextEditingController();

  @override
  void initState() {
    super.initState();
    // futureUser = getUsers();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'users',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.purple,
                fontWeight: FontWeight.w300,
                fontFamily: 'Open Sans',
                fontSize: 36,
              ),
            ),
            SizedBox(height: 45.0),
            Container(
              width: 350,
              child: TextField(
                controller: _controllerFilter,
                autofocus: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.wb_sunny, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'search by zodiac sign',
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: FutureBuilder(
                future: getUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // returns list of users
                    return Container(
                      child: createListView(snapshot.data, context),
                    );
                    //   snapshot.data[0]['first name'],
                    // );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getUsers() async {
    // VARIABLE RESPONSE THAT GETS DATA FROM API
    final response = await http.get(
      Uri.parse("http://localhost:5000/users"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 response,
      // then parse the JSON.

      print(jsonDecode(response.body));

      // returns all the users
      return jsonDecode(response.body);

      // return User.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.

      throw Exception('Failed to load users');
    }
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      // buildSearch(),
      child: Expanded(
        child: SizedBox(
          child: ListView.builder(
            // scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Divider(
                    height: 10.0,
                  ),
                  ListTile(
                      title: Text('${data[index]['first name']}'),
                      subtitle: Text('${data[index]['birthday']}'),
                      leading: Container(
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              child: Icon(Icons.person),
                              backgroundColor: Colors.purple,
                              radius: 23.0,
                            ),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.purple,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewMessage()),
                            );
                          },
                          child: Text('msg'))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
