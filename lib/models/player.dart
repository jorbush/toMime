
class Player {
  final String name;
  int points;

  Player({
    required this.name,
    required this.points,
  });

  void setPoints(int pointsPlayer) {
    points = pointsPlayer;
    //notifyListeners();
  }

  void resetPoints() {
    points = 0;
    //notifyListeners();
  }
}
