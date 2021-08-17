import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  // deliberately overriding StatelessWidget
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String username = '';

  @override
  Widget build(BuildContext context) {
    // MaterialApp does not have any default styling. In flutter you have to configure all the styling manually
    return MaterialApp(
      // Scaffold and hit control space for some potential arguments
      home: Container(
        // AppBar is a pre-built widget provided by MaterialApp
        // title takes in text widget that's why it needs Text and not just the string
        // appBar: AppBar(
        //   title: Text('Zodiac App'),
        // ),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3099ec),
              Color(0xFF05050c),
              Color(0xFF212155),
              Color(0xFF4e2c43),
            ],
          ),
        ),

        // child: Padding(
        //   padding: const EdgeInsets.all(double.infinity),
        // );

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ImageBanner('assets/images/zodiac_signs.png'),
            Text(
              'orbytz',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.purple,
                fontWeight: FontWeight.w300,
                fontFamily: 'Open Sans',
                fontSize: 72,
              ),
            ),

            SizedBox(height: 40.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // background
                onPrimary: Colors.purple, // foreground
              ),
              child: Text('login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),

            SizedBox(height: 20.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white, // background
                onPrimary: Colors.purple, // foreground
              ),
              child: Text('get started'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
            ),
          ], // Children
        ),
      ),
    );
  }
}
