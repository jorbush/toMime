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
      children: [
        Icon(
          iconData,
          size: sizeIcon - 4.0,
          color: colorIcon,
        ),
        Icon(
          iconData,
          size: sizeIcon,
          color: Colors.black,
        ),
      ],
    );
  }
}
