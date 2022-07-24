import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:to_mime/Player.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  String screenPoints = '1000';
  String screenName = 'JORDInito';
  int indexPlayer = 0;
  int numCard = 0;
  List<Player> players;
  List<Player> playersSolve = [];
  List<String> cardImages = [
    'assets/chicken.jpg',
    'assets/ball.jpg',
    'assets/plane.jpg',
    'assets/car.jpg',
    'assets/chainsaw.jpg'
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Timer _timer;
  int seconds = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds <= 0) {
          setState(() {
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

  void restartTimer() {
    _timer.cancel();
    seconds = 30;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    CardController controller;
    players = ModalRoute.of(context).settings.arguments;
    screenName = players[indexPlayer].name;
    screenPoints = players[indexPlayer].points.toString();
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
                padding: const EdgeInsets.fromLTRB(30, 90, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "$seconds",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 70.0,
                              fontFamily: 'LuckiestGuy'),
                        ),
                        Text(
                          "$seconds",
                          style: TextStyle(
                              fontSize: 70.0,
                              fontFamily: 'LuckiestGuy',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 435,
                child: TinderSwapCard(
                  orientation: AmassOrientation.BOTTOM,
                  cardBuilder: (context, index) => Card(
                    child: Image.asset('${cardImages[index]}'),
                  ),
                  totalNum: 5,
                  stackNum: 4,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardController: controller = CardController(),
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
                      players[indexPlayer].points += 50;
                      showListPlayersSolve();
                      //_startTimer();
                      setState(() {
                        _timer.cancel();
                        updatePlayer();
                        print('Current player: ${screenName.toUpperCase()}');
                      });
                    } else if (orientation == CardSwipeOrientation.LEFT) {
                      print('Card swiped to the left.');
                      setState(() {
                        updatePlayer();
                        print('Current player: ${screenName.toUpperCase()}');
                        if (numCard == cardImages.length) {
                          Navigator.pushNamed(context, '/end',
                              arguments: players);
                        } else {
                          restartTimer();
                        }
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "PLAYER: ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'LuckiestGuy'),
                        ),
                        Text(
                          "PLAYER: ",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'LuckiestGuy',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Stack(
                        children: [
                          Text(
                            screenName,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontFamily: 'LuckiestGuy'),
                          ),
                          Text(
                            screenName,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'LuckiestGuy',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Text(
                        "POINTS: ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'LuckiestGuy'),
                      ),
                      Text(
                        "POINTS: ",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'LuckiestGuy',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Stack(
                      children: [
                        Text(
                          screenPoints,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'LuckiestGuy'),
                        ),
                        Text(
                          screenPoints,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontFamily: 'LuckiestGuy',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePlayersSolve() {
    playersSolve.clear();
    for (int i = 0; i < players.length; i++) {
      if (players[i].name != screenName) {
        playersSolve.add(players[i]);
        print(
            'Player ${players[i].name} added to playersSolve (screenName = $screenName).');
      }
    }
  }

  void showListPlayersSolve() {
    updatePlayersSolve();
    print('$playersSolve');
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
            content: setupAlertDialoadContainer(),
          );
        });
  }

  void updatePlayer() async {
    indexPlayer++;
    if (indexPlayer >= players.length) {
      indexPlayer = 0;
    }
    screenName = players[indexPlayer].name;
    screenPoints = players[indexPlayer].points.toString();
    numCard++;
  }

  void updatePlayerPointsByName(String name) {
    for (int i = 0; i < players.length; i++) {
      if (players[i].name == screenName) {
        players[i].points += 100;
        print('Now player ${players[i].name} has ${players[i].points} points.');
      }
    }
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: new ListView.builder(
        itemCount: playersSolve.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                print(
                    'You have pressed the player ${playersSolve[index].name}');
                updatePlayerPointsByName(playersSolve[index].name);
                playersSolve = [];
                Navigator.pop(context);
                if (numCard == cardImages.length) {
                  Navigator.pushNamed(context, '/end', arguments: players);
                } else {
                  restartTimer();
                }
              },
              title: Text(
                playersSolve[index].name.toUpperCase(),
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
}

class TinderAnimation extends StatefulWidget {
  @override
  _TinderAnimationState createState() => _TinderAnimationState();
}

class _TinderAnimationState extends State<TinderAnimation>
    with TickerProviderStateMixin {
  List<String> cardImages = [
    'assets/chicken.jpg',
    'assets/ball.jpg',
    'assets/plane.jpg',
    'assets/car.jpg',
    'assets/chainsaw.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    CardController controller;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Tinder',
          style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'LuckiestGuy',
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..color = Colors.black),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: TinderSwapCard(
          orientation: AmassOrientation.BOTTOM,
          cardBuilder: (context, index) => Card(
            child: Image.asset('${cardImages[index]}'),
          ),
          totalNum: 5,
          stackNum: 4,
          swipeEdge: 4.0,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.width * 0.9,
          minWidth: MediaQuery.of(context).size.width * 0.9,
          minHeight: MediaQuery.of(context).size.width * 0.9,
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            if (align.x < 0) {
            } else if (align.x < 0) {}
          },
          swipeCompleteCallback:
              (CardSwipeOrientation orientation, int index) {},
        ),
      ),
    );
  }
}
