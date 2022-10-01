import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/models/player.dart';
import 'package:to_mime/widgets/cartoon_text.dart';

class End extends StatefulWidget {
  @override
  _EndState createState() => _EndState();
}

class _EndState extends State<End> {
  List<Player> players;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    players = ModalRoute.of(context).settings.arguments;
    players.sort((a, b) => b.points.compareTo(a.points));
    print('${players[0].name}');
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
                child: CartoonText(
                    text:
                        "1. ${players[0].name.toUpperCase()} ${players[0].points}",
                    textSize: 45.0,
                    color: Color.fromRGBO(255, 215, 0, 1)),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartoonText(
                    text:
                        "2. ${players[1].name.toUpperCase()} ${players[1].points}",
                    textSize: 37.0,
                    strokeWidth: 1,
                    color: Color.fromRGBO(192, 192, 192, 1),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartoonText(
                    text:
                        "3. ${players[2].name.toUpperCase()} ${players[2].points}",
                    textSize: 30,
                    strokeWidth: 1,
                    color: Color.fromRGBO(205, 127, 50, 1),
                  )),
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
      ),
    );
  }
}
