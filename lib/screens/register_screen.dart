import 'package:flutter/material.dart';
import 'package:zodiac_app/screens/user_profile_screen.dart';
import 'dart:async';
import 'package:zodiac_app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Register extends StatefulWidget {
  var selectZodiacSign = '';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerAboutMe = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword1 = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();

  Future<User>? _futureUser;

  String selectZodiacSign = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Center(
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
                fontSize: 28,
              ),
            ),
            Container(
              width: 350.0,
              child: TextField(
                controller: _controllerFirstName,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'first name',
                ),
              ),
            ),
            Container(
              width: 350.0,
              child: TextField(
                controller: _controllerLastName,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'last name',
                ),
              ),
            ),
            Container(
              width: 350.0,
              child: Expanded(
                child: DropdownButtonFormField(
                  // style: (TextStyle(
                  //   fontSize: ,
                  // )),
                  decoration: InputDecoration(
                    icon: Icon(Icons.calendar_view_month_rounded,
                        color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectZodiacSign = newValue!;
                    });
                  },
                  items: <String>[
                    'Aries March 21 - April 19',
                    'Taurus April 20 - May 20',
                    'Gemini May 21 - June 20',
                    'Cancer June 21 - July 22',
                    'Leo July 23 - Aug. 22',
                    'Virgo Aug. 23 - Sep. 22',
                    'Libra Sep. 23 - Oct. 22',
                    'Scorpio Oct. 23 - Nov. 21',
                    'Sagittarius Nov. 22 - Dec. 21',
                    'Capricorn Dec. 22 - Jan. 19',
                    'Aquarius Jan. 20 - Feb. 18',
                    'Pisces Feb. 19 - March 20',
                  ].map<DropdownMenuItem<String>>(
                    (
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 350.0,
              child: TextField(
                controller: _controllerAboutMe,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'about me',
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 350.0,
              child: TextField(
                controller: _controllerUsername,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'username',
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 350.0,
              child: TextField(
                controller: _controllerPassword1,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.purple),
                  suffixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 'create a password',
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 350.0,
              child: TextField(
                controller: _controllerPassword2,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.purple),
                  suffixIcon: Icon(Icons.visibility),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: 're-enter password',
                ),
              ),
            ),
            Container(
              width: 100.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.purple,
                ),
                child: Text(
                  'submit',
                ),
                onPressed: () {
                  setState(
                    () {
                      _futureUser = createUser(
                        _controllerFirstName.text,
                        _controllerLastName.text,
                        selectZodiacSign,
                        _controllerAboutMe.text,
                        _controllerUsername.text,
                        _controllerPassword1.text,
                        _controllerPassword2.text,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // API CALL

  Future<User> createUser(
    String firstName,
    String lastName,
    String birthday,
    String aboutMe,
    String username,
    String password1,
    String password2,
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
          'about me': aboutMe,
          'username': username,
          'password1': password1,
          'password2': password2,
        },
      ),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('invalid input')),
      );

      throw Exception('Failed to create user.');
    }
  }
}
