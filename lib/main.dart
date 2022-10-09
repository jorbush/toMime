import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/end.dart';
import './screens/game.dart';
import './providers/players.dart';
import './screens/form.dart';
import './screens/home.dart';
import './screens/settings.dart';

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
