import 'package:flutter/material.dart';

class Card {
  final String name;
  final String imgPath;

  Card({
    @required this.name,
    @required this.imgPath,
  });

  String get path {
    return imgPath;
  }
}
