import 'package:flutter/material.dart';

class CardItem {
  final String name;
  final String imgPath;

  CardItem({
    @required this.name,
    @required this.imgPath,
  });

  String get path {
    return imgPath;
  }
}
