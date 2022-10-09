import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/players.dart';
import './player_item.dart';

class PlayersList extends StatelessWidget {
  final double heightScreen;

  const PlayersList({Key key, @required this.heightScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _playersData = Provider.of<Players>(context);
    return Padding(
      padding:
          EdgeInsets.fromLTRB(0, heightScreen * 0.02, 0, heightScreen * 0.08),
      child: SizedBox(
        height: heightScreen * 0.30,
        child: ListView.builder(
          itemCount: _playersData.players.length,
          itemBuilder: (context, index) {
            return PlayerItem(
                player: _playersData.players[index],
                deletePlayer: _playersData.deletePlayer);
          },
        ),
      ),
    );
  }
}
