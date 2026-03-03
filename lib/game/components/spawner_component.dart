import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import '../../core/constants/app_constants.dart';
import '../biome_run_game.dart';
import 'obstacle_component.dart';
import 'coin_component.dart';
import '../biomes/biome_type.dart';

class SpawnerComponent extends Component
    with HasGameReference<BiomeRunGame> {

  final Random _random = Random();
  double _obstacleTimer = 0;
  double _coinTimer = 0;

  double get _obstacleInterval =>
      2.5 - (game.gameSpeed - AppConstants.gameSpeed) / 500;

  @override
  void update(double dt) {
    super.update(dt);
    if (game.isGameOver) return;

    _obstacleTimer += dt;
    _coinTimer += dt;

    if (_obstacleTimer >= _obstacleInterval.clamp(1.0, 2.5)) {
      _spawnObstacle();
      _obstacleTimer = 0;
    }

    if (_coinTimer >= 1.5) {
      _spawnCollectible();
      _coinTimer = 0;
    }
  }

  void _spawnObstacle() {
    final height = _random.nextDouble() * 40 + 40;
    final biome = game.gameWorld.currentBiome;
    final obstacles = biome.obstaclePaths;
    final spritePath = obstacles[_random.nextInt(obstacles.length)];

    game.add(ObstacleComponent(
      position: Vector2(game.size.x + 50, game.groundY - height),
      size: Vector2(80, height),
      spritePath: spritePath,
    ));
  }

  void _spawnCollectible() {
    final isGem = _random.nextDouble() < 0.15;
    final yPos = game.groundY - (_random.nextDouble() * 120 + 30);
    game.add(CoinComponent(
      position: Vector2(game.size.x + 50, yPos),
      collectibleType: isGem ? CollectibleType.gem : CollectibleType.coin,
    ));
  }
}