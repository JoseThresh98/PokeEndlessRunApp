import '../../data/repositories/score_repository.dart';
import '../entities/score_entity.dart';

class GetHighScore {
  final ScoreRepository _repository;

  GetHighScore(this._repository);

  ScoreEntity call() {
    final model = _repository.getScore();
    return ScoreEntity(
      highScore: model.highScore,
      totalCoins: model.totalCoins,
      totalGems: model.totalGems,
      lastPlayed: model.lastPlayed,
    );
  }
}