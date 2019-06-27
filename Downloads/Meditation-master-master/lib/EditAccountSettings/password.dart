import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class EditPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          'Change Password',
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
                      initialValue: '',
                      obscureText: true,
                      decoration: new InputDecoration(
                        hintText: "Current Password",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please fill Password';
                        }
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: '',
                      obscureText: true,
                      decoration: new InputDecoration(
                        hintText: "Password (8+ characters)",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please fill Password';
                        }
                      },
                      onSaved: (String value) {},
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21.0)),
                          color: Colors.blueGrey,
                          child: Text(
                            'SAVE',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            } else {
                              _formKey.currentState.save();
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21.0)),
                        color: Color(0xffFFFFF7),
                        child: Text(
                          'Cancel',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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
