import 'package:flutter/material.dart';
import './player_item.dart';
import '../../models/player.dart';

class PlayersList extends StatelessWidget {
  final List<Player> players;
  final double heightScreen;
  final Function deletePlayer;

  const PlayersList(
      {Key key,
      @required this.players,
      @required this.deletePlayer,
      @required this.heightScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(0, heightScreen * 0.02, 0, heightScreen * 0.08),
      child: SizedBox(
        height: heightScreen * 0.30,
        child: ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            return PlayerItem(
                player: players[index], deletePlayer: deletePlayer);
          },
        ),
      ),
    );
  }
}
