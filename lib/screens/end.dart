import 'package:flutter/material.dart';
import '../widgets/cartoon_text.dart';
import '../widgets/results_list.dart';
import '../models/player.dart';

class End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Player> players = ModalRoute.of(context).settings.arguments;
    players.sort((a, b) => b.points.compareTo(a.points));
    //print('${players[0].name}');
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 180, 255, 1),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/sky1.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CartoonText(text: "RESULTS", textSize: 50.0)],
                  ),
                ),
                ResultsList(players, 200),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 270, 0, 0),
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
            ),
          ),
        ));
  }
}
