import '../../data/repositories/creature_repository.dart';
import '../../data/models/creature_model.dart';
import '../entities/creature_entity.dart';

class GetCreatures {
  final CreatureRepository _repository;

  GetCreatures(this._repository);

  List<CreatureEntity> call({bool unlockedOnly = false}) {
    final models = unlockedOnly
        ? _repository.getUnlockedCreatures()
        : _repository.getAllCreatures();

    return models.map(_toEntity).toList();
  }

  CreatureEntity _toEntity(CreatureModel model) {
    return CreatureEntity(
      id: model.id,
      name: model.name,
      type: model.type,
      isUnlocked: model.isUnlocked,
      unlockCost: model.unlockCost,
      spritePath: model.spritePath,
    );
  }
}