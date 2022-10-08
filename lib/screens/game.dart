import 'dart:async';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';
import 'package:to_mime/providers/player.dart';
import 'package:to_mime/providers/players.dart';
import 'package:to_mime/widgets/utils/confirm_dialog.dart';
import '../widgets/utils/cartoon_text.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  String _screenPoints = '1000';
  String _screenName = 'JORDInito';
  int _indexPlayer = 0;
  int _numCard = 0;
  List<String> _cardImages = [
    'assets/started_pack/chick.png',
    'assets/started_pack/hammer.png',
    'assets/started_pack/plane.png',
    'assets/started_pack/chicken.png',
    'assets/started_pack/football_ball.png',
    'assets/started_pack/car.png',
    'assets/started_pack/chainsaw.png',
  ];
  CardController _controllerCard;
  // FlipCardController _controllerFlipCard;
  Timer _timer;
  int _seconds = 30;
  Image _gameMode;
  bool _gameModeGestures = true;
  bool _gameModeSounds = true;
  double _opacityDone = 0.0;
  double _opacityClose = 0.0;
  // bool _swipeEnabled;
  bool _flipEnabled;
  List<Player> _playersSolve = [];

  @override
  void initState() {
    super.initState();
    _controllerCard = CardController();
    // _controllerFlipCard = FlipCardController();
    // _swipeEnabled = false;
    _flipEnabled = true;
    Future.delayed(Duration.zero, (() => _getFormData(context)));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void showConfirmDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //_getFormData(context);
    final _playersData = Provider.of<Players>(context);

    final _players = _playersData.players;
    _screenName = _players[_indexPlayer].name;
    _screenPoints = _players[_indexPlayer].points.toString();
    //startTimer();
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/backgrounds/sky1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  30,
                  mediaQuery.size.height * 0.07,
                  30,
                  mediaQuery.size.height * 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CartoonText(
                      text: "$_seconds",
                      textSize: 70.0,
                    ),
                  ],
                ),
              ),
              Stack(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    mediaQuery.size.height * 0.560,
                    0,
                    mediaQuery.size.height * 0.020,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CartoonText(
                            text: "PLAYER: ",
                            textSize: 30.0,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              mediaQuery.size.height * 0.015,
                              0,
                              0,
                              0,
                            ),
                            child: CartoonText(
                              text: _screenName,
                              textSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, mediaQuery.size.height * 0.025, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CartoonText(
                              text: "POINTS: ",
                              textSize: 30.0,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                mediaQuery.size.height * 0.020,
                                0,
                                0,
                                0,
                              ),
                              child: CartoonText(
                                text: _screenPoints,
                                textSize: 30.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 435,
                  child: TinderSwapCard(
                    allowVerticalMovement: true,
                    orientation: AmassOrientation.BOTTOM,
                    cardBuilder: (context, index) => FlipCard(
                      key: Key('flip$index'),
                      flipOnTouch: _flipEnabled,
                      back: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: !_flipEnabled
                                  //     ? Border.all(color: Colors.black)
                                  //     : null,
                                  // border: Border.all(color: Colors.black),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Image.asset(
                                    '${_cardImages[index]}',
                                    fit: BoxFit.fill,
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  mediaQuery.size.width * 0.045,
                                  mediaQuery.size.width * 0.045,
                                  0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Icon(
                                  //   _gameMode,
                                  //   size: mediaQuery.size.width * 0.15,
                                  //   color: Colors.white,
                                  // ),
                                  IconButton(
                                    icon: _gameMode,
                                    iconSize: 44,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       Stack(children: [
                            //         Icon(
                            //           Icons.close_rounded,
                            //           size: mediaQuery.size.width * 0.75,
                            //           color:
                            //               Colors.red.withOpacity(_opacityClose),
                            //         ),
                            //         Icon(
                            //           Icons.check_rounded,
                            //           size: mediaQuery.size.width * 0.75,
                            //           color: Colors.green
                            //               .withOpacity(_opacityDone),
                            //         ),
                            //       ]),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      // ),
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      front: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black),
                            // border: _flipEnabled
                            //     ? Border.all(color: Colors.black)
                            //     : null,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                color: Color.fromRGBO(0, 180, 255, 1),
                                padding: EdgeInsets.all(48.0),
                                child: Image.asset(
                                  'assets/icon/to_mime_icon_without_background.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      direction: FlipDirection.HORIZONTAL,
                      speed: 1000,
                      onFlipDone: (status) {
                        _startTimer();
                        setState(() {
                          _flipEnabled = false;
                        });
                      },
                    ),
                    totalNum: _cardImages.length,
                    stackNum: 4,
                    swipeEdge: 4.0,
                    maxWidth: mediaQuery.size.width * 0.9,
                    maxHeight: mediaQuery.size.width * 0.9,
                    minWidth: mediaQuery.size.width * 0.8,
                    minHeight: mediaQuery.size.width * 0.8,
                    cardController: _controllerCard,
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      // _setOpacityIcons(align.x); TODO
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      if (orientation == CardSwipeOrientation.RIGHT) {
                        print('Card swiped to the right.');
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.green,
                          content: Container(
                            height: mediaQuery.size.height * 0.030,
                            child: Text(
                              "CORRECT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: 'LuckiestGuy'),
                            ),
                          ),
                          duration: Duration(milliseconds: 1000),
                          behavior: SnackBarBehavior.fixed,
                        ));
                        _players[_indexPlayer].points += 50;
                        _showListPlayersSolve(_playersData);
                        //_startTimer();
                        setState(() {
                          _timer.cancel();
                          _updatePlayer(_players);
                          _updateGameMode();
                          _opacityClose = 0.0;
                          _opacityDone = 0.0;
                          _flipEnabled = true;
                          print('Current player: ${_screenName.toUpperCase()}');
                        });
                      } else if (orientation == CardSwipeOrientation.LEFT) {
                        print('Card swiped to the left.');
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                          backgroundColor: Colors.red,
                          content: Container(
                            height: mediaQuery.size.height * 0.030,
                            child: Text(
                              "INCORRECT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: 'LuckiestGuy'),
                            ),
                          ),
                          duration: Duration(milliseconds: 1000),
                          behavior: SnackBarBehavior.fixed,
                        ));
                        setState(() {
                          _updatePlayer(_players);
                          _updateGameMode();
                          _opacityClose = 0.0;
                          _opacityDone = 0.0;
                          _flipEnabled = true;
                          print('Current player: ${_screenName.toUpperCase()}');
                          if (_numCard == _cardImages.length) {
                            Navigator.pushNamed(context, '/end',
                                arguments: _players);
                          } else {
                            _restartTimer(30);
                          }
                        });
                      }
                    },
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer({int seconds = 30}) {
    const oneSec = const Duration(seconds: 1);
    _restartTimer(seconds);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds <= 0) {
          setState(() {
            _controllerCard.triggerLeft();
            timer.cancel();
          });
        } else {
          setState(() {
            _seconds--;
            //print('Time left: ' + seconds.toString());
          });
        }
      },
    );
  }

  void _restartTimer(int seconds) {
    if (_timer != null) {
      _timer.cancel();
      setState(() {
        _seconds = seconds;
      });
    }
  }

  void _updatePlayersSolve(players) {
    _playersSolve.clear();
    for (int i = 0; i < players.length; i++) {
      if (players[i].name != _screenName) {
        _playersSolve.add(players[i]);
        print(
            'Player ${players[i].name} added to playersSolve (screenName = $_screenName).');
      }
    }
  }

  void _showListPlayersSolve(playersData) {
    _updatePlayersSolve(playersData.players);
    print('$_playersSolve');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(0, 180, 255, 1),
            title: Text(
              'Who has solved it?',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontFamily: 'LuckiestGuy', color: Colors.grey[900]),
            ),
            content: _setupAlertDialoadContainer(playersData),
          );
        });
  }

  void _updatePlayer(players) async {
    _indexPlayer++;
    if (_indexPlayer >= players.length) {
      _indexPlayer = 0;
    }
    _screenName = players[_indexPlayer].name;
    _screenPoints = players[_indexPlayer].points.toString();
    _numCard++;
  }

  ///   A list of players that solved the puzzle.
  Widget _setupAlertDialoadContainer(playersData) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: new ListView.builder(
        itemCount: _playersSolve.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                print(
                    'You have pressed the player ${_playersSolve[index].name}');
                playersData.updatePlayerPointsByName(_playersSolve[index].name);
                _playersSolve = [];
                Navigator.pop(context);
                if (_numCard == _cardImages.length) {
                  Navigator.pushNamed(context, '/end');
                } else {
                  _restartTimer(30);
                }
              },
              title: Text(
                _playersSolve[index].name.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'LuckiestGuy', color: Colors.grey[800]),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/icon/blank_profile.png'),
              ),
            ),
          );
        },
      ),
    );
  }

  Image _getRandomGameMode() {
    int _randomNumber = Random().nextInt(2);
    //print(_randomNumber);
    switch (_randomNumber) {
      case 0:
        return Image.asset('assets/icon/arms_up2.png');
        break;
      case 1:
        return Image.asset('assets/icon/music.png');
        break;
      default:
        print("_getRandomGameMode() -> ERROR");
        return Image.asset('assets/icon/arms_up2.png');
    }
  }

  void _updateGameMode() {
    setState(() {
      if (_gameModeGestures && !_gameModeSounds) {
        //_gameMode = IconData(0xf51b, fontFamily: 'MaterialIcons');
        _gameMode = Image.asset('assets/icon/arms_up2.png');
        print("Gestures mode!");
      } else if (!_gameModeGestures && _gameModeSounds) {
        // _gameMode = IconData(0xf8ed, fontFamily: 'MaterialIcons');
        _gameMode = Image.asset('assets/icon/music.png');
        print("Sounds mode!");
      } else {
        _gameMode = _getRandomGameMode();
      }
      // print(_gameMode.toString());
    });
  }

  void _getFormData(BuildContext context) {
    Map _formData = ModalRoute.of(context).settings.arguments;
    // print(_formData);
    setState(() {
      _gameModeGestures = _formData["gamemode"]["gestures"];
      _gameModeSounds = _formData["gamemode"]["sounds"];
      //_players = _formData["players"];
    });
    // print(_gameModeGestures);
    // print(_gameModeSounds);
    // print(_players);
    _updateGameMode();
  }

  void _setOpacityIcons(double xValue) {
    double _opacity = xValue / 10;
    if (xValue > 0) {
      //print('Card is going to the right.');
      if (_opacity > 1) {
        _opacity = 1;
      }
      setState(() {
        _opacityDone = _opacity;
      });
      //print(_opacityDone);
    } else if (xValue < 0) {
      //print('Card is going to the left.');
      _opacity *= -1;
      if (_opacity > 1) {
        _opacity = 1;
      }
      setState(() {
        _opacityClose = _opacity;
      });
      //print(_opacityClose);
    } else {
      setState(() {
        _opacityClose = 0.0;
        _opacityDone = 0.0;
      });
    }
  }
}
