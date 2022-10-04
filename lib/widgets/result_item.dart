import 'package:flutter/material.dart';
import '../models/player.dart';

class ResultItem extends StatefulWidget {
  final Player player;

  const ResultItem({
    Key key,
    @required this.player,
  }) : super(key: key);

  @override
  State<ResultItem> createState() => _ResultItemState();
}

class _ResultItemState extends State<ResultItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
