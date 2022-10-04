import 'package:flutter/material.dart';
import 'package:to_mime/widgets/result_item.dart';
import './cartoon_text.dart';
import '../models/player.dart';

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
    // Padding(
    //   padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
    //   child: CartoonText(
    //       text: "1. ${players[0].name.toUpperCase()} ${players[0].points}",
    //       textSize: 45.0,
    //       color: Color.fromRGBO(255, 215, 0, 1)),
    // ),
    // Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CartoonText(
    //       text: "2. ${players[1].name.toUpperCase()} ${players[1].points}",
    //       textSize: 37.0,
    //       strokeWidth: 1,
    //       color: Color.fromRGBO(192, 192, 192, 1),
    //     )),
    // Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: CartoonText(
    //       text: "3. ${players[2].name.toUpperCase()} ${players[2].points}",
    //       textSize: 30,
    //       strokeWidth: 1,
    //       color: Color.fromRGBO(205, 127, 50, 1),
    //     )),
  }
}
