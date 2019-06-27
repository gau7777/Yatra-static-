import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:meditation/AccountSettings.dart';
import 'package:meditation/policy.dart';
import 'package:meditation/tc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';

class PersonSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonSettingsState();
  }
}

class PersonSettingsState extends State<PersonSettings> {
  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.currentUser().then((user){
      this.user = user;
    });

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
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffFFFFF7),
      ),
      backgroundColor: Color(0xffFFFFF7),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Text(
              'Account Settings',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => AccountSettings()));
            },
          ),
          ListTile(
            leading: Text(
              'Terms & Conditions',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TermsConditions()));
            },
          ),
          ListTile(
            leading: Text(
              'Privacy Policy',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Policy()));
            },
          ),
          Expanded(
            child: Container(
              height: 200.0,
              width: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Logged in as',
                      style: TextStyle(color: Colors.blueGrey)),
                  Text(
                    'kaushal.deligence@gmail.com',
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Version 3.0.1',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 70.0,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blueGrey,
                      child: Text(
                        'LOG OUT',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onPressed: () {
                       _auth.signOut();
                       Navigator.pop(context);
                       Navigator.pop(context);
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Welcome()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
