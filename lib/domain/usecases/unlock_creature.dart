import '../../data/repositories/creature_repository.dart';
import '../../data/repositories/score_repository.dart';

class UnlockCreature {
  final CreatureRepository _creatureRepository;
  final ScoreRepository _scoreRepository;

  UnlockCreature(this._creatureRepository, this._scoreRepository);

  Future<bool> call(String creatureId, int cost) async {
    final score = _scoreRepository.getScore();

    if (score.totalCoins < cost) return false;

    await _scoreRepository.spendCoins(cost);
    await _creatureRepository.unlockCreature(creatureId);
    return true;
  }
}