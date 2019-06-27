import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audio/audio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AudioPlayerDemo extends StatefulWidget {
  final String url;
  final int time;

  AudioPlayerDemo(this.url, this.time);

  @override
  State<StatefulWidget> createState() => AudioPlayerDemoState();
}

class AudioPlayerDemoState extends State<AudioPlayerDemo> {
  int totaltime, sessioncompleted, averageduration;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Audio audioPlayer = new Audio(single: true);
  AudioPlayerState state = AudioPlayerState.STOPPED;
  double position = 0;
  StreamSubscription<AudioPlayerState> _playerStateSubscription;
  StreamSubscription<double> _playerPositionController;
  StreamSubscription<int> _playerBufferingSubscription;
  StreamSubscription<AudioPlayerError> _playerErrorSubscription;

  checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Internet lost'),
              content: Text(
                  'Sorry, Please ckeck your internet connection and then try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  onPressed: () {
                    checkConnectivity();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    } else if (result == ConnectivityResult.mobile) {
    } else if (result == ConnectivityResult.wifi) {}
  }

  bool visiblejpg = true;

  var visiblegif = false;

  var isVisible;
  int timeCounter = 0;

  ScrollController controller;

  @override
  void initState() {
    checkConnectivity();

    _auth.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((documentsnapshot) {
        print('                                               userid: ' +
            user.uid);
        setState(() {
          this.totaltime = documentsnapshot['totaltime'];
          this.sessioncompleted = documentsnapshot['sessioncompleted'];
          this.averageduration = documentsnapshot['averageduration'];
          print(
              'totaltime : $totaltime    sessioncompleted: $sessioncompleted   averageduration: $averageduration');
        });
      });
    });

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

    _playerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      print("onPlayerStateChanged: ${audioPlayer.uid} $state");

      if (mounted) setState(() => this.state = state);
    });

    _playerPositionController =
        audioPlayer.onPlayerPositionChanged.listen((double position) {
      print(
          "onPlayerPositionChanged: ${audioPlayer.uid} $position ${audioPlayer.duration}");

      if (mounted) setState(() => this.position = position);
    });

    _playerBufferingSubscription =
        audioPlayer.onPlayerBufferingChanged.listen((int percent) {
      print("onPlayerBufferingChanged: ${audioPlayer.uid} $percent");
    });

    _playerErrorSubscription =
        audioPlayer.onPlayerError.listen((AudioPlayerError error) {
      throw ("onPlayerError: ${error.code} ${error.message}");
    });

    audioPlayer.preload(widget.url);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget status = Container();

    print(
        "[build] uid=${audioPlayer.uid} duration=${audioPlayer.duration} state=$state");

    switch (state) {
      case AudioPlayerState.LOADING:
        {
          status = Container(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2.0)),
                  width: 24.0,
                  height: 24.0));

          break;
        }

      case AudioPlayerState.PLAYING:
        {
          status = IconButton(
              icon: Icon(Icons.pause, color: Colors.white, size: 28.0),
              onPressed: onPause);
          break;
        }

      case AudioPlayerState.READY:
      case AudioPlayerState.PAUSED:
      case AudioPlayerState.STOPPED:
        {
          status = IconButton(
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 28.0),
              onPressed: onPlay);

          if (state == AudioPlayerState.STOPPED) {
            audioPlayer.seek(0.0);

            setState(() {
              visiblegif = false;
              visiblejpg = true;
            });

            timeCounter = (timeCounter + 1);
            if ((timeCounter) % 2 == 0) {
              print(
                  '..........................................................................total time: $totaltime');
              totaltime = totaltime + widget.time;
              sessioncompleted = (sessioncompleted + 1);
              averageduration = (totaltime / sessioncompleted).round();

              print(
                  'totaltime : $totaltime    sessioncompleted: $sessioncompleted   averageduration: $averageduration');

              _auth.currentUser().then((user) {
                Firestore.instance
                    .collection('users')
                    .document(user.uid)
                    .setData({
                  'totaltime': totaltime,
                  'sessioncompleted': sessioncompleted,
                  'averageduration': averageduration,
                }, merge: true);
              });
            }
          }

          break;
        }
    }

    return state != AudioPlayerState.LOADING
        ? Scaffold(
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
                    onPause();
                    audioPlayer.stop();
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            body: Container(
              color: Colors.black,
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment(0, 0),
                    child: Visibility(
                        visible: visiblejpg,
                        child: Image(
                          image: AssetImage('assets/circleImage.jpg'),
                        )),
                  ),
                  Container(
                    alignment: Alignment(0, 0),
                    child: Visibility(
                        visible: visiblegif,
                        child: Image(
                          image: AssetImage('assets/circleLoading.gif'),
                        )),
                  ),
                  Container(alignment: Alignment(0, 0), child: status),
                  Container(
                    alignment: Alignment(0, -0.7),
                    child: Text(
                      '${((audioPlayer.duration / 1000) / 60).round()} Min',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 400, left: 100, right: 100),
                    child: Slider(
                      activeColor: Colors.white,
                      max: audioPlayer.duration.toDouble(),
                      value: position.toDouble(),
                      onChanged: onSeek,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Color(0xffFFFFF7),
            body: Center(
              child: Image(image: AssetImage('assets/meditation.gif')),
            ),
          );
  }

  @override
  void dispose() {
    _playerStateSubscription.cancel();
    _playerPositionController.cancel();
    _playerBufferingSubscription.cancel();
    _playerErrorSubscription.cancel();
    audioPlayer.release();

    super.dispose();
  }

  onPlay() {
    audioPlayer.play(widget.url);
    setState(() {
      visiblegif = true;
      visiblejpg = false;
    });
  }

  onPause() {
    audioPlayer.pause();
    setState(() {
      visiblegif = false;
      visiblejpg = true;
    });
  }

  onSeek(double value) {
    // Note: We can only seek if the audio is ready
    audioPlayer.seek(value);
  }
}
