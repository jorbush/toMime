import 'package:flutter_test/flutter_test.dart';
import 'package:to_mime/models/player.dart';

void main() {
  group('Player Model Tests', () {
    test('Player creation initializing with correct name and points', () {
      final player = Player(name: 'Alice', points: 50);

      expect(player.name, equals('Alice'));
      expect(player.points, equals(50));
    });

    test('setPoints updates player points', () {
      final player = Player(name: 'Bob', points: 10);
      player.setPoints(100);

      expect(player.points, equals(100));
    });

    test('resetPoints resets player points to zero', () {
      final player = Player(name: 'Charlie', points: 75);
      player.resetPoints();

      expect(player.points, equals(0));
    });
  });
}
