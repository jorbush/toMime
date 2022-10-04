import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:to_mime/models/player.dart';
import 'package:to_mime/widgets/cartoon_text.dart';

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
  IconData _gameMode;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _gameMode = IconData(0xf51b, fontFamily: 'MaterialIcons');
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
            print('Time left: ' + seconds.toString());
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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

  void showListPlayersSolve() {
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

  /// _setupAlertDialoadContainer() is a function that returns a Container widget that contains a
  /// ListView.builder widget that contains a Card widget that contains a ListTile widget that contains
  /// a Text widget that contains a CircleAvatar widget
  ///
  /// Returns:
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

  IconData _getRandomGameMode() {
    int _randomNumber = Random().nextInt(2);
    print(_randomNumber);
    switch (_randomNumber) {
      case 0:
        return IconData(0xf51b, fontFamily: 'MaterialIcons');
        break;
      case 1:
        return IconData(0xf8ed, fontFamily: 'MaterialIcons');
        break;
      default:
        print("_getRandomGameMode() -> ERROR");
    }
  }

  void _updateGameMode() {
    setState(() {
      _gameMode = _getRandomGameMode();
      print(_gameMode.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    _players = ModalRoute.of(context).settings.arguments;
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
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 15),
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
                height: MediaQuery.of(context).size.height - 360,
                child: TinderSwapCard(
                  //allowVerticalMovement: false,
                  orientation: AmassOrientation.BOTTOM,
                  cardBuilder: (context, index) => Card(
                    child: Column(
                      children: [
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Image.asset('${_cardImages[index]}'),
                            height: MediaQuery.of(context).size.height * 0.44,
                          ),
                          Icon(
                            _gameMode,
                          ),
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.close,
                              size: 80,
                              color: Colors.red,
                            ),
                            Icon(
                              Icons.check,
                              size: 80,
                              color: Colors.green,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  totalNum: _cardImages.length,
                  stackNum: 3,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.85,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.65,
                  minHeight: MediaQuery.of(context).size.height * 0.65,
                  cardController: _controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    if (align.x > 0) {
                      //print('Card is going to the right.');
                    } else if (align.x < 0) {
                      //print('Card is going to the left.');
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
                      showListPlayersSolve();
                      //_startTimer();
                      setState(() {
                        _timer.cancel();
                        _updatePlayer();
                        _updateGameMode();
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
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CartoonText(text: "PLAYER: ", textSize: 30.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: CartoonText(text: _screenName, textSize: 30.0),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartoonText(text: "POINTS: ", textSize: 30.0),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: CartoonText(text: _screenPoints, textSize: 30.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
