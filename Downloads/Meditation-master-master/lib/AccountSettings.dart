import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import './EditAccountSettings/firstname.dart';
import './EditAccountSettings/lastname.dart';
import './EditAccountSettings/email.dart';
import './EditAccountSettings/password.dart';
import 'resetpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AccountSettingsState();
  }
}

class AccountSettingsState extends State<AccountSettings> {
  String firstname, email, lastname;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth.currentUser().then((user) {
      Firestore.instance
          .collection("users")
          .document(user.uid)
          .get()
          .then((snapshot) {
        setState(() {
          this.firstname = snapshot['firstname'];
          this.lastname = snapshot['lastname'];
          this.email = snapshot['email'];
        });
      });
      print("userid:" + user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return firstname != null && lastname != null && email != null
        ? Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: BackButton(
                color: Colors.black,
              ),
              centerTitle: true,
              title: Text(
                'Account Settings',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Color(0xffFFFFF7),
            ),
            backgroundColor: Color(0xffFFFFF7),
            body: Column(
              children: <Widget>[
                ListTile(
                  leading: null,
                  title: Text(
                    'First Name',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  subtitle: firstname != null
                      ? Text(
                          firstname,
                          style: TextStyle(fontSize: 18.0),
                        )
                      : Text(
                          " ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                  trailing: FlatButton(
                    child: Text(
                      'EDIT',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => EditFirstName(
                                    firstname: this.firstname,
                                  )));
                    },
                  ),
                ),
                ListTile(
                  leading: null,
                  title: Text(
                    'Last Name',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  subtitle: lastname != null
                      ? Text(
                          lastname,
                          style: TextStyle(fontSize: 18.0),
                        )
                      : Text(
                          " ",
                          style: TextStyle(fontSize: 18.0),
                        ),
                  trailing: FlatButton(
                    child: Text(
                      'EDIT',
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => EditLastName(
                                    lastname: this.lastname,
                                  )));
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200.0,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blueGrey,
                        child: Text(
                          'RESET PASSWORD',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ResetPass(
                                        email: email,
                                      )));
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            body: Center(
              child: Image(image: AssetImage('assets/meditation.gif')),
            ),
          );
  }
}
