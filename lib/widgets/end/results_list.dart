import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/players.dart';
import '../end/result_item.dart';

class ResultsList extends StatelessWidget {
  final double listHeight;

  ResultsList(this.listHeight);

  @override
  Widget build(BuildContext context) {
    final _playersData = Provider.of<Players>(context);
    return SizedBox(
        height: listHeight,
        child: ListView.builder(
            itemCount: _playersData.numPlayers,
            itemBuilder: (context, index) {
              return ResultItem(
                player: _playersData.players.elementAt(index),
                position: index + 1,
              );
            }));
  }
}
