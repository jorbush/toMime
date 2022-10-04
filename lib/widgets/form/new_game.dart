import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/widgets/form/game_modes.dart';

import '../form/players_list.dart';
import '../cartoon_text.dart';
import '../../models/player.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key key}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  String _playerName = "";
  List<Player> _players = [];
  String _lastPlayerName = "";
  final int _maxPlayers = 10;
  bool _gestures = true;
  bool _sounds = true;

  // Method for add a player to the game.
  void _addNewPlayer(controller) async {
    if (_canBeAdded()) {
      setState(() {
        print('lastPlayerName: $_lastPlayerName, playerName: $_playerName');
        _addPlayer();
      });
      controller.clear();
    }
  }

  // Method for add a player to the game.
  void _addPlayer() async {
    if (_playerName != '' && _players.length < _maxPlayers) {
      _players.add(Player(name: _playerName, points: 0));
      _lastPlayerName = _playerName;
      print('Player $_playerName added');
      Player p;
      int playerCount = 0;
      print('PLAYERS:');
      for (p in _players) {
        playerCount++;
        print('   Player $playerCount: ${p.name}');
      }
    } else if (_players.length >= _maxPlayers) {
      print("Too many players.");
    } else {
      print("TextField is empty");
    }
  }

  // Method to prove that a player can be added to the game.
  bool _canBeAdded() {
    if (_hasAlreadyBeenAdded(_playerName)) {
      print('Player $_playerName has been already added.');
    }
    return !_hasAlreadyBeenAdded(_playerName) || _lastPlayerName == '';
  }

  // Method to prove that a player has already been added.
  bool _hasAlreadyBeenAdded(String pName) {
    bool added = false;
    for (Player p in _players) {
      if (p.name == pName) {
        added = true;
      }
    }
    return added;
  }

  // Method to delete a player of the new game.
  void _deleteNewPlayer(String namePlayer) async {
    if (_hasAlreadyBeenAdded(namePlayer)) {
      setState(() {
        _players.removeWhere((player) => player.name == namePlayer);
        print('Player $_playerName has been removed.');
      });
    }
  }

  void _setGestures() {
    setState(() {
      _gestures = !_gestures;
      print("Gestures -> $_gestures");
    });
  }

  void _setSounds() {
    setState(() {
      _sounds = !_sounds;
      print("Sounds -> $_sounds");
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var _controller = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(children: [
            Row(children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mediaQuery.size.width * 0.02, 0, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
              ),
            ]),
            Padding(
              padding:
                  EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.04, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CartoonText(text: "NEW GAME", textSize: 40.0)],
              ),
            ),
          ]),
          Padding(
              padding:
                  EdgeInsets.fromLTRB(24, 0, 24, mediaQuery.size.height * 0.02),
              child: Column(children: [
                SizedBox(
                  height: mediaQuery.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CartoonText(
                      text: "ENTER THE PLAYER'S NAME:",
                      textSize: 22.0,
                      strokeWidth: 1,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.01,
                      0, mediaQuery.size.height * 0.03),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.name,
                    onChanged: (name) {
                      _playerName = name;
                    },
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'LuckiestGuy'),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: "Enter here a name",
                      suffixIcon: IconButton(
                        onPressed: () {
                          _addNewPlayer(_controller);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      _addNewPlayer(_controller);
                    },
                  ),
                ),
                Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CartoonText(
                        text: "PLAYERS ",
                        textSize: 28.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CartoonText(
                        text: "${_players.length}/$_maxPlayers",
                        textSize: 28.0,
                        strokeWidth: 1.5,
                      ),
                    ],
                  ),
                ]),
                PlayersList(
                  players: _players,
                  deletePlayer: _deleteNewPlayer,
                  heightScreen: mediaQuery.size.height,
                ),
                GameModes(
                    gestures: _gestures,
                    sounds: _sounds,
                    setGestures: _setGestures,
                    setSounds: _setSounds),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (_players.length > 2) {
                      print('Starting game...');
                      Navigator.pushNamed(context, '/game',
                          arguments: _players);
                    } else {
                      print('Not enought players to start the game.');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        50,
                        mediaQuery.size.height * 0.026,
                        50,
                        mediaQuery.size.height * 0.019),
                    child: Text(
                      'START GAME',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontFamily: 'LuckiestGuy'),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
