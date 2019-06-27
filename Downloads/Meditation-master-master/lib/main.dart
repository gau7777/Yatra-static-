import 'package:flutter/material.dart';
import 'package:meditation/signup.dart';
import 'package:meditation/welcome.dart';
import 'home.dart';
import 'person.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(accentColor: Colors.white),
      home: Splash(),
      debugShowCheckedModeBanner: false));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white10,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  String firstname;
  FirebaseAuth _auth = FirebaseAuth.instance;

  int curIndex = 0;
  TabScreen p1 = new TabScreen();
  Person p2 = new Person();
  List<Widget> Pages;
  Widget currentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pages = [p1, p2];
    currentPage = p1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((snapshots) {
        setState(() {
          this.firstname = snapshots['firstname'];
        });
      });
    });
    return firstname != null
        ? Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            bottomNavigationBar: new BottomNavigationBar(
                backgroundColor: Color(0xffFFFFF7),
                type: BottomNavigationBarType.fixed,
                currentIndex: curIndex,
                onTap: (int index) {
                  setState(() {
                    curIndex = index;
                    currentPage = Pages[index];
                  });
                },
                items: [
                  new BottomNavigationBarItem(
                      backgroundColor: Color(0xffFFFFF7),
                      icon: Icon(
                        Icons.home,
                        color: curIndex == 0 ? Colors.blueGrey : Colors.grey,
                      ),
                      title: new Text('Home',
                          style: new TextStyle(
                              fontSize: 12.0,
                              color: curIndex == 0
                                  ? Colors.blueGrey
                                  : Colors.grey))),
                  new BottomNavigationBarItem(
                      backgroundColor: Color(0xffFFFFF7),
                      icon: Icon(
                        Icons.person,
                        color: curIndex == 1 ? Colors.blueGrey : Colors.grey,
                      ),
                      title: new Text(firstname,
                          style: new TextStyle(
                              fontSize: 12.0,
                              color: curIndex == 1
                                  ? Colors.blueGrey
                                  : Colors.grey))),
                ]),
            body: currentPage,
          )
        : Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            body: Center(
              child: Image(image: AssetImage('assets/meditation.gif')),
            ),
          );
  }
}
