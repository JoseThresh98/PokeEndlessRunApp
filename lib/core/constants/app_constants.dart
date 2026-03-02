class AppConstants {
  AppConstants._();

  // Game Settings
  static const String gameTitle = 'PokeRun';
  static const double gameSpeed = 200.0;
  static const double speedIncrement = 10.0;
  static const double gravity = 800.0;
  static const double jumpForce = -400.0;

  // World
  static const double groundHeight = 100.0;
  static const double tileSize = 64.0;

  // Scoring
  static const int scorePerMeter = 1;
  static const int coinValue = 10;
  static const int gemValue = 100;

  // Creatures
  static const int maxCreatures = 4;
  static const double swapCooldown = 2.0; // seconds

  // Abilities cooldowns (seconds)
  static const double fireDashCooldown = 3.0;
  static const double waterGlideCooldown = 4.0;
  static const double psychicTeleportCooldown = 5.0;
  static const double grassVineCooldown = 3.5;

  // Storage Keys
  static const String highScoreKey = 'high_score';
  static const String coinsKey = 'total_coins';
  static const String gemsKey = 'total_gems';
  static const String unlockedCreaturesKey = 'unlocked_creatures';

  // Creature Unlock Costs
  static const int waterCreatureCost = 50;
  static const int psychicCreatureCost = 100;
  static const int grassCreatureCost = 75;
}