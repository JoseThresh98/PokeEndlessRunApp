import '../local/hive_service.dart';
import '../models/score_model.dart';

class ScoreRepository {
  ScoreModel getScore() {
    final box = HiveService.scores;
    return box.get('score') ?? ScoreModel.initial();
  }

  Future<void> saveScore(ScoreModel score) async {
    await HiveService.scores.put('score', score);
  }

  Future<void> updateHighScore(int newScore) async {
    final current = getScore();
    if (newScore > current.highScore) {
      await saveScore(current.copyWith(
        highScore: newScore,
        lastPlayed: DateTime.now(),
      ));
    }
  }

  Future<void> addCoins(int amount) async {
    final current = getScore();
    await saveScore(current.copyWith(
      totalCoins: current.totalCoins + amount,
    ));
  }

  Future<void> addGems(int amount) async {
    final current = getScore();
    await saveScore(current.copyWith(
      totalGems: current.totalGems + amount,
    ));
  }

  Future<void> spendCoins(int amount) async {
    final current = getScore();
    await saveScore(current.copyWith(
      totalCoins: current.totalCoins - amount,
    ));
  }

  Future<void> spendGems(int amount) async {
    final current = getScore();
    await saveScore(current.copyWith(
      totalGems: current.totalGems - amount,
    ));
  }
}