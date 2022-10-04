import 'dart:math';

import 'package:flutter/material.dart';
import '../models/player.dart';

class ResultItem extends StatelessWidget {
  final Player player;
  final int position;

  const ResultItem({
    Key key,
    @required this.player,
    @required this.position,
  }) : super(key: key);

  Color getTextColor(int position) {
    switch (position) {
      case 1:
        {
          return Color.fromRGBO(255, 215, 0, 1);
        }
        break;
      case 2:
        {
          return Color.fromRGBO(192, 192, 192, 1);
        }
        break;
      case 3:
        {
          return Color.fromRGBO(205, 127, 50, 1);
        }
        break;
      default:
        {
          return Colors.white;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: getTextColor(position),
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${player.points}'),
            ),
          ),
        ),
        title: Text(
          player.name,
        ),
      ),
    );
  }
}
