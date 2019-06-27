import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:meditation/main.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:meditation/policy.dart';
import 'package:meditation/resetpassword.dart';
import 'package:meditation/tc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';
import 'package:connectivity/connectivity.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InputBorder border;
  String email, password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      signInWithEmail();
    } else if (result == ConnectivityResult.wifi) {
      signInWithEmail();
    }
  }

  void signInWithEmail() async {
    // marked async
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MyApp()));
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Invalid credentials.'),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Color(0xffFFFFF7),
        appBar: AppBar(

          leading: BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Log In',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xffFFFFF7),
        ),

        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 14.0, right: 14.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey,
                                style: BorderStyle.solid,
                                width: 2.0)),
                      ),
                      validator: (String value) {
                        if (value.isEmpty ||
                            RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                                .hasMatch(value) ||
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                          return 'Please fill valid Email';
                        }
                      },
                      onSaved: (String value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password (8+ characters)',
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.blueGrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueGrey,
                                style: BorderStyle.solid,
                                width: 2.0)),
                      ),
                      validator: (String value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Please fill valid Password';
                        }
                      },
                      onSaved: (String value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 14.0,
                    ),
                    GestureDetector(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      onTap: () {
                        _formKey.currentState.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ResetPass(
                                      email: email,
                                    )));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: Colors.blueGrey,
                        child: Text(
                          'LOG IN',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          } else {
                            _formKey.currentState.save();
                          }
                          checkConnectivity();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
