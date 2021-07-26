import 'package:flutter/material.dart';
import 'package:to_mime/form.dart';
import 'package:to_mime/home.dart';
import 'package:to_mime/settings.dart';

import 'end.dart';
import 'game.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/home', //'/'
        routes: {
          //'/': (context) => Loading(),
          '/home': (context) => Home(),
          '/settings': (context) => Settings(),
          '/form': (context) => FormGame(),
          '/game': (context) => Game(),
          '/end': (context) => End()
        },
      ),
    );
