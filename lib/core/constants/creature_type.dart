enum CreatureType {
  fire,
  water,
  psychic,
  grass,
}

extension CreatureTypeExtension on CreatureType {
  String get displayName {
    switch (this) {
      case CreatureType.fire:
        return 'Emberon';
      case CreatureType.water:
        return 'Aquafin';
      case CreatureType.psychic:
        return 'Psywyn';
      case CreatureType.grass:
        return 'Thornveil';
    }
  }

  String get abilityName {
    switch (this) {
      case CreatureType.fire:
        return 'Fire Dash';
      case CreatureType.water:
        return 'Water Glide';
      case CreatureType.psychic:
        return 'Psychic Teleport';
      case CreatureType.grass:
        return 'Vine Swing';
    }
  }
}