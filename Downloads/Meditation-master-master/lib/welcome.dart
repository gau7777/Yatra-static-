import 'package:flutter/material.dart';
import 'package:meditation/login.dart';
import 'package:meditation/signup.dart';
import 'splash.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomeState();
  }
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Color(0xffFFFFF7),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Align(
                alignment: Alignment(0,5),
                child: Image.asset('assets/meditation.gif')),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200.0,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 70.0,
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          color: Colors.blueGrey,
                          child: Text(
                            'CREATE  ACCOUNT',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SignUp()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 20.0, right: 10.0),
                      child: SizedBox(
                        height: 70.0,
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side:
                                BorderSide(color: Colors.blueGrey, width: 2.0),
                          ),
                          color: Color(0xffFFFFF7),
                          child: Text(
                            'ALREADY HAVE AN ACCOUNT ?',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 15.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
