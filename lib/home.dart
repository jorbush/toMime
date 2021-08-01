import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/sky1.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        color: Colors.grey[800],
                        iconSize: 36.0,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                          print('opening settings');
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 10, 26, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Text(
                            "TO MIME",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 40.0,
                                fontFamily: 'Pacifico',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 5
                                  ..color = Colors.black),
                          ),
                          Text("TO MIME",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontFamily: 'Pacifico',
                                  color: Colors.white))
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 600.0,
                  child: Container(
                    width: 500.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/form');
                      },
                      child: null,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: <Widget>[
                          Text(
                            "TAP TO START",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 29.0,
                                fontFamily: 'LuckiestGuy'),
                          ),
                          Text(
                            "TAP TO START",
                            style: TextStyle(
                                fontSize: 29.0,
                                fontFamily: 'LuckiestGuy',
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
