import '../../core/constants/creature_type.dart';

class CreatureEntity {
  final String id;
  final String name;
  final CreatureType type;
  final bool isUnlocked;
  final int unlockCost;
  final String spritePath;

  const CreatureEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.isUnlocked,
    required this.unlockCost,
    required this.spritePath,
  });

  double get abilityCooldown {
    switch (type) {
      case CreatureType.fire:
        return 3.0;
      case CreatureType.water:
        return 4.0;
      case CreatureType.psychic:
        return 5.0;
      case CreatureType.grass:
        return 3.5;
    }
  }
}