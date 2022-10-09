import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/players.dart';

class ListSolve extends StatelessWidget {
  final Function setReward;
  final playersSolve;

  const ListSolve({
    Key key,
    @required this.playersSolve,
    @required this.setReward,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _playersData = Provider.of<Players>(context);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.24, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: new ListView.builder(
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
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/icon/blank_profile.png'),
              ),
            ),
          );
        },
      ),
    );
  }
}
