class ScoreEntity {
  final int highScore;
  final int totalCoins;
  final int totalGems;
  final DateTime lastPlayed;

  const ScoreEntity({
    required this.highScore,
    required this.totalCoins,
    required this.totalGems,
    required this.lastPlayed,
  });

  bool canAfford(int cost) => totalCoins >= cost;
}