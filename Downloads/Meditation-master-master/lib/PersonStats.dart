import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:share/share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonStatsState();
  }
}

class PersonStatsState extends State<PersonStats> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  int totaltime, sessioncompleted, averageduration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((documentsnapshot) {
        setState(() {
          this.totaltime = documentsnapshot['totaltime'];
          this.sessioncompleted = documentsnapshot['sessioncompleted'];
          this.averageduration = documentsnapshot['averageduration'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return totaltime != null &&
            averageduration != null &&
            sessioncompleted != null
        ? Scaffold(
        backgroundColor: Color(0xffFFFFF7),
            body: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.av_timer,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'TOTAL TIME MEDITATED',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text('$totaltime',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'MINUTES',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.headset,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'SESSIONS COMPLETED',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text('$sessioncompleted',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'SESSIONS',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.timer,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'AVERAGE DURATION',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: <Widget>[
                      Text('$averageduration',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'MINUTES',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, top: 20.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('BUDDIES',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.blueGrey)),
                    IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blueGrey,
                        iconSize: 25.0,
                        onPressed: () {
                          final RenderBox box = context.findRenderObject();
                          Share.share(
                              'https://www.youtube.com/watch?v=m60bi4SqQ1U',
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size);
//                          Navigator.pop(context);
                        })
                  ],
                ),
              )
            ]))
        : Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            body: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
              ),
            ),
          );
  }
}
