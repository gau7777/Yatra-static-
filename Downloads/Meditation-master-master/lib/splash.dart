import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'welcome.dart';
import 'main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Internet lost'),
              content: Text(
                  'Sorry, Please ckeck your internet connection and then try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK',style: TextStyle(color: Colors.blueGrey),),
                  onPressed: () {
                    checkConnectivity();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => MyApp()));
    } else if (result == ConnectivityResult.wifi) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => MyApp()));
    }
  }

  FirebaseUser user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.currentUser().then((user) {
      if (user != null) {
        Future.delayed(Duration(seconds: 4), () {
          checkConnectivity();
        });
      } else {
        Future.delayed(Duration(seconds: 4), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Welcome()));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFF7),
      body: Center(
        child: Container(
           color: Color(0xffFFFFF7),
          child: Image(image: AssetImage('assets/meditation.gif')),
        ),
      ),
    );
  }
}
