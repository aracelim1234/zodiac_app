import 'package:flutter/material.dart';

class ProfileCreator extends StatefulWidget {
  @override
  _ProfileCreatorState createState() => _ProfileCreatorState();
}

class _ProfileCreatorState extends State<ProfileCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zodiac App')),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Container(
              width: 350,
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Picture',
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'About me'),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Form(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Birthday'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
