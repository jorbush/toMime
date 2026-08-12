import 'dart:async';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/player.dart';
import '../providers/players.dart';
import '../widgets/game/card_swiper.dart';
import '../widgets/game/list_solve.dart';
import '../widgets/game/player_info.dart';
import '../widgets/utils/confirm_dialog.dart';
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
  final List<String> _cardImages = [
    'assets/started_pack/chick.png',
    'assets/started_pack/hammer.png',
    'assets/started_pack/plane.png',
    'assets/started_pack/chicken.png',
    'assets/started_pack/football_ball.png',
    'assets/started_pack/car.png',
    'assets/started_pack/chainsaw.png',
  ];
  late CustomCardSwiperController _controllerCard;
  Timer? _timer;
  int _seconds = 30;
  Image? _gameMode;
  bool _gameModeGestures = true;
  bool _gameModeSounds = true;
  bool _flipEnabled = true;
  List<Player> _playersSolve = [];

  @override
  void initState() {
    super.initState();
    _controllerCard = CustomCardSwiperController();
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
    _timer?.cancel();
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
    if (_playersData == null || _playersData.numPlayers == 0) {
      Navigator.popUntil(context, ModalRoute.withName('/form'));
    }
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
                PlayerInfo(name: _screenName, points: _screenPoints),
                SwipeCards(mediaQuery, context, _players, _playersData),
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
      _timer!.cancel();
      setState(() {
        _seconds = seconds;
      });
    }
  }

  void _updatePlayersSolve(List<Player> players) {
    _playersSolve.clear();
    for (int i = 0; i < players.length; i++) {
      if (players[i].name != _screenName) {
        _playersSolve.add(players[i]);
        print(
            'Player ${players[i].name} added to playersSolve (screenName = $_screenName).');
      }
    }
  }

  void _showListPlayersSolve(Players playersData) {
    _updatePlayersSolve(playersData.players);
    print('$_playersSolve');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(0, 180, 255, 1),
            title: null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CartoonText(
                    text: 'Who has solved it?',
                    textSize: 24.0,
                    strokeWidth: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ListSolve(
                      playersSolve: _playersSolve,
                      setReward: _setRewardPlayer,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _updatePlayer(List<Player> players) async {
    _indexPlayer++;
    if (_indexPlayer >= players.length) {
      _indexPlayer = 0;
    }
    _screenName = players[_indexPlayer].name;
    _screenPoints = players[_indexPlayer].points.toString();
    _numCard++;
  }

  void _setRewardPlayer(int index, Players playersData, BuildContext context) {
    print('You have pressed the player ${_playersSolve[index].name}');
    playersData.updatePlayerPointsByName(_playersSolve[index].name);
    _playersSolve = [];
    Navigator.pop(context);
    if (_numCard == _cardImages.length) {
      Navigator.pushNamed(context, '/end');
    } else {
      _restartTimer(30);
    }
  }

  Image _getRandomGameMode() {
    int _randomNumber = Random().nextInt(2);
    switch (_randomNumber) {
      case 0:
        return Image.asset('assets/icon/arms_up2.png');
      case 1:
        return Image.asset('assets/icon/music.png');
      default:
        print("_getRandomGameMode() -> ERROR");
        return Image.asset('assets/icon/arms_up2.png');
    }
  }

  void _updateGameMode() {
    setState(() {
      if (_gameModeGestures && !_gameModeSounds) {
        _gameMode = Image.asset('assets/icon/arms_up2.png');
        print("Gestures mode!");
      } else if (!_gameModeGestures && _gameModeSounds) {
        _gameMode = Image.asset('assets/icon/music.png');
        print("Sounds mode!");
      } else {
        _gameMode = _getRandomGameMode();
      }
    });
  }

  void _getFormData(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route != null && route.settings.arguments != null) {
      Map _formData = route.settings.arguments as Map;
      setState(() {
        _gameModeGestures = _formData["gamemode"]?["gestures"] ?? true;
        _gameModeSounds = _formData["gamemode"]?["sounds"] ?? true;
      });
    }
    _updateGameMode();
  }

  Container SwipeCards(MediaQueryData mediaQuery, BuildContext context,
      List<Player> _players, Players _playersData) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 435,
      child: CustomCardSwiper(
        controller: _controllerCard,
        itemCount: _cardImages.length,
        itemBuilder: (context, index) => FlipCard(
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
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Image.asset(
                      _cardImages[index],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    mediaQuery.size.width * 0.045,
                    mediaQuery.size.width * 0.045,
                    0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: _gameMode ??
                            Image.asset('assets/icon/arms_up2.png'),
                        iconSize: 44,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          front: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  color: const Color.fromRGBO(0, 180, 255, 1),
                  padding: const EdgeInsets.all(48.0),
                  child: Image.asset(
                    'assets/icon/to_mime_icon_without_background.png',
                    fit: BoxFit.fill,
                  ),
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
        onSwipe: (direction, index) {
          if (direction == SwipeDirection.right) {
            print('Card swiped to the right.');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: SizedBox(
                height: mediaQuery.size.height * 0.030,
                child: const Text(
                  "CORRECT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'LuckiestGuy'),
                ),
              ),
              duration: const Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.fixed,
            ));
            _players[_indexPlayer].points += 50;
            _showListPlayersSolve(_playersData);
            setState(() {
              _timer?.cancel();
              _updatePlayer(_players);
              _updateGameMode();
              _flipEnabled = true;
              print('Current player: ${_screenName.toUpperCase()}');
            });
          } else if (direction == SwipeDirection.left) {
            print('Card swiped to the left.');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: SizedBox(
                height: mediaQuery.size.height * 0.030,
                child: const Text(
                  "INCORRECT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontFamily: 'LuckiestGuy'),
                ),
              ),
              duration: const Duration(milliseconds: 1000),
              behavior: SnackBarBehavior.fixed,
            ));
            setState(() {
              _updatePlayer(_players);
              _updateGameMode();
              _flipEnabled = true;
              print('Current player: ${_screenName.toUpperCase()}');
              if (_numCard == _cardImages.length) {
                Navigator.pushNamed(context, '/end', arguments: _players);
              } else {
                _restartTimer(30);
              }
            });
          }
        },
      ),
    );
  }
}
