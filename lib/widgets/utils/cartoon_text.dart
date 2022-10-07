import 'package:flutter/material.dart';

class CartoonText extends StatelessWidget {
  final String text;
  final double textSize;
  final double strokeWidth;
  final String fontFamily;
  final Color color;

  CartoonText(
      {@required this.text,
      @required this.textSize,
      this.strokeWidth = 2,
      this.fontFamily = 'LuckiestGuy',
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    // print(this.text.toString() +
    //     ' ' +
    //     this.textSize.toString() +
    //     ' ' +
    //     this.strokeWidth.toString() +
    //     ' ' +
    //     this.fontFamily.toString());
    return this.fontFamily == 'LuckiestGuy'
        ? Stack(
            children: <Widget>[
              Text(this.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: this.textSize,
                      fontFamily: this.fontFamily,
                      color: this.color)),
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
            ],
          )
        : Stack(
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
