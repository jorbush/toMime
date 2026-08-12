import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/player.dart';
import '../../providers/players.dart';

class ListSolve extends StatelessWidget {
  final Function setReward;
  final List<Player> playersSolve;

  const ListSolve({
    Key? key,
    required this.playersSolve,
    required this.setReward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _playersData = Provider.of<Players>(context);
    return SizedBox(
      width: 300.0,
      height: 180.0,
      child: ListView.builder(
        itemCount: playersSolve.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                setReward(index, _playersData, context);
              },
              title: Text(
                playersSolve[index].name.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'LuckiestGuy',
                  color: Colors.grey[800],
                ),
              ),
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/icon/blank_profile.png'),
              ),
            ),
          );
        },
      ),
    );
  }
}
