import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: Text('settings'),
    );
  }
}
