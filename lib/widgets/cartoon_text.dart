import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CartoonText extends StatelessWidget {
  final String text;
  final double textSize;
  final double strokeWidth;
  final String fontFamily;

  CartoonText({
    @required this.text,
    @required this.textSize,
    this.strokeWidth = 2,
    this.fontFamily = 'LuckiestGuy',
  });

  @override
  Widget build(BuildContext context) {
    print(this.text.toString() +
        ' ' +
        this.textSize.toString() +
        ' ' +
        this.strokeWidth.toString() +
        ' ' +
        this.fontFamily.toString());
    return Stack(
      children: <Widget>[
        Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: this.textSize,
              fontFamily: this.fontFamily,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = this.strokeWidth
                ..color = Colors.black),
        ),
        Text(this.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: this.textSize,
                fontFamily: this.fontFamily,
                color: Colors.white))
      ],
    );
  }
}
