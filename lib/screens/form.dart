import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/player.dart';

class FormGame extends StatefulWidget {
  @override
  _FormGameState createState() => _FormGameState();
}

class _FormGameState extends State<FormGame> {
  String playerName = "";
  List<Player> players = [];
  String lastPlayerName = "";
  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 4),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 23),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "NEW GAME",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontFamily: 'LuckiestGuy'),
                          ),
                          Text(
                            "NEW GAME",
                            style: TextStyle(
                                fontSize: 40.0,
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "ENTER THE PLAYER'S NAME:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontFamily: 'LuckiestGuy'),
                          ),
                          Text(
                            "ENTER THE PLAYER'S NAME:",
                            style: TextStyle(
                                fontSize: 22.0,
                                fontFamily: 'LuckiestGuy',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.name,
                      onChanged: (name) {
                        playerName = name;
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
                            addNewPlayer(_controller);
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        addNewPlayer(_controller);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Text(
                            "PLAYERS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0,
                                fontFamily: 'LuckiestGuy'),
                          ),
                          Text(
                            "PLAYERS",
                            style: TextStyle(
                                fontSize: 28.0,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: SizedBox(
                      height: 370,
                      child: new ListView.builder(
                        itemCount: players.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1.0, horizontal: 4.0),
                            child: Card(
                              child: ListTile(
                                onTap: () {
                                  print(
                                      'You have pressed the player ${players[index].name}');
                                },
                                title: Text(
                                  players[index].name.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'LuckiestGuy',
                                      color: Colors.grey[800]),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/blank_profile.png'),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    onPressed: () {
                      if (players.length > 2) {
                        print('Starting game...');
                        Navigator.pushNamed(context, '/game',
                            arguments: players);
                      } else {
                        print('Not enought players to start the game.');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 22, 50, 18),
                      child: Text(
                        'START GAME',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontFamily: 'LuckiestGuy'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method for add a player to the game.
  void addNewPlayer(controller) async {
    if (canBeAdded()) {
      setState(() {
        print('lastPlayerName: $lastPlayerName, playerName: $playerName');
        addPlayer();
      });
      controller.clear();
    }
  }

  // Method for add a player to the game.
  void addPlayer() async {
    if (playerName != '' && players.length < 10) {
      players.add(Player(name: playerName, points: 0));
      lastPlayerName = playerName;
      print('Player $playerName added');
      Player p;
      int playerCount = 0;
      print('PLAYERS:');
      for (p in players) {
        playerCount++;
        print('   Player $playerCount: ${p.name}');
      }
    } else if (players.length >= 10) {
      print("Too many players.");
    } else {
      print("TextField is empty");
    }
  }

  // Method to prove that a player can be added to the game.
  bool canBeAdded() {
    if (hasAlreadyBeenAdded(playerName)) {
      print('Player $playerName has been already added.');
    }
    return !hasAlreadyBeenAdded(playerName) || lastPlayerName == '';
  }

  // Method to prove that a player has already been added.
  bool hasAlreadyBeenAdded(String pName) {
    bool added = false;
    for (Player p in players) {
      if (p.name == pName) {
        added = true;
      }
    }
    return added;
  }
}
