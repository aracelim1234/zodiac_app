import 'package:flutter/material.dart';
import 'package:zodiac_app/screens/user_profile_screen.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'inbox',
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.purple,
              fontWeight: FontWeight.w400,
              fontFamily: 'Open Sans',
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
