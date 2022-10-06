import 'package:flutter/material.dart';
import '../widgets/cartoon_text.dart';
import '../widgets/end/results_list.dart';
import '../models/player.dart';

class End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Player> players = ModalRoute.of(context).settings.arguments;
    players.sort((a, b) => b.points.compareTo(a.points));
    final mediaQuery = MediaQuery.of(context);
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
                ResultsList(players, mediaQuery.size.height * 0.47),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, mediaQuery.size.height * 0.1, 0, 0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/form'));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          50,
                          mediaQuery.size.height * 0.026,
                          50,
                          mediaQuery.size.height * 0.019),
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
            ),
          ),
        ));
  }
}
