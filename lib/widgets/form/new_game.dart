import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/providers/player.dart';
import 'package:to_mime/providers/players.dart';
import 'package:to_mime/widgets/utils/outlined_cartoon_button.dart';
import './game_modes.dart';
import 'package:provider/provider.dart';

import '../form/players_list.dart';
import '../utils/cartoon_text.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key key}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  bool _gestures = true;
  bool _sounds = true;

  @override
  void initState() {
    super.initState();
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
    final _playersData = Provider.of<Players>(context);
    final _players = _playersData.players;
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
                      _playersData.playerName = name;
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
                          _playersData.addNewPlayer(_controller);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onSubmitted: (value) {
                      _playersData.addNewPlayer(_controller);
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
                        text: "${_players.length}/${_playersData.maxPlayers}",
                        textSize: 28.0,
                        strokeWidth: 1.5,
                      ),
                    ],
                  ),
                ]),
                PlayersList(
                  heightScreen: mediaQuery.size.height,
                ),
                GameModes(
                  gestures: _gestures,
                  sounds: _sounds,
                  setGestures: _setGestures,
                  setSounds: _setSounds,
                ),
                OutlinedCartoonButton(
                  text: 'START GAME',
                  functionOnClick: () {
                    validateForm(context, _players, _playersData);
                  },
                ),
              ])),
        ],
      ),
    );
  }

  void validateForm(
      BuildContext context, List<Player> players, Players playersData) {
    if (players.length > 2) {
      print('Starting game...');
      Map _gameModes = {'sounds': _sounds, 'gestures': _gestures};
      Map _formData = {"gamemode": _gameModes};
      startNewGame(context, _formData, playersData);
    } else {
      print('Not enought players to start the game.');
    }
  }

  void startNewGame(BuildContext context, Map<dynamic, dynamic> _formData,
      Players playersData) {
    playersData.resetPlayersPoints();
    Navigator.pushNamed(context, '/game', arguments: _formData);
  }
}
