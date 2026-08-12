import 'package:flutter/material.dart';

class OutlinedCartoonButton extends StatelessWidget {
  final String text;
  final VoidCallback? functionOnClick;

  const OutlinedCartoonButton({
    Key? key,
    required this.text,
    this.functionOnClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side:
            BorderSide(color: Colors.white, style: BorderStyle.solid, width: 2),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
      ),
      onPressed: functionOnClick,
      child: Padding(
        padding: EdgeInsets.fromLTRB(50, mediaQuery.size.height * 0.026, 50,
            mediaQuery.size.height * 0.019),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontFamily: 'LuckiestGuy'),
        ),
      ),
    );
  }
}
