import 'package:flutter/material.dart';
import '../models/player.dart';

class PlayerItem extends StatefulWidget {
  final Player player;
  final Function deletePlayer;

  const PlayerItem({
    Key key,
    @required this.player,
    @required this.deletePlayer,
  }) : super(key: key);

  @override
  State<PlayerItem> createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: () {
            print('You have pressed the player ${widget.player.name}');
          },
          title: Text(
            widget.player.name.toUpperCase(),
            style:
                TextStyle(fontFamily: 'LuckiestGuy', color: Colors.grey[800]),
          ),
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/blank_profile.png'),
          ),
        ),
      ),
    );
  }
}
