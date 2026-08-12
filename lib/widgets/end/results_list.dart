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
    final sorted = _playersData.sortedPlayers;
    return SizedBox(
        height: listHeight,
        child: ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (context, index) {
              return ResultItem(
                player: sorted[index],
                position: index + 1,
              );
            }));
  }
}
