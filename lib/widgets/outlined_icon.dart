import 'package:flutter/material.dart';

class OutlinedIconCartoon extends StatelessWidget {
  final IconData iconData;
  final Color colorIcon;
  final double sizeIcon;

  const OutlinedIconCartoon({
    @required this.iconData,
    this.colorIcon = Colors.white,
    this.sizeIcon = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          iconData,
          size: sizeIcon,
          color: Colors.black,
        ),
        Icon(
          iconData,
          size: sizeIcon - 2.0,
          color: colorIcon,
        ),
      ],
    );
  }
}
