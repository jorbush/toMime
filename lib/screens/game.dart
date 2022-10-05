import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import '../models/player.dart';
import '../widgets/cartoon_text.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  String _screenPoints = '1000';
  String _screenName = 'JORDInito';
  int _indexPlayer = 0;
  int _numCard = 0;
  List<Player> _players;
  List<Player> _playersSolve = [];
  List<String> _cardImages = [
    'assets/chick.jpeg',
    'assets/hammer.jpg',
    'assets/plane.jpg',
    'assets/chicken.jpg',
    'assets/ball.jpg',
    'assets/car.jpg',
    'assets/chainsaw.jpeg',
  ];
  CardController _controller;
  Timer _timer;
  int seconds = 30;
  Image _gameMode;
  bool _gameModeGestures = true;
  bool _gameModeSounds = true;
  double _opacityDone = 0.0;
  double _opacityClose = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, (() => _getFormData(context)));
    _startTimer();
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //_getFormData(context);
    _screenName = _players[_indexPlayer].name;
    _screenPoints = _players[_indexPlayer].points.toString();
    //startTimer();
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/sky1.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  30,
                  mediaQuery.size.height * 0.025,
                  30,
                  mediaQuery.size.height * 0.015,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CartoonText(
                      text: "$seconds",
                      textSize: 70.0,
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
                  cardBuilder: (context, index) => Card(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(children: [
                                Icon(
                                  Icons.close_rounded,
                                  size: mediaQuery.size.width * 0.75,
                                  color: Colors.red.withOpacity(_opacityClose),
                                ),
                                Icon(
                                  Icons.check_rounded,
                                  size: mediaQuery.size.width * 0.75,
                                  color: Colors.green.withOpacity(_opacityDone),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  totalNum: _cardImages.length,
                  stackNum: 4,
                  swipeEdge: 4.0,
                  maxWidth: mediaQuery.size.width * 0.9,
                  maxHeight: mediaQuery.size.width * 0.9,
                  minWidth: mediaQuery.size.width * 0.8,
                  minHeight: mediaQuery.size.width * 0.8,
                  cardController: _controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    double _opacity = align.x / 10;
                    if (align.x > 0) {
                      //print('Card is going to the right.');
                      if (_opacity > 1) {
                        _opacity = 1;
                      }
                      setState(() {
                        _opacityDone = _opacity;
                      });
                      //print(_opacityDone);
                    } else if (align.x < 0) {
                      //print('Card is going to the left.');
                      _opacity *= -1;
                      if (_opacity > 1) {
                        _opacity = 1;
                      }
                      setState(() {
                        _opacityClose = _opacity;
                      });
                      //print(_opacityClose);
                    } else if (align.x == 0) {
                      setState(() {
                        _opacityClose = 0.0;
                        _opacityDone = 0.0;
                      });
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    if (orientation == CardSwipeOrientation.RIGHT) {
                      print('Card swiped to the right.');
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.green,
                        content: Container(
                          height: 20,
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
                      _showListPlayersSolve();
                      //_startTimer();
                      setState(() {
                        _timer.cancel();
                        _updatePlayer();
                        _updateGameMode();
                        _opacityClose = 0.0;
                        _opacityDone = 0.0;
                        print('Current player: ${_screenName.toUpperCase()}');
                      });
                    } else if (orientation == CardSwipeOrientation.LEFT) {
                      print('Card swiped to the left.');
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Colors.red,
                        content: Container(
                          height: 20,
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
                        _updatePlayer();
                        _updateGameMode();
                        _opacityClose = 0.0;
                        _opacityDone = 0.0;
                        print('Current player: ${_screenName.toUpperCase()}');
                        if (_numCard == _cardImages.length) {
                          Navigator.pushNamed(context, '/end',
                              arguments: _players);
                        } else {
                          restartTimer(30);
                        }
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  mediaQuery.size.height * 0.035,
                  0,
                  mediaQuery.size.height * 0.020,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CartoonText(text: "PLAYER: ", textSize: 30.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          mediaQuery.size.height * 0.015, 0, 0, 0),
                      child: CartoonText(
                        text: _screenName,
                        textSize: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartoonText(text: "POINTS: ", textSize: 30.0),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                        mediaQuery.size.height * 0.020,
                        0,
                        0,
                        0,
                      ),
                      child: CartoonText(text: _screenPoints, textSize: 30.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds <= 0) {
          setState(() {
            _controller.triggerLeft();
            timer.cancel();
          });
        } else {
          setState(() {
            seconds--;
            //print('Time left: ' + seconds.toString());
          });
        }
      },
    );
  }

  void restartTimer(_seconds) {
    _timer.cancel();
    seconds = _seconds;
    _startTimer();
  }

  void _updatePlayersSolve() {
    _playersSolve.clear();
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].name != _screenName) {
        _playersSolve.add(_players[i]);
        print(
            'Player ${_players[i].name} added to playersSolve (screenName = $_screenName).');
      }
    }
  }

  void _showListPlayersSolve() {
    _updatePlayersSolve();
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
            content: _setupAlertDialoadContainer(),
          );
        });
  }

  void _updatePlayer() async {
    _indexPlayer++;
    if (_indexPlayer >= _players.length) {
      _indexPlayer = 0;
    }
    _screenName = _players[_indexPlayer].name;
    _screenPoints = _players[_indexPlayer].points.toString();
    _numCard++;
  }

  void _updatePlayerPointsByName(String name) {
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].name == _screenName) {
        _players[i].points += 100;
        print(
            'Now player ${_players[i].name} has ${_players[i].points} points.');
      }
    }
  }

  ///   A list of players that solved the puzzle.
  Widget _setupAlertDialoadContainer() {
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
                _updatePlayerPointsByName(_playersSolve[index].name);
                _playersSolve = [];
                Navigator.pop(context);
                if (_numCard == _cardImages.length) {
                  Navigator.pushNamed(context, '/end', arguments: _players);
                } else {
                  restartTimer(31);
                }
              },
              title: Text(
                _playersSolve[index].name.toUpperCase(),
                style: TextStyle(
                    fontFamily: 'LuckiestGuy', color: Colors.grey[800]),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/blank_profile.png'),
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
      _players = _formData["players"];
    });
    // print(_gameModeGestures);
    // print(_gameModeSounds);
    // print(_players);
    _updateGameMode();
  }
}
