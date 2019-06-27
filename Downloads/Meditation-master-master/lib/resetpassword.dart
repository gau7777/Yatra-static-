import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditation/welcome.dart';

class ResetPass extends StatefulWidget {
  String email;
  ResetPass({this.email});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPassState();
  }
}

class ResetPassState extends State<ResetPass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        leading: BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
          'Reset Password',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFFFFF7),
      ),
      backgroundColor: Color(0xffFFFFF7),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Container(
              height: 300.0,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.email,
                      decoration: new InputDecoration(
                        hintText: "Email Address",
                      ),
                      validator: (String value) {
                        if (value.isEmpty ||
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                          return 'Please fill valid Email';
                        }
                        if (RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                            .hasMatch(value) ||
                            value.endsWith(
                                RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                    .toString())) {
                          return 'Please fill valid Email';
                        }
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          color: Colors.blueGrey,
                          child: Text(
                            'SEND',
                            style:
                            TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              _formKey.currentState.save();
                            }
                            resetPassword(widget.email);
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Reset Password !!'),
                                    content: Text(
                                        'Please check your email Id. Sent reset link to you your email Id'),
                                    actions: <Widget>[
                                      RaisedButton(
                                        color: Colors.blueGrey,
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                      Welcome()));
                                        },
                                      )
                                    ],
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}





