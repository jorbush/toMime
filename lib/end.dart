import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/Player.dart';

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
                  children: [
                    Stack(
                      children: [
                        Text(
                          "RESULTS",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.0,
                              fontFamily: 'LuckiestGuy'),
                        ),
                        Text(
                          "RESULTS",
                          style: TextStyle(
                              fontSize: 50.0,
                              fontFamily: 'LuckiestGuy',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
                child: Stack(
                  children: [
                    Text(
                      "1. ${players[0].name.toUpperCase()} ${players[0].points}",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 215, 0, 1),
                          fontSize: 45.0,
                          fontFamily: 'LuckiestGuy'),
                    ),
                    Text(
                      "1. ${players[0].name.toUpperCase()} ${players[0].points}",
                      style: TextStyle(
                          fontSize: 45.0,
                          fontFamily: 'LuckiestGuy',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Text(
                      "2. ${players[1].name.toUpperCase()} ${players[1].points}",
                      style: TextStyle(
                          color: Color.fromRGBO(192, 192, 192, 1),
                          fontSize: 37.0,
                          fontFamily: 'LuckiestGuy'),
                    ),
                    Text(
                      "2. ${players[1].name.toUpperCase()} ${players[1].points}",
                      style: TextStyle(
                          fontSize: 37.0,
                          fontFamily: 'LuckiestGuy',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Text(
                      "3. ${players[2].name.toUpperCase()} ${players[2].points}",
                      style: TextStyle(
                          color: Color.fromRGBO(205, 127, 50, 1),
                          fontSize: 30.0,
                          fontFamily: 'LuckiestGuy'),
                    ),
                    Text(
                      "3. ${players[2].name.toUpperCase()} ${players[2].points}",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'LuckiestGuy',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = Colors.black),
                    ),
                  ],
                ),
              ),
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
