import 'package:flutter_test/flutter_test.dart';
import 'package:to_mime/models/card.dart';
import 'package:to_mime/models/collection.dart';

void main() {
  group('Collection and CardItem Model Tests', () {
    test('CardItem getters and path property', () {
      final card = CardItem(name: 'Guitar', imgPath: 'assets/guitar.png');
      expect(card.name, equals('Guitar'));
      expect(card.imgPath, equals('assets/guitar.png'));
      expect(card.path, equals('assets/guitar.png'));
    });

    test('Collection initialization and getters', () {
      final card = CardItem(name: 'Dance', imgPath: 'assets/dance.png');
      final collection = Collection(
        id: 'c1',
        cards: [card],
        title: 'Actions',
        description: 'Action cards for mime',
        price: 0.0,
        imgPath: 'assets/actions.png',
      );

      expect(collection.id, equals('c1'));
      expect(collection.title, equals('Actions'));
      expect(collection.description, equals('Action cards for mime'));
      expect(collection.price, equals(0.0));
      expect(collection.imgPath, equals('assets/actions.png'));
      expect(collection.isSelected, isFalse);
      expect(collection.isBought, isFalse);
      expect(collection.cardsItems.length, equals(1));
    });

    test('setSelected and setUnselected toggle selection state', () {
      final collection = Collection(
        id: 'c2',
        cards: [],
        title: 'Sports',
        description: 'Sports mime',
        price: 1.99,
        imgPath: 'assets/sports.png',
      );

      collection.setSelected();
      expect(collection.isSelected, isTrue);

      collection.setUnselected();
      expect(collection.isSelected, isFalse);
    });

    test('setBought updates isBought state', () {
      final collection = Collection(
        id: 'c3',
        cards: [],
        title: 'Movies',
        description: 'Movie mime',
        price: 2.99,
        imgPath: 'assets/movies.png',
      );

      collection.setBought();
      expect(collection.isBought, isTrue);
    });
  });
}
