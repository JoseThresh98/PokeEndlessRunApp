enum BiomeType {
  forest,
  volcano,
  ocean,
  crystal,
}

extension BiomeTypeExtension on BiomeType {
  String get backgroundPath {
    switch (this) {
      case BiomeType.forest:
        return 'backgrounds/forest_bg.png';
      case BiomeType.volcano:
        return 'backgrounds/volcano_bg.png';
      case BiomeType.ocean:
        return 'backgrounds/ocean_bg.png';
      case BiomeType.crystal:
        return 'backgrounds/crystal_bg.png';
    }
  }

  String get groundPath {
    switch (this) {
      case BiomeType.forest:
        return 'ground/forest_ground.png';
      case BiomeType.volcano:
        return 'ground/volcano_ground.png';
      case BiomeType.ocean:
        return 'ground/ocean_ground.png';
      case BiomeType.crystal:
        return 'ground/crystal_ground.png';
    }
  }

  List<String> get obstaclePaths {
    switch (this) {
      case BiomeType.forest:
        return [
          'obstacles/obstacle_log.png',
          'obstacles/obstacle_mossy_rock.png',
          'obstacles/obstacle_bush.png',
          'obstacles/obstacle_purple_mushrooms.png',
        ];
      case BiomeType.volcano:
        return [
          'obstacles/obstacle_crystalLava.png',
          'obstacles/obstacle_lavaRock.png',
        ];
      case BiomeType.ocean:
        return [
          'obstacles/obstacle_Crab.png',
          'obstacles/obstacle_coral.png',
        ];
      case BiomeType.crystal:
        return [
          'obstacles/obstacle_TotemCrystalCave.png',
          'obstacles/obstacle_crystalCave.png',
        ];
    }
  }

  // Score threshold to trigger biome change
  int get scoreThreshold {
    switch (this) {
      case BiomeType.forest:
        return 0;
      case BiomeType.volcano:
        return 50;
      case BiomeType.ocean:
        return 100;
      case BiomeType.crystal:
        return 150;
    }
  }

  String get displayName {
    switch (this) {
      case BiomeType.forest:
        return 'Forest';
      case BiomeType.volcano:
        return 'Volcano';
      case BiomeType.ocean:
        return 'Ocean';
      case BiomeType.crystal:
        return 'Crystal Cave';
    }
  }

  BiomeType get next {
    switch (this) {
      case BiomeType.forest:
        return BiomeType.volcano;
      case BiomeType.volcano:
        return BiomeType.ocean;
      case BiomeType.ocean:
        return BiomeType.crystal;
      case BiomeType.crystal:
        return BiomeType.forest; // loops back
    }
  }
}