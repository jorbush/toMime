import 'package:flutter_test/flutter_test.dart';
import 'package:to_mime/models/player.dart';
import 'package:to_mime/providers/players.dart';

void main() {
  group('Players Provider Tests', () {
    late Players playersProvider;

    setUp(() {
      playersProvider = Players([]);
    });

    test('Initial players list is empty', () {
      expect(playersProvider.players, isEmpty);
      expect(playersProvider.numPlayers, equals(0));
      expect(playersProvider.maxPlayers, equals(10));
    });

    test('addPlayer adds a player successfully', () async {
      playersProvider.playerName = 'Player 1';
      await playersProvider.addPlayer('Player 1');

      expect(playersProvider.numPlayers, equals(1));
      expect(playersProvider.players.first.name, equals('Player 1'));
    });

    test('addPlayer prevents duplicate player names', () async {
      playersProvider.playerName = 'Player 1';
      await playersProvider.addPlayer('Player 1');
      await playersProvider.addPlayer('Player 1');

      expect(playersProvider.numPlayers, equals(1));
    });

    test('deletePlayer removes existing player', () async {
      playersProvider.playerName = 'Player 1';
      await playersProvider.addPlayer('Player 1');
      expect(playersProvider.numPlayers, equals(1));

      await playersProvider.deletePlayer('Player 1');
      expect(playersProvider.numPlayers, equals(0));
    });

    test('findByName returns correct player or null', () async {
      playersProvider.playerName = 'Alice';
      await playersProvider.addPlayer('Alice');

      final found = playersProvider.findByName('Alice');
      expect(found, isNotNull);
      expect(found!.name, equals('Alice'));

      final notFound = playersProvider.findByName('Unknown');
      expect(notFound, isNull);
    });

    test('updatePlayerPointsByName increments player points by 100', () async {
      playersProvider.playerName = 'Bob';
      await playersProvider.addPlayer('Bob');

      playersProvider.updatePlayerPointsByName('Bob');
      expect(playersProvider.findByName('Bob')!.points, equals(100));
    });

    test('sortedPlayers returns players sorted descending by points', () {
      final p1 = Player(name: 'Low', points: 10);
      final p2 = Player(name: 'High', points: 100);
      final p3 = Player(name: 'Mid', points: 50);

      final provider = Players([p1, p2, p3]);
      final sorted = provider.sortedPlayers;

      expect(sorted[0].name, equals('High'));
      expect(sorted[1].name, equals('Mid'));
      expect(sorted[2].name, equals('Low'));
    });

    test('resetPlayersPoints sets all players points to zero', () async {
      final p1 = Player(name: 'Player A', points: 50);
      final p2 = Player(name: 'Player B', points: 100);
      final provider = Players([p1, p2]);

      await provider.resetPlayersPoints();

      expect(p1.points, equals(0));
      expect(p2.points, equals(0));
    });
  });
}
