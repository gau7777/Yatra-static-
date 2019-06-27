import 'package:flutter/material.dart';

class PersonJourney extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonJourneyState();
  }
}

class PersonJourneyState extends State<PersonJourney> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffFFFFF7),
      body: Container(
        child: Center(
            child: Text('My Journey',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey))),
      ),
    );
  }
}
