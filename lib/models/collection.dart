import 'package:flutter/material.dart';
import './card.dart';

class Collection {
  final List<CardItem> cards;

  final String id;
  final String title;
  final String description;
  final double price;
  final String imgPath;

  bool isSelected;
  bool isBought;

  Collection({
    @required this.id,
    @required this.cards,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imgPath,
    this.isSelected = false,
    this.isBought = false,
  });

  List<CardItem> get cardsItems {
    return [...cards];
  }

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
