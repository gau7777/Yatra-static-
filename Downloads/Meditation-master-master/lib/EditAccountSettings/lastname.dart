import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditation/AccountSettings.dart';
import 'package:connectivity/connectivity.dart';


class EditLastName extends StatefulWidget {
  String lastname;

  EditLastName({this.lastname});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditLastNameState();
  }
}

class EditLastNameState extends State<EditLastName> {
  FirebaseAuth _auth = FirebaseAuth.instance;


  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Internet lost'),
              content: Text(
                  'Sorry, Please ckeck your internet connection and then try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    checkConnectivity();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {

      _auth.currentUser().then((user) {
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({
          'lastname': widget.lastname,
        }, merge: true).whenComplete(() {

          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AccountSettings()));

        });
      });


    } else if (result == ConnectivityResult.wifi) {
      _auth.currentUser().then((user) {
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({
          'lastname': widget.lastname,
        }, merge: true).whenComplete(() {

          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AccountSettings()));

        });
      });
    }
  }

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
          'Edit last name',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFFFFF7),
      ),
      backgroundColor:Color(0xffFFFFF7),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Container(
              height: 250.0,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.lastname,
                      decoration: new InputDecoration(
                        hintText: "Last Name",
                      ),
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value)) {
                          return 'Please fill valid Name';
                        }
                      },
                      onSaved: (String value) {
                        widget.lastname = value;
                      },
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

                            checkConnectivity();
                            _auth.currentUser().then((user) {
                              Firestore.instance
                                  .collection('users')
                                  .document(user.uid)
                                  .setData({
                                'lastname': widget.lastname,
                              }, merge: true).whenComplete(() {

                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            AccountSettings()));

                              });
                            });

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
