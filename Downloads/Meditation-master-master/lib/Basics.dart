import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/widgets.dart';
import 'package:meditation/Bodyscan.dart';
import 'package:meditation/Bodysound.dart';
import 'package:meditation/Breathing.dart';

class Basics extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BasicsState();
  }
}

class BasicsState extends State<Basics> {
  ScrollController controller;
  bool isVisible;
  bool visible;

  // Widget pause() {
  //   Widget pause = IconButton(
  //     icon: Icon(
  //       Icons.check,
  //       size: 50.0,
  //       color: Colors.green[400],
  //     ),
  //     onPressed: () {
  //       setState(() {
  //         visible = !visible;
  //       });
  //     },
  //   );
  //   return pause;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visible = true;
    isVisible = true;
    controller = new ScrollController();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          isVisible = false;
        });
      }
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffFFFFF7),
      appBar: null,
      floatingActionButton: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 130.0),
          child: FloatingActionButton(
            elevation: 10,
            child: BackButton(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // bottomNavigationBar:
      //     new BottomNavigationBar(type: BottomNavigationBarType.fixed, items: [
      //   new BottomNavigationBarItem(
      //     backgroundColor: Colors.white,
      //     icon: SizedBox(
      //       height: 50.0,
      //       width: 50.0,
      //       child: RaisedButton(
      //         elevation: 0.0,
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(21.0)),
      //         color: Colors.blueGrey,
      //         child: Text(
      //           'BEGIN COURSE',
      //           style: TextStyle(color: Colors.white, fontSize: 15.0),
      //         ),
      //         onPressed: () {},
      //       ),
      //     ),
      //   )
      // ]),
      body: ListView(
        shrinkWrap: true,
        controller: controller,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/basicmeditation.jpg',
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 50.0,
                  child: Text(
                    'Basics',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    '3 - 6 MIN',
                    style: TextStyle(color: Colors.black45, fontSize: 17.0),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    'Live happier and healthier by learning the fundamentals of meditation',
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sessions',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 180.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BodyAndScan()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 170.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/bodyscan.jpeg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Body & Scan Meditation',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                '3 MIN',
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
                                      BodyAndSound()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 170.0,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 100.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/bodysound.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('Body & Sound Meditation',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('3 MIN')
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
                                      Breathing()));
                        },
                        child: Container(
                          height: 150.0,
                          width: 170.0,
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
                              Text('Breathing Meditation',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text('6 MIN')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
