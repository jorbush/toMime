import 'package:flutter/material.dart';
import 'package:to_mime/widgets/result_item.dart';
import './cartoon_text.dart';
import '../models/player.dart';

class ResultsList extends StatelessWidget {
  final List<Player> players;

  ResultsList(this.players);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CartoonText(text: "RESULTS", textSize: 50.0)],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(30, 70, 30, 20),
          child: ListView(
            children: players
                .map((player) => ResultItem(
                      player: player,
                    ))
                .toList(),
          ),
        ),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 270, 0, 0),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: Colors.white, style: BorderStyle.solid, width: 2),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/form'));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 22, 50, 18),
              child: Text(
                'RETURN HOME',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'LuckiestGuy'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
