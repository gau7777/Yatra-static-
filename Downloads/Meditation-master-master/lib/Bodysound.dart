import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/widgets.dart';
import 'audioplayer.dart';

class BodyAndSound extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BodyAndSoundState();
  }
}

class BodyAndSoundState extends State<BodyAndSound> {
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
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/bodysound.jpg',
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
                  height: 80.0,
                  child: Text(
                    'Body & Sound Meditation',
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
                    '3 MIN',
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
                  height: 40.0,
                ),

                Container(
                  height: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 30.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      color: Colors.blueGrey,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.play_arrow,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AudioPlayerDemo(
                                    'https://firebasestorage.googleapis.com/v0/b/flutterwithfirebase-86c29.appspot.com/o/Body-Sound-Meditation.mp3?alt=media&token=31f9a965-f893-4691-9f0d-0c55cb6103ec',3)));
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
