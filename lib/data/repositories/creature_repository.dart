import '../local/hive_service.dart';
import '../models/creature_model.dart';

class CreatureRepository {
  List<CreatureModel> getAllCreatures() {
    final box = HiveService.creatures;

    if (box.isEmpty) {
      _seedDefaultCreatures();
    }

    return box.values.toList();
  }

  void _seedDefaultCreatures() {
    final box = HiveService.creatures;
    for (final creature in CreatureModel.defaultCreatures) {
      box.put(creature.id, creature);
    }
  }

  CreatureModel? getCreature(String id) {
    return HiveService.creatures.get(id);
  }

  Future<void> unlockCreature(String id) async {
    final creature = HiveService.creatures.get(id);
    if (creature != null) {
      creature.isUnlocked = true;
      await creature.save();
    }
  }

  List<CreatureModel> getUnlockedCreatures() {
    return getAllCreatures()
        .where((c) => c.isUnlocked)
        .toList();
  }
}