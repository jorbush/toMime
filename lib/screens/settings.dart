import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_mime/widgets/utils/header_back.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 180, 255, 1),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Column(children: [
            HeaderBack(text: "SETTINGS"),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 23),
              child: Column(children: [
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
