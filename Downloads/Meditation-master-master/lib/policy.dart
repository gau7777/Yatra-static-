import 'package:flutter/material.dart';

class Policy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PolicyState();
  }
}

class PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFFFFF7),
      ),
      backgroundColor: Color(0xffFFFFF7),
      body: Container(
        child: Center(
            child: Text('Privacy Policy',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey))),
      ),
    );
  }
}
