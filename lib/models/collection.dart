import 'package:flutter/material.dart';
import './card.dart';

class Collection {
  final List<CardItem> cards;
  final String collectionImg;
  bool isSelected;
  bool isBought;

  Collection({
    @required this.cards,
    @required this.collectionImg,
  });

  void setSelected() {
    isSelected = true;
  }

  void setUnselected() {
    isSelected = false;
  }

  void setBought() {
    isBought = true;
  }
}
