import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meditation/Advanced.dart';
import 'package:meditation/Basics.dart';
import 'package:meditation/Breathing.dart';

import 'package:meditation/Intermediate.dart';
import 'package:meditation/breathsoundbody.dart';
import 'package:meditation/lovingkindness.dart';
import 'package:story_view/story_view.dart';
import 'package:meditation/main.dart';
import 'package:meditation/person.dart';

class TabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
    controller.addListener(_handleTabSelection);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    MediaQueryData media = MediaQuery.of(context);
    var size = media.size;
    return Scaffold(
      backgroundColor: Color(0xffFFFFF7),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12.0, top: 30.0, right: 12.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    'Medimate',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
                Container(
                  height: 300,
                  child: StoryView(
                    [
                      StoryItem.inlineImage(
                        AssetImage('assets/descrip1.png'),
                      ),
                      StoryItem.inlineImage(
                        AssetImage('assets/descrip2.jpg'),
                      ),
                      StoryItem.inlineImage(
                        AssetImage('assets/descript3.jpg'),
                      ),
                      StoryItem.inlineImage(
                        AssetImage('assets/discrip4.jpg'),
                      ),
                    ],
                    onStoryShow: (s) {
                      print("Showing a story");
                    },
                    onComplete: () {
                      print("Completed a cycle");
                    },
                    progressPosition: ProgressPosition.bottom,
                    repeat: false,
                    inline: true,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 170.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Breathing()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/breathing.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Breathing',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '6 MIN',
                                style: TextStyle(),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BreathSoundBody()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/breathesoundbody.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('Breathe, Sound & Body',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('12 MIN')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LovingKindness()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 150.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/lovingkindness.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('Loving and Kindness',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('9 MIN')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    'My Courses',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            'assets/basicmeditation.jpg',
                            height: 75.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment(0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 35.0,
                              left: 0.0,
                            ),
                            child: Text(
                              'Basics',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          alignment: Alignment(0.9, 0),
                          child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Basics())),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Icon(Icons.keyboard_arrow_right),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1, 0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/intermidiatemeditaion.jpg',
                            height: 75.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Container(
                          alignment: Alignment(0, 0),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 35.0, left: 40.0),
                            child: Text(
                              'Intermediate',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          alignment: Alignment(0.9, 0),
                          child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Intermediate())),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Icon(Icons.keyboard_arrow_right),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1, 0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/advancemeditation.jpg',
                            height: 75.0,
                            width: 120.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      Container(
                          alignment: Alignment(0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 35.0, left: 20),
                            child: Text(
                              'Advanced',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          alignment: Alignment(0.9, 0),
                          child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Advanced())),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Icon(Icons.keyboard_arrow_right),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
