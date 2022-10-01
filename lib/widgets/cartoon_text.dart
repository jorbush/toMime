import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CartoonText extends StatelessWidget {
  final String text;
  final double textSize;

  CartoonText({
    @required this.text,
    @required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: this.textSize,
              fontFamily: 'Pacifico',
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 5
                ..color = Colors.black),
        ),
        Text(this.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: this.textSize,
                fontFamily: 'Pacifico',
                color: Colors.white))
      ],
    );
  }
}
