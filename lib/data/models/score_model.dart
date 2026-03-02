import 'package:hive/hive.dart';

part 'score_model.g.dart';

@HiveType(typeId: 1)
class ScoreModel extends HiveObject {
  @HiveField(0)
  final int highScore;

  @HiveField(1)
  final int totalCoins;

  @HiveField(2)
  final int totalGems;

  @HiveField(3)
  final DateTime lastPlayed;

  ScoreModel({
    required this.highScore,
    required this.totalCoins,
    required this.totalGems,
    required this.lastPlayed,
  });

  ScoreModel copyWith({
    int? highScore,
    int? totalCoins,
    int? totalGems,
    DateTime? lastPlayed,
  }) {
    return ScoreModel(
      highScore: highScore ?? this.highScore,
      totalCoins: totalCoins ?? this.totalCoins,
      totalGems: totalGems ?? this.totalGems,
      lastPlayed: lastPlayed ?? this.lastPlayed,
    );
  }

  factory ScoreModel.initial() => ScoreModel(
    highScore: 0,
    totalCoins: 0,
    totalGems: 0,
    lastPlayed: DateTime.now(),
  );
}