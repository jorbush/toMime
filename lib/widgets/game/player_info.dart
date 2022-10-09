import 'package:flutter/material.dart';

import '../utils/cartoon_text.dart';

class PlayerInfo extends StatelessWidget {
  final String name;
  final String points;

  const PlayerInfo({
    Key key,
    @required this.name,
    @required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        mediaQuery.size.height * 0.560,
        0,
        mediaQuery.size.height * 0.020,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CartoonText(
                text: "PLAYER: ",
                textSize: 30.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  mediaQuery.size.height * 0.015,
                  0,
                  0,
                  0,
                ),
                child: CartoonText(
                  text: name,
                  textSize: 30.0,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.025, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CartoonText(
                  text: "POINTS: ",
                  textSize: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    mediaQuery.size.height * 0.020,
                    0,
                    0,
                    0,
                  ),
                  child: CartoonText(
                    text: points,
                    textSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
