import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TermsConditions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TermsConditionsState();
  }
}

class TermsConditionsState extends State<TermsConditions> {
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
          'Terms and conditions',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFFFFF7),
      ),
      backgroundColor: Color(0xffFFFFF7),
      body: Container(
        child: Center(
            child: Text('Terms & Conditions',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey))),
      ),
    );
  }
}
