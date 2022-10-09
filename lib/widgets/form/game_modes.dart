import 'package:flutter/material.dart';

import '../utils/cartoon_text.dart';

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
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, mediaQuery.size.height * 0.02, 0, mediaQuery.size.height * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding:
                EdgeInsets.fromLTRB(0, mediaQuery.size.height * 0.01, 0, 0),
            child: CartoonText(
              text: "MODES: ",
              textSize: 22.0,
              strokeWidth: 1,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Image.asset('assets/icon/arms_up2.png'),
              ),
              Checkbox(
                value: gestures,
                onChanged: ((_) => setGestures()),
              ),
              IconButton(
                icon: Image.asset('assets/icon/music.png'),
              ),
              Checkbox(
                value: sounds,
                onChanged: ((_) => setSounds()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
