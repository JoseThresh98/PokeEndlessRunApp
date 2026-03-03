import 'package:hive/hive.dart';
import '../../core/constants/creature_type.dart';

part 'creature_model.g.dart';

@HiveType(typeId: 0)
class CreatureModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int typeIndex; // maps to CreatureType enum

  @HiveField(3)
  bool isUnlocked;

  @HiveField(4)
  final int unlockCost;

  @HiveField(5)
  final String spritePath;

  @HiveField(6)
  final int gemCost;

  CreatureModel({
    required this.id,
    required this.name,
    required this.typeIndex,
    required this.isUnlocked,
    required this.unlockCost,
    required this.spritePath,
    this.gemCost = 0,
  });

  bool get requiresGems => gemCost > 0;

  CreatureType get type => CreatureType.values[typeIndex];

  static List<CreatureModel> get defaultCreatures => [
    CreatureModel(
      id: 'fire_1',
      name: 'Emberon',
      typeIndex: CreatureType.fire.index,
      isUnlocked: true, // starter creature
      unlockCost: 0,
      spritePath: 'assets/images/creatures/emberon.png',
    ),
    CreatureModel(
      id: 'water_1',
      name: 'Aquafin',
      typeIndex: CreatureType.water.index,
      isUnlocked: false,
      unlockCost: 500,
      spritePath: 'assets/images/creatures/aquafin.png',
    ),
    CreatureModel(
      id: 'psychic_1',
      name: 'Psywyn',
      typeIndex: CreatureType.psychic.index,
      isUnlocked: false,
      unlockCost: 0,
      gemCost: 1000,
      spritePath: 'assets/images/creatures/psywyn.png',
    ),
    CreatureModel(
      id: 'grass_1',
      name: 'Thornveil',
      typeIndex: CreatureType.grass.index,
      isUnlocked: false,
      unlockCost: 0,
      gemCost: 2000,
      spritePath: 'assets/images/creatures/thornveil.png',
    ),
  ];
}