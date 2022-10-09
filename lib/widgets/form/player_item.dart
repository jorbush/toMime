import 'package:flutter/material.dart';

import '../../providers/player.dart';
import '../utils/confirm_dialog.dart';

class PlayerItem extends StatelessWidget {
  final Player player;
  final Function deletePlayer;

  const PlayerItem({
    Key key,
    @required this.player,
    @required this.deletePlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(player.name),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (_) => ConfirmDialog(),
        );
      },
      onDismissed: (direction) {
        //Provider.of<Cart>(context, listen: false).removeItem(productId);
        deletePlayer(player.name);
      },
      child: Card(
        child: ListTile(
          onTap: () {
            print('You have pressed the player ${player.name}');
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/icon/blank_profile.png'),
          ),
          title: Text(
            player.name.toUpperCase(),
            style: TextStyle(
              fontFamily: 'LuckiestGuy',
              color: Colors.grey[800],
            ),
          ),
          // trailing: MediaQuery.of(context).size.width > 460
          //     ? TextButton.icon(
          //         icon: const Icon(Icons.delete),
          //         label: const Text('Delete'),
          //         style: TextButton.styleFrom(
          //           foregroundColor: Theme.of(context).errorColor,
          //         ),
          //         onPressed: () => widget.deletePlayer(widget.player.name),
          //       )
          //     : IconButton(
          //         icon: const Icon(Icons.delete),
          //         color: Theme.of(context).errorColor,
          //         onPressed: () => widget.deletePlayer(widget.player.name),
          //       ),
        ),
      ),
    );
  }
}
