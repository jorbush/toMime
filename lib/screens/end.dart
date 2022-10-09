import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/players.dart';
import '../widgets/utils/outlined_cartoon_button.dart';
import '../widgets/utils/cartoon_text.dart';
import '../widgets/end/results_list.dart';

class End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _playersData = Provider.of<Players>(context);
    _playersData.orderByPoints();
    final mediaQuery = MediaQuery.of(context);
    if (_playersData == null || _playersData.numPlayers == 0) {
      Navigator.popUntil(context, ModalRoute.withName('/form'));
    }
    //print('${players[0].name}');
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 180, 255, 1),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/sky1.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      30,
                      mediaQuery.size.height * 0.09,
                      30,
                      mediaQuery.size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CartoonText(text: "RESULTS", textSize: 50.0)],
                  ),
                ),
                ResultsList(mediaQuery.size.height * 0.47),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, mediaQuery.size.height * 0.07, 0, 0),
                  child: OutlinedCartoonButton(
                    text: 'RETURN HOME',
                    functionOnClick: () {
                      Navigator.popUntil(context, ModalRoute.withName('/form'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
