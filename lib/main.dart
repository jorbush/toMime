import 'package:flutter/material.dart';
import 'package:to_mime/providers/players.dart';
import 'package:to_mime/screens/form.dart';
import 'package:to_mime/screens/home.dart';
import 'package:to_mime/screens/settings.dart';
import 'package:provider/provider.dart';

import 'screens/end.dart';
import 'screens/game.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Players([]),
        ),
      ],
      child: MaterialApp(
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
  }
}
