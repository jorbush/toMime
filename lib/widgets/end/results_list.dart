import 'package:flutter/material.dart';
import '../end/result_item.dart';
import '../../models/player.dart';

class ResultsList extends StatelessWidget {
  final List<Player> players;
  final double listHeight;

  ResultsList(this.players, this.listHeight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: listHeight,
        child: ListView.builder(
            itemCount: players.length,
            itemBuilder: (context, index) {
              return ResultItem(
                player: players.elementAt(index),
                position: index + 1,
              );
            }));
  }
}
