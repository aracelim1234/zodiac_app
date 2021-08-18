import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String selectedvalue = 'Orange';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDown List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 70,
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                dropdownColor: Colors.grey.shade200,
                isExpanded: true,
                value: selectedvalue,
                icon: Icon(Icons.arrow_circle_down_rounded),
                onChanged: (String? newvalue) {
                  setState(
                    () {
                      selectedvalue = newvalue!;
                    },
                  );
                },
                items: <String>[
                  'Aries March 21 - April 19',
                  'Taurus April 20 - May 20',
                  'Gemini May 21 - June 20',
                  'Cancer June 21 - July 22',
                  'Leo July 23 - August 22',
                  'Virgo August 23 - September 22',
                  'Libra September 23 - October 22',
                  'Scorpio October 23 - November 21',
                  'Sagittarius November 22 - December 21',
                  'Capricorn December 22 - January 19',
                  'Aquarius January 20 - February 18',
                  'Pisces February 19 - March 20',
                ].map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
