import 'package:zodiac_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// above can also be: void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // deliberately overriding StatelessWidget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Orbytz',
      home: WelcomeScreen(),
    );
  }
}
