import 'package:flutter/material.dart';
import '../cartoon_text.dart';

class GameModes extends StatelessWidget {
  final Function setGestures;
  final Function setSounds;
  final bool gestures;
  final bool sounds;

  const GameModes({
    @required this.gestures,
    @required this.sounds,
    @required this.setGestures,
    @required this.setSounds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.01, 0, 0),
          child: CartoonText(
            text: "GAME MODES: ",
            textSize: 22.0,
            strokeWidth: 1,
          ),
        ),
        Row(
          children: [
            Icon(
              IconData(0xf51b, fontFamily: 'MaterialIcons'),
            ),
            Checkbox(
              value: gestures,
              onChanged: ((_) => setGestures()),
            ),
            Icon(
              IconData(0xf8ed, fontFamily: 'MaterialIcons'),
            ),
            Checkbox(
              value: sounds,
              onChanged: ((_) => setSounds()),
            )
          ],
        ),
      ],
    );
  }
}
