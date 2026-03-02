import '../../data/repositories/score_repository.dart';

class UpdateHighScore {
  final ScoreRepository _repository;

  UpdateHighScore(this._repository);

  Future<void> call(int score) async {
    await _repository.updateHighScore(score);
  }
}