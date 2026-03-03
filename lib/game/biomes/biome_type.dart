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
        return 'images/backgrounds/forest_bg.png';
      case BiomeType.volcano:
        return 'images/backgrounds/volcano_bg.png';
      case BiomeType.ocean:
        return 'images/backgrounds/ocean_bg.png';
      case BiomeType.crystal:
        return 'images/backgrounds/crystal_bg.png';
    }
  }

  String get groundPath {
    switch (this) {
      case BiomeType.forest:
        return 'images/ground/forest_ground.png';
      case BiomeType.volcano:
        return 'images/ground/volcano_ground.png';
      case BiomeType.ocean:
        return 'images/ground/ocean_ground.png';
      case BiomeType.crystal:
        return 'images/ground/crystal_ground.png';
    }
  }

  List<String> get obstaclePaths {
    switch (this) {
      case BiomeType.forest:
        return [
          'images/obstacles/obstacle_log.png',
          'images/obstacles/obstacle_mossy_rock.png',
          'images/obstacles/obstacle_bush.png',
          'images/obstacles/obstacle_purple_mushrooms.png',
        ];
      case BiomeType.volcano:
        return [
          'images/obstacles/obstacle_crystalLava.png',
          'images/obstacles/obstacle_lavaRock.png',
        ];
      case BiomeType.ocean:
        return [
          'images/obstacles/obstacle_Crab.png',
          'images/obstacles/obstacle_coral.png',
        ];
      case BiomeType.crystal:
        return [
          'images/obstacles/obstacle_TotemCrystalCave.png',
          'images/obstacles/obstacle_crystalCave.png',
        ];
    }
  }

  // Score threshold to trigger biome change
  int get scoreThreshold {
    switch (this) {
      case BiomeType.forest:
        return 0;
      case BiomeType.volcano:
        return 500;
      case BiomeType.ocean:
        return 1000;
      case BiomeType.crystal:
        return 1500;
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