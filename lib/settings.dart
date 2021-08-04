import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 180, 255, 1),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 4),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 23),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Stack(
                    children: [
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontFamily: 'LuckiestGuy'),
                      ),
                      Text(
                        "SETTINGS",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'LuckiestGuy',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black),
                      ),
                    ],
                  ),
                ]),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "LANGUAGE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'LuckiestGuy'),
                        ),
                        Text(
                          "LANGUAGE",
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
                  ],
                ),
              ]),
            ),
          ]),
        ));
  }
}
