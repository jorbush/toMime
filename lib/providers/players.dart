import 'package:flutter/foundation.dart';
import 'package:to_mime/providers/player.dart';

class Players with ChangeNotifier {
  List<Player> _players = [];
  final int _maxPlayers = 10;
  String _playerName = "";
  String _lastPlayerName = "";

  Players(this._players);

  List<Player> get players {
    return [..._players];
  }

  int get maxPlayers {
    return _maxPlayers;
  }

  int get numPlayers {
    return _players.length;
  }

  void set playerName(String name) {
    _playerName = name;
  }

  Future<void> fetchAndSetPlayers() async {
    // TODO: Get from cookies
    notifyListeners();
  }

  Future<void> resetPlayersPoints() async {
    _players.forEach((player) => player.resetPoints());
    print("Reset players\' points");
    notifyListeners();
  }

  Future<void> orderByPoints() async {
    _players.sort((a, b) => b.points.compareTo(a.points));
    notifyListeners();
  }

  Player findByName(String name) {
    return _players.firstWhere((player) => player.name == name);
  }

  Future<void> updatePlayerPointsByName(String name) {
    for (int i = 0; i < _players.length; i++) {
      if (_players[i].name == name) {
        _players[i].points += 100;
        print(
            'Now player ${_players[i].name} has ${_players[i].points} points.');
      }
    }
  }

  Future<void> addPlayer(String name) async {
    if (!_hasAlreadyBeenAdded(name)) {
      if (_playerName != '' && _players.length < _maxPlayers) {
        _players.insert(
          0,
          Player(
            name: name,
            points: 0,
          ),
        );
        _lastPlayerName = _playerName;
        print('Player $_playerName added');
        Player p;
        int playerCount = 0;
        print('PLAYERS:');
        for (p in _players) {
          playerCount++;
          print('   Player $playerCount: ${p.name}');
        }
      } else if (_players.length >= _maxPlayers) {
        print("Too many players.");
      } else {
        print("TextField is empty");
      }
      notifyListeners();
    } else {
      print('Player $name has been already added.');
    }
  }

  Future<void> deletePlayer() async {
    String namePlayer = _playerName;
    if (_hasAlreadyBeenAdded(namePlayer)) {
      _players.removeWhere((player) => player.name == namePlayer);
      print('Player $namePlayer has been removed.');
      notifyListeners();
    } else {
      print('Player $namePlayer doesn\'t exist.');
    }
  }

  Future<void> updateProduct(String name, int points) async {
    if (_hasAlreadyBeenAdded(name)) {
      _players.firstWhere((player) => player.name == name).setPoints(points);
      notifyListeners();
    } else {
      print('Player $name doesn\'t exist.');
    }
  }

  // Method to prove that a player has already been added.
  bool _hasAlreadyBeenAdded(String pName) {
    bool added = false;
    for (Player p in _players) {
      if (p.name == pName) {
        added = true;
      }
    }
    return added;
  }

  // Method for add a player to the game.
  void addNewPlayer(controller) async {
    if (_canBeAdded()) {
      print('lastPlayerName: $_lastPlayerName, playerName: $_playerName');
      addPlayer(_playerName);
      controller.clear();
    }
  }

  // Method to prove that a player can be added to the game.
  bool _canBeAdded() {
    if (_hasAlreadyBeenAdded(_playerName)) {
      print('Player $_playerName has been already added.');
    }
    return !_hasAlreadyBeenAdded(_playerName) || _lastPlayerName == '';
  }
}
