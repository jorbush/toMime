import 'package:flutter/material.dart';
import '../widgets/results_list.dart';
import '../models/player.dart';

class End extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Player> players = ModalRoute.of(context).settings.arguments;
    players.sort((a, b) => b.points.compareTo(a.points));
    //print('${players[0].name}');
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 180, 255, 1),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/sky1.png'),
            fit: BoxFit.cover,
          )),
          child: ResultsList(players),
        ),
      ),
    );
  }
}
