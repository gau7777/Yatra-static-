import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class EditEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditEmailState();
  }
}

class EditEmailState extends State<EditEmail> {
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
          'Change Email',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                      initialValue: 'kaushal.deligence@gmail.com',
                      decoration: new InputDecoration(
                        hintText: "Email",
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
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: '.........',
                      obscureText: true,
                      decoration: new InputDecoration(
                        hintText: "Password",
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
                        color: Colors.white,
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
