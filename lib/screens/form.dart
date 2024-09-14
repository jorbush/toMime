import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/form/new_game.dart';

class FormGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 180, 255, 1),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: NewGame()),
            ])));
  }
}
