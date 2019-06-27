import 'package:flutter/material.dart';
import 'package:meditation/PersonJourney.dart';
import 'package:meditation/PersonSettings.dart';
import 'package:meditation/PersonStats.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Person extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonState();
  }
}

class _PersonState extends State<Person> with SingleTickerProviderStateMixin {
  TabController controller;

  String firstname;
  FirebaseAuth _auth = FirebaseAuth.instance;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 1);
    controller.addListener(_handleTabSelection);


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _auth.currentUser().then((user) {
      Firestore.instance
          .collection("users")
          .document(user.uid)
          .get()
          .then((snapshot) {
        setState(() {
          this.firstname = snapshot['firstname'];
        });
      });
      print("userid:" + user.uid);
    });
    return firstname != null
        ? Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            body: Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Color(0xffFFFFF7),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 15.0, right: 15.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20.0,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/user.jpg',
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            firstname != null
                                ? Text(firstname,
                                    style: TextStyle(fontSize: 20.0))
                                : Text(""),
                            IconButton(
                              alignment: Alignment.centerRight,
                              icon: Icon(Icons.settings,color: Colors.blueGrey,),
                              iconSize: 27.0,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PersonSettings()));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TabBar(
                        labelColor: Colors.blueGrey,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blueGrey,
                        controller: controller,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'My  Stats',
                              style: TextStyle(
                                  color: (controller.index == 0)
                                      ? Colors.blueGrey
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller,
                    children: <Widget>[PersonStats()],
                  ),
                ),
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
