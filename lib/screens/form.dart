import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/widgets/cartoon_text.dart';

import '../models/player.dart';

class FormGame extends StatefulWidget {
  @override
  _FormGameState createState() => _FormGameState();
}

class _FormGameState extends State<FormGame> {
  String playerName = "";
  List<Player> players = [];
  String lastPlayerName = "";

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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var _controller = TextEditingController();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, mediaQuery.size.height * 0.07, 16,
            mediaQuery.size.height * 0.04),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Stack(children: [
                    Row(children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.white,
                      ),
                    ]),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          0, mediaQuery.size.height * 0.04, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CartoonText(text: "NEW GAME", textSize: 40.0)
                        ],
                      ),
                    ),
                  ]),
                  Padding(
                      padding: EdgeInsets.fromLTRB(
                          24, 0, 24, mediaQuery.size.height * 0.04),
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
                          padding: EdgeInsets.fromLTRB(
                              0,
                              mediaQuery.size.height * 0.01,
                              0,
                              mediaQuery.size.height * 0.03),
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
                            CartoonText(text: "PLAYERS", textSize: 28.0)
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              mediaQuery.size.height * 0.02,
                              0,
                              mediaQuery.size.height * 0.04),
                          child: SizedBox(
                            height: mediaQuery.size.height * 0.40,
                            child: ListView.builder(
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
                                        backgroundImage: AssetImage(
                                            'assets/blank_profile.png'),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
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
            ),
          ],
        ),
      ),
    );
  }
}
