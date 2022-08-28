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
    'assets/chick.jpeg',
    'assets/hammer.jpg',
    'assets/plane.jpg',
    'assets/chicken.jpg',
    'assets/ball.jpg',
    'assets/car.jpg',
    'assets/chainsaw.jpeg',
  ];
  CardController controller;

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
            controller.triggerLeft();
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
                padding: const EdgeInsets.fromLTRB(30, 25, 30, 15),
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
                height: MediaQuery.of(context).size.height - 360,
                child: TinderSwapCard(
                  //allowVerticalMovement: false,
                  orientation: AmassOrientation.BOTTOM,
                  cardBuilder: (context, index) => Card(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Image.asset('${cardImages[index]}'),
                          height: MediaQuery.of(context).size.height * 0.44,
                        ),
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
                  totalNum: cardImages.length,
                  stackNum: 3,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.85,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.65,
                  minHeight: MediaQuery.of(context).size.height * 0.65,
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
                        updatePlayer();
                        print('Current player: ${screenName.toUpperCase()}');
                        if (numCard == cardImages.length) {
                          Navigator.pushNamed(context, '/end',
                              arguments: players);
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
                  restartTimer(31);
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
          totalNum: cardImages.length,
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
