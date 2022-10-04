import 'package:flutter/material.dart';
import '../../models/player.dart';

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
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/blank_profile.png'),
          ),
          title: Text(
            widget.player.name.toUpperCase(),
            style: TextStyle(
              fontFamily: 'LuckiestGuy',
              color: Colors.grey[800],
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor,
                  ),
                  onPressed: () => widget.deletePlayer(widget.player.name),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => widget.deletePlayer(widget.player.name),
                ),
        ),
      ),
    );
  }
}
