import 'package:flutter/material.dart';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  // void initState() {
  //   super.initState();
  //   futureUser = getUsers();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
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
              // child: FutureBuilder<User>(
              //   future: futureUser,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Text(snapshot.data!.firstName);
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }

              //     // By default, show a loading spinner.
              //     return const CircularProgressIndicator();
              //   },
              // ),
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
      // Iterable l = json.decode(response.body);
      // List<User> users =
      //     List<User>.from(l.map((model) => User.fromJson(model)));
      print(jsonDecode(response.body));
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => ProfileCreator()));

      // returns all the users
      return jsonDecode(response.body);

      // return User.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 201 CREATED response,
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
                      leading: Column(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(Icons.person),
                            backgroundColor: Colors.purple,
                            radius: 23.0,
                          ),
                        ],
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

//   Widget buildSearch() => SearchWidget(
//     text: query,
//     hintText: 'Zodiac sign search',
//     onChanged: 
//   );
// }

// String getZodicaSign(DateTime date) {
//   var days = date.day;
//   var months = date.month;
//   if (months == 1) {
//     if (days >= 21) {
//       return "Aquarius";
//     } else {
//       return "Capricorn";
//     }
//   } else if (months == 2) {
//     if (days >= 20) {
//       return "Pisces";
//     } else {
//       return "Aquarius";
//     }
//   } else if (months == 3) {
//     if (days >= 21) {
//       return "Aries";
//     } else {
//       return "Pisces";
//     }
//   } else if (months == 4) {
//     if (days >= 21) {
//       return "Taurus";
//     } else {
//       return "Aries";
//     }
//   } else if (months == 5) {
//     if (days >= 22) {
//       return "Gemini";
//     } else {
//       return "Taurus";
//     }
//   } else if (months == 6) {
//     if (days >= 22) {
//       return "Cancer";
//     } else {
//       return "Gemini";
//     }
//   } else if (months == 7) {
//     if (days >= 23) {
//       return "Leo";
//     } else {
//       return "Cancer";
//     }
//   } else if (months == 8) {
//     if (days >= 23) {
//       return "Virgo";
//     } else {
//       return "Leo";
//     }
//   } else if (months == 9) {
//     if (days >= 24) {
//       return "Libra";
//     } else {
//       return "Virgo";
//     }
//   } else if (months == 10) {
//     if (days >= 24) {
//       return "Scorpio";
//     } else {
//       return "Libra";
//     }
//   } else if (months == 11) {
//     if (days >= 23) {
//       return "Sagittarius";
//     } else {
//       return "Scorpio";
//     }
//   } else if (months == 12) {
//     if (days >= 22) {
//       return "Capricorn";
//     } else {
//       return "Sagittarius";
//     }
//   }
//   return "";
// }
